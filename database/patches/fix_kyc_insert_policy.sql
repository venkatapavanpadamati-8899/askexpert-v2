-- ==============================================================================
-- ASKEXPERT - MISSING INSERT POLICY FIX
-- Resolves "new row violates row-level security policy" (42501) on KYC submission.
-- ==============================================================================

BEGIN;

-- 1. Ensure experts can insert their own verification
DROP POLICY IF EXISTS "Experts can view and submit own verification" ON public.professional_verifications;
CREATE POLICY "Experts can view and submit own verification" ON public.professional_verifications
  FOR ALL TO authenticated 
  USING (auth.uid() = expert_id) 
  WITH CHECK (auth.uid() = expert_id);

-- Optional explicit INSERT policy (often needed if FOR ALL behaves unexpectedly)
DROP POLICY IF EXISTS "Experts can insert own verification" ON public.professional_verifications;
CREATE POLICY "Experts can insert own verification" ON public.professional_verifications
  FOR INSERT TO authenticated 
  WITH CHECK (auth.uid() = expert_id);

COMMIT;
