-- ==============================================================================
-- MIGRATION: 20260910_strict_role_and_account_security.sql
-- DESCRIPTION: Enforces strict database-level protection on sensitive profile columns
--              (role, is_verified, account_status, is_blocked).
--              Prevents privilege escalation (e.g. users updating their role to 'admin'
--              or 'expert', or un-blocking their accounts) via Supabase client requests.
-- ==============================================================================

-- 1. Helper function: check if caller is an administrator
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid()
    AND role = 'admin'
  );
$$;

-- 2. Enhanced Security Trigger Function: Guard role, is_verified, and account_status
CREATE OR REPLACE FUNCTION public.enforce_profile_role_security()
RETURNS TRIGGER AS $$
BEGIN
  -- Prevent privilege escalation on INSERT
  IF (TG_OP = 'INSERT') THEN
    -- If role is requested as 'admin', only existing admins or service_role can create it
    IF (NEW.role = 'admin') THEN
      IF NOT (public.is_admin() OR auth.role() = 'service_role') THEN
        NEW.role := 'user';
      END IF;
    END IF;

    -- Force is_verified to false on self-registration
    IF (NEW.is_verified = true) THEN
      IF NOT (public.is_admin() OR auth.role() = 'service_role') THEN
        NEW.is_verified := false;
      END IF;
    END IF;

    -- Force account_status to 'active' on new registrations
    IF (NEW.account_status IS NULL) THEN
      NEW.account_status := 'active';
    END IF;

    RETURN NEW;
  END IF;

  -- Prevent privilege escalation on UPDATE
  IF (TG_OP = 'UPDATE') THEN
    -- A: Prohibit non-admins from changing role
    IF (NEW.role IS DISTINCT FROM OLD.role) THEN
      IF NOT (public.is_admin() OR auth.role() = 'service_role') THEN
        RAISE EXCEPTION 'Access Denied: You do not have permission to modify account roles.';
      END IF;
    END IF;

    -- B: Prohibit non-admins from self-verifying expert status
    IF (NEW.is_verified IS DISTINCT FROM OLD.is_verified) THEN
      IF NOT (public.is_admin() OR auth.role() = 'service_role') THEN
        RAISE EXCEPTION 'Access Denied: Only compliance administrators can modify verification status.';
      END IF;
    END IF;

    -- C: Prohibit non-admins from altering account suspension / blocked status
    IF (NEW.account_status IS DISTINCT FROM OLD.account_status) THEN
      IF NOT (public.is_admin() OR auth.role() = 'service_role') THEN
        RAISE EXCEPTION 'Access Denied: Only administrators can modify account status.';
      END IF;
    END IF;

    IF (NEW.is_blocked IS DISTINCT FROM OLD.is_blocked) THEN
      IF NOT (public.is_admin() OR auth.role() = 'service_role') THEN
        RAISE EXCEPTION 'Access Denied: Only administrators can modify block status.';
      END IF;
    END IF;

    RETURN NEW;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Attach Trigger to public.profiles
DROP TRIGGER IF EXISTS trg_enforce_profile_role_security ON public.profiles;
CREATE TRIGGER trg_enforce_profile_role_security
BEFORE INSERT OR UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.enforce_profile_role_security();

-- 4. Enable and Verify Row Level Security on profiles
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Ensure Users Can Only Update Non-Privileged Columns on Their Own Profile
-- (The BEFORE UPDATE trigger above acts as the ironclad guard against role modification)
DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;
CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Admins can update any profile
DROP POLICY IF EXISTS "Admins can manage all profiles" ON public.profiles;
CREATE POLICY "Admins can manage all profiles" ON public.profiles
  FOR ALL USING (public.is_admin() OR auth.role() = 'service_role');

-- ==============================================================================
-- ROLLBACK INSTRUCTIONS
-- ==============================================================================
-- To revert this security migration if needed, run:
--
-- DROP TRIGGER IF EXISTS trg_enforce_profile_role_security ON public.profiles;
-- DROP FUNCTION IF EXISTS public.enforce_profile_role_security();
-- ==============================================================================
