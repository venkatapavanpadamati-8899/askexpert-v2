-- ==============================================================================
-- MIGRATION: 20260912_grant_admin_pavan.sql
-- DESCRIPTION: Elevates venkatapavanpadamati1@gmail.com to Admin role
-- ==============================================================================

BEGIN;

-- 1. Update public.profiles if the profile exists
UPDATE public.profiles
SET 
  role = 'admin',
  is_verified = true,
  account_status = 'active',
  is_blocked = false
WHERE email ILIKE 'venkatapavanpadamati1@gmail.com'
   OR id IN (SELECT id FROM auth.users WHERE email ILIKE 'venkatapavanpadamati1@gmail.com');

-- 2. Insert into public.profiles if not present
INSERT INTO public.profiles (id, email, full_name, role, is_verified, account_status, is_blocked)
SELECT 
  id, 
  email, 
  COALESCE(raw_user_meta_data->>'full_name', raw_user_meta_data->>'name', 'Venkata Pavan (Admin)'), 
  'admin', 
  true, 
  'active', 
  false
FROM auth.users
WHERE email ILIKE 'venkatapavanpadamati1@gmail.com'
ON CONFLICT (id) DO UPDATE 
SET 
  role = 'admin',
  is_verified = true,
  account_status = 'active',
  is_blocked = false;

-- 3. Update auth metadata so session claims reflect admin role
UPDATE auth.users
SET 
  raw_user_meta_data = jsonb_set(COALESCE(raw_user_meta_data, '{}'::jsonb), '{role}', '"admin"'),
  raw_app_meta_data = jsonb_set(COALESCE(raw_app_meta_data, '{}'::jsonb), '{role}', '"admin"')
WHERE email ILIKE 'venkatapavanpadamati1@gmail.com';

COMMIT;

-- 4. Verification Query:
SELECT id, email, full_name, role, is_verified, account_status
FROM public.profiles
WHERE email ILIKE 'venkatapavanpadamati1@gmail.com';
