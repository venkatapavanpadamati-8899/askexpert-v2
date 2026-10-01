-- 20260929_college_safety_security_hardening.sql
-- PRE-STAGING SECURITY FIX PACK (CORRECTED)

-- ==================================================
-- FIX 1: SECURE EVIDENCE STORAGE
-- ==================================================
-- Ensure the storage bucket exists with hard limits for MIME types and size (10MB = 10485760 bytes).
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types) 
VALUES (
  'safety_evidence', 
  'safety_evidence', 
  false, 
  10485760, 
  ARRAY['image/jpeg','image/png','video/mp4','audio/mpeg','application/pdf']
)
ON CONFLICT (id) DO UPDATE 
SET file_size_limit = EXCLUDED.file_size_limit, 
    allowed_mime_types = EXCLUDED.allowed_mime_types,
    public = false;

-- Function to check if user can access an evidence file based on incident ownership/staff role
CREATE OR REPLACE FUNCTION public.can_access_evidence_file(file_path text) RETURNS boolean AS $$
DECLARE
  v_incident_id uuid;
  v_college_id uuid;
  v_student_id uuid;
BEGIN
  -- Find the related incident from safety_evidence table
  SELECT incident_id, uploaded_by INTO v_incident_id, v_student_id
  FROM public.safety_evidence WHERE safety_evidence.file_path = $1 LIMIT 1;
  
  IF v_incident_id IS NULL THEN
    -- If it's not yet in the safety_evidence table, allow upload if path starts with their UUID
    IF split_part($1, '/', 1) = auth.uid()::text THEN RETURN TRUE; END IF;
    RETURN FALSE;
  END IF;

  IF v_student_id = auth.uid() THEN RETURN TRUE; END IF;
  
  SELECT college_id INTO v_college_id FROM public.safety_incidents WHERE id = v_incident_id;
  IF public.is_safety_staff_for(v_college_id) THEN RETURN TRUE; END IF;
  
  RETURN FALSE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Storage object policies (drop old potentially conflicting ones)
DROP POLICY IF EXISTS "Give users access to own folder" ON storage.objects;
DROP POLICY IF EXISTS "Staff access evidence" ON storage.objects;
DROP POLICY IF EXISTS "Student insert own evidence files" ON storage.objects;
DROP POLICY IF EXISTS "Authorized read evidence files" ON storage.objects;
DROP POLICY IF EXISTS "No unauthorized delete" ON storage.objects;
DROP POLICY IF EXISTS "Students can upload evidence for own incidents" ON storage.objects;
DROP POLICY IF EXISTS "Safety staff can view evidence for their college" ON storage.objects;

CREATE POLICY "Student insert own evidence files" ON storage.objects FOR INSERT TO authenticated WITH CHECK (
  bucket_id = 'safety_evidence' AND split_part(name, '/', 1) = auth.uid()::text
);

CREATE POLICY "Authorized read evidence files" ON storage.objects FOR SELECT TO authenticated USING (
  bucket_id = 'safety_evidence' AND public.can_access_evidence_file(name)
);

CREATE POLICY "No unauthorized delete" ON storage.objects FOR DELETE TO authenticated USING (
  false -- Deletion disabled for audit integrity; must use a secure RPC if needed
);

-- ==================================================
-- FIX 2: CASE STATE MACHINE
-- ==================================================
-- Valid transitions based on the Phase 3 constraint:
-- ACTIVE -> ACKNOWLEDGED -> RESPONDING -> INVESTIGATION -> WAITING_FOR_INFORMATION -> RESOLUTION_PROPOSED -> RESOLVED -> CLOSED
-- Plus: any active state -> CANCELLED (by student or staff)
-- Students can only: ACTIVE -> CANCELLED
-- Staff can: advance forward through the pipeline

CREATE OR REPLACE FUNCTION public.check_incident_state_transition() RETURNS trigger AS $$
DECLARE
  v_valid boolean := false;
BEGIN
  -- If status hasn't changed, allow (non-status updates like assignment)
  IF OLD.status = NEW.status THEN
    RETURN NEW;
  END IF;

  -- Prevent modifications FROM closed/cancelled states
  IF OLD.status IN ('CLOSED', 'CANCELLED') THEN
    RAISE EXCEPTION 'Cannot modify a CLOSED or CANCELLED incident without an explicitly authorized reopen workflow.';
  END IF;

  -- Allow cancellation from any active state
  IF NEW.status = 'CANCELLED' THEN
    RETURN NEW;
  END IF;

  -- Define valid forward transitions
  CASE OLD.status
    WHEN 'ACTIVE' THEN
      v_valid := NEW.status IN ('ACKNOWLEDGED', 'RESPONDING', 'CANCELLED');
    WHEN 'ACKNOWLEDGED' THEN
      v_valid := NEW.status IN ('RESPONDING', 'INVESTIGATION', 'RESOLVED', 'CANCELLED');
    WHEN 'RESPONDING' THEN
      v_valid := NEW.status IN ('INVESTIGATION', 'RESOLVED', 'CANCELLED');
    WHEN 'INVESTIGATION' THEN
      v_valid := NEW.status IN ('WAITING_FOR_INFORMATION', 'RESOLUTION_PROPOSED', 'RESOLVED', 'CANCELLED');
    WHEN 'WAITING_FOR_INFORMATION' THEN
      v_valid := NEW.status IN ('INVESTIGATION', 'RESOLUTION_PROPOSED', 'RESOLVED', 'CANCELLED');
    WHEN 'RESOLUTION_PROPOSED' THEN
      v_valid := NEW.status IN ('RESOLVED', 'INVESTIGATION', 'CANCELLED');
    WHEN 'RESOLVED' THEN
      v_valid := NEW.status IN ('CLOSED');
    ELSE
      v_valid := false;
  END CASE;

  IF NOT v_valid THEN
    RAISE EXCEPTION 'Invalid state transition from % to %', OLD.status, NEW.status;
  END IF;

  -- Log state change in audit
  INSERT INTO public.safety_audit_logs(incident_id, actor_id, action, resource, resource_id, metadata)
  VALUES (NEW.id, auth.uid(), 'STATUS_TRANSITION', 'safety_incidents', NEW.id::text, 
          jsonb_build_object('from', OLD.status, 'to', NEW.status));

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS enforce_incident_state ON public.safety_incidents;
CREATE TRIGGER enforce_incident_state
BEFORE UPDATE ON public.safety_incidents
FOR EACH ROW
EXECUTE FUNCTION public.check_incident_state_transition();

-- ==================================================
-- FIX 3: STAFF ROLE ESCALATION
-- ==================================================
-- Restrict direct UPDATE/INSERT on safety_staff
DROP POLICY IF EXISTS "Staff insert" ON public.safety_staff;
DROP POLICY IF EXISTS "Staff update" ON public.safety_staff;
DROP POLICY IF EXISTS "Staff manage" ON public.safety_staff;
DROP POLICY IF EXISTS "Super Admins manage staff" ON public.safety_staff;
DROP POLICY IF EXISTS "Staff update own availability" ON public.safety_staff;

CREATE POLICY "Super Admins manage staff" ON public.safety_staff FOR ALL TO authenticated USING (
  public.is_admin()
);

-- Allow staff to update their OWN availability only
CREATE POLICY "Staff update own availability" ON public.safety_staff FOR UPDATE TO authenticated USING (
  profile_id = auth.uid()
) WITH CHECK (
  profile_id = auth.uid()
);

-- Trigger prevents staff from changing their own staff_role or college_id
CREATE OR REPLACE FUNCTION public.prevent_role_escalation() RETURNS trigger AS $$
BEGIN
  IF NEW.staff_role IS DISTINCT FROM OLD.staff_role OR NEW.college_id IS DISTINCT FROM OLD.college_id THEN
    IF NOT public.is_admin() THEN
      RAISE EXCEPTION 'Unauthorized attempt to modify staff_role or college_id.';
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS prevent_role_escalation_trg ON public.safety_staff;
CREATE TRIGGER prevent_role_escalation_trg
BEFORE UPDATE ON public.safety_staff
FOR EACH ROW
EXECUTE FUNCTION public.prevent_role_escalation();

-- ==================================================
-- FIX 4: ANONYMOUS COMPLAINT PRIVACY
-- ==================================================
-- Secure view that nullifies student_id for anonymous complaints 
-- unless the viewer is the student themselves OR an authorized high-level authority.
-- Uses staff_role (the actual column name) with lowercase values (matching the constraint).
DROP VIEW IF EXISTS public.vw_safety_incidents_safe;
CREATE OR REPLACE VIEW public.vw_safety_incidents_safe AS
SELECT 
  i.id, i.college_id, i.incident_type, i.severity, i.message, i.status, 
  i.evidence_urls,
  i.created_at, i.updated_at, i.location_sharing_enabled,
  i.is_anonymous, i.ai_risk_explanation,
  i.assigned_responder_id, i.secondary_responder_id, i.escalation_authority_id,
  i.assigned_at, i.responding_at, i.resolved_at,
  i.is_possible_duplicate, i.duplicate_of_id,
  i.escalation_level, i.escalated_at, i.response_due_at,
  i.acknowledged_at, i.closed_at,
  CASE 
    WHEN i.is_anonymous = true 
         AND i.student_id != auth.uid() 
         AND NOT EXISTS (
           SELECT 1 FROM public.safety_staff s 
           WHERE s.profile_id = auth.uid() 
             AND s.college_id = i.college_id 
             AND s.staff_role IN ('principal', 'hod', 'manager')
         )
    THEN NULL 
    ELSE i.student_id
  END AS student_id
FROM public.safety_incidents i;

-- Note: The frontend should query vw_safety_incidents_safe instead of safety_incidents for listing.
