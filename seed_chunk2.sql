-- ==============================================================================
-- ASKEXPERT - SEED CHUNK 2 OF 5 (CATEGORIES 9 TO 16)
-- MODULAR SEED MIGRATION FILE FOR EASY EXECUTION IN SUPABASE SQL EDITOR
-- ==============================================================================

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS category TEXT,
  ADD COLUMN IF NOT EXISTS location TEXT,
  ADD COLUMN IF NOT EXISTS is_demo BOOLEAN DEFAULT false;

CREATE INDEX IF NOT EXISTS idx_profiles_role_category ON public.profiles(role, category);
CREATE INDEX IF NOT EXISTS idx_profiles_role_rating ON public.profiles(role, rating DESC);
CREATE INDEX IF NOT EXISTS idx_profiles_role_avail ON public.profiles(role, availability_status);
CREATE INDEX IF NOT EXISTS idx_profiles_category ON public.profiles(category);

DO $$
BEGIN
  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000100000000', '00000000-0000-0000-0000-000000000000', 'preeti_chopra_9_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000100000000', 'Preeti Chopra', 'expert', 'preeti_chopra_9_1', 'preeti_chopra_9_1@demo.askexpert.com', '+91 98000 00169',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (4+ Yrs Exp)', 'Taxation Specialist Level 2', 'Taxation',
    4, ARRAY['English', 'Hindi'], 4.30, 63, 650,
    'Certified professional with 4 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000200000000', '00000000-0000-0000-0000-000000000000', 'alok_jain_9_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000200000000', 'Alok Jain', 'expert', 'alok_jain_9_2', 'alok_jain_9_2@demo.askexpert.com', '+91 98000 00170',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (5+ Yrs Exp)', 'Taxation Specialist Level 3', 'Taxation',
    5, ARRAY['English', 'Hindi'], 4.40, 70, 800,
    'Certified professional with 5 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000300000000', '00000000-0000-0000-0000-000000000000', 'kavita_nair_9_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000300000000', 'Kavita Nair', 'expert', 'kavita_nair_9_3', 'kavita_nair_9_3@demo.askexpert.com', '+91 98000 00171',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (6+ Yrs Exp)', 'Taxation Specialist Level 1', 'Taxation',
    6, ARRAY['English', 'Hindi'], 4.50, 77, 950,
    'Certified professional with 6 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000400000000', '00000000-0000-0000-0000-000000000000', 'manish_sharma_9_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000400000000', 'Manish Sharma', 'expert', 'manish_sharma_9_4', 'manish_sharma_9_4@demo.askexpert.com', '+91 98000 00172',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (7+ Yrs Exp)', 'Taxation Specialist Level 2', 'Taxation',
    7, ARRAY['English', 'Hindi'], 4.60, 84, 1100,
    'Certified professional with 7 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000500000000', '00000000-0000-0000-0000-000000000000', 'pooja_reddy_9_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000500000000', 'Pooja Reddy', 'expert', 'pooja_reddy_9_5', 'pooja_reddy_9_5@demo.askexpert.com', '+91 98000 00173',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (8+ Yrs Exp)', 'Taxation Specialist Level 3', 'Taxation',
    8, ARRAY['English', 'Hindi'], 4.70, 91, 1250,
    'Certified professional with 8 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000600000000', '00000000-0000-0000-0000-000000000000', 'sanjay_kulkarni_9_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000600000000', 'Sanjay Kulkarni', 'expert', 'sanjay_kulkarni_9_6', 'sanjay_kulkarni_9_6@demo.askexpert.com', '+91 98000 00174',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (9+ Yrs Exp)', 'Taxation Specialist Level 1', 'Taxation',
    9, ARRAY['English', 'Hindi'], 4.80, 98, 1400,
    'Certified professional with 9 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000700000000', '00000000-0000-0000-0000-000000000000', 'tanvi_malhotra_9_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000700000000', 'Tanvi Malhotra', 'expert', 'tanvi_malhotra_9_7', 'tanvi_malhotra_9_7@demo.askexpert.com', '+91 98000 00175',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (10+ Yrs Exp)', 'Taxation Specialist Level 2', 'Taxation',
    10, ARRAY['English', 'Hindi'], 4.90, 105, 1550,
    'Certified professional with 10 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000800000000', '00000000-0000-0000-0000-000000000000', 'varun_bhattacharya_9_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000800000000', 'Varun Bhattacharya', 'expert', 'varun_bhattacharya_9_8', 'varun_bhattacharya_9_8@demo.askexpert.com', '+91 98000 00176',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (11+ Yrs Exp)', 'Taxation Specialist Level 3', 'Taxation',
    11, ARRAY['English', 'Hindi'], 4.20, 112, 1700,
    'Certified professional with 11 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000900000000', '00000000-0000-0000-0000-000000000000', 'divya_saxena_9_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000900000000', 'Divya Saxena', 'expert', 'divya_saxena_9_9', 'divya_saxena_9_9@demo.askexpert.com', '+91 98000 00177',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (12+ Yrs Exp)', 'Taxation Specialist Level 1', 'Taxation',
    12, ARRAY['English', 'Hindi'], 4.30, 119, 1850,
    'Certified professional with 12 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000a00000000', '00000000-0000-0000-0000-000000000000', 'gautam_gupta_9_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000a00000000', 'Gautam Gupta', 'expert', 'gautam_gupta_9_10', 'gautam_gupta_9_10@demo.askexpert.com', '+91 98000 00178',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (13+ Yrs Exp)', 'Taxation Specialist Level 2', 'Taxation',
    13, ARRAY['English', 'Hindi'], 4.40, 126, 2000,
    'Certified professional with 13 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000b00000000', '00000000-0000-0000-0000-000000000000', 'swati_chopra_9_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000b00000000', 'Swati Chopra', 'expert', 'swati_chopra_9_11', 'swati_chopra_9_11@demo.askexpert.com', '+91 98000 00179',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (14+ Yrs Exp)', 'Taxation Specialist Level 3', 'Taxation',
    14, ARRAY['English', 'Hindi'], 4.50, 133, 2150,
    'Certified professional with 14 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000c00000000', '00000000-0000-0000-0000-000000000000', 'rajesh_jain_9_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000c00000000', 'Rajesh Jain', 'expert', 'rajesh_jain_9_12', 'rajesh_jain_9_12@demo.askexpert.com', '+91 98000 00180',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (15+ Yrs Exp)', 'Taxation Specialist Level 1', 'Taxation',
    15, ARRAY['English', 'Hindi'], 4.60, 140, 2300,
    'Certified professional with 15 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000d00000000', '00000000-0000-0000-0000-000000000000', 'priya_nair_9_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000d00000000', 'Priya Nair', 'expert', 'priya_nair_9_13', 'priya_nair_9_13@demo.askexpert.com', '+91 98000 00181',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (16+ Yrs Exp)', 'Taxation Specialist Level 2', 'Taxation',
    16, ARRAY['English', 'Hindi'], 4.70, 147, 2450,
    'Certified professional with 16 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000e00000000', '00000000-0000-0000-0000-000000000000', 'vikram_sharma_9_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000e00000000', 'Vikram Sharma', 'expert', 'vikram_sharma_9_14', 'vikram_sharma_9_14@demo.askexpert.com', '+91 98000 00182',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (17+ Yrs Exp)', 'Taxation Specialist Level 3', 'Taxation',
    17, ARRAY['English', 'Hindi'], 4.80, 154, 2600,
    'Certified professional with 17 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-000f00000000', '00000000-0000-0000-0000-000000000000', 'ananya_reddy_9_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-000f00000000', 'Ananya Reddy', 'expert', 'ananya_reddy_9_15', 'ananya_reddy_9_15@demo.askexpert.com', '+91 98000 00183',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (18+ Yrs Exp)', 'Taxation Specialist Level 1', 'Taxation',
    18, ARRAY['English', 'Hindi'], 4.90, 161, 500,
    'Certified professional with 18 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-001000000000', '00000000-0000-0000-0000-000000000000', 'siddharth_kulkarni_9_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-001000000000', 'Siddharth Kulkarni', 'expert', 'siddharth_kulkarni_9_16', 'siddharth_kulkarni_9_16@demo.askexpert.com', '+91 98000 00184',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (19+ Yrs Exp)', 'Taxation Specialist Level 2', 'Taxation',
    19, ARRAY['English', 'Hindi'], 4.20, 168, 650,
    'Certified professional with 19 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-001100000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_malhotra_9_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-001100000000', 'Meenakshi Malhotra', 'expert', 'meenakshi_malhotra_9_17', 'meenakshi_malhotra_9_17@demo.askexpert.com', '+91 98000 00185',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (20+ Yrs Exp)', 'Taxation Specialist Level 3', 'Taxation',
    20, ARRAY['English', 'Hindi'], 4.30, 175, 800,
    'Certified professional with 20 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-001200000000', '00000000-0000-0000-0000-000000000000', 'amitabh_bhattacharya_9_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-001200000000', 'Amitabh Bhattacharya', 'expert', 'amitabh_bhattacharya_9_18', 'amitabh_bhattacharya_9_18@demo.askexpert.com', '+91 98000 00186',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (3+ Yrs Exp)', 'Taxation Specialist Level 1', 'Taxation',
    3, ARRAY['English', 'Hindi'], 4.40, 182, 950,
    'Certified professional with 3 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-001300000000', '00000000-0000-0000-0000-000000000000', 'sunita_saxena_9_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-001300000000', 'Sunita Saxena', 'expert', 'sunita_saxena_9_19', 'sunita_saxena_9_19@demo.askexpert.com', '+91 98000 00187',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (4+ Yrs Exp)', 'Taxation Specialist Level 2', 'Taxation',
    4, ARRAY['English', 'Hindi'], 4.50, 189, 1100,
    'Certified professional with 4 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-001400000000', '00000000-0000-0000-0000-000000000000', 'rohan_gupta_9_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-001400000000', 'Rohan Gupta', 'expert', 'rohan_gupta_9_20', 'rohan_gupta_9_20@demo.askexpert.com', '+91 98000 00188',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (5+ Yrs Exp)', 'Taxation Specialist Level 3', 'Taxation',
    5, ARRAY['English', 'Hindi'], 4.60, 196, 1250,
    'Certified professional with 5 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0900-001500000000', '00000000-0000-0000-0000-000000000000', 'shalini_chopra_9_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0900-001500000000', 'Shalini Chopra', 'expert', 'shalini_chopra_9_21', 'shalini_chopra_9_21@demo.askexpert.com', '+91 98000 00189',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Taxation (6+ Yrs Exp)', 'Taxation Specialist Level 1', 'Taxation',
    6, ARRAY['English', 'Hindi'], 4.70, 203, 1400,
    'Certified professional with 6 years of expertise in Taxation. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Taxation Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000100000000', '00000000-0000-0000-0000-000000000000', 'suresh_bhattacharya_10_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000100000000', 'Suresh Bhattacharya', 'expert', 'suresh_bhattacharya_10_1', 'suresh_bhattacharya_10_1@demo.askexpert.com', '+91 98000 00190',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (4+ Yrs Exp)', 'Business & Startup Specialist Level 2', 'Business & Startup',
    4, ARRAY['English', 'Hindi'], 4.30, 75, 650,
    'Certified professional with 4 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000200000000', '00000000-0000-0000-0000-000000000000', 'ritu_saxena_10_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000200000000', 'Ritu Saxena', 'expert', 'ritu_saxena_10_2', 'ritu_saxena_10_2@demo.askexpert.com', '+91 98000 00191',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (5+ Yrs Exp)', 'Business & Startup Specialist Level 3', 'Business & Startup',
    5, ARRAY['English', 'Hindi'], 4.40, 82, 800,
    'Certified professional with 5 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000300000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_gupta_10_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000300000000', 'Vikramaditya Gupta', 'expert', 'vikramaditya_gupta_10_3', 'vikramaditya_gupta_10_3@demo.askexpert.com', '+91 98000 00192',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (6+ Yrs Exp)', 'Business & Startup Specialist Level 1', 'Business & Startup',
    6, ARRAY['English', 'Hindi'], 4.50, 89, 950,
    'Certified professional with 6 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000400000000', '00000000-0000-0000-0000-000000000000', 'deepa_chopra_10_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000400000000', 'Deepa Chopra', 'expert', 'deepa_chopra_10_4', 'deepa_chopra_10_4@demo.askexpert.com', '+91 98000 00193',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (7+ Yrs Exp)', 'Business & Startup Specialist Level 2', 'Business & Startup',
    7, ARRAY['English', 'Hindi'], 4.60, 96, 1100,
    'Certified professional with 7 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000500000000', '00000000-0000-0000-0000-000000000000', 'arvind_jain_10_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000500000000', 'Arvind Jain', 'expert', 'arvind_jain_10_5', 'arvind_jain_10_5@demo.askexpert.com', '+91 98000 00194',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (8+ Yrs Exp)', 'Business & Startup Specialist Level 3', 'Business & Startup',
    8, ARRAY['English', 'Hindi'], 4.70, 103, 1250,
    'Certified professional with 8 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000600000000', '00000000-0000-0000-0000-000000000000', 'sneha_nair_10_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000600000000', 'Sneha Nair', 'expert', 'sneha_nair_10_6', 'sneha_nair_10_6@demo.askexpert.com', '+91 98000 00195',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (9+ Yrs Exp)', 'Business & Startup Specialist Level 1', 'Business & Startup',
    9, ARRAY['English', 'Hindi'], 4.80, 110, 1400,
    'Certified professional with 9 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000700000000', '00000000-0000-0000-0000-000000000000', 'karthik_sharma_10_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000700000000', 'Karthik Sharma', 'expert', 'karthik_sharma_10_7', 'karthik_sharma_10_7@demo.askexpert.com', '+91 98000 00196',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (10+ Yrs Exp)', 'Business & Startup Specialist Level 2', 'Business & Startup',
    10, ARRAY['English', 'Hindi'], 4.90, 117, 1550,
    'Certified professional with 10 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000800000000', '00000000-0000-0000-0000-000000000000', 'neha_reddy_10_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000800000000', 'Neha Reddy', 'expert', 'neha_reddy_10_8', 'neha_reddy_10_8@demo.askexpert.com', '+91 98000 00197',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (11+ Yrs Exp)', 'Business & Startup Specialist Level 3', 'Business & Startup',
    11, ARRAY['English', 'Hindi'], 4.20, 124, 1700,
    'Certified professional with 11 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000900000000', '00000000-0000-0000-0000-000000000000', 'devendra_kulkarni_10_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000900000000', 'Devendra Kulkarni', 'expert', 'devendra_kulkarni_10_9', 'devendra_kulkarni_10_9@demo.askexpert.com', '+91 98000 00198',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (12+ Yrs Exp)', 'Business & Startup Specialist Level 1', 'Business & Startup',
    12, ARRAY['English', 'Hindi'], 4.30, 131, 1850,
    'Certified professional with 12 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000a00000000', '00000000-0000-0000-0000-000000000000', 'preeti_malhotra_10_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000a00000000', 'Preeti Malhotra', 'expert', 'preeti_malhotra_10_10', 'preeti_malhotra_10_10@demo.askexpert.com', '+91 98000 00199',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (13+ Yrs Exp)', 'Business & Startup Specialist Level 2', 'Business & Startup',
    13, ARRAY['English', 'Hindi'], 4.40, 138, 2000,
    'Certified professional with 13 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000b00000000', '00000000-0000-0000-0000-000000000000', 'alok_bhattacharya_10_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000b00000000', 'Alok Bhattacharya', 'expert', 'alok_bhattacharya_10_11', 'alok_bhattacharya_10_11@demo.askexpert.com', '+91 98000 00200',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (14+ Yrs Exp)', 'Business & Startup Specialist Level 3', 'Business & Startup',
    14, ARRAY['English', 'Hindi'], 4.50, 145, 2150,
    'Certified professional with 14 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000c00000000', '00000000-0000-0000-0000-000000000000', 'kavita_saxena_10_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000c00000000', 'Kavita Saxena', 'expert', 'kavita_saxena_10_12', 'kavita_saxena_10_12@demo.askexpert.com', '+91 98000 00201',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (15+ Yrs Exp)', 'Business & Startup Specialist Level 1', 'Business & Startup',
    15, ARRAY['English', 'Hindi'], 4.60, 152, 2300,
    'Certified professional with 15 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000d00000000', '00000000-0000-0000-0000-000000000000', 'manish_gupta_10_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000d00000000', 'Manish Gupta', 'expert', 'manish_gupta_10_13', 'manish_gupta_10_13@demo.askexpert.com', '+91 98000 00202',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (16+ Yrs Exp)', 'Business & Startup Specialist Level 2', 'Business & Startup',
    16, ARRAY['English', 'Hindi'], 4.70, 159, 2450,
    'Certified professional with 16 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000e00000000', '00000000-0000-0000-0000-000000000000', 'pooja_chopra_10_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000e00000000', 'Pooja Chopra', 'expert', 'pooja_chopra_10_14', 'pooja_chopra_10_14@demo.askexpert.com', '+91 98000 00203',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (17+ Yrs Exp)', 'Business & Startup Specialist Level 3', 'Business & Startup',
    17, ARRAY['English', 'Hindi'], 4.80, 166, 2600,
    'Certified professional with 17 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-000f00000000', '00000000-0000-0000-0000-000000000000', 'sanjay_jain_10_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-000f00000000', 'Sanjay Jain', 'expert', 'sanjay_jain_10_15', 'sanjay_jain_10_15@demo.askexpert.com', '+91 98000 00204',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (18+ Yrs Exp)', 'Business & Startup Specialist Level 1', 'Business & Startup',
    18, ARRAY['English', 'Hindi'], 4.90, 173, 500,
    'Certified professional with 18 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-001000000000', '00000000-0000-0000-0000-000000000000', 'tanvi_nair_10_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-001000000000', 'Tanvi Nair', 'expert', 'tanvi_nair_10_16', 'tanvi_nair_10_16@demo.askexpert.com', '+91 98000 00205',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (19+ Yrs Exp)', 'Business & Startup Specialist Level 2', 'Business & Startup',
    19, ARRAY['English', 'Hindi'], 4.20, 180, 650,
    'Certified professional with 19 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-001100000000', '00000000-0000-0000-0000-000000000000', 'varun_sharma_10_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-001100000000', 'Varun Sharma', 'expert', 'varun_sharma_10_17', 'varun_sharma_10_17@demo.askexpert.com', '+91 98000 00206',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (20+ Yrs Exp)', 'Business & Startup Specialist Level 3', 'Business & Startup',
    20, ARRAY['English', 'Hindi'], 4.30, 187, 800,
    'Certified professional with 20 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-001200000000', '00000000-0000-0000-0000-000000000000', 'divya_reddy_10_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-001200000000', 'Divya Reddy', 'expert', 'divya_reddy_10_18', 'divya_reddy_10_18@demo.askexpert.com', '+91 98000 00207',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (3+ Yrs Exp)', 'Business & Startup Specialist Level 1', 'Business & Startup',
    3, ARRAY['English', 'Hindi'], 4.40, 194, 950,
    'Certified professional with 3 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-001300000000', '00000000-0000-0000-0000-000000000000', 'gautam_kulkarni_10_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-001300000000', 'Gautam Kulkarni', 'expert', 'gautam_kulkarni_10_19', 'gautam_kulkarni_10_19@demo.askexpert.com', '+91 98000 00208',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (4+ Yrs Exp)', 'Business & Startup Specialist Level 2', 'Business & Startup',
    4, ARRAY['English', 'Hindi'], 4.50, 201, 1100,
    'Certified professional with 4 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-001400000000', '00000000-0000-0000-0000-000000000000', 'swati_malhotra_10_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-001400000000', 'Swati Malhotra', 'expert', 'swati_malhotra_10_20', 'swati_malhotra_10_20@demo.askexpert.com', '+91 98000 00209',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (5+ Yrs Exp)', 'Business & Startup Specialist Level 3', 'Business & Startup',
    5, ARRAY['English', 'Hindi'], 4.60, 208, 1250,
    'Certified professional with 5 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0a00-001500000000', '00000000-0000-0000-0000-000000000000', 'rajesh_bhattacharya_10_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0a00-001500000000', 'Rajesh Bhattacharya', 'expert', 'rajesh_bhattacharya_10_21', 'rajesh_bhattacharya_10_21@demo.askexpert.com', '+91 98000 00210',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Business & Startup (6+ Yrs Exp)', 'Business & Startup Specialist Level 1', 'Business & Startup',
    6, ARRAY['English', 'Hindi'], 4.70, 215, 1400,
    'Certified professional with 6 years of expertise in Business & Startup. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Business & Startup Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000100000000', '00000000-0000-0000-0000-000000000000', 'priya_reddy_11_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000100000000', 'Priya Reddy', 'expert', 'priya_reddy_11_1', 'priya_reddy_11_1@demo.askexpert.com', '+91 98000 00211',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (4+ Yrs Exp)', 'Marketing Specialist Level 2', 'Marketing',
    4, ARRAY['English', 'Hindi'], 4.30, 27, 650,
    'Certified professional with 4 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000200000000', '00000000-0000-0000-0000-000000000000', 'vikram_kulkarni_11_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000200000000', 'Vikram Kulkarni', 'expert', 'vikram_kulkarni_11_2', 'vikram_kulkarni_11_2@demo.askexpert.com', '+91 98000 00212',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (5+ Yrs Exp)', 'Marketing Specialist Level 3', 'Marketing',
    5, ARRAY['English', 'Hindi'], 4.40, 34, 800,
    'Certified professional with 5 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000300000000', '00000000-0000-0000-0000-000000000000', 'ananya_malhotra_11_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000300000000', 'Ananya Malhotra', 'expert', 'ananya_malhotra_11_3', 'ananya_malhotra_11_3@demo.askexpert.com', '+91 98000 00213',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (6+ Yrs Exp)', 'Marketing Specialist Level 1', 'Marketing',
    6, ARRAY['English', 'Hindi'], 4.50, 41, 950,
    'Certified professional with 6 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000400000000', '00000000-0000-0000-0000-000000000000', 'siddharth_bhattacharya_11_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000400000000', 'Siddharth Bhattacharya', 'expert', 'siddharth_bhattacharya_11_4', 'siddharth_bhattacharya_11_4@demo.askexpert.com', '+91 98000 00214',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (7+ Yrs Exp)', 'Marketing Specialist Level 2', 'Marketing',
    7, ARRAY['English', 'Hindi'], 4.60, 48, 1100,
    'Certified professional with 7 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000500000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_saxena_11_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000500000000', 'Meenakshi Saxena', 'expert', 'meenakshi_saxena_11_5', 'meenakshi_saxena_11_5@demo.askexpert.com', '+91 98000 00215',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (8+ Yrs Exp)', 'Marketing Specialist Level 3', 'Marketing',
    8, ARRAY['English', 'Hindi'], 4.70, 55, 1250,
    'Certified professional with 8 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000600000000', '00000000-0000-0000-0000-000000000000', 'amitabh_gupta_11_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000600000000', 'Amitabh Gupta', 'expert', 'amitabh_gupta_11_6', 'amitabh_gupta_11_6@demo.askexpert.com', '+91 98000 00216',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (9+ Yrs Exp)', 'Marketing Specialist Level 1', 'Marketing',
    9, ARRAY['English', 'Hindi'], 4.80, 62, 1400,
    'Certified professional with 9 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000700000000', '00000000-0000-0000-0000-000000000000', 'sunita_chopra_11_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000700000000', 'Sunita Chopra', 'expert', 'sunita_chopra_11_7', 'sunita_chopra_11_7@demo.askexpert.com', '+91 98000 00217',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (10+ Yrs Exp)', 'Marketing Specialist Level 2', 'Marketing',
    10, ARRAY['English', 'Hindi'], 4.90, 69, 1550,
    'Certified professional with 10 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000800000000', '00000000-0000-0000-0000-000000000000', 'rohan_jain_11_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000800000000', 'Rohan Jain', 'expert', 'rohan_jain_11_8', 'rohan_jain_11_8@demo.askexpert.com', '+91 98000 00218',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (11+ Yrs Exp)', 'Marketing Specialist Level 3', 'Marketing',
    11, ARRAY['English', 'Hindi'], 4.20, 76, 1700,
    'Certified professional with 11 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000900000000', '00000000-0000-0000-0000-000000000000', 'shalini_nair_11_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000900000000', 'Shalini Nair', 'expert', 'shalini_nair_11_9', 'shalini_nair_11_9@demo.askexpert.com', '+91 98000 00219',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (12+ Yrs Exp)', 'Marketing Specialist Level 1', 'Marketing',
    12, ARRAY['English', 'Hindi'], 4.30, 83, 1850,
    'Certified professional with 12 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000a00000000', '00000000-0000-0000-0000-000000000000', 'suresh_sharma_11_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000a00000000', 'Suresh Sharma', 'expert', 'suresh_sharma_11_10', 'suresh_sharma_11_10@demo.askexpert.com', '+91 98000 00220',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (13+ Yrs Exp)', 'Marketing Specialist Level 2', 'Marketing',
    13, ARRAY['English', 'Hindi'], 4.40, 90, 2000,
    'Certified professional with 13 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000b00000000', '00000000-0000-0000-0000-000000000000', 'ritu_reddy_11_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000b00000000', 'Ritu Reddy', 'expert', 'ritu_reddy_11_11', 'ritu_reddy_11_11@demo.askexpert.com', '+91 98000 00221',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (14+ Yrs Exp)', 'Marketing Specialist Level 3', 'Marketing',
    14, ARRAY['English', 'Hindi'], 4.50, 97, 2150,
    'Certified professional with 14 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000c00000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_kulkarni_11_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000c00000000', 'Vikramaditya Kulkarni', 'expert', 'vikramaditya_kulkarni_11_12', 'vikramaditya_kulkarni_11_12@demo.askexpert.com', '+91 98000 00222',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (15+ Yrs Exp)', 'Marketing Specialist Level 1', 'Marketing',
    15, ARRAY['English', 'Hindi'], 4.60, 104, 2300,
    'Certified professional with 15 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000d00000000', '00000000-0000-0000-0000-000000000000', 'deepa_malhotra_11_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000d00000000', 'Deepa Malhotra', 'expert', 'deepa_malhotra_11_13', 'deepa_malhotra_11_13@demo.askexpert.com', '+91 98000 00223',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (16+ Yrs Exp)', 'Marketing Specialist Level 2', 'Marketing',
    16, ARRAY['English', 'Hindi'], 4.70, 111, 2450,
    'Certified professional with 16 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000e00000000', '00000000-0000-0000-0000-000000000000', 'arvind_bhattacharya_11_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000e00000000', 'Arvind Bhattacharya', 'expert', 'arvind_bhattacharya_11_14', 'arvind_bhattacharya_11_14@demo.askexpert.com', '+91 98000 00224',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (17+ Yrs Exp)', 'Marketing Specialist Level 3', 'Marketing',
    17, ARRAY['English', 'Hindi'], 4.80, 118, 2600,
    'Certified professional with 17 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-000f00000000', '00000000-0000-0000-0000-000000000000', 'sneha_saxena_11_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-000f00000000', 'Sneha Saxena', 'expert', 'sneha_saxena_11_15', 'sneha_saxena_11_15@demo.askexpert.com', '+91 98000 00225',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (18+ Yrs Exp)', 'Marketing Specialist Level 1', 'Marketing',
    18, ARRAY['English', 'Hindi'], 4.90, 125, 500,
    'Certified professional with 18 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-001000000000', '00000000-0000-0000-0000-000000000000', 'karthik_gupta_11_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-001000000000', 'Karthik Gupta', 'expert', 'karthik_gupta_11_16', 'karthik_gupta_11_16@demo.askexpert.com', '+91 98000 00226',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (19+ Yrs Exp)', 'Marketing Specialist Level 2', 'Marketing',
    19, ARRAY['English', 'Hindi'], 4.20, 132, 650,
    'Certified professional with 19 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-001100000000', '00000000-0000-0000-0000-000000000000', 'neha_chopra_11_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-001100000000', 'Neha Chopra', 'expert', 'neha_chopra_11_17', 'neha_chopra_11_17@demo.askexpert.com', '+91 98000 00227',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (20+ Yrs Exp)', 'Marketing Specialist Level 3', 'Marketing',
    20, ARRAY['English', 'Hindi'], 4.30, 139, 800,
    'Certified professional with 20 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-001200000000', '00000000-0000-0000-0000-000000000000', 'devendra_jain_11_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-001200000000', 'Devendra Jain', 'expert', 'devendra_jain_11_18', 'devendra_jain_11_18@demo.askexpert.com', '+91 98000 00228',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (3+ Yrs Exp)', 'Marketing Specialist Level 1', 'Marketing',
    3, ARRAY['English', 'Hindi'], 4.40, 146, 950,
    'Certified professional with 3 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-001300000000', '00000000-0000-0000-0000-000000000000', 'preeti_nair_11_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-001300000000', 'Preeti Nair', 'expert', 'preeti_nair_11_19', 'preeti_nair_11_19@demo.askexpert.com', '+91 98000 00229',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (4+ Yrs Exp)', 'Marketing Specialist Level 2', 'Marketing',
    4, ARRAY['English', 'Hindi'], 4.50, 153, 1100,
    'Certified professional with 4 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-001400000000', '00000000-0000-0000-0000-000000000000', 'alok_sharma_11_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-001400000000', 'Alok Sharma', 'expert', 'alok_sharma_11_20', 'alok_sharma_11_20@demo.askexpert.com', '+91 98000 00230',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (5+ Yrs Exp)', 'Marketing Specialist Level 3', 'Marketing',
    5, ARRAY['English', 'Hindi'], 4.60, 160, 1250,
    'Certified professional with 5 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0b00-001500000000', '00000000-0000-0000-0000-000000000000', 'kavita_reddy_11_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0b00-001500000000', 'Kavita Reddy', 'expert', 'kavita_reddy_11_21', 'kavita_reddy_11_21@demo.askexpert.com', '+91 98000 00231',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Marketing (6+ Yrs Exp)', 'Marketing Specialist Level 1', 'Marketing',
    6, ARRAY['English', 'Hindi'], 4.70, 167, 1400,
    'Certified professional with 6 years of expertise in Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Marketing Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000100000000', '00000000-0000-0000-0000-000000000000', 'manish_jain_12_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000100000000', 'Manish Jain', 'expert', 'manish_jain_12_1', 'manish_jain_12_1@demo.askexpert.com', '+91 98000 00232',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (4+ Yrs Exp)', 'Human Resources & Careers Specialist Level 2', 'Human Resources & Careers',
    4, ARRAY['English', 'Hindi'], 4.30, 39, 650,
    'Certified professional with 4 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000200000000', '00000000-0000-0000-0000-000000000000', 'pooja_nair_12_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000200000000', 'Pooja Nair', 'expert', 'pooja_nair_12_2', 'pooja_nair_12_2@demo.askexpert.com', '+91 98000 00233',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (5+ Yrs Exp)', 'Human Resources & Careers Specialist Level 3', 'Human Resources & Careers',
    5, ARRAY['English', 'Hindi'], 4.40, 46, 800,
    'Certified professional with 5 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000300000000', '00000000-0000-0000-0000-000000000000', 'sanjay_sharma_12_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000300000000', 'Sanjay Sharma', 'expert', 'sanjay_sharma_12_3', 'sanjay_sharma_12_3@demo.askexpert.com', '+91 98000 00234',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (6+ Yrs Exp)', 'Human Resources & Careers Specialist Level 1', 'Human Resources & Careers',
    6, ARRAY['English', 'Hindi'], 4.50, 53, 950,
    'Certified professional with 6 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000400000000', '00000000-0000-0000-0000-000000000000', 'tanvi_reddy_12_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000400000000', 'Tanvi Reddy', 'expert', 'tanvi_reddy_12_4', 'tanvi_reddy_12_4@demo.askexpert.com', '+91 98000 00235',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (7+ Yrs Exp)', 'Human Resources & Careers Specialist Level 2', 'Human Resources & Careers',
    7, ARRAY['English', 'Hindi'], 4.60, 60, 1100,
    'Certified professional with 7 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000500000000', '00000000-0000-0000-0000-000000000000', 'varun_kulkarni_12_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000500000000', 'Varun Kulkarni', 'expert', 'varun_kulkarni_12_5', 'varun_kulkarni_12_5@demo.askexpert.com', '+91 98000 00236',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (8+ Yrs Exp)', 'Human Resources & Careers Specialist Level 3', 'Human Resources & Careers',
    8, ARRAY['English', 'Hindi'], 4.70, 67, 1250,
    'Certified professional with 8 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000600000000', '00000000-0000-0000-0000-000000000000', 'divya_malhotra_12_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000600000000', 'Divya Malhotra', 'expert', 'divya_malhotra_12_6', 'divya_malhotra_12_6@demo.askexpert.com', '+91 98000 00237',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (9+ Yrs Exp)', 'Human Resources & Careers Specialist Level 1', 'Human Resources & Careers',
    9, ARRAY['English', 'Hindi'], 4.80, 74, 1400,
    'Certified professional with 9 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000700000000', '00000000-0000-0000-0000-000000000000', 'gautam_bhattacharya_12_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000700000000', 'Gautam Bhattacharya', 'expert', 'gautam_bhattacharya_12_7', 'gautam_bhattacharya_12_7@demo.askexpert.com', '+91 98000 00238',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (10+ Yrs Exp)', 'Human Resources & Careers Specialist Level 2', 'Human Resources & Careers',
    10, ARRAY['English', 'Hindi'], 4.90, 81, 1550,
    'Certified professional with 10 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000800000000', '00000000-0000-0000-0000-000000000000', 'swati_saxena_12_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000800000000', 'Swati Saxena', 'expert', 'swati_saxena_12_8', 'swati_saxena_12_8@demo.askexpert.com', '+91 98000 00239',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (11+ Yrs Exp)', 'Human Resources & Careers Specialist Level 3', 'Human Resources & Careers',
    11, ARRAY['English', 'Hindi'], 4.20, 88, 1700,
    'Certified professional with 11 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000900000000', '00000000-0000-0000-0000-000000000000', 'rajesh_gupta_12_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000900000000', 'Rajesh Gupta', 'expert', 'rajesh_gupta_12_9', 'rajesh_gupta_12_9@demo.askexpert.com', '+91 98000 00240',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (12+ Yrs Exp)', 'Human Resources & Careers Specialist Level 1', 'Human Resources & Careers',
    12, ARRAY['English', 'Hindi'], 4.30, 95, 1850,
    'Certified professional with 12 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000a00000000', '00000000-0000-0000-0000-000000000000', 'priya_chopra_12_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000a00000000', 'Priya Chopra', 'expert', 'priya_chopra_12_10', 'priya_chopra_12_10@demo.askexpert.com', '+91 98000 00241',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (13+ Yrs Exp)', 'Human Resources & Careers Specialist Level 2', 'Human Resources & Careers',
    13, ARRAY['English', 'Hindi'], 4.40, 102, 2000,
    'Certified professional with 13 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000b00000000', '00000000-0000-0000-0000-000000000000', 'vikram_jain_12_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000b00000000', 'Vikram Jain', 'expert', 'vikram_jain_12_11', 'vikram_jain_12_11@demo.askexpert.com', '+91 98000 00242',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (14+ Yrs Exp)', 'Human Resources & Careers Specialist Level 3', 'Human Resources & Careers',
    14, ARRAY['English', 'Hindi'], 4.50, 109, 2150,
    'Certified professional with 14 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000c00000000', '00000000-0000-0000-0000-000000000000', 'ananya_nair_12_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000c00000000', 'Ananya Nair', 'expert', 'ananya_nair_12_12', 'ananya_nair_12_12@demo.askexpert.com', '+91 98000 00243',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (15+ Yrs Exp)', 'Human Resources & Careers Specialist Level 1', 'Human Resources & Careers',
    15, ARRAY['English', 'Hindi'], 4.60, 116, 2300,
    'Certified professional with 15 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000d00000000', '00000000-0000-0000-0000-000000000000', 'siddharth_sharma_12_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000d00000000', 'Siddharth Sharma', 'expert', 'siddharth_sharma_12_13', 'siddharth_sharma_12_13@demo.askexpert.com', '+91 98000 00244',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (16+ Yrs Exp)', 'Human Resources & Careers Specialist Level 2', 'Human Resources & Careers',
    16, ARRAY['English', 'Hindi'], 4.70, 123, 2450,
    'Certified professional with 16 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000e00000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_reddy_12_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000e00000000', 'Meenakshi Reddy', 'expert', 'meenakshi_reddy_12_14', 'meenakshi_reddy_12_14@demo.askexpert.com', '+91 98000 00245',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (17+ Yrs Exp)', 'Human Resources & Careers Specialist Level 3', 'Human Resources & Careers',
    17, ARRAY['English', 'Hindi'], 4.80, 130, 2600,
    'Certified professional with 17 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-000f00000000', '00000000-0000-0000-0000-000000000000', 'amitabh_kulkarni_12_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-000f00000000', 'Amitabh Kulkarni', 'expert', 'amitabh_kulkarni_12_15', 'amitabh_kulkarni_12_15@demo.askexpert.com', '+91 98000 00246',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (18+ Yrs Exp)', 'Human Resources & Careers Specialist Level 1', 'Human Resources & Careers',
    18, ARRAY['English', 'Hindi'], 4.90, 137, 500,
    'Certified professional with 18 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-001000000000', '00000000-0000-0000-0000-000000000000', 'sunita_malhotra_12_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-001000000000', 'Sunita Malhotra', 'expert', 'sunita_malhotra_12_16', 'sunita_malhotra_12_16@demo.askexpert.com', '+91 98000 00247',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (19+ Yrs Exp)', 'Human Resources & Careers Specialist Level 2', 'Human Resources & Careers',
    19, ARRAY['English', 'Hindi'], 4.20, 144, 650,
    'Certified professional with 19 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-001100000000', '00000000-0000-0000-0000-000000000000', 'rohan_bhattacharya_12_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-001100000000', 'Rohan Bhattacharya', 'expert', 'rohan_bhattacharya_12_17', 'rohan_bhattacharya_12_17@demo.askexpert.com', '+91 98000 00248',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (20+ Yrs Exp)', 'Human Resources & Careers Specialist Level 3', 'Human Resources & Careers',
    20, ARRAY['English', 'Hindi'], 4.30, 151, 800,
    'Certified professional with 20 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-001200000000', '00000000-0000-0000-0000-000000000000', 'shalini_saxena_12_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-001200000000', 'Shalini Saxena', 'expert', 'shalini_saxena_12_18', 'shalini_saxena_12_18@demo.askexpert.com', '+91 98000 00249',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (3+ Yrs Exp)', 'Human Resources & Careers Specialist Level 1', 'Human Resources & Careers',
    3, ARRAY['English', 'Hindi'], 4.40, 158, 950,
    'Certified professional with 3 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-001300000000', '00000000-0000-0000-0000-000000000000', 'suresh_gupta_12_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-001300000000', 'Suresh Gupta', 'expert', 'suresh_gupta_12_19', 'suresh_gupta_12_19@demo.askexpert.com', '+91 98000 00250',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (4+ Yrs Exp)', 'Human Resources & Careers Specialist Level 2', 'Human Resources & Careers',
    4, ARRAY['English', 'Hindi'], 4.50, 165, 1100,
    'Certified professional with 4 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-001400000000', '00000000-0000-0000-0000-000000000000', 'ritu_chopra_12_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-001400000000', 'Ritu Chopra', 'expert', 'ritu_chopra_12_20', 'ritu_chopra_12_20@demo.askexpert.com', '+91 98000 00251',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (5+ Yrs Exp)', 'Human Resources & Careers Specialist Level 3', 'Human Resources & Careers',
    5, ARRAY['English', 'Hindi'], 4.60, 172, 1250,
    'Certified professional with 5 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0c00-001500000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_jain_12_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0c00-001500000000', 'Vikramaditya Jain', 'expert', 'vikramaditya_jain_12_21', 'vikramaditya_jain_12_21@demo.askexpert.com', '+91 98000 00252',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Human Resources & Careers (6+ Yrs Exp)', 'Human Resources & Careers Specialist Level 1', 'Human Resources & Careers',
    6, ARRAY['English', 'Hindi'], 4.70, 179, 1400,
    'Certified professional with 6 years of expertise in Human Resources & Careers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Human Resources & Careers Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000100000000', '00000000-0000-0000-0000-000000000000', 'deepa_saxena_13_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000100000000', 'Deepa Saxena', 'expert', 'deepa_saxena_13_1', 'deepa_saxena_13_1@demo.askexpert.com', '+91 98000 00253',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (4+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 2', 'Medicine & Healthcare',
    4, ARRAY['English', 'Hindi'], 4.30, 51, 650,
    'Certified professional with 4 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000200000000', '00000000-0000-0000-0000-000000000000', 'arvind_gupta_13_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000200000000', 'Arvind Gupta', 'expert', 'arvind_gupta_13_2', 'arvind_gupta_13_2@demo.askexpert.com', '+91 98000 00254',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (5+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 3', 'Medicine & Healthcare',
    5, ARRAY['English', 'Hindi'], 4.40, 58, 800,
    'Certified professional with 5 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000300000000', '00000000-0000-0000-0000-000000000000', 'sneha_chopra_13_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000300000000', 'Sneha Chopra', 'expert', 'sneha_chopra_13_3', 'sneha_chopra_13_3@demo.askexpert.com', '+91 98000 00255',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (6+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 1', 'Medicine & Healthcare',
    6, ARRAY['English', 'Hindi'], 4.50, 65, 950,
    'Certified professional with 6 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000400000000', '00000000-0000-0000-0000-000000000000', 'karthik_jain_13_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000400000000', 'Karthik Jain', 'expert', 'karthik_jain_13_4', 'karthik_jain_13_4@demo.askexpert.com', '+91 98000 00256',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (7+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 2', 'Medicine & Healthcare',
    7, ARRAY['English', 'Hindi'], 4.60, 72, 1100,
    'Certified professional with 7 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000500000000', '00000000-0000-0000-0000-000000000000', 'neha_nair_13_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000500000000', 'Neha Nair', 'expert', 'neha_nair_13_5', 'neha_nair_13_5@demo.askexpert.com', '+91 98000 00257',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (8+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 3', 'Medicine & Healthcare',
    8, ARRAY['English', 'Hindi'], 4.70, 79, 1250,
    'Certified professional with 8 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000600000000', '00000000-0000-0000-0000-000000000000', 'devendra_sharma_13_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000600000000', 'Devendra Sharma', 'expert', 'devendra_sharma_13_6', 'devendra_sharma_13_6@demo.askexpert.com', '+91 98000 00258',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (9+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 1', 'Medicine & Healthcare',
    9, ARRAY['English', 'Hindi'], 4.80, 86, 1400,
    'Certified professional with 9 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000700000000', '00000000-0000-0000-0000-000000000000', 'preeti_reddy_13_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000700000000', 'Preeti Reddy', 'expert', 'preeti_reddy_13_7', 'preeti_reddy_13_7@demo.askexpert.com', '+91 98000 00259',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (10+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 2', 'Medicine & Healthcare',
    10, ARRAY['English', 'Hindi'], 4.90, 93, 1550,
    'Certified professional with 10 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000800000000', '00000000-0000-0000-0000-000000000000', 'alok_kulkarni_13_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000800000000', 'Alok Kulkarni', 'expert', 'alok_kulkarni_13_8', 'alok_kulkarni_13_8@demo.askexpert.com', '+91 98000 00260',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (11+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 3', 'Medicine & Healthcare',
    11, ARRAY['English', 'Hindi'], 4.20, 100, 1700,
    'Certified professional with 11 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000900000000', '00000000-0000-0000-0000-000000000000', 'kavita_malhotra_13_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000900000000', 'Kavita Malhotra', 'expert', 'kavita_malhotra_13_9', 'kavita_malhotra_13_9@demo.askexpert.com', '+91 98000 00261',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (12+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 1', 'Medicine & Healthcare',
    12, ARRAY['English', 'Hindi'], 4.30, 107, 1850,
    'Certified professional with 12 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000a00000000', '00000000-0000-0000-0000-000000000000', 'manish_bhattacharya_13_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000a00000000', 'Manish Bhattacharya', 'expert', 'manish_bhattacharya_13_10', 'manish_bhattacharya_13_10@demo.askexpert.com', '+91 98000 00262',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (13+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 2', 'Medicine & Healthcare',
    13, ARRAY['English', 'Hindi'], 4.40, 114, 2000,
    'Certified professional with 13 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000b00000000', '00000000-0000-0000-0000-000000000000', 'pooja_saxena_13_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000b00000000', 'Pooja Saxena', 'expert', 'pooja_saxena_13_11', 'pooja_saxena_13_11@demo.askexpert.com', '+91 98000 00263',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (14+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 3', 'Medicine & Healthcare',
    14, ARRAY['English', 'Hindi'], 4.50, 121, 2150,
    'Certified professional with 14 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000c00000000', '00000000-0000-0000-0000-000000000000', 'sanjay_gupta_13_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000c00000000', 'Sanjay Gupta', 'expert', 'sanjay_gupta_13_12', 'sanjay_gupta_13_12@demo.askexpert.com', '+91 98000 00264',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (15+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 1', 'Medicine & Healthcare',
    15, ARRAY['English', 'Hindi'], 4.60, 128, 2300,
    'Certified professional with 15 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000d00000000', '00000000-0000-0000-0000-000000000000', 'tanvi_chopra_13_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000d00000000', 'Tanvi Chopra', 'expert', 'tanvi_chopra_13_13', 'tanvi_chopra_13_13@demo.askexpert.com', '+91 98000 00265',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (16+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 2', 'Medicine & Healthcare',
    16, ARRAY['English', 'Hindi'], 4.70, 135, 2450,
    'Certified professional with 16 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000e00000000', '00000000-0000-0000-0000-000000000000', 'varun_jain_13_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000e00000000', 'Varun Jain', 'expert', 'varun_jain_13_14', 'varun_jain_13_14@demo.askexpert.com', '+91 98000 00266',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (17+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 3', 'Medicine & Healthcare',
    17, ARRAY['English', 'Hindi'], 4.80, 142, 2600,
    'Certified professional with 17 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-000f00000000', '00000000-0000-0000-0000-000000000000', 'divya_nair_13_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-000f00000000', 'Divya Nair', 'expert', 'divya_nair_13_15', 'divya_nair_13_15@demo.askexpert.com', '+91 98000 00267',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (18+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 1', 'Medicine & Healthcare',
    18, ARRAY['English', 'Hindi'], 4.90, 149, 500,
    'Certified professional with 18 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-001000000000', '00000000-0000-0000-0000-000000000000', 'gautam_sharma_13_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-001000000000', 'Gautam Sharma', 'expert', 'gautam_sharma_13_16', 'gautam_sharma_13_16@demo.askexpert.com', '+91 98000 00268',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (19+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 2', 'Medicine & Healthcare',
    19, ARRAY['English', 'Hindi'], 4.20, 156, 650,
    'Certified professional with 19 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-001100000000', '00000000-0000-0000-0000-000000000000', 'swati_reddy_13_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-001100000000', 'Swati Reddy', 'expert', 'swati_reddy_13_17', 'swati_reddy_13_17@demo.askexpert.com', '+91 98000 00269',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (20+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 3', 'Medicine & Healthcare',
    20, ARRAY['English', 'Hindi'], 4.30, 163, 800,
    'Certified professional with 20 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-001200000000', '00000000-0000-0000-0000-000000000000', 'rajesh_kulkarni_13_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-001200000000', 'Rajesh Kulkarni', 'expert', 'rajesh_kulkarni_13_18', 'rajesh_kulkarni_13_18@demo.askexpert.com', '+91 98000 00270',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (3+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 1', 'Medicine & Healthcare',
    3, ARRAY['English', 'Hindi'], 4.40, 170, 950,
    'Certified professional with 3 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-001300000000', '00000000-0000-0000-0000-000000000000', 'priya_malhotra_13_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-001300000000', 'Priya Malhotra', 'expert', 'priya_malhotra_13_19', 'priya_malhotra_13_19@demo.askexpert.com', '+91 98000 00271',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (4+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 2', 'Medicine & Healthcare',
    4, ARRAY['English', 'Hindi'], 4.50, 177, 1100,
    'Certified professional with 4 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-001400000000', '00000000-0000-0000-0000-000000000000', 'vikram_bhattacharya_13_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-001400000000', 'Vikram Bhattacharya', 'expert', 'vikram_bhattacharya_13_20', 'vikram_bhattacharya_13_20@demo.askexpert.com', '+91 98000 00272',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (5+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 3', 'Medicine & Healthcare',
    5, ARRAY['English', 'Hindi'], 4.60, 184, 1250,
    'Certified professional with 5 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0d00-001500000000', '00000000-0000-0000-0000-000000000000', 'ananya_saxena_13_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0d00-001500000000', 'Ananya Saxena', 'expert', 'ananya_saxena_13_21', 'ananya_saxena_13_21@demo.askexpert.com', '+91 98000 00273',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Medicine & Healthcare (6+ Yrs Exp)', 'Medicine & Healthcare Specialist Level 1', 'Medicine & Healthcare',
    6, ARRAY['English', 'Hindi'], 4.70, 191, 1400,
    'Certified professional with 6 years of expertise in Medicine & Healthcare. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Medicine & Healthcare Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000100000000', '00000000-0000-0000-0000-000000000000', 'siddharth_kulkarni_14_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000100000000', 'Siddharth Kulkarni', 'expert', 'siddharth_kulkarni_14_1', 'siddharth_kulkarni_14_1@demo.askexpert.com', '+91 98000 00274',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (4+ Yrs Exp)', 'Mental Wellness Specialist Level 2', 'Mental Wellness',
    4, ARRAY['English', 'Hindi'], 4.30, 63, 650,
    'Certified professional with 4 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000200000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_malhotra_14_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000200000000', 'Meenakshi Malhotra', 'expert', 'meenakshi_malhotra_14_2', 'meenakshi_malhotra_14_2@demo.askexpert.com', '+91 98000 00275',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (5+ Yrs Exp)', 'Mental Wellness Specialist Level 3', 'Mental Wellness',
    5, ARRAY['English', 'Hindi'], 4.40, 70, 800,
    'Certified professional with 5 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000300000000', '00000000-0000-0000-0000-000000000000', 'amitabh_bhattacharya_14_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000300000000', 'Amitabh Bhattacharya', 'expert', 'amitabh_bhattacharya_14_3', 'amitabh_bhattacharya_14_3@demo.askexpert.com', '+91 98000 00276',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (6+ Yrs Exp)', 'Mental Wellness Specialist Level 1', 'Mental Wellness',
    6, ARRAY['English', 'Hindi'], 4.50, 77, 950,
    'Certified professional with 6 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000400000000', '00000000-0000-0000-0000-000000000000', 'sunita_saxena_14_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000400000000', 'Sunita Saxena', 'expert', 'sunita_saxena_14_4', 'sunita_saxena_14_4@demo.askexpert.com', '+91 98000 00277',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (7+ Yrs Exp)', 'Mental Wellness Specialist Level 2', 'Mental Wellness',
    7, ARRAY['English', 'Hindi'], 4.60, 84, 1100,
    'Certified professional with 7 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000500000000', '00000000-0000-0000-0000-000000000000', 'rohan_gupta_14_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000500000000', 'Rohan Gupta', 'expert', 'rohan_gupta_14_5', 'rohan_gupta_14_5@demo.askexpert.com', '+91 98000 00278',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (8+ Yrs Exp)', 'Mental Wellness Specialist Level 3', 'Mental Wellness',
    8, ARRAY['English', 'Hindi'], 4.70, 91, 1250,
    'Certified professional with 8 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000600000000', '00000000-0000-0000-0000-000000000000', 'shalini_chopra_14_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000600000000', 'Shalini Chopra', 'expert', 'shalini_chopra_14_6', 'shalini_chopra_14_6@demo.askexpert.com', '+91 98000 00279',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (9+ Yrs Exp)', 'Mental Wellness Specialist Level 1', 'Mental Wellness',
    9, ARRAY['English', 'Hindi'], 4.80, 98, 1400,
    'Certified professional with 9 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000700000000', '00000000-0000-0000-0000-000000000000', 'suresh_jain_14_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000700000000', 'Suresh Jain', 'expert', 'suresh_jain_14_7', 'suresh_jain_14_7@demo.askexpert.com', '+91 98000 00280',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (10+ Yrs Exp)', 'Mental Wellness Specialist Level 2', 'Mental Wellness',
    10, ARRAY['English', 'Hindi'], 4.90, 105, 1550,
    'Certified professional with 10 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000800000000', '00000000-0000-0000-0000-000000000000', 'ritu_nair_14_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000800000000', 'Ritu Nair', 'expert', 'ritu_nair_14_8', 'ritu_nair_14_8@demo.askexpert.com', '+91 98000 00281',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (11+ Yrs Exp)', 'Mental Wellness Specialist Level 3', 'Mental Wellness',
    11, ARRAY['English', 'Hindi'], 4.20, 112, 1700,
    'Certified professional with 11 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000900000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_sharma_14_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000900000000', 'Vikramaditya Sharma', 'expert', 'vikramaditya_sharma_14_9', 'vikramaditya_sharma_14_9@demo.askexpert.com', '+91 98000 00282',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (12+ Yrs Exp)', 'Mental Wellness Specialist Level 1', 'Mental Wellness',
    12, ARRAY['English', 'Hindi'], 4.30, 119, 1850,
    'Certified professional with 12 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000a00000000', '00000000-0000-0000-0000-000000000000', 'deepa_reddy_14_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000a00000000', 'Deepa Reddy', 'expert', 'deepa_reddy_14_10', 'deepa_reddy_14_10@demo.askexpert.com', '+91 98000 00283',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (13+ Yrs Exp)', 'Mental Wellness Specialist Level 2', 'Mental Wellness',
    13, ARRAY['English', 'Hindi'], 4.40, 126, 2000,
    'Certified professional with 13 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000b00000000', '00000000-0000-0000-0000-000000000000', 'arvind_kulkarni_14_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000b00000000', 'Arvind Kulkarni', 'expert', 'arvind_kulkarni_14_11', 'arvind_kulkarni_14_11@demo.askexpert.com', '+91 98000 00284',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (14+ Yrs Exp)', 'Mental Wellness Specialist Level 3', 'Mental Wellness',
    14, ARRAY['English', 'Hindi'], 4.50, 133, 2150,
    'Certified professional with 14 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000c00000000', '00000000-0000-0000-0000-000000000000', 'sneha_malhotra_14_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000c00000000', 'Sneha Malhotra', 'expert', 'sneha_malhotra_14_12', 'sneha_malhotra_14_12@demo.askexpert.com', '+91 98000 00285',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (15+ Yrs Exp)', 'Mental Wellness Specialist Level 1', 'Mental Wellness',
    15, ARRAY['English', 'Hindi'], 4.60, 140, 2300,
    'Certified professional with 15 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000d00000000', '00000000-0000-0000-0000-000000000000', 'karthik_bhattacharya_14_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000d00000000', 'Karthik Bhattacharya', 'expert', 'karthik_bhattacharya_14_13', 'karthik_bhattacharya_14_13@demo.askexpert.com', '+91 98000 00286',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (16+ Yrs Exp)', 'Mental Wellness Specialist Level 2', 'Mental Wellness',
    16, ARRAY['English', 'Hindi'], 4.70, 147, 2450,
    'Certified professional with 16 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000e00000000', '00000000-0000-0000-0000-000000000000', 'neha_saxena_14_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000e00000000', 'Neha Saxena', 'expert', 'neha_saxena_14_14', 'neha_saxena_14_14@demo.askexpert.com', '+91 98000 00287',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (17+ Yrs Exp)', 'Mental Wellness Specialist Level 3', 'Mental Wellness',
    17, ARRAY['English', 'Hindi'], 4.80, 154, 2600,
    'Certified professional with 17 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-000f00000000', '00000000-0000-0000-0000-000000000000', 'devendra_gupta_14_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-000f00000000', 'Devendra Gupta', 'expert', 'devendra_gupta_14_15', 'devendra_gupta_14_15@demo.askexpert.com', '+91 98000 00288',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (18+ Yrs Exp)', 'Mental Wellness Specialist Level 1', 'Mental Wellness',
    18, ARRAY['English', 'Hindi'], 4.90, 161, 500,
    'Certified professional with 18 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-001000000000', '00000000-0000-0000-0000-000000000000', 'preeti_chopra_14_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-001000000000', 'Preeti Chopra', 'expert', 'preeti_chopra_14_16', 'preeti_chopra_14_16@demo.askexpert.com', '+91 98000 00289',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (19+ Yrs Exp)', 'Mental Wellness Specialist Level 2', 'Mental Wellness',
    19, ARRAY['English', 'Hindi'], 4.20, 168, 650,
    'Certified professional with 19 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-001100000000', '00000000-0000-0000-0000-000000000000', 'alok_jain_14_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-001100000000', 'Alok Jain', 'expert', 'alok_jain_14_17', 'alok_jain_14_17@demo.askexpert.com', '+91 98000 00290',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (20+ Yrs Exp)', 'Mental Wellness Specialist Level 3', 'Mental Wellness',
    20, ARRAY['English', 'Hindi'], 4.30, 175, 800,
    'Certified professional with 20 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-001200000000', '00000000-0000-0000-0000-000000000000', 'kavita_nair_14_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-001200000000', 'Kavita Nair', 'expert', 'kavita_nair_14_18', 'kavita_nair_14_18@demo.askexpert.com', '+91 98000 00291',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (3+ Yrs Exp)', 'Mental Wellness Specialist Level 1', 'Mental Wellness',
    3, ARRAY['English', 'Hindi'], 4.40, 182, 950,
    'Certified professional with 3 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-001300000000', '00000000-0000-0000-0000-000000000000', 'manish_sharma_14_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-001300000000', 'Manish Sharma', 'expert', 'manish_sharma_14_19', 'manish_sharma_14_19@demo.askexpert.com', '+91 98000 00292',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (4+ Yrs Exp)', 'Mental Wellness Specialist Level 2', 'Mental Wellness',
    4, ARRAY['English', 'Hindi'], 4.50, 189, 1100,
    'Certified professional with 4 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-001400000000', '00000000-0000-0000-0000-000000000000', 'pooja_reddy_14_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-001400000000', 'Pooja Reddy', 'expert', 'pooja_reddy_14_20', 'pooja_reddy_14_20@demo.askexpert.com', '+91 98000 00293',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (5+ Yrs Exp)', 'Mental Wellness Specialist Level 3', 'Mental Wellness',
    5, ARRAY['English', 'Hindi'], 4.60, 196, 1250,
    'Certified professional with 5 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0e00-001500000000', '00000000-0000-0000-0000-000000000000', 'sanjay_kulkarni_14_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0e00-001500000000', 'Sanjay Kulkarni', 'expert', 'sanjay_kulkarni_14_21', 'sanjay_kulkarni_14_21@demo.askexpert.com', '+91 98000 00294',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mental Wellness (6+ Yrs Exp)', 'Mental Wellness Specialist Level 1', 'Mental Wellness',
    6, ARRAY['English', 'Hindi'], 4.70, 203, 1400,
    'Certified professional with 6 years of expertise in Mental Wellness. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mental Wellness Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000100000000', '00000000-0000-0000-0000-000000000000', 'tanvi_nair_15_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000100000000', 'Tanvi Nair', 'expert', 'tanvi_nair_15_1', 'tanvi_nair_15_1@demo.askexpert.com', '+91 98000 00295',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (4+ Yrs Exp)', 'Civil Engineering Specialist Level 2', 'Civil Engineering',
    4, ARRAY['English', 'Hindi'], 4.30, 75, 650,
    'Certified professional with 4 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000200000000', '00000000-0000-0000-0000-000000000000', 'varun_sharma_15_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000200000000', 'Varun Sharma', 'expert', 'varun_sharma_15_2', 'varun_sharma_15_2@demo.askexpert.com', '+91 98000 00296',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (5+ Yrs Exp)', 'Civil Engineering Specialist Level 3', 'Civil Engineering',
    5, ARRAY['English', 'Hindi'], 4.40, 82, 800,
    'Certified professional with 5 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000300000000', '00000000-0000-0000-0000-000000000000', 'divya_reddy_15_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000300000000', 'Divya Reddy', 'expert', 'divya_reddy_15_3', 'divya_reddy_15_3@demo.askexpert.com', '+91 98000 00297',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (6+ Yrs Exp)', 'Civil Engineering Specialist Level 1', 'Civil Engineering',
    6, ARRAY['English', 'Hindi'], 4.50, 89, 950,
    'Certified professional with 6 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000400000000', '00000000-0000-0000-0000-000000000000', 'gautam_kulkarni_15_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000400000000', 'Gautam Kulkarni', 'expert', 'gautam_kulkarni_15_4', 'gautam_kulkarni_15_4@demo.askexpert.com', '+91 98000 00298',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (7+ Yrs Exp)', 'Civil Engineering Specialist Level 2', 'Civil Engineering',
    7, ARRAY['English', 'Hindi'], 4.60, 96, 1100,
    'Certified professional with 7 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000500000000', '00000000-0000-0000-0000-000000000000', 'swati_malhotra_15_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000500000000', 'Swati Malhotra', 'expert', 'swati_malhotra_15_5', 'swati_malhotra_15_5@demo.askexpert.com', '+91 98000 00299',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (8+ Yrs Exp)', 'Civil Engineering Specialist Level 3', 'Civil Engineering',
    8, ARRAY['English', 'Hindi'], 4.70, 103, 1250,
    'Certified professional with 8 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000600000000', '00000000-0000-0000-0000-000000000000', 'rajesh_bhattacharya_15_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000600000000', 'Rajesh Bhattacharya', 'expert', 'rajesh_bhattacharya_15_6', 'rajesh_bhattacharya_15_6@demo.askexpert.com', '+91 98000 00300',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (9+ Yrs Exp)', 'Civil Engineering Specialist Level 1', 'Civil Engineering',
    9, ARRAY['English', 'Hindi'], 4.80, 110, 1400,
    'Certified professional with 9 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000700000000', '00000000-0000-0000-0000-000000000000', 'priya_saxena_15_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000700000000', 'Priya Saxena', 'expert', 'priya_saxena_15_7', 'priya_saxena_15_7@demo.askexpert.com', '+91 98000 00301',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (10+ Yrs Exp)', 'Civil Engineering Specialist Level 2', 'Civil Engineering',
    10, ARRAY['English', 'Hindi'], 4.90, 117, 1550,
    'Certified professional with 10 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000800000000', '00000000-0000-0000-0000-000000000000', 'vikram_gupta_15_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000800000000', 'Vikram Gupta', 'expert', 'vikram_gupta_15_8', 'vikram_gupta_15_8@demo.askexpert.com', '+91 98000 00302',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (11+ Yrs Exp)', 'Civil Engineering Specialist Level 3', 'Civil Engineering',
    11, ARRAY['English', 'Hindi'], 4.20, 124, 1700,
    'Certified professional with 11 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000900000000', '00000000-0000-0000-0000-000000000000', 'ananya_chopra_15_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000900000000', 'Ananya Chopra', 'expert', 'ananya_chopra_15_9', 'ananya_chopra_15_9@demo.askexpert.com', '+91 98000 00303',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (12+ Yrs Exp)', 'Civil Engineering Specialist Level 1', 'Civil Engineering',
    12, ARRAY['English', 'Hindi'], 4.30, 131, 1850,
    'Certified professional with 12 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000a00000000', '00000000-0000-0000-0000-000000000000', 'siddharth_jain_15_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000a00000000', 'Siddharth Jain', 'expert', 'siddharth_jain_15_10', 'siddharth_jain_15_10@demo.askexpert.com', '+91 98000 00304',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (13+ Yrs Exp)', 'Civil Engineering Specialist Level 2', 'Civil Engineering',
    13, ARRAY['English', 'Hindi'], 4.40, 138, 2000,
    'Certified professional with 13 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000b00000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_nair_15_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000b00000000', 'Meenakshi Nair', 'expert', 'meenakshi_nair_15_11', 'meenakshi_nair_15_11@demo.askexpert.com', '+91 98000 00305',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (14+ Yrs Exp)', 'Civil Engineering Specialist Level 3', 'Civil Engineering',
    14, ARRAY['English', 'Hindi'], 4.50, 145, 2150,
    'Certified professional with 14 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000c00000000', '00000000-0000-0000-0000-000000000000', 'amitabh_sharma_15_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000c00000000', 'Amitabh Sharma', 'expert', 'amitabh_sharma_15_12', 'amitabh_sharma_15_12@demo.askexpert.com', '+91 98000 00306',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (15+ Yrs Exp)', 'Civil Engineering Specialist Level 1', 'Civil Engineering',
    15, ARRAY['English', 'Hindi'], 4.60, 152, 2300,
    'Certified professional with 15 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000d00000000', '00000000-0000-0000-0000-000000000000', 'sunita_reddy_15_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000d00000000', 'Sunita Reddy', 'expert', 'sunita_reddy_15_13', 'sunita_reddy_15_13@demo.askexpert.com', '+91 98000 00307',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (16+ Yrs Exp)', 'Civil Engineering Specialist Level 2', 'Civil Engineering',
    16, ARRAY['English', 'Hindi'], 4.70, 159, 2450,
    'Certified professional with 16 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000e00000000', '00000000-0000-0000-0000-000000000000', 'rohan_kulkarni_15_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000e00000000', 'Rohan Kulkarni', 'expert', 'rohan_kulkarni_15_14', 'rohan_kulkarni_15_14@demo.askexpert.com', '+91 98000 00308',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (17+ Yrs Exp)', 'Civil Engineering Specialist Level 3', 'Civil Engineering',
    17, ARRAY['English', 'Hindi'], 4.80, 166, 2600,
    'Certified professional with 17 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-000f00000000', '00000000-0000-0000-0000-000000000000', 'shalini_malhotra_15_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-000f00000000', 'Shalini Malhotra', 'expert', 'shalini_malhotra_15_15', 'shalini_malhotra_15_15@demo.askexpert.com', '+91 98000 00309',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (18+ Yrs Exp)', 'Civil Engineering Specialist Level 1', 'Civil Engineering',
    18, ARRAY['English', 'Hindi'], 4.90, 173, 500,
    'Certified professional with 18 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-001000000000', '00000000-0000-0000-0000-000000000000', 'suresh_bhattacharya_15_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-001000000000', 'Suresh Bhattacharya', 'expert', 'suresh_bhattacharya_15_16', 'suresh_bhattacharya_15_16@demo.askexpert.com', '+91 98000 00310',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (19+ Yrs Exp)', 'Civil Engineering Specialist Level 2', 'Civil Engineering',
    19, ARRAY['English', 'Hindi'], 4.20, 180, 650,
    'Certified professional with 19 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-001100000000', '00000000-0000-0000-0000-000000000000', 'ritu_saxena_15_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-001100000000', 'Ritu Saxena', 'expert', 'ritu_saxena_15_17', 'ritu_saxena_15_17@demo.askexpert.com', '+91 98000 00311',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (20+ Yrs Exp)', 'Civil Engineering Specialist Level 3', 'Civil Engineering',
    20, ARRAY['English', 'Hindi'], 4.30, 187, 800,
    'Certified professional with 20 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-001200000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_gupta_15_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-001200000000', 'Vikramaditya Gupta', 'expert', 'vikramaditya_gupta_15_18', 'vikramaditya_gupta_15_18@demo.askexpert.com', '+91 98000 00312',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (3+ Yrs Exp)', 'Civil Engineering Specialist Level 1', 'Civil Engineering',
    3, ARRAY['English', 'Hindi'], 4.40, 194, 950,
    'Certified professional with 3 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-001300000000', '00000000-0000-0000-0000-000000000000', 'deepa_chopra_15_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-001300000000', 'Deepa Chopra', 'expert', 'deepa_chopra_15_19', 'deepa_chopra_15_19@demo.askexpert.com', '+91 98000 00313',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (4+ Yrs Exp)', 'Civil Engineering Specialist Level 2', 'Civil Engineering',
    4, ARRAY['English', 'Hindi'], 4.50, 201, 1100,
    'Certified professional with 4 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-001400000000', '00000000-0000-0000-0000-000000000000', 'arvind_jain_15_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-001400000000', 'Arvind Jain', 'expert', 'arvind_jain_15_20', 'arvind_jain_15_20@demo.askexpert.com', '+91 98000 00314',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (5+ Yrs Exp)', 'Civil Engineering Specialist Level 3', 'Civil Engineering',
    5, ARRAY['English', 'Hindi'], 4.60, 208, 1250,
    'Certified professional with 5 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-0f00-001500000000', '00000000-0000-0000-0000-000000000000', 'sneha_nair_15_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0f00-001500000000', 'Sneha Nair', 'expert', 'sneha_nair_15_21', 'sneha_nair_15_21@demo.askexpert.com', '+91 98000 00315',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Civil Engineering (6+ Yrs Exp)', 'Civil Engineering Specialist Level 1', 'Civil Engineering',
    6, ARRAY['English', 'Hindi'], 4.70, 215, 1400,
    'Certified professional with 6 years of expertise in Civil Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Civil Engineering Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000100000000', '00000000-0000-0000-0000-000000000000', 'karthik_gupta_16_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000100000000', 'Karthik Gupta', 'expert', 'karthik_gupta_16_1', 'karthik_gupta_16_1@demo.askexpert.com', '+91 98000 00316',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (4+ Yrs Exp)', 'Architecture Specialist Level 2', 'Architecture',
    4, ARRAY['English', 'Hindi'], 4.30, 27, 650,
    'Certified professional with 4 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000200000000', '00000000-0000-0000-0000-000000000000', 'neha_chopra_16_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000200000000', 'Neha Chopra', 'expert', 'neha_chopra_16_2', 'neha_chopra_16_2@demo.askexpert.com', '+91 98000 00317',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (5+ Yrs Exp)', 'Architecture Specialist Level 3', 'Architecture',
    5, ARRAY['English', 'Hindi'], 4.40, 34, 800,
    'Certified professional with 5 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000300000000', '00000000-0000-0000-0000-000000000000', 'devendra_jain_16_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000300000000', 'Devendra Jain', 'expert', 'devendra_jain_16_3', 'devendra_jain_16_3@demo.askexpert.com', '+91 98000 00318',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (6+ Yrs Exp)', 'Architecture Specialist Level 1', 'Architecture',
    6, ARRAY['English', 'Hindi'], 4.50, 41, 950,
    'Certified professional with 6 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000400000000', '00000000-0000-0000-0000-000000000000', 'preeti_nair_16_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000400000000', 'Preeti Nair', 'expert', 'preeti_nair_16_4', 'preeti_nair_16_4@demo.askexpert.com', '+91 98000 00319',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (7+ Yrs Exp)', 'Architecture Specialist Level 2', 'Architecture',
    7, ARRAY['English', 'Hindi'], 4.60, 48, 1100,
    'Certified professional with 7 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000500000000', '00000000-0000-0000-0000-000000000000', 'alok_sharma_16_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000500000000', 'Alok Sharma', 'expert', 'alok_sharma_16_5', 'alok_sharma_16_5@demo.askexpert.com', '+91 98000 00320',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (8+ Yrs Exp)', 'Architecture Specialist Level 3', 'Architecture',
    8, ARRAY['English', 'Hindi'], 4.70, 55, 1250,
    'Certified professional with 8 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000600000000', '00000000-0000-0000-0000-000000000000', 'kavita_reddy_16_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000600000000', 'Kavita Reddy', 'expert', 'kavita_reddy_16_6', 'kavita_reddy_16_6@demo.askexpert.com', '+91 98000 00321',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (9+ Yrs Exp)', 'Architecture Specialist Level 1', 'Architecture',
    9, ARRAY['English', 'Hindi'], 4.80, 62, 1400,
    'Certified professional with 9 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000700000000', '00000000-0000-0000-0000-000000000000', 'manish_kulkarni_16_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000700000000', 'Manish Kulkarni', 'expert', 'manish_kulkarni_16_7', 'manish_kulkarni_16_7@demo.askexpert.com', '+91 98000 00322',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (10+ Yrs Exp)', 'Architecture Specialist Level 2', 'Architecture',
    10, ARRAY['English', 'Hindi'], 4.90, 69, 1550,
    'Certified professional with 10 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000800000000', '00000000-0000-0000-0000-000000000000', 'pooja_malhotra_16_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000800000000', 'Pooja Malhotra', 'expert', 'pooja_malhotra_16_8', 'pooja_malhotra_16_8@demo.askexpert.com', '+91 98000 00323',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (11+ Yrs Exp)', 'Architecture Specialist Level 3', 'Architecture',
    11, ARRAY['English', 'Hindi'], 4.20, 76, 1700,
    'Certified professional with 11 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000900000000', '00000000-0000-0000-0000-000000000000', 'sanjay_bhattacharya_16_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000900000000', 'Sanjay Bhattacharya', 'expert', 'sanjay_bhattacharya_16_9', 'sanjay_bhattacharya_16_9@demo.askexpert.com', '+91 98000 00324',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (12+ Yrs Exp)', 'Architecture Specialist Level 1', 'Architecture',
    12, ARRAY['English', 'Hindi'], 4.30, 83, 1850,
    'Certified professional with 12 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000a00000000', '00000000-0000-0000-0000-000000000000', 'tanvi_saxena_16_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000a00000000', 'Tanvi Saxena', 'expert', 'tanvi_saxena_16_10', 'tanvi_saxena_16_10@demo.askexpert.com', '+91 98000 00325',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (13+ Yrs Exp)', 'Architecture Specialist Level 2', 'Architecture',
    13, ARRAY['English', 'Hindi'], 4.40, 90, 2000,
    'Certified professional with 13 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000b00000000', '00000000-0000-0000-0000-000000000000', 'varun_gupta_16_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000b00000000', 'Varun Gupta', 'expert', 'varun_gupta_16_11', 'varun_gupta_16_11@demo.askexpert.com', '+91 98000 00326',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (14+ Yrs Exp)', 'Architecture Specialist Level 3', 'Architecture',
    14, ARRAY['English', 'Hindi'], 4.50, 97, 2150,
    'Certified professional with 14 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000c00000000', '00000000-0000-0000-0000-000000000000', 'divya_chopra_16_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000c00000000', 'Divya Chopra', 'expert', 'divya_chopra_16_12', 'divya_chopra_16_12@demo.askexpert.com', '+91 98000 00327',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (15+ Yrs Exp)', 'Architecture Specialist Level 1', 'Architecture',
    15, ARRAY['English', 'Hindi'], 4.60, 104, 2300,
    'Certified professional with 15 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Ahmedabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000d00000000', '00000000-0000-0000-0000-000000000000', 'gautam_jain_16_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000d00000000', 'Gautam Jain', 'expert', 'gautam_jain_16_13', 'gautam_jain_16_13@demo.askexpert.com', '+91 98000 00328',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (16+ Yrs Exp)', 'Architecture Specialist Level 2', 'Architecture',
    16, ARRAY['English', 'Hindi'], 4.70, 111, 2450,
    'Certified professional with 16 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Kochi, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000e00000000', '00000000-0000-0000-0000-000000000000', 'swati_nair_16_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000e00000000', 'Swati Nair', 'expert', 'swati_nair_16_14', 'swati_nair_16_14@demo.askexpert.com', '+91 98000 00329',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (17+ Yrs Exp)', 'Architecture Specialist Level 3', 'Architecture',
    17, ARRAY['English', 'Hindi'], 4.80, 118, 2600,
    'Certified professional with 17 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Chandigarh, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-000f00000000', '00000000-0000-0000-0000-000000000000', 'rajesh_sharma_16_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-000f00000000', 'Rajesh Sharma', 'expert', 'rajesh_sharma_16_15', 'rajesh_sharma_16_15@demo.askexpert.com', '+91 98000 00330',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (18+ Yrs Exp)', 'Architecture Specialist Level 1', 'Architecture',
    18, ARRAY['English', 'Hindi'], 4.90, 125, 500,
    'Certified professional with 18 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Hyderabad, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-001000000000', '00000000-0000-0000-0000-000000000000', 'priya_reddy_16_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-001000000000', 'Priya Reddy', 'expert', 'priya_reddy_16_16', 'priya_reddy_16_16@demo.askexpert.com', '+91 98000 00331',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (19+ Yrs Exp)', 'Architecture Specialist Level 2', 'Architecture',
    19, ARRAY['English', 'Hindi'], 4.20, 132, 650,
    'Certified professional with 19 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Bangalore, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-001100000000', '00000000-0000-0000-0000-000000000000', 'vikram_kulkarni_16_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-001100000000', 'Vikram Kulkarni', 'expert', 'vikram_kulkarni_16_17', 'vikram_kulkarni_16_17@demo.askexpert.com', '+91 98000 00332',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (20+ Yrs Exp)', 'Architecture Specialist Level 3', 'Architecture',
    20, ARRAY['English', 'Hindi'], 4.30, 139, 800,
    'Certified professional with 20 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Mumbai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-001200000000', '00000000-0000-0000-0000-000000000000', 'ananya_malhotra_16_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-001200000000', 'Ananya Malhotra', 'expert', 'ananya_malhotra_16_18', 'ananya_malhotra_16_18@demo.askexpert.com', '+91 98000 00333',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (3+ Yrs Exp)', 'Architecture Specialist Level 1', 'Architecture',
    3, ARRAY['English', 'Hindi'], 4.40, 146, 950,
    'Certified professional with 3 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Delhi NCR, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-001300000000', '00000000-0000-0000-0000-000000000000', 'siddharth_bhattacharya_16_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-001300000000', 'Siddharth Bhattacharya', 'expert', 'siddharth_bhattacharya_16_19', 'siddharth_bhattacharya_16_19@demo.askexpert.com', '+91 98000 00334',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (4+ Yrs Exp)', 'Architecture Specialist Level 2', 'Architecture',
    4, ARRAY['English', 'Hindi'], 4.50, 153, 1100,
    'Certified professional with 4 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'available', 'active', 'Chennai, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-001400000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_saxena_16_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-001400000000', 'Meenakshi Saxena', 'expert', 'meenakshi_saxena_16_20', 'meenakshi_saxena_16_20@demo.askexpert.com', '+91 98000 00335',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (5+ Yrs Exp)', 'Architecture Specialist Level 3', 'Architecture',
    5, ARRAY['English', 'Hindi'], 4.60, 160, 1250,
    'Certified professional with 5 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'busy', 'active', 'Pune, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    'a0000000-0000-0000-1000-001500000000', '00000000-0000-0000-0000-000000000000', 'amitabh_gupta_16_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1000-001500000000', 'Amitabh Gupta', 'expert', 'amitabh_gupta_16_21', 'amitabh_gupta_16_21@demo.askexpert.com', '+91 98000 00336',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Architecture (6+ Yrs Exp)', 'Architecture Specialist Level 1', 'Architecture',
    6, ARRAY['English', 'Hindi'], 4.70, 167, 1400,
    'Certified professional with 6 years of expertise in Architecture. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Architecture Advisory', 'Consultation', 'Strategy'],
    'offline', 'active', 'Kolkata, India', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
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

END $;

-- ENSURE ALL EXPERTS HAVE IS_VERIFIED = TRUE
UPDATE public.profiles SET is_verified = true WHERE role = 'expert';

SELECT count(*) AS chunk_2_demo_experts FROM public.profiles WHERE is_demo = true;
