-- ==============================================================================
-- FIX SUPABASE SECURITY ADVISOR CRITICAL FINDING:
-- View public.verified_profiles is defined with the SECURITY DEFINER property
-- (Security Advisor Finding 0010_security_definer_view)
-- ==============================================================================

-- 1. Alter the view to enforce security_invoker = true
-- This guarantees the view executes with the privileges of the querying user (SECURITY INVOKER)
-- rather than the view owner (SECURITY DEFINER), strictly respecting Row Level Security (RLS) policies
-- on underlying tables (public.profiles).
ALTER VIEW IF EXISTS public.verified_profiles SET (security_invoker = true);

-- 2. Ensure RLS is enabled on underlying public.profiles table
ALTER TABLE IF EXISTS public.profiles ENABLE ROW LEVEL SECURITY;

-- 3. Confirm public select policy on public.profiles for authenticated/anon directory views
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies 
    WHERE schemaname = 'public' 
      AND tablename = 'profiles' 
      AND policyname = 'Public profiles are viewable by everyone'
  ) THEN
    CREATE POLICY "Public profiles are viewable by everyone" 
      ON public.profiles 
      FOR SELECT 
      USING (true);
  END IF;
END $$;
