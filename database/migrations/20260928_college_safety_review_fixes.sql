-- Fixes for 20260928_college_safety.sql (Local SQL Review)
-- Must be executed AFTER 20260928_college_safety.sql

-- 1. FIX: Prevent students from arbitrarily changing their college_id
-- Without this, a student could update their profiles.college_id to spoof incidents in another college.
CREATE OR REPLACE FUNCTION public.enforce_profile_college_security()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  IF TG_OP = 'UPDATE' AND NEW.college_id IS DISTINCT FROM OLD.college_id THEN
    IF NOT (public.is_admin() OR auth.role() = 'service_role') THEN
      RAISE EXCEPTION 'Access Denied: Only administrators can modify college assignments.';
    END IF;
  END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_enforce_profile_college_security ON public.profiles;
CREATE TRIGGER trg_enforce_profile_college_security
BEFORE UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.enforce_profile_college_security();

-- 2. FIX: Prevent infinite location sharing on INSERT
-- The original trigger only enforced the 30-minute location sharing bound on UPDATE.
-- This forces location sharing off during INSERT to require an explicit, bounded UPDATE.
CREATE OR REPLACE FUNCTION public.safety_apply_incident_defaults()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  NEW.response_due_at := now() + CASE NEW.severity
    WHEN 'CRITICAL' THEN interval '5 minutes' WHEN 'HIGH' THEN interval '15 minutes'
    WHEN 'MEDIUM' THEN interval '30 minutes' ELSE interval '60 minutes' END;
  NEW.escalation_level := 0;
  
  -- Force location sharing off during INSERT to require a bounded explicit UPDATE
  NEW.location_sharing_enabled := false;
  NEW.location_sharing_expires_at := NULL;
  
  RETURN NEW;
END;
$$;

-- 3. FIX: Prevent direct client INSERT into safety_escalations
-- Escalations must be performed via the safety_escalate_incident() function to ensure
-- the safety_incidents table is locked and updated atomically.
DROP POLICY IF EXISTS "Authorized staff creates escalation" ON public.safety_escalations;
