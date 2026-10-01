-- Phase 4 College Safety: Emergency Command Center & Incident Intelligence

-- 2. SOS RESPONSE TIMER
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS assigned_at timestamptz;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS responding_at timestamptz;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS resolved_at timestamptz;

-- 3. MULTI-RESPONDER SUPPORT
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS secondary_responder_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS escalation_authority_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL;

-- 5. INCIDENT DEDUPLICATION
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS is_possible_duplicate boolean DEFAULT false;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS duplicate_of_id uuid REFERENCES public.safety_incidents(id) ON DELETE SET NULL;

-- 6 & 7. EVIDENCE MANAGEMENT & INTEGRITY
CREATE TABLE IF NOT EXISTS public.safety_evidence (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id uuid NOT NULL REFERENCES public.safety_incidents(id) ON DELETE CASCADE,
  file_path text NOT NULL,
  filename text NOT NULL,
  file_type text NOT NULL,
  file_size bigint NOT NULL,
  content_hash text,
  uploaded_by uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  access_status text DEFAULT 'PRIVATE',
  metadata jsonb DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE public.safety_evidence ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Students read own evidence" ON public.safety_evidence FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND i.student_id = auth.uid())
);
CREATE POLICY "Staff read evidence" ON public.safety_evidence FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);
CREATE POLICY "Students insert own evidence" ON public.safety_evidence FOR INSERT TO authenticated WITH CHECK (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND i.student_id = auth.uid())
  AND uploaded_by = auth.uid()
);
CREATE POLICY "Staff insert evidence" ON public.safety_evidence FOR INSERT TO authenticated WITH CHECK (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
  AND uploaded_by = auth.uid()
);

-- 10. AUTHORITY AVAILABILITY
ALTER TABLE public.safety_staff ADD COLUMN IF NOT EXISTS availability text DEFAULT 'AVAILABLE' 
  CHECK (availability IN ('AVAILABLE', 'BUSY', 'OFFLINE', 'EMERGENCY_ONLY'));

-- 14. AUDIT INTEGRITY (Extending existing audit_logs)
ALTER TABLE public.safety_audit_logs ADD COLUMN IF NOT EXISTS role text;
ALTER TABLE public.safety_audit_logs ADD COLUMN IF NOT EXISTS college_id uuid REFERENCES public.colleges(id) ON DELETE CASCADE;
ALTER TABLE public.safety_audit_logs ADD COLUMN IF NOT EXISTS resource text;
ALTER TABLE public.safety_audit_logs ADD COLUMN IF NOT EXISTS resource_id text;
ALTER TABLE public.safety_audit_logs ADD COLUMN IF NOT EXISTS result text;
ALTER TABLE public.safety_audit_logs ADD COLUMN IF NOT EXISTS reason text;
ALTER TABLE public.safety_audit_logs ADD COLUMN IF NOT EXISTS metadata jsonb DEFAULT '{}'::jsonb;

-- Prevent students from editing audit records (already achieved implicitly by lack of UPDATE/DELETE policies, but let's be explicit)
-- Just ensuring no UPDATE/DELETE policies exist is enough, as RLS denies by default.
-- Ensure staff can read audit logs for their college.
DROP POLICY IF EXISTS "Staff read audit logs" ON public.safety_audit_logs;
CREATE POLICY "Staff read audit logs" ON public.safety_audit_logs FOR SELECT TO authenticated USING (
  college_id IS NOT NULL AND public.is_safety_staff_for(college_id)
);

-- 15. SECURITY CENTER
CREATE TABLE IF NOT EXISTS public.safety_security_events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  college_id uuid REFERENCES public.colleges(id) ON DELETE CASCADE,
  actor_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  event_type text NOT NULL,
  description text,
  metadata jsonb DEFAULT '{}'::jsonb,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE public.safety_security_events ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Staff read security events" ON public.safety_security_events FOR SELECT TO authenticated USING (
  public.is_safety_staff_for(college_id)
);

-- Note: No operations directly alter production DB per instructions. This is for local reference and documentation.
