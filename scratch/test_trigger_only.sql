-- ==============================================================================
-- ASKEXPERT - EXPLICIT TRIGGER TEST (INSERT ONLY INTO auth.users)
-- Tests whether on_auth_user_created trigger automatically fires handle_new_user()
-- ==============================================================================

-- 1. Ensure required columns exist on public.profiles
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS category TEXT,
  ADD COLUMN IF NOT EXISTS location TEXT,
  ADD COLUMN IF NOT EXISTS is_demo BOOLEAN DEFAULT false;

-- 2. Insert ONLY into auth.users (No manual insertion into public.profiles!)
INSERT INTO auth.users (
  id, instance_id, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
) VALUES (
  'f0000000-0000-0000-0000-000000000099', '00000000-0000-0000-0000-000000000000', 'trigger_test_user@askexpert.com',
  '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
  NOW(), '{"provider":"email","providers":["email"]}',
  '{"full_name":"Trigger Test User","role":"user","username":"trigger_test_user"}', NOW(), NOW(), 'authenticated', 'authenticated'
) ON CONFLICT (id) DO NOTHING;

-- 3. Verify if handle_new_user() trigger automatically created the profile in public.profiles!
SELECT id, full_name, role, username, email, created_at 
FROM public.profiles 
WHERE id = 'f0000000-0000-0000-0000-000000000099';

-- 4. Clean up the test user from auth.users (CASCADE will delete from public.profiles)
DELETE FROM auth.users WHERE id = 'f0000000-0000-0000-0000-000000000099';
