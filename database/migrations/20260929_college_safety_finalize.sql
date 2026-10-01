-- AskExpert College Safety: canonical advanced finalization
-- PREREQUISITE: Apply 20260928_college_safety.sql successfully first.
-- This replaces the separate phase2/phase3/phase4/enhancement/hardening deployment path.
-- Run as one SQL Editor transaction. Do not run the superseded phase files afterwards.

BEGIN;

ALTER TABLE public.safety_staff DROP CONSTRAINT IF EXISTS safety_staff_staff_role_check;
ALTER TABLE public.safety_staff ADD CONSTRAINT safety_staff_staff_role_check
  CHECK (staff_role IN ('manager','security','responder','hod','women_safety_cell','principal'));
ALTER TABLE public.safety_staff ADD COLUMN IF NOT EXISTS availability text NOT NULL DEFAULT 'AVAILABLE'
  CHECK (availability IN ('AVAILABLE','BUSY','OFFLINE','EMERGENCY_ONLY'));
ALTER TABLE public.safety_staff ADD COLUMN IF NOT EXISTS department text;

ALTER TABLE public.safety_incidents DROP CONSTRAINT IF EXISTS safety_incidents_status_check;
ALTER TABLE public.safety_incidents ADD CONSTRAINT safety_incidents_status_check CHECK
  (status IN ('ACTIVE','ACKNOWLEDGED','RESPONDING','INVESTIGATION','WAITING_FOR_INFORMATION','RESOLUTION_PROPOSED','RESOLVED','CLOSED','CANCELLED'));
ALTER TABLE public.safety_incidents
  ADD COLUMN IF NOT EXISTS is_anonymous boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS ai_category_suggestion text,
  ADD COLUMN IF NOT EXISTS ai_priority_suggestion text,
  ADD COLUMN IF NOT EXISTS ai_risk_explanation text,
  ADD COLUMN IF NOT EXISTS duplicate_hash text,
  ADD COLUMN IF NOT EXISTS is_possible_duplicate boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS duplicate_of_id uuid REFERENCES public.safety_incidents(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS assigned_at timestamptz,
  ADD COLUMN IF NOT EXISTS responding_at timestamptz,
  ADD COLUMN IF NOT EXISTS resolved_at timestamptz,
  ADD COLUMN IF NOT EXISTS secondary_responder_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS escalation_authority_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS is_overdue boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS sla_breach_at timestamptz;

-- Read scope is enforced in Postgres, not in page JavaScript:
-- security sees emergency/critical cases only; HOD sees its department; women cell,
-- manager, and principal see their own college; a responder sees only assigned cases.
CREATE OR REPLACE FUNCTION public.can_access_safety_incident(target_incident_id uuid)
RETURNS boolean LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT public.is_admin() OR EXISTS (
    SELECT 1 FROM public.safety_incidents i
    JOIN public.profiles student ON student.id = i.student_id
    JOIN public.safety_staff s ON s.college_id = i.college_id AND s.profile_id = auth.uid() AND s.is_active
    WHERE i.id = target_incident_id AND (
      s.staff_role IN ('principal','manager','women_safety_cell')
      OR (s.staff_role = 'hod' AND s.department IS NOT NULL AND s.department = student.department)
      OR (s.staff_role = 'security' AND i.severity = 'CRITICAL')
      OR (s.staff_role = 'responder' AND i.assigned_responder_id = auth.uid())
    )
  );
$$;
REVOKE ALL ON FUNCTION public.can_access_safety_incident(uuid) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.can_access_safety_incident(uuid) TO authenticated;

DROP POLICY IF EXISTS "Authorized staff read incidents" ON public.safety_incidents;
DROP POLICY IF EXISTS "Authorized staff update incidents" ON public.safety_incidents;
CREATE POLICY "Role-scoped staff read incidents" ON public.safety_incidents FOR SELECT TO authenticated
  USING (public.can_access_safety_incident(id));
CREATE POLICY "Role-scoped staff update incidents" ON public.safety_incidents FOR UPDATE TO authenticated
  USING (public.can_access_safety_incident(id)) WITH CHECK (public.can_access_safety_incident(id));

DROP POLICY IF EXISTS "Staff reads authorized locations" ON public.safety_locations;
CREATE POLICY "Role-scoped staff read locations" ON public.safety_locations FOR SELECT TO authenticated USING (
  public.can_access_safety_incident(incident_id)
);
DROP POLICY IF EXISTS "Incident participants see audit log" ON public.safety_audit_logs;
CREATE POLICY "Role-scoped incident audit logs" ON public.safety_audit_logs FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND (i.student_id = auth.uid() OR public.can_access_safety_incident(i.id)))
);

DROP POLICY IF EXISTS "Safety: authorized responders read college profiles" ON public.profiles;
CREATE POLICY "Safety: role-scoped incident profiles" ON public.profiles FOR SELECT TO authenticated USING (
  public.is_admin() OR EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.student_id = profiles.id AND public.can_access_safety_incident(i.id))
);

CREATE TABLE IF NOT EXISTS public.safety_messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id uuid NOT NULL REFERENCES public.safety_incidents(id) ON DELETE CASCADE,
  sender_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  message text NOT NULL CHECK (char_length(message) BETWEEN 1 AND 4000),
  is_internal boolean NOT NULL DEFAULT false,
  attachment_urls text[] NOT NULL DEFAULT '{}',
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.safety_evidence (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id uuid NOT NULL REFERENCES public.safety_incidents(id) ON DELETE CASCADE,
  file_path text NOT NULL UNIQUE,
  filename text NOT NULL,
  file_type text NOT NULL,
  file_size bigint NOT NULL CHECK (file_size > 0 AND file_size <= 10485760),
  content_hash text,
  uploaded_by uuid NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
  access_status text NOT NULL DEFAULT 'PRIVATE' CHECK (access_status IN ('PRIVATE','STAFF_ONLY')),
  metadata jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  CHECK (split_part(file_path, '/', 1) = incident_id::text),
  CHECK (split_part(file_path, '/', 2) = uploaded_by::text)
);

ALTER TABLE public.safety_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.safety_evidence ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Students read own non-internal messages" ON public.safety_messages;
DROP POLICY IF EXISTS "Students send messages" ON public.safety_messages;
DROP POLICY IF EXISTS "Staff read messages" ON public.safety_messages;
DROP POLICY IF EXISTS "Staff send messages" ON public.safety_messages;
CREATE POLICY "Students read own non-internal messages" ON public.safety_messages FOR SELECT TO authenticated USING (
  NOT is_internal AND EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND i.student_id = auth.uid())
);
CREATE POLICY "Students send incident messages" ON public.safety_messages FOR INSERT TO authenticated WITH CHECK (
  NOT is_internal AND sender_id = auth.uid() AND EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND i.student_id = auth.uid() AND i.status NOT IN ('CLOSED','CANCELLED'))
);
CREATE POLICY "Staff read college messages" ON public.safety_messages FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);
CREATE POLICY "Staff send college messages" ON public.safety_messages FOR INSERT TO authenticated WITH CHECK (
  sender_id = auth.uid() AND EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);

DROP POLICY IF EXISTS "Students read own evidence" ON public.safety_evidence;
DROP POLICY IF EXISTS "Staff read evidence" ON public.safety_evidence;
DROP POLICY IF EXISTS "Students insert own evidence" ON public.safety_evidence;
DROP POLICY IF EXISTS "Staff insert evidence" ON public.safety_evidence;
CREATE POLICY "Students read own evidence" ON public.safety_evidence FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND i.student_id = auth.uid())
);
CREATE POLICY "Staff read authorized evidence" ON public.safety_evidence FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);
CREATE POLICY "Students record own evidence" ON public.safety_evidence FOR INSERT TO authenticated WITH CHECK (
  uploaded_by = auth.uid() AND EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND i.student_id = auth.uid() AND i.status NOT IN ('CLOSED','CANCELLED'))
);
CREATE POLICY "Staff record authorized evidence" ON public.safety_evidence FOR INSERT TO authenticated WITH CHECK (
  uploaded_by = auth.uid() AND EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);

-- Private bucket: storage object access is tied to a registered evidence record.
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES ('safety_evidence','safety_evidence',false,10485760,ARRAY['image/jpeg','image/png','video/mp4','audio/mpeg','application/pdf'])
ON CONFLICT (id) DO UPDATE SET public = false, file_size_limit = EXCLUDED.file_size_limit, allowed_mime_types = EXCLUDED.allowed_mime_types;
DROP POLICY IF EXISTS "Students can upload evidence for own incidents" ON storage.objects;
DROP POLICY IF EXISTS "Safety staff can view evidence for their college" ON storage.objects;
DROP POLICY IF EXISTS "Student insert own evidence files" ON storage.objects;
DROP POLICY IF EXISTS "Authorized read evidence files" ON storage.objects;
DROP POLICY IF EXISTS "No unauthorized delete" ON storage.objects;
CREATE POLICY "Safety evidence upload by incident owner" ON storage.objects FOR INSERT TO authenticated WITH CHECK (
  bucket_id = 'safety_evidence' AND split_part(name, '/', 2) = auth.uid()::text AND EXISTS (
    SELECT 1 FROM public.safety_incidents i WHERE i.id::text = split_part(name, '/', 1) AND i.student_id = auth.uid() AND i.status NOT IN ('CLOSED','CANCELLED')
  )
);
CREATE POLICY "Safety evidence read by authorized participant" ON storage.objects FOR SELECT TO authenticated USING (
  bucket_id = 'safety_evidence' AND EXISTS (
    SELECT 1 FROM public.safety_evidence e JOIN public.safety_incidents i ON i.id = e.incident_id
    WHERE e.file_path = name AND (i.student_id = auth.uid() OR public.is_safety_staff_for(i.college_id))
  )
);

ALTER TABLE public.safety_audit_logs
  ADD COLUMN IF NOT EXISTS college_id uuid REFERENCES public.colleges(id) ON DELETE CASCADE,
  ADD COLUMN IF NOT EXISTS resource text,
  ADD COLUMN IF NOT EXISTS resource_id text,
  ADD COLUMN IF NOT EXISTS metadata jsonb NOT NULL DEFAULT '{}'::jsonb;
CREATE INDEX IF NOT EXISTS idx_safety_evidence_incident ON public.safety_evidence(incident_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_safety_messages_incident ON public.safety_messages(incident_id, created_at);

-- Anonymous cases redact identity for responders other than principal/HOD/manager; the student sees self.
DROP VIEW IF EXISTS public.vw_safety_incidents_safe;
CREATE VIEW public.vw_safety_incidents_safe WITH (security_invoker = true) AS
SELECT i.id, i.college_id, i.incident_type, i.severity, i.message, i.status, i.created_at, i.updated_at,
  i.location_sharing_enabled, i.assigned_responder_id, i.escalation_level, i.response_due_at, i.is_anonymous,
  i.ai_risk_explanation, i.is_possible_duplicate, i.duplicate_of_id,
  CASE WHEN i.is_anonymous AND i.student_id <> auth.uid() AND NOT EXISTS (
    SELECT 1 FROM public.safety_staff s WHERE s.profile_id = auth.uid() AND s.college_id = i.college_id
      AND s.is_active AND s.staff_role IN ('principal','hod','manager')
  ) THEN NULL ELSE i.student_id END AS student_id
FROM public.safety_incidents i;

DO $$ BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.safety_messages; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
COMMIT;
