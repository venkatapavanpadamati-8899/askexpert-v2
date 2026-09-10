-- ==============================================================================
-- MIGRATION: 20260910_2_harden_role_and_account_security.sql
-- DESCRIPTION: Comprehensive security revision for public.profiles.
--              1. Hardens public.is_admin() with empty search_path and restricted EXECUTE.
--              2. Unifies and hardens profile trigger to strictly guard:
--                 - INSERT: role must default to 'user' (or pending unverified 'expert'),
--                   is_verified forced false, account_status forced 'active', is_blocked forced false.
--                 - UPDATE: role, is_verified, account_status, is_blocked cannot be changed by non-admins.
--              3. Hardens RLS UPDATE policy with explicit WITH CHECK clause.
--              4. Explicit transaction safety (BEGIN ... COMMIT).
-- ==============================================================================

BEGIN;

-- ------------------------------------------------------------------------------
-- 1. Helper Function: public.is_admin()
-- ------------------------------------------------------------------------------
-- Must be SECURITY DEFINER to query public.profiles without triggering RLS recursion.
-- Hardened with SET search_path = '' and fully qualified schema names.
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = ''
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid()
    AND role = 'admin'
  );
$$;

-- Restrict function execute permissions
REVOKE ALL ON FUNCTION public.is_admin() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.is_admin() TO authenticated, service_role;

-- ------------------------------------------------------------------------------
-- 2. Enhanced Profile Security Trigger Function
-- ------------------------------------------------------------------------------
-- Hardened with SET search_path = '' and schema-qualified references.
CREATE OR REPLACE FUNCTION public.enforce_profile_role_security()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
  -- ==========================================
  -- A. INSERT CONTROLS (Self-Registration & Profile Creation)
  -- ==========================================
  IF (TG_OP = 'INSERT') THEN
    -- If caller is NOT an existing admin or service_role:
    IF NOT (public.is_admin() OR auth.role() = 'service_role') THEN
      -- 1. Role validation: Only 'user' or 'expert' (pending KYC applicant) allowed.
      -- Prohibit self-assignment of 'admin' or any unapproved role.
      IF NEW.role IS NULL OR NEW.role NOT IN ('user', 'expert') OR NEW.role = 'admin' THEN
        NEW.role := 'user';
      END IF;

      -- 2. Verification status: Unconditionally force false on self-insert.
      -- Approved expert status can only be granted by compliance admins.
      NEW.is_verified := false;

      -- 3. Account status: Unconditionally force schema default 'active'.
      NEW.account_status := 'active';

      -- 4. Block status: Unconditionally force false on self-insert.
      NEW.is_blocked := false;
    END IF;

    RETURN NEW;
  END IF;

  -- ==========================================
  -- B. UPDATE CONTROLS (Profile Modifications)
  -- ==========================================
  IF (TG_OP = 'UPDATE') THEN
    -- If caller is NOT an existing admin or service_role:
    IF NOT (public.is_admin() OR auth.role() = 'service_role') THEN
      -- 1. Role immutability: Users cannot promote themselves or modify roles.
      IF (NEW.role IS DISTINCT FROM OLD.role) THEN
        RAISE EXCEPTION 'Access Denied: You do not have permission to modify account roles.';
      END IF;

      -- 2. Verification immutability: Users cannot grant themselves verified status.
      IF (NEW.is_verified IS DISTINCT FROM OLD.is_verified) THEN
        RAISE EXCEPTION 'Access Denied: Only compliance administrators can modify verification status.';
      END IF;

      -- 3. Account status immutability: Users cannot alter account suspension.
      IF (NEW.account_status IS DISTINCT FROM OLD.account_status) THEN
        RAISE EXCEPTION 'Access Denied: Only administrators can modify account status.';
      END IF;

      -- 4. Block status immutability: Users cannot alter block status.
      IF (NEW.is_blocked IS DISTINCT FROM OLD.is_blocked) THEN
        RAISE EXCEPTION 'Access Denied: Only administrators can modify block status.';
      END IF;
    END IF;

    RETURN NEW;
  END IF;

  RETURN NEW;
END;
$$;

-- Restrict trigger function execute privileges
REVOKE ALL ON FUNCTION public.enforce_profile_role_security() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.enforce_profile_role_security() TO postgres, authenticated, anon, service_role;

-- ------------------------------------------------------------------------------
-- 3. Attach Unified Trigger to public.profiles
-- ------------------------------------------------------------------------------
-- Clean up both legacy verification trigger and previous revision trigger
DROP TRIGGER IF EXISTS trg_enforce_profile_verification_security ON public.profiles;
DROP TRIGGER IF EXISTS trg_enforce_profile_role_security ON public.profiles;

CREATE TRIGGER trg_enforce_profile_role_security
BEFORE INSERT OR UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.enforce_profile_role_security();

-- ------------------------------------------------------------------------------
-- 4. Row Level Security Policies on public.profiles
-- ------------------------------------------------------------------------------
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Ensure SELECT policy exists for directory and profile views
DROP POLICY IF EXISTS "Profiles are viewable by everyone" ON public.profiles;
DROP POLICY IF EXISTS "Public profiles are viewable by everyone" ON public.profiles;
CREATE POLICY "Profiles are viewable by everyone" ON public.profiles
  FOR SELECT USING (true);

-- Ensure Users Can Only Update Their Own Profile (and cannot hijack target id)
DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;
CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Ensure Admins & Service Role Can Manage All Profiles
DROP POLICY IF EXISTS "Admins can manage all profiles" ON public.profiles;
CREATE POLICY "Admins can manage all profiles" ON public.profiles
  FOR ALL TO authenticated, service_role
  USING (public.is_admin() OR auth.role() = 'service_role')
  WITH CHECK (public.is_admin() OR auth.role() = 'service_role');

COMMIT;
