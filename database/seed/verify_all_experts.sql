-- =========================================================
-- ASKEXPERT - ENSURE ALL EXPERTS HAVE IS_VERIFIED = TRUE
-- =========================================================
-- Execute this script in your Supabase SQL Editor to mark 
-- all expert profiles as verified (is_verified = true).
-- =========================================================

-- 1. Update is_verified = true for all profiles with role = 'expert'
UPDATE public.profiles
SET is_verified = true
WHERE role = 'expert';

-- 2. Ensure all expert verifications are approved in professional_verifications
INSERT INTO public.professional_verifications (
  expert_id, degree_qualification, council_registration_no, document_url, verification_status, verified_at
)
SELECT 
  id as expert_id,
  COALESCE(specialization, 'Certified Professional') as degree_qualification,
  'REG-' || UPPER(SUBSTRING(REPLACE(id::text, '-', ''), 1, 8)) as council_registration_no,
  'https://askexpert.in/docs/verification/' || id::text as document_url,
  'approved' as verification_status,
  now() as verified_at
FROM public.profiles
WHERE role = 'expert'
ON CONFLICT (expert_id) DO UPDATE SET
  verification_status = 'approved',
  verified_at = now();

-- 3. Verify total count of verified experts
SELECT 
  role,
  is_verified,
  count(*) as total_count
FROM public.profiles
GROUP BY role, is_verified;
