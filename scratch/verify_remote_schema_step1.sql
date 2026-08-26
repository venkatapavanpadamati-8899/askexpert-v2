-- ==============================================================================
-- ASKEXPERT - STEP 1: REMOTE SCHEMA & TRIGGER AUDIT + SINGLE TEST USER VERIFICATION
-- Run this script in Supabase SQL Editor to verify schema, triggers, and 1 test user
-- ==============================================================================

-- 1. Check & Add Columns to public.profiles safely
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS category TEXT,
  ADD COLUMN IF NOT EXISTS location TEXT,
  ADD COLUMN IF NOT EXISTS is_demo BOOLEAN DEFAULT false;

-- 2. Add performance indexes
CREATE INDEX IF NOT EXISTS idx_profiles_role_category ON public.profiles(role, category);
CREATE INDEX IF NOT EXISTS idx_profiles_role_rating ON public.profiles(role, rating DESC);
CREATE INDEX IF NOT EXISTS idx_profiles_role_avail ON public.profiles(role, availability_status);
CREATE INDEX IF NOT EXISTS idx_profiles_category ON public.profiles(category);

-- 3. Verify public.profiles columns exist
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_schema = 'public' AND table_name = 'profiles'
ORDER BY ordinal_position;

-- 4. Check trigger configuration
SELECT tgname, tgenabled, relname 
FROM pg_trigger t 
JOIN pg_class c ON t.tgrelid = c.oid 
WHERE tgname = 'on_auth_user_created';

-- 5. Test 1 Single Auth User Creation & Profile Update
DO $$
DECLARE
  test_uid UUID := 'f0000000-0000-0000-0000-000000000001';
BEGIN
  -- Insert 1 test auth user
  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    test_uid, '00000000-0000-0000-0000-000000000000', 'test_expert_verification@askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Test Audit Expert"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  -- Update or Insert into public.profiles with expert attributes
  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    test_uid, 'Test Audit Expert', 'expert', 'test_audit_expert', 'test_expert_verification@askexpert.com', '+91 99999 00001',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
    'Senior Test Expert in Agriculture', 'Agriculture Specialist', 'Agriculture & Farming',
    10, ARRAY['English', 'Telugu'], 4.90, 150, 1200,
    'Audit test expert verification account.', ARRAY['Agriculture Advisory', 'Testing'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
    role = EXCLUDED.role,
    headline = EXCLUDED.headline,
    specialization = EXCLUDED.specialization,
    category = EXCLUDED.category,
    experience_years = EXCLUDED.experience_years,
    rating = EXCLUDED.rating,
    reviews_count = EXCLUDED.reviews_count,
    consultation_fee = EXCLUDED.consultation_fee,
    avatar_url = EXCLUDED.avatar_url,
    location = EXCLUDED.location,
    is_demo = true;
END $$;

-- 6. Verify single created test user in profiles
SELECT id, full_name, role, category, specialization, is_demo 
FROM public.profiles 
WHERE id = 'f0000000-0000-0000-0000-000000000001';

-- 7. Clean up test verification user
DELETE FROM auth.users WHERE id = 'f0000000-0000-0000-0000-000000000001';
