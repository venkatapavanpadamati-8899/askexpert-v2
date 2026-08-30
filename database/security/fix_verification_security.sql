-- ==============================================================================
-- ASKEXPERT - COMPREHENSIVE DATABASE VERIFICATION SECURITY ENFORCEMENT
-- Blocks client-side bypass of verification, restricts `is_verified` and `role`
-- updates to authorized Admins, and secures `professional_verifications`.
-- ==============================================================================

-- 1. Ensure public.is_admin() helper function is defined & SECURITY DEFINER
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

-- 2. Security Trigger: Restrict is_verified = true and role = 'expert' on public.profiles
CREATE OR REPLACE FUNCTION public.enforce_profile_verification_security()
RETURNS TRIGGER AS $$
BEGIN
  -- Prevent non-admin users from setting is_verified to true
  IF (NEW.is_verified = true AND (OLD.is_verified IS NULL OR OLD.is_verified = false)) THEN
    IF NOT public.is_admin() THEN
      RAISE EXCEPTION 'Access Denied: Only compliance admins can grant Verified Status.';
    END IF;
  END IF;

  -- Prevent non-admin users from promoting role to expert directly
  IF (NEW.role = 'expert' AND (OLD.role IS NULL OR OLD.role != 'expert')) THEN
    IF NOT public.is_admin() THEN
      RAISE EXCEPTION 'Access Denied: Expert role assignment requires compliance board verification.';
    END IF;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_enforce_profile_verification_security ON public.profiles;
CREATE TRIGGER trg_enforce_profile_verification_security
BEFORE INSERT OR UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.enforce_profile_verification_security();

-- 3. Security Trigger: Restrict verification_status = 'approved' on public.professional_verifications
CREATE OR REPLACE FUNCTION public.enforce_verification_approval_security()
RETURNS TRIGGER AS $$
BEGIN
  -- Prevent non-admin users from setting verification_status = 'approved'
  IF (NEW.verification_status = 'approved' AND (OLD.verification_status IS NULL OR OLD.verification_status != 'approved')) THEN
    IF NOT public.is_admin() THEN
      RAISE EXCEPTION 'Access Denied: Only compliance admins can set verification status to approved.';
    END IF;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS trg_enforce_verification_approval_security ON public.professional_verifications;
CREATE TRIGGER trg_enforce_verification_approval_security
BEFORE INSERT OR UPDATE ON public.professional_verifications
FOR EACH ROW EXECUTE FUNCTION public.enforce_verification_approval_security();

-- 4. Verify RLS is enabled on both tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.professional_verifications ENABLE ROW LEVEL SECURITY;

-- 5. RLS Policies for profiles
DROP POLICY IF EXISTS "Profiles are viewable by everyone" ON public.profiles;
CREATE POLICY "Profiles are viewable by everyone" ON public.profiles
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;
CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

DROP POLICY IF EXISTS "Admins can manage all profiles" ON public.profiles;
CREATE POLICY "Admins can manage all profiles" ON public.profiles
  FOR ALL USING (public.is_admin());

-- 6. RLS Policies for professional_verifications
DROP POLICY IF EXISTS "Experts can view and submit own verification" ON public.professional_verifications;
CREATE POLICY "Experts can view and submit own verification" ON public.professional_verifications
  FOR ALL USING (auth.uid() = expert_id);

DROP POLICY IF EXISTS "Admins can view and moderate all verifications" ON public.professional_verifications;
CREATE POLICY "Admins can view and moderate all verifications" ON public.professional_verifications
  FOR ALL USING (public.is_admin());
