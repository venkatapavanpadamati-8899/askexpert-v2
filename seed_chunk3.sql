-- ==============================================================================
-- ASKEXPERT - SEED CHUNK 3 OF 5 (CATEGORIES 17 TO 24)
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
    'a0000000-0000-0000-1100-000100000000', '00000000-0000-0000-0000-000000000000', 'sunita_malhotra_17_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000100000000', 'Sunita Malhotra', 'expert', 'sunita_malhotra_17_1', 'sunita_malhotra_17_1@demo.askexpert.com', '+91 98000 00337',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (4+ Yrs Exp)', 'Mechanical Engineering Specialist Level 2', 'Mechanical Engineering',
    4, ARRAY['English', 'Hindi'], 4.30, 39, 650,
    'Certified professional with 4 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000200000000', '00000000-0000-0000-0000-000000000000', 'rohan_bhattacharya_17_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000200000000', 'Rohan Bhattacharya', 'expert', 'rohan_bhattacharya_17_2', 'rohan_bhattacharya_17_2@demo.askexpert.com', '+91 98000 00338',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (5+ Yrs Exp)', 'Mechanical Engineering Specialist Level 3', 'Mechanical Engineering',
    5, ARRAY['English', 'Hindi'], 4.40, 46, 800,
    'Certified professional with 5 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000300000000', '00000000-0000-0000-0000-000000000000', 'shalini_saxena_17_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000300000000', 'Shalini Saxena', 'expert', 'shalini_saxena_17_3', 'shalini_saxena_17_3@demo.askexpert.com', '+91 98000 00339',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (6+ Yrs Exp)', 'Mechanical Engineering Specialist Level 1', 'Mechanical Engineering',
    6, ARRAY['English', 'Hindi'], 4.50, 53, 950,
    'Certified professional with 6 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000400000000', '00000000-0000-0000-0000-000000000000', 'suresh_gupta_17_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000400000000', 'Suresh Gupta', 'expert', 'suresh_gupta_17_4', 'suresh_gupta_17_4@demo.askexpert.com', '+91 98000 00340',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (7+ Yrs Exp)', 'Mechanical Engineering Specialist Level 2', 'Mechanical Engineering',
    7, ARRAY['English', 'Hindi'], 4.60, 60, 1100,
    'Certified professional with 7 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000500000000', '00000000-0000-0000-0000-000000000000', 'ritu_chopra_17_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000500000000', 'Ritu Chopra', 'expert', 'ritu_chopra_17_5', 'ritu_chopra_17_5@demo.askexpert.com', '+91 98000 00341',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (8+ Yrs Exp)', 'Mechanical Engineering Specialist Level 3', 'Mechanical Engineering',
    8, ARRAY['English', 'Hindi'], 4.70, 67, 1250,
    'Certified professional with 8 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000600000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_jain_17_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000600000000', 'Vikramaditya Jain', 'expert', 'vikramaditya_jain_17_6', 'vikramaditya_jain_17_6@demo.askexpert.com', '+91 98000 00342',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (9+ Yrs Exp)', 'Mechanical Engineering Specialist Level 1', 'Mechanical Engineering',
    9, ARRAY['English', 'Hindi'], 4.80, 74, 1400,
    'Certified professional with 9 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000700000000', '00000000-0000-0000-0000-000000000000', 'deepa_nair_17_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000700000000', 'Deepa Nair', 'expert', 'deepa_nair_17_7', 'deepa_nair_17_7@demo.askexpert.com', '+91 98000 00343',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (10+ Yrs Exp)', 'Mechanical Engineering Specialist Level 2', 'Mechanical Engineering',
    10, ARRAY['English', 'Hindi'], 4.90, 81, 1550,
    'Certified professional with 10 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000800000000', '00000000-0000-0000-0000-000000000000', 'arvind_sharma_17_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000800000000', 'Arvind Sharma', 'expert', 'arvind_sharma_17_8', 'arvind_sharma_17_8@demo.askexpert.com', '+91 98000 00344',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (11+ Yrs Exp)', 'Mechanical Engineering Specialist Level 3', 'Mechanical Engineering',
    11, ARRAY['English', 'Hindi'], 4.20, 88, 1700,
    'Certified professional with 11 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000900000000', '00000000-0000-0000-0000-000000000000', 'sneha_reddy_17_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000900000000', 'Sneha Reddy', 'expert', 'sneha_reddy_17_9', 'sneha_reddy_17_9@demo.askexpert.com', '+91 98000 00345',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (12+ Yrs Exp)', 'Mechanical Engineering Specialist Level 1', 'Mechanical Engineering',
    12, ARRAY['English', 'Hindi'], 4.30, 95, 1850,
    'Certified professional with 12 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000a00000000', '00000000-0000-0000-0000-000000000000', 'karthik_kulkarni_17_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000a00000000', 'Karthik Kulkarni', 'expert', 'karthik_kulkarni_17_10', 'karthik_kulkarni_17_10@demo.askexpert.com', '+91 98000 00346',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (13+ Yrs Exp)', 'Mechanical Engineering Specialist Level 2', 'Mechanical Engineering',
    13, ARRAY['English', 'Hindi'], 4.40, 102, 2000,
    'Certified professional with 13 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000b00000000', '00000000-0000-0000-0000-000000000000', 'neha_malhotra_17_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000b00000000', 'Neha Malhotra', 'expert', 'neha_malhotra_17_11', 'neha_malhotra_17_11@demo.askexpert.com', '+91 98000 00347',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (14+ Yrs Exp)', 'Mechanical Engineering Specialist Level 3', 'Mechanical Engineering',
    14, ARRAY['English', 'Hindi'], 4.50, 109, 2150,
    'Certified professional with 14 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000c00000000', '00000000-0000-0000-0000-000000000000', 'devendra_bhattacharya_17_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000c00000000', 'Devendra Bhattacharya', 'expert', 'devendra_bhattacharya_17_12', 'devendra_bhattacharya_17_12@demo.askexpert.com', '+91 98000 00348',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (15+ Yrs Exp)', 'Mechanical Engineering Specialist Level 1', 'Mechanical Engineering',
    15, ARRAY['English', 'Hindi'], 4.60, 116, 2300,
    'Certified professional with 15 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000d00000000', '00000000-0000-0000-0000-000000000000', 'preeti_saxena_17_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000d00000000', 'Preeti Saxena', 'expert', 'preeti_saxena_17_13', 'preeti_saxena_17_13@demo.askexpert.com', '+91 98000 00349',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (16+ Yrs Exp)', 'Mechanical Engineering Specialist Level 2', 'Mechanical Engineering',
    16, ARRAY['English', 'Hindi'], 4.70, 123, 2450,
    'Certified professional with 16 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000e00000000', '00000000-0000-0000-0000-000000000000', 'alok_gupta_17_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000e00000000', 'Alok Gupta', 'expert', 'alok_gupta_17_14', 'alok_gupta_17_14@demo.askexpert.com', '+91 98000 00350',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (17+ Yrs Exp)', 'Mechanical Engineering Specialist Level 3', 'Mechanical Engineering',
    17, ARRAY['English', 'Hindi'], 4.80, 130, 2600,
    'Certified professional with 17 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-000f00000000', '00000000-0000-0000-0000-000000000000', 'kavita_chopra_17_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-000f00000000', 'Kavita Chopra', 'expert', 'kavita_chopra_17_15', 'kavita_chopra_17_15@demo.askexpert.com', '+91 98000 00351',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (18+ Yrs Exp)', 'Mechanical Engineering Specialist Level 1', 'Mechanical Engineering',
    18, ARRAY['English', 'Hindi'], 4.90, 137, 500,
    'Certified professional with 18 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-001000000000', '00000000-0000-0000-0000-000000000000', 'manish_jain_17_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-001000000000', 'Manish Jain', 'expert', 'manish_jain_17_16', 'manish_jain_17_16@demo.askexpert.com', '+91 98000 00352',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (19+ Yrs Exp)', 'Mechanical Engineering Specialist Level 2', 'Mechanical Engineering',
    19, ARRAY['English', 'Hindi'], 4.20, 144, 650,
    'Certified professional with 19 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-001100000000', '00000000-0000-0000-0000-000000000000', 'pooja_nair_17_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-001100000000', 'Pooja Nair', 'expert', 'pooja_nair_17_17', 'pooja_nair_17_17@demo.askexpert.com', '+91 98000 00353',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (20+ Yrs Exp)', 'Mechanical Engineering Specialist Level 3', 'Mechanical Engineering',
    20, ARRAY['English', 'Hindi'], 4.30, 151, 800,
    'Certified professional with 20 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-001200000000', '00000000-0000-0000-0000-000000000000', 'sanjay_sharma_17_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-001200000000', 'Sanjay Sharma', 'expert', 'sanjay_sharma_17_18', 'sanjay_sharma_17_18@demo.askexpert.com', '+91 98000 00354',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (3+ Yrs Exp)', 'Mechanical Engineering Specialist Level 1', 'Mechanical Engineering',
    3, ARRAY['English', 'Hindi'], 4.40, 158, 950,
    'Certified professional with 3 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-001300000000', '00000000-0000-0000-0000-000000000000', 'tanvi_reddy_17_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-001300000000', 'Tanvi Reddy', 'expert', 'tanvi_reddy_17_19', 'tanvi_reddy_17_19@demo.askexpert.com', '+91 98000 00355',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (4+ Yrs Exp)', 'Mechanical Engineering Specialist Level 2', 'Mechanical Engineering',
    4, ARRAY['English', 'Hindi'], 4.50, 165, 1100,
    'Certified professional with 4 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-001400000000', '00000000-0000-0000-0000-000000000000', 'varun_kulkarni_17_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-001400000000', 'Varun Kulkarni', 'expert', 'varun_kulkarni_17_20', 'varun_kulkarni_17_20@demo.askexpert.com', '+91 98000 00356',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (5+ Yrs Exp)', 'Mechanical Engineering Specialist Level 3', 'Mechanical Engineering',
    5, ARRAY['English', 'Hindi'], 4.60, 172, 1250,
    'Certified professional with 5 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1100-001500000000', '00000000-0000-0000-0000-000000000000', 'divya_malhotra_17_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1100-001500000000', 'Divya Malhotra', 'expert', 'divya_malhotra_17_21', 'divya_malhotra_17_21@demo.askexpert.com', '+91 98000 00357',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Mechanical Engineering (6+ Yrs Exp)', 'Mechanical Engineering Specialist Level 1', 'Mechanical Engineering',
    6, ARRAY['English', 'Hindi'], 4.70, 179, 1400,
    'Certified professional with 6 years of expertise in Mechanical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Mechanical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000100000000', '00000000-0000-0000-0000-000000000000', 'gautam_sharma_18_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000100000000', 'Gautam Sharma', 'expert', 'gautam_sharma_18_1', 'gautam_sharma_18_1@demo.askexpert.com', '+91 98000 00358',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (4+ Yrs Exp)', 'Electrical Engineering Specialist Level 2', 'Electrical Engineering',
    4, ARRAY['English', 'Hindi'], 4.30, 51, 650,
    'Certified professional with 4 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000200000000', '00000000-0000-0000-0000-000000000000', 'swati_reddy_18_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000200000000', 'Swati Reddy', 'expert', 'swati_reddy_18_2', 'swati_reddy_18_2@demo.askexpert.com', '+91 98000 00359',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (5+ Yrs Exp)', 'Electrical Engineering Specialist Level 3', 'Electrical Engineering',
    5, ARRAY['English', 'Hindi'], 4.40, 58, 800,
    'Certified professional with 5 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000300000000', '00000000-0000-0000-0000-000000000000', 'rajesh_kulkarni_18_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000300000000', 'Rajesh Kulkarni', 'expert', 'rajesh_kulkarni_18_3', 'rajesh_kulkarni_18_3@demo.askexpert.com', '+91 98000 00360',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (6+ Yrs Exp)', 'Electrical Engineering Specialist Level 1', 'Electrical Engineering',
    6, ARRAY['English', 'Hindi'], 4.50, 65, 950,
    'Certified professional with 6 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000400000000', '00000000-0000-0000-0000-000000000000', 'priya_malhotra_18_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000400000000', 'Priya Malhotra', 'expert', 'priya_malhotra_18_4', 'priya_malhotra_18_4@demo.askexpert.com', '+91 98000 00361',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (7+ Yrs Exp)', 'Electrical Engineering Specialist Level 2', 'Electrical Engineering',
    7, ARRAY['English', 'Hindi'], 4.60, 72, 1100,
    'Certified professional with 7 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000500000000', '00000000-0000-0000-0000-000000000000', 'vikram_bhattacharya_18_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000500000000', 'Vikram Bhattacharya', 'expert', 'vikram_bhattacharya_18_5', 'vikram_bhattacharya_18_5@demo.askexpert.com', '+91 98000 00362',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (8+ Yrs Exp)', 'Electrical Engineering Specialist Level 3', 'Electrical Engineering',
    8, ARRAY['English', 'Hindi'], 4.70, 79, 1250,
    'Certified professional with 8 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000600000000', '00000000-0000-0000-0000-000000000000', 'ananya_saxena_18_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000600000000', 'Ananya Saxena', 'expert', 'ananya_saxena_18_6', 'ananya_saxena_18_6@demo.askexpert.com', '+91 98000 00363',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (9+ Yrs Exp)', 'Electrical Engineering Specialist Level 1', 'Electrical Engineering',
    9, ARRAY['English', 'Hindi'], 4.80, 86, 1400,
    'Certified professional with 9 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000700000000', '00000000-0000-0000-0000-000000000000', 'siddharth_gupta_18_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000700000000', 'Siddharth Gupta', 'expert', 'siddharth_gupta_18_7', 'siddharth_gupta_18_7@demo.askexpert.com', '+91 98000 00364',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (10+ Yrs Exp)', 'Electrical Engineering Specialist Level 2', 'Electrical Engineering',
    10, ARRAY['English', 'Hindi'], 4.90, 93, 1550,
    'Certified professional with 10 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000800000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_chopra_18_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000800000000', 'Meenakshi Chopra', 'expert', 'meenakshi_chopra_18_8', 'meenakshi_chopra_18_8@demo.askexpert.com', '+91 98000 00365',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (11+ Yrs Exp)', 'Electrical Engineering Specialist Level 3', 'Electrical Engineering',
    11, ARRAY['English', 'Hindi'], 4.20, 100, 1700,
    'Certified professional with 11 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000900000000', '00000000-0000-0000-0000-000000000000', 'amitabh_jain_18_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000900000000', 'Amitabh Jain', 'expert', 'amitabh_jain_18_9', 'amitabh_jain_18_9@demo.askexpert.com', '+91 98000 00366',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (12+ Yrs Exp)', 'Electrical Engineering Specialist Level 1', 'Electrical Engineering',
    12, ARRAY['English', 'Hindi'], 4.30, 107, 1850,
    'Certified professional with 12 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000a00000000', '00000000-0000-0000-0000-000000000000', 'sunita_nair_18_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000a00000000', 'Sunita Nair', 'expert', 'sunita_nair_18_10', 'sunita_nair_18_10@demo.askexpert.com', '+91 98000 00367',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (13+ Yrs Exp)', 'Electrical Engineering Specialist Level 2', 'Electrical Engineering',
    13, ARRAY['English', 'Hindi'], 4.40, 114, 2000,
    'Certified professional with 13 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000b00000000', '00000000-0000-0000-0000-000000000000', 'rohan_sharma_18_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000b00000000', 'Rohan Sharma', 'expert', 'rohan_sharma_18_11', 'rohan_sharma_18_11@demo.askexpert.com', '+91 98000 00368',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (14+ Yrs Exp)', 'Electrical Engineering Specialist Level 3', 'Electrical Engineering',
    14, ARRAY['English', 'Hindi'], 4.50, 121, 2150,
    'Certified professional with 14 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000c00000000', '00000000-0000-0000-0000-000000000000', 'shalini_reddy_18_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000c00000000', 'Shalini Reddy', 'expert', 'shalini_reddy_18_12', 'shalini_reddy_18_12@demo.askexpert.com', '+91 98000 00369',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (15+ Yrs Exp)', 'Electrical Engineering Specialist Level 1', 'Electrical Engineering',
    15, ARRAY['English', 'Hindi'], 4.60, 128, 2300,
    'Certified professional with 15 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000d00000000', '00000000-0000-0000-0000-000000000000', 'suresh_kulkarni_18_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000d00000000', 'Suresh Kulkarni', 'expert', 'suresh_kulkarni_18_13', 'suresh_kulkarni_18_13@demo.askexpert.com', '+91 98000 00370',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (16+ Yrs Exp)', 'Electrical Engineering Specialist Level 2', 'Electrical Engineering',
    16, ARRAY['English', 'Hindi'], 4.70, 135, 2450,
    'Certified professional with 16 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000e00000000', '00000000-0000-0000-0000-000000000000', 'ritu_malhotra_18_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000e00000000', 'Ritu Malhotra', 'expert', 'ritu_malhotra_18_14', 'ritu_malhotra_18_14@demo.askexpert.com', '+91 98000 00371',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (17+ Yrs Exp)', 'Electrical Engineering Specialist Level 3', 'Electrical Engineering',
    17, ARRAY['English', 'Hindi'], 4.80, 142, 2600,
    'Certified professional with 17 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-000f00000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_bhattacharya_18_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-000f00000000', 'Vikramaditya Bhattacharya', 'expert', 'vikramaditya_bhattacharya_18_15', 'vikramaditya_bhattacharya_18_15@demo.askexpert.com', '+91 98000 00372',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (18+ Yrs Exp)', 'Electrical Engineering Specialist Level 1', 'Electrical Engineering',
    18, ARRAY['English', 'Hindi'], 4.90, 149, 500,
    'Certified professional with 18 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-001000000000', '00000000-0000-0000-0000-000000000000', 'deepa_saxena_18_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-001000000000', 'Deepa Saxena', 'expert', 'deepa_saxena_18_16', 'deepa_saxena_18_16@demo.askexpert.com', '+91 98000 00373',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (19+ Yrs Exp)', 'Electrical Engineering Specialist Level 2', 'Electrical Engineering',
    19, ARRAY['English', 'Hindi'], 4.20, 156, 650,
    'Certified professional with 19 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-001100000000', '00000000-0000-0000-0000-000000000000', 'arvind_gupta_18_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-001100000000', 'Arvind Gupta', 'expert', 'arvind_gupta_18_17', 'arvind_gupta_18_17@demo.askexpert.com', '+91 98000 00374',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (20+ Yrs Exp)', 'Electrical Engineering Specialist Level 3', 'Electrical Engineering',
    20, ARRAY['English', 'Hindi'], 4.30, 163, 800,
    'Certified professional with 20 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-001200000000', '00000000-0000-0000-0000-000000000000', 'sneha_chopra_18_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-001200000000', 'Sneha Chopra', 'expert', 'sneha_chopra_18_18', 'sneha_chopra_18_18@demo.askexpert.com', '+91 98000 00375',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (3+ Yrs Exp)', 'Electrical Engineering Specialist Level 1', 'Electrical Engineering',
    3, ARRAY['English', 'Hindi'], 4.40, 170, 950,
    'Certified professional with 3 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-001300000000', '00000000-0000-0000-0000-000000000000', 'karthik_jain_18_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-001300000000', 'Karthik Jain', 'expert', 'karthik_jain_18_19', 'karthik_jain_18_19@demo.askexpert.com', '+91 98000 00376',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (4+ Yrs Exp)', 'Electrical Engineering Specialist Level 2', 'Electrical Engineering',
    4, ARRAY['English', 'Hindi'], 4.50, 177, 1100,
    'Certified professional with 4 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-001400000000', '00000000-0000-0000-0000-000000000000', 'neha_nair_18_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-001400000000', 'Neha Nair', 'expert', 'neha_nair_18_20', 'neha_nair_18_20@demo.askexpert.com', '+91 98000 00377',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (5+ Yrs Exp)', 'Electrical Engineering Specialist Level 3', 'Electrical Engineering',
    5, ARRAY['English', 'Hindi'], 4.60, 184, 1250,
    'Certified professional with 5 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1200-001500000000', '00000000-0000-0000-0000-000000000000', 'devendra_sharma_18_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1200-001500000000', 'Devendra Sharma', 'expert', 'devendra_sharma_18_21', 'devendra_sharma_18_21@demo.askexpert.com', '+91 98000 00378',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electrical Engineering (6+ Yrs Exp)', 'Electrical Engineering Specialist Level 1', 'Electrical Engineering',
    6, ARRAY['English', 'Hindi'], 4.70, 191, 1400,
    'Certified professional with 6 years of expertise in Electrical Engineering. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electrical Engineering Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000100000000', '00000000-0000-0000-0000-000000000000', 'preeti_chopra_19_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000100000000', 'Preeti Chopra', 'expert', 'preeti_chopra_19_1', 'preeti_chopra_19_1@demo.askexpert.com', '+91 98000 00379',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (4+ Yrs Exp)', 'Electronics Specialist Level 2', 'Electronics',
    4, ARRAY['English', 'Hindi'], 4.30, 63, 650,
    'Certified professional with 4 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000200000000', '00000000-0000-0000-0000-000000000000', 'alok_jain_19_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000200000000', 'Alok Jain', 'expert', 'alok_jain_19_2', 'alok_jain_19_2@demo.askexpert.com', '+91 98000 00380',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (5+ Yrs Exp)', 'Electronics Specialist Level 3', 'Electronics',
    5, ARRAY['English', 'Hindi'], 4.40, 70, 800,
    'Certified professional with 5 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000300000000', '00000000-0000-0000-0000-000000000000', 'kavita_nair_19_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000300000000', 'Kavita Nair', 'expert', 'kavita_nair_19_3', 'kavita_nair_19_3@demo.askexpert.com', '+91 98000 00381',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (6+ Yrs Exp)', 'Electronics Specialist Level 1', 'Electronics',
    6, ARRAY['English', 'Hindi'], 4.50, 77, 950,
    'Certified professional with 6 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000400000000', '00000000-0000-0000-0000-000000000000', 'manish_sharma_19_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000400000000', 'Manish Sharma', 'expert', 'manish_sharma_19_4', 'manish_sharma_19_4@demo.askexpert.com', '+91 98000 00382',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (7+ Yrs Exp)', 'Electronics Specialist Level 2', 'Electronics',
    7, ARRAY['English', 'Hindi'], 4.60, 84, 1100,
    'Certified professional with 7 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000500000000', '00000000-0000-0000-0000-000000000000', 'pooja_reddy_19_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000500000000', 'Pooja Reddy', 'expert', 'pooja_reddy_19_5', 'pooja_reddy_19_5@demo.askexpert.com', '+91 98000 00383',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (8+ Yrs Exp)', 'Electronics Specialist Level 3', 'Electronics',
    8, ARRAY['English', 'Hindi'], 4.70, 91, 1250,
    'Certified professional with 8 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000600000000', '00000000-0000-0000-0000-000000000000', 'sanjay_kulkarni_19_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000600000000', 'Sanjay Kulkarni', 'expert', 'sanjay_kulkarni_19_6', 'sanjay_kulkarni_19_6@demo.askexpert.com', '+91 98000 00384',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (9+ Yrs Exp)', 'Electronics Specialist Level 1', 'Electronics',
    9, ARRAY['English', 'Hindi'], 4.80, 98, 1400,
    'Certified professional with 9 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000700000000', '00000000-0000-0000-0000-000000000000', 'tanvi_malhotra_19_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000700000000', 'Tanvi Malhotra', 'expert', 'tanvi_malhotra_19_7', 'tanvi_malhotra_19_7@demo.askexpert.com', '+91 98000 00385',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (10+ Yrs Exp)', 'Electronics Specialist Level 2', 'Electronics',
    10, ARRAY['English', 'Hindi'], 4.90, 105, 1550,
    'Certified professional with 10 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000800000000', '00000000-0000-0000-0000-000000000000', 'varun_bhattacharya_19_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000800000000', 'Varun Bhattacharya', 'expert', 'varun_bhattacharya_19_8', 'varun_bhattacharya_19_8@demo.askexpert.com', '+91 98000 00386',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (11+ Yrs Exp)', 'Electronics Specialist Level 3', 'Electronics',
    11, ARRAY['English', 'Hindi'], 4.20, 112, 1700,
    'Certified professional with 11 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000900000000', '00000000-0000-0000-0000-000000000000', 'divya_saxena_19_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000900000000', 'Divya Saxena', 'expert', 'divya_saxena_19_9', 'divya_saxena_19_9@demo.askexpert.com', '+91 98000 00387',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (12+ Yrs Exp)', 'Electronics Specialist Level 1', 'Electronics',
    12, ARRAY['English', 'Hindi'], 4.30, 119, 1850,
    'Certified professional with 12 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000a00000000', '00000000-0000-0000-0000-000000000000', 'gautam_gupta_19_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000a00000000', 'Gautam Gupta', 'expert', 'gautam_gupta_19_10', 'gautam_gupta_19_10@demo.askexpert.com', '+91 98000 00388',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (13+ Yrs Exp)', 'Electronics Specialist Level 2', 'Electronics',
    13, ARRAY['English', 'Hindi'], 4.40, 126, 2000,
    'Certified professional with 13 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000b00000000', '00000000-0000-0000-0000-000000000000', 'swati_chopra_19_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000b00000000', 'Swati Chopra', 'expert', 'swati_chopra_19_11', 'swati_chopra_19_11@demo.askexpert.com', '+91 98000 00389',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (14+ Yrs Exp)', 'Electronics Specialist Level 3', 'Electronics',
    14, ARRAY['English', 'Hindi'], 4.50, 133, 2150,
    'Certified professional with 14 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000c00000000', '00000000-0000-0000-0000-000000000000', 'rajesh_jain_19_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000c00000000', 'Rajesh Jain', 'expert', 'rajesh_jain_19_12', 'rajesh_jain_19_12@demo.askexpert.com', '+91 98000 00390',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (15+ Yrs Exp)', 'Electronics Specialist Level 1', 'Electronics',
    15, ARRAY['English', 'Hindi'], 4.60, 140, 2300,
    'Certified professional with 15 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000d00000000', '00000000-0000-0000-0000-000000000000', 'priya_nair_19_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000d00000000', 'Priya Nair', 'expert', 'priya_nair_19_13', 'priya_nair_19_13@demo.askexpert.com', '+91 98000 00391',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (16+ Yrs Exp)', 'Electronics Specialist Level 2', 'Electronics',
    16, ARRAY['English', 'Hindi'], 4.70, 147, 2450,
    'Certified professional with 16 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000e00000000', '00000000-0000-0000-0000-000000000000', 'vikram_sharma_19_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000e00000000', 'Vikram Sharma', 'expert', 'vikram_sharma_19_14', 'vikram_sharma_19_14@demo.askexpert.com', '+91 98000 00392',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (17+ Yrs Exp)', 'Electronics Specialist Level 3', 'Electronics',
    17, ARRAY['English', 'Hindi'], 4.80, 154, 2600,
    'Certified professional with 17 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-000f00000000', '00000000-0000-0000-0000-000000000000', 'ananya_reddy_19_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-000f00000000', 'Ananya Reddy', 'expert', 'ananya_reddy_19_15', 'ananya_reddy_19_15@demo.askexpert.com', '+91 98000 00393',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (18+ Yrs Exp)', 'Electronics Specialist Level 1', 'Electronics',
    18, ARRAY['English', 'Hindi'], 4.90, 161, 500,
    'Certified professional with 18 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-001000000000', '00000000-0000-0000-0000-000000000000', 'siddharth_kulkarni_19_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-001000000000', 'Siddharth Kulkarni', 'expert', 'siddharth_kulkarni_19_16', 'siddharth_kulkarni_19_16@demo.askexpert.com', '+91 98000 00394',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (19+ Yrs Exp)', 'Electronics Specialist Level 2', 'Electronics',
    19, ARRAY['English', 'Hindi'], 4.20, 168, 650,
    'Certified professional with 19 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-001100000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_malhotra_19_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-001100000000', 'Meenakshi Malhotra', 'expert', 'meenakshi_malhotra_19_17', 'meenakshi_malhotra_19_17@demo.askexpert.com', '+91 98000 00395',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (20+ Yrs Exp)', 'Electronics Specialist Level 3', 'Electronics',
    20, ARRAY['English', 'Hindi'], 4.30, 175, 800,
    'Certified professional with 20 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-001200000000', '00000000-0000-0000-0000-000000000000', 'amitabh_bhattacharya_19_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-001200000000', 'Amitabh Bhattacharya', 'expert', 'amitabh_bhattacharya_19_18', 'amitabh_bhattacharya_19_18@demo.askexpert.com', '+91 98000 00396',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (3+ Yrs Exp)', 'Electronics Specialist Level 1', 'Electronics',
    3, ARRAY['English', 'Hindi'], 4.40, 182, 950,
    'Certified professional with 3 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-001300000000', '00000000-0000-0000-0000-000000000000', 'sunita_saxena_19_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-001300000000', 'Sunita Saxena', 'expert', 'sunita_saxena_19_19', 'sunita_saxena_19_19@demo.askexpert.com', '+91 98000 00397',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (4+ Yrs Exp)', 'Electronics Specialist Level 2', 'Electronics',
    4, ARRAY['English', 'Hindi'], 4.50, 189, 1100,
    'Certified professional with 4 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-001400000000', '00000000-0000-0000-0000-000000000000', 'rohan_gupta_19_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-001400000000', 'Rohan Gupta', 'expert', 'rohan_gupta_19_20', 'rohan_gupta_19_20@demo.askexpert.com', '+91 98000 00398',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (5+ Yrs Exp)', 'Electronics Specialist Level 3', 'Electronics',
    5, ARRAY['English', 'Hindi'], 4.60, 196, 1250,
    'Certified professional with 5 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1300-001500000000', '00000000-0000-0000-0000-000000000000', 'shalini_chopra_19_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1300-001500000000', 'Shalini Chopra', 'expert', 'shalini_chopra_19_21', 'shalini_chopra_19_21@demo.askexpert.com', '+91 98000 00399',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Electronics (6+ Yrs Exp)', 'Electronics Specialist Level 1', 'Electronics',
    6, ARRAY['English', 'Hindi'], 4.70, 203, 1400,
    'Certified professional with 6 years of expertise in Electronics. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Electronics Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000100000000', '00000000-0000-0000-0000-000000000000', 'suresh_bhattacharya_20_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000100000000', 'Suresh Bhattacharya', 'expert', 'suresh_bhattacharya_20_1', 'suresh_bhattacharya_20_1@demo.askexpert.com', '+91 98000 00400',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (4+ Yrs Exp)', 'Government & Civil Services Specialist Level 2', 'Government & Civil Services',
    4, ARRAY['English', 'Hindi'], 4.30, 75, 650,
    'Certified professional with 4 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000200000000', '00000000-0000-0000-0000-000000000000', 'ritu_saxena_20_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000200000000', 'Ritu Saxena', 'expert', 'ritu_saxena_20_2', 'ritu_saxena_20_2@demo.askexpert.com', '+91 98000 00401',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (5+ Yrs Exp)', 'Government & Civil Services Specialist Level 3', 'Government & Civil Services',
    5, ARRAY['English', 'Hindi'], 4.40, 82, 800,
    'Certified professional with 5 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000300000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_gupta_20_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000300000000', 'Vikramaditya Gupta', 'expert', 'vikramaditya_gupta_20_3', 'vikramaditya_gupta_20_3@demo.askexpert.com', '+91 98000 00402',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (6+ Yrs Exp)', 'Government & Civil Services Specialist Level 1', 'Government & Civil Services',
    6, ARRAY['English', 'Hindi'], 4.50, 89, 950,
    'Certified professional with 6 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000400000000', '00000000-0000-0000-0000-000000000000', 'deepa_chopra_20_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000400000000', 'Deepa Chopra', 'expert', 'deepa_chopra_20_4', 'deepa_chopra_20_4@demo.askexpert.com', '+91 98000 00403',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (7+ Yrs Exp)', 'Government & Civil Services Specialist Level 2', 'Government & Civil Services',
    7, ARRAY['English', 'Hindi'], 4.60, 96, 1100,
    'Certified professional with 7 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000500000000', '00000000-0000-0000-0000-000000000000', 'arvind_jain_20_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000500000000', 'Arvind Jain', 'expert', 'arvind_jain_20_5', 'arvind_jain_20_5@demo.askexpert.com', '+91 98000 00404',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (8+ Yrs Exp)', 'Government & Civil Services Specialist Level 3', 'Government & Civil Services',
    8, ARRAY['English', 'Hindi'], 4.70, 103, 1250,
    'Certified professional with 8 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000600000000', '00000000-0000-0000-0000-000000000000', 'sneha_nair_20_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000600000000', 'Sneha Nair', 'expert', 'sneha_nair_20_6', 'sneha_nair_20_6@demo.askexpert.com', '+91 98000 00405',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (9+ Yrs Exp)', 'Government & Civil Services Specialist Level 1', 'Government & Civil Services',
    9, ARRAY['English', 'Hindi'], 4.80, 110, 1400,
    'Certified professional with 9 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000700000000', '00000000-0000-0000-0000-000000000000', 'karthik_sharma_20_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000700000000', 'Karthik Sharma', 'expert', 'karthik_sharma_20_7', 'karthik_sharma_20_7@demo.askexpert.com', '+91 98000 00406',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (10+ Yrs Exp)', 'Government & Civil Services Specialist Level 2', 'Government & Civil Services',
    10, ARRAY['English', 'Hindi'], 4.90, 117, 1550,
    'Certified professional with 10 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000800000000', '00000000-0000-0000-0000-000000000000', 'neha_reddy_20_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000800000000', 'Neha Reddy', 'expert', 'neha_reddy_20_8', 'neha_reddy_20_8@demo.askexpert.com', '+91 98000 00407',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (11+ Yrs Exp)', 'Government & Civil Services Specialist Level 3', 'Government & Civil Services',
    11, ARRAY['English', 'Hindi'], 4.20, 124, 1700,
    'Certified professional with 11 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000900000000', '00000000-0000-0000-0000-000000000000', 'devendra_kulkarni_20_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000900000000', 'Devendra Kulkarni', 'expert', 'devendra_kulkarni_20_9', 'devendra_kulkarni_20_9@demo.askexpert.com', '+91 98000 00408',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (12+ Yrs Exp)', 'Government & Civil Services Specialist Level 1', 'Government & Civil Services',
    12, ARRAY['English', 'Hindi'], 4.30, 131, 1850,
    'Certified professional with 12 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000a00000000', '00000000-0000-0000-0000-000000000000', 'preeti_malhotra_20_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000a00000000', 'Preeti Malhotra', 'expert', 'preeti_malhotra_20_10', 'preeti_malhotra_20_10@demo.askexpert.com', '+91 98000 00409',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (13+ Yrs Exp)', 'Government & Civil Services Specialist Level 2', 'Government & Civil Services',
    13, ARRAY['English', 'Hindi'], 4.40, 138, 2000,
    'Certified professional with 13 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000b00000000', '00000000-0000-0000-0000-000000000000', 'alok_bhattacharya_20_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000b00000000', 'Alok Bhattacharya', 'expert', 'alok_bhattacharya_20_11', 'alok_bhattacharya_20_11@demo.askexpert.com', '+91 98000 00410',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (14+ Yrs Exp)', 'Government & Civil Services Specialist Level 3', 'Government & Civil Services',
    14, ARRAY['English', 'Hindi'], 4.50, 145, 2150,
    'Certified professional with 14 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000c00000000', '00000000-0000-0000-0000-000000000000', 'kavita_saxena_20_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000c00000000', 'Kavita Saxena', 'expert', 'kavita_saxena_20_12', 'kavita_saxena_20_12@demo.askexpert.com', '+91 98000 00411',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (15+ Yrs Exp)', 'Government & Civil Services Specialist Level 1', 'Government & Civil Services',
    15, ARRAY['English', 'Hindi'], 4.60, 152, 2300,
    'Certified professional with 15 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000d00000000', '00000000-0000-0000-0000-000000000000', 'manish_gupta_20_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000d00000000', 'Manish Gupta', 'expert', 'manish_gupta_20_13', 'manish_gupta_20_13@demo.askexpert.com', '+91 98000 00412',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (16+ Yrs Exp)', 'Government & Civil Services Specialist Level 2', 'Government & Civil Services',
    16, ARRAY['English', 'Hindi'], 4.70, 159, 2450,
    'Certified professional with 16 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000e00000000', '00000000-0000-0000-0000-000000000000', 'pooja_chopra_20_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000e00000000', 'Pooja Chopra', 'expert', 'pooja_chopra_20_14', 'pooja_chopra_20_14@demo.askexpert.com', '+91 98000 00413',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (17+ Yrs Exp)', 'Government & Civil Services Specialist Level 3', 'Government & Civil Services',
    17, ARRAY['English', 'Hindi'], 4.80, 166, 2600,
    'Certified professional with 17 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-000f00000000', '00000000-0000-0000-0000-000000000000', 'sanjay_jain_20_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-000f00000000', 'Sanjay Jain', 'expert', 'sanjay_jain_20_15', 'sanjay_jain_20_15@demo.askexpert.com', '+91 98000 00414',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (18+ Yrs Exp)', 'Government & Civil Services Specialist Level 1', 'Government & Civil Services',
    18, ARRAY['English', 'Hindi'], 4.90, 173, 500,
    'Certified professional with 18 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-001000000000', '00000000-0000-0000-0000-000000000000', 'tanvi_nair_20_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-001000000000', 'Tanvi Nair', 'expert', 'tanvi_nair_20_16', 'tanvi_nair_20_16@demo.askexpert.com', '+91 98000 00415',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (19+ Yrs Exp)', 'Government & Civil Services Specialist Level 2', 'Government & Civil Services',
    19, ARRAY['English', 'Hindi'], 4.20, 180, 650,
    'Certified professional with 19 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-001100000000', '00000000-0000-0000-0000-000000000000', 'varun_sharma_20_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-001100000000', 'Varun Sharma', 'expert', 'varun_sharma_20_17', 'varun_sharma_20_17@demo.askexpert.com', '+91 98000 00416',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (20+ Yrs Exp)', 'Government & Civil Services Specialist Level 3', 'Government & Civil Services',
    20, ARRAY['English', 'Hindi'], 4.30, 187, 800,
    'Certified professional with 20 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-001200000000', '00000000-0000-0000-0000-000000000000', 'divya_reddy_20_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-001200000000', 'Divya Reddy', 'expert', 'divya_reddy_20_18', 'divya_reddy_20_18@demo.askexpert.com', '+91 98000 00417',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (3+ Yrs Exp)', 'Government & Civil Services Specialist Level 1', 'Government & Civil Services',
    3, ARRAY['English', 'Hindi'], 4.40, 194, 950,
    'Certified professional with 3 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-001300000000', '00000000-0000-0000-0000-000000000000', 'gautam_kulkarni_20_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-001300000000', 'Gautam Kulkarni', 'expert', 'gautam_kulkarni_20_19', 'gautam_kulkarni_20_19@demo.askexpert.com', '+91 98000 00418',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (4+ Yrs Exp)', 'Government & Civil Services Specialist Level 2', 'Government & Civil Services',
    4, ARRAY['English', 'Hindi'], 4.50, 201, 1100,
    'Certified professional with 4 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-001400000000', '00000000-0000-0000-0000-000000000000', 'swati_malhotra_20_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-001400000000', 'Swati Malhotra', 'expert', 'swati_malhotra_20_20', 'swati_malhotra_20_20@demo.askexpert.com', '+91 98000 00419',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (5+ Yrs Exp)', 'Government & Civil Services Specialist Level 3', 'Government & Civil Services',
    5, ARRAY['English', 'Hindi'], 4.60, 208, 1250,
    'Certified professional with 5 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1400-001500000000', '00000000-0000-0000-0000-000000000000', 'rajesh_bhattacharya_20_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1400-001500000000', 'Rajesh Bhattacharya', 'expert', 'rajesh_bhattacharya_20_21', 'rajesh_bhattacharya_20_21@demo.askexpert.com', '+91 98000 00420',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Government & Civil Services (6+ Yrs Exp)', 'Government & Civil Services Specialist Level 1', 'Government & Civil Services',
    6, ARRAY['English', 'Hindi'], 4.70, 215, 1400,
    'Certified professional with 6 years of expertise in Government & Civil Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Government & Civil Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000100000000', '00000000-0000-0000-0000-000000000000', 'priya_reddy_21_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000100000000', 'Priya Reddy', 'expert', 'priya_reddy_21_1', 'priya_reddy_21_1@demo.askexpert.com', '+91 98000 00421',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (4+ Yrs Exp)', 'District Administration / Collector Specialist Level 2', 'District Administration / Collector',
    4, ARRAY['English', 'Hindi'], 4.30, 27, 650,
    'Certified professional with 4 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000200000000', '00000000-0000-0000-0000-000000000000', 'vikram_kulkarni_21_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000200000000', 'Vikram Kulkarni', 'expert', 'vikram_kulkarni_21_2', 'vikram_kulkarni_21_2@demo.askexpert.com', '+91 98000 00422',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (5+ Yrs Exp)', 'District Administration / Collector Specialist Level 3', 'District Administration / Collector',
    5, ARRAY['English', 'Hindi'], 4.40, 34, 800,
    'Certified professional with 5 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000300000000', '00000000-0000-0000-0000-000000000000', 'ananya_malhotra_21_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000300000000', 'Ananya Malhotra', 'expert', 'ananya_malhotra_21_3', 'ananya_malhotra_21_3@demo.askexpert.com', '+91 98000 00423',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (6+ Yrs Exp)', 'District Administration / Collector Specialist Level 1', 'District Administration / Collector',
    6, ARRAY['English', 'Hindi'], 4.50, 41, 950,
    'Certified professional with 6 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000400000000', '00000000-0000-0000-0000-000000000000', 'siddharth_bhattacharya_21_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000400000000', 'Siddharth Bhattacharya', 'expert', 'siddharth_bhattacharya_21_4', 'siddharth_bhattacharya_21_4@demo.askexpert.com', '+91 98000 00424',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (7+ Yrs Exp)', 'District Administration / Collector Specialist Level 2', 'District Administration / Collector',
    7, ARRAY['English', 'Hindi'], 4.60, 48, 1100,
    'Certified professional with 7 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000500000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_saxena_21_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000500000000', 'Meenakshi Saxena', 'expert', 'meenakshi_saxena_21_5', 'meenakshi_saxena_21_5@demo.askexpert.com', '+91 98000 00425',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (8+ Yrs Exp)', 'District Administration / Collector Specialist Level 3', 'District Administration / Collector',
    8, ARRAY['English', 'Hindi'], 4.70, 55, 1250,
    'Certified professional with 8 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000600000000', '00000000-0000-0000-0000-000000000000', 'amitabh_gupta_21_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000600000000', 'Amitabh Gupta', 'expert', 'amitabh_gupta_21_6', 'amitabh_gupta_21_6@demo.askexpert.com', '+91 98000 00426',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (9+ Yrs Exp)', 'District Administration / Collector Specialist Level 1', 'District Administration / Collector',
    9, ARRAY['English', 'Hindi'], 4.80, 62, 1400,
    'Certified professional with 9 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000700000000', '00000000-0000-0000-0000-000000000000', 'sunita_chopra_21_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000700000000', 'Sunita Chopra', 'expert', 'sunita_chopra_21_7', 'sunita_chopra_21_7@demo.askexpert.com', '+91 98000 00427',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (10+ Yrs Exp)', 'District Administration / Collector Specialist Level 2', 'District Administration / Collector',
    10, ARRAY['English', 'Hindi'], 4.90, 69, 1550,
    'Certified professional with 10 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000800000000', '00000000-0000-0000-0000-000000000000', 'rohan_jain_21_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000800000000', 'Rohan Jain', 'expert', 'rohan_jain_21_8', 'rohan_jain_21_8@demo.askexpert.com', '+91 98000 00428',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (11+ Yrs Exp)', 'District Administration / Collector Specialist Level 3', 'District Administration / Collector',
    11, ARRAY['English', 'Hindi'], 4.20, 76, 1700,
    'Certified professional with 11 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000900000000', '00000000-0000-0000-0000-000000000000', 'shalini_nair_21_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000900000000', 'Shalini Nair', 'expert', 'shalini_nair_21_9', 'shalini_nair_21_9@demo.askexpert.com', '+91 98000 00429',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (12+ Yrs Exp)', 'District Administration / Collector Specialist Level 1', 'District Administration / Collector',
    12, ARRAY['English', 'Hindi'], 4.30, 83, 1850,
    'Certified professional with 12 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000a00000000', '00000000-0000-0000-0000-000000000000', 'suresh_sharma_21_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000a00000000', 'Suresh Sharma', 'expert', 'suresh_sharma_21_10', 'suresh_sharma_21_10@demo.askexpert.com', '+91 98000 00430',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (13+ Yrs Exp)', 'District Administration / Collector Specialist Level 2', 'District Administration / Collector',
    13, ARRAY['English', 'Hindi'], 4.40, 90, 2000,
    'Certified professional with 13 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000b00000000', '00000000-0000-0000-0000-000000000000', 'ritu_reddy_21_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000b00000000', 'Ritu Reddy', 'expert', 'ritu_reddy_21_11', 'ritu_reddy_21_11@demo.askexpert.com', '+91 98000 00431',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (14+ Yrs Exp)', 'District Administration / Collector Specialist Level 3', 'District Administration / Collector',
    14, ARRAY['English', 'Hindi'], 4.50, 97, 2150,
    'Certified professional with 14 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000c00000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_kulkarni_21_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000c00000000', 'Vikramaditya Kulkarni', 'expert', 'vikramaditya_kulkarni_21_12', 'vikramaditya_kulkarni_21_12@demo.askexpert.com', '+91 98000 00432',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (15+ Yrs Exp)', 'District Administration / Collector Specialist Level 1', 'District Administration / Collector',
    15, ARRAY['English', 'Hindi'], 4.60, 104, 2300,
    'Certified professional with 15 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000d00000000', '00000000-0000-0000-0000-000000000000', 'deepa_malhotra_21_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000d00000000', 'Deepa Malhotra', 'expert', 'deepa_malhotra_21_13', 'deepa_malhotra_21_13@demo.askexpert.com', '+91 98000 00433',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (16+ Yrs Exp)', 'District Administration / Collector Specialist Level 2', 'District Administration / Collector',
    16, ARRAY['English', 'Hindi'], 4.70, 111, 2450,
    'Certified professional with 16 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000e00000000', '00000000-0000-0000-0000-000000000000', 'arvind_bhattacharya_21_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000e00000000', 'Arvind Bhattacharya', 'expert', 'arvind_bhattacharya_21_14', 'arvind_bhattacharya_21_14@demo.askexpert.com', '+91 98000 00434',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (17+ Yrs Exp)', 'District Administration / Collector Specialist Level 3', 'District Administration / Collector',
    17, ARRAY['English', 'Hindi'], 4.80, 118, 2600,
    'Certified professional with 17 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-000f00000000', '00000000-0000-0000-0000-000000000000', 'sneha_saxena_21_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-000f00000000', 'Sneha Saxena', 'expert', 'sneha_saxena_21_15', 'sneha_saxena_21_15@demo.askexpert.com', '+91 98000 00435',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (18+ Yrs Exp)', 'District Administration / Collector Specialist Level 1', 'District Administration / Collector',
    18, ARRAY['English', 'Hindi'], 4.90, 125, 500,
    'Certified professional with 18 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-001000000000', '00000000-0000-0000-0000-000000000000', 'karthik_gupta_21_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-001000000000', 'Karthik Gupta', 'expert', 'karthik_gupta_21_16', 'karthik_gupta_21_16@demo.askexpert.com', '+91 98000 00436',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (19+ Yrs Exp)', 'District Administration / Collector Specialist Level 2', 'District Administration / Collector',
    19, ARRAY['English', 'Hindi'], 4.20, 132, 650,
    'Certified professional with 19 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-001100000000', '00000000-0000-0000-0000-000000000000', 'neha_chopra_21_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-001100000000', 'Neha Chopra', 'expert', 'neha_chopra_21_17', 'neha_chopra_21_17@demo.askexpert.com', '+91 98000 00437',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (20+ Yrs Exp)', 'District Administration / Collector Specialist Level 3', 'District Administration / Collector',
    20, ARRAY['English', 'Hindi'], 4.30, 139, 800,
    'Certified professional with 20 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-001200000000', '00000000-0000-0000-0000-000000000000', 'devendra_jain_21_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-001200000000', 'Devendra Jain', 'expert', 'devendra_jain_21_18', 'devendra_jain_21_18@demo.askexpert.com', '+91 98000 00438',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (3+ Yrs Exp)', 'District Administration / Collector Specialist Level 1', 'District Administration / Collector',
    3, ARRAY['English', 'Hindi'], 4.40, 146, 950,
    'Certified professional with 3 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-001300000000', '00000000-0000-0000-0000-000000000000', 'preeti_nair_21_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-001300000000', 'Preeti Nair', 'expert', 'preeti_nair_21_19', 'preeti_nair_21_19@demo.askexpert.com', '+91 98000 00439',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (4+ Yrs Exp)', 'District Administration / Collector Specialist Level 2', 'District Administration / Collector',
    4, ARRAY['English', 'Hindi'], 4.50, 153, 1100,
    'Certified professional with 4 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-001400000000', '00000000-0000-0000-0000-000000000000', 'alok_sharma_21_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-001400000000', 'Alok Sharma', 'expert', 'alok_sharma_21_20', 'alok_sharma_21_20@demo.askexpert.com', '+91 98000 00440',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (5+ Yrs Exp)', 'District Administration / Collector Specialist Level 3', 'District Administration / Collector',
    5, ARRAY['English', 'Hindi'], 4.60, 160, 1250,
    'Certified professional with 5 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1500-001500000000', '00000000-0000-0000-0000-000000000000', 'kavita_reddy_21_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1500-001500000000', 'Kavita Reddy', 'expert', 'kavita_reddy_21_21', 'kavita_reddy_21_21@demo.askexpert.com', '+91 98000 00441',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in District Administration / Collector (6+ Yrs Exp)', 'District Administration / Collector Specialist Level 1', 'District Administration / Collector',
    6, ARRAY['English', 'Hindi'], 4.70, 167, 1400,
    'Certified professional with 6 years of expertise in District Administration / Collector. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['District Administration / Collector Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000100000000', '00000000-0000-0000-0000-000000000000', 'manish_jain_22_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000100000000', 'Manish Jain', 'expert', 'manish_jain_22_1', 'manish_jain_22_1@demo.askexpert.com', '+91 98000 00442',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (4+ Yrs Exp)', 'Real Estate Specialist Level 2', 'Real Estate',
    4, ARRAY['English', 'Hindi'], 4.30, 39, 650,
    'Certified professional with 4 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000200000000', '00000000-0000-0000-0000-000000000000', 'pooja_nair_22_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000200000000', 'Pooja Nair', 'expert', 'pooja_nair_22_2', 'pooja_nair_22_2@demo.askexpert.com', '+91 98000 00443',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (5+ Yrs Exp)', 'Real Estate Specialist Level 3', 'Real Estate',
    5, ARRAY['English', 'Hindi'], 4.40, 46, 800,
    'Certified professional with 5 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000300000000', '00000000-0000-0000-0000-000000000000', 'sanjay_sharma_22_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000300000000', 'Sanjay Sharma', 'expert', 'sanjay_sharma_22_3', 'sanjay_sharma_22_3@demo.askexpert.com', '+91 98000 00444',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (6+ Yrs Exp)', 'Real Estate Specialist Level 1', 'Real Estate',
    6, ARRAY['English', 'Hindi'], 4.50, 53, 950,
    'Certified professional with 6 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000400000000', '00000000-0000-0000-0000-000000000000', 'tanvi_reddy_22_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000400000000', 'Tanvi Reddy', 'expert', 'tanvi_reddy_22_4', 'tanvi_reddy_22_4@demo.askexpert.com', '+91 98000 00445',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (7+ Yrs Exp)', 'Real Estate Specialist Level 2', 'Real Estate',
    7, ARRAY['English', 'Hindi'], 4.60, 60, 1100,
    'Certified professional with 7 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000500000000', '00000000-0000-0000-0000-000000000000', 'varun_kulkarni_22_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000500000000', 'Varun Kulkarni', 'expert', 'varun_kulkarni_22_5', 'varun_kulkarni_22_5@demo.askexpert.com', '+91 98000 00446',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (8+ Yrs Exp)', 'Real Estate Specialist Level 3', 'Real Estate',
    8, ARRAY['English', 'Hindi'], 4.70, 67, 1250,
    'Certified professional with 8 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000600000000', '00000000-0000-0000-0000-000000000000', 'divya_malhotra_22_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000600000000', 'Divya Malhotra', 'expert', 'divya_malhotra_22_6', 'divya_malhotra_22_6@demo.askexpert.com', '+91 98000 00447',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (9+ Yrs Exp)', 'Real Estate Specialist Level 1', 'Real Estate',
    9, ARRAY['English', 'Hindi'], 4.80, 74, 1400,
    'Certified professional with 9 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000700000000', '00000000-0000-0000-0000-000000000000', 'gautam_bhattacharya_22_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000700000000', 'Gautam Bhattacharya', 'expert', 'gautam_bhattacharya_22_7', 'gautam_bhattacharya_22_7@demo.askexpert.com', '+91 98000 00448',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (10+ Yrs Exp)', 'Real Estate Specialist Level 2', 'Real Estate',
    10, ARRAY['English', 'Hindi'], 4.90, 81, 1550,
    'Certified professional with 10 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000800000000', '00000000-0000-0000-0000-000000000000', 'swati_saxena_22_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000800000000', 'Swati Saxena', 'expert', 'swati_saxena_22_8', 'swati_saxena_22_8@demo.askexpert.com', '+91 98000 00449',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (11+ Yrs Exp)', 'Real Estate Specialist Level 3', 'Real Estate',
    11, ARRAY['English', 'Hindi'], 4.20, 88, 1700,
    'Certified professional with 11 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000900000000', '00000000-0000-0000-0000-000000000000', 'rajesh_gupta_22_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000900000000', 'Rajesh Gupta', 'expert', 'rajesh_gupta_22_9', 'rajesh_gupta_22_9@demo.askexpert.com', '+91 98000 00450',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (12+ Yrs Exp)', 'Real Estate Specialist Level 1', 'Real Estate',
    12, ARRAY['English', 'Hindi'], 4.30, 95, 1850,
    'Certified professional with 12 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000a00000000', '00000000-0000-0000-0000-000000000000', 'priya_chopra_22_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000a00000000', 'Priya Chopra', 'expert', 'priya_chopra_22_10', 'priya_chopra_22_10@demo.askexpert.com', '+91 98000 00451',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (13+ Yrs Exp)', 'Real Estate Specialist Level 2', 'Real Estate',
    13, ARRAY['English', 'Hindi'], 4.40, 102, 2000,
    'Certified professional with 13 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000b00000000', '00000000-0000-0000-0000-000000000000', 'vikram_jain_22_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000b00000000', 'Vikram Jain', 'expert', 'vikram_jain_22_11', 'vikram_jain_22_11@demo.askexpert.com', '+91 98000 00452',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (14+ Yrs Exp)', 'Real Estate Specialist Level 3', 'Real Estate',
    14, ARRAY['English', 'Hindi'], 4.50, 109, 2150,
    'Certified professional with 14 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000c00000000', '00000000-0000-0000-0000-000000000000', 'ananya_nair_22_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000c00000000', 'Ananya Nair', 'expert', 'ananya_nair_22_12', 'ananya_nair_22_12@demo.askexpert.com', '+91 98000 00453',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (15+ Yrs Exp)', 'Real Estate Specialist Level 1', 'Real Estate',
    15, ARRAY['English', 'Hindi'], 4.60, 116, 2300,
    'Certified professional with 15 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000d00000000', '00000000-0000-0000-0000-000000000000', 'siddharth_sharma_22_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000d00000000', 'Siddharth Sharma', 'expert', 'siddharth_sharma_22_13', 'siddharth_sharma_22_13@demo.askexpert.com', '+91 98000 00454',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (16+ Yrs Exp)', 'Real Estate Specialist Level 2', 'Real Estate',
    16, ARRAY['English', 'Hindi'], 4.70, 123, 2450,
    'Certified professional with 16 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000e00000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_reddy_22_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000e00000000', 'Meenakshi Reddy', 'expert', 'meenakshi_reddy_22_14', 'meenakshi_reddy_22_14@demo.askexpert.com', '+91 98000 00455',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (17+ Yrs Exp)', 'Real Estate Specialist Level 3', 'Real Estate',
    17, ARRAY['English', 'Hindi'], 4.80, 130, 2600,
    'Certified professional with 17 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-000f00000000', '00000000-0000-0000-0000-000000000000', 'amitabh_kulkarni_22_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-000f00000000', 'Amitabh Kulkarni', 'expert', 'amitabh_kulkarni_22_15', 'amitabh_kulkarni_22_15@demo.askexpert.com', '+91 98000 00456',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (18+ Yrs Exp)', 'Real Estate Specialist Level 1', 'Real Estate',
    18, ARRAY['English', 'Hindi'], 4.90, 137, 500,
    'Certified professional with 18 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-001000000000', '00000000-0000-0000-0000-000000000000', 'sunita_malhotra_22_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-001000000000', 'Sunita Malhotra', 'expert', 'sunita_malhotra_22_16', 'sunita_malhotra_22_16@demo.askexpert.com', '+91 98000 00457',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (19+ Yrs Exp)', 'Real Estate Specialist Level 2', 'Real Estate',
    19, ARRAY['English', 'Hindi'], 4.20, 144, 650,
    'Certified professional with 19 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-001100000000', '00000000-0000-0000-0000-000000000000', 'rohan_bhattacharya_22_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-001100000000', 'Rohan Bhattacharya', 'expert', 'rohan_bhattacharya_22_17', 'rohan_bhattacharya_22_17@demo.askexpert.com', '+91 98000 00458',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (20+ Yrs Exp)', 'Real Estate Specialist Level 3', 'Real Estate',
    20, ARRAY['English', 'Hindi'], 4.30, 151, 800,
    'Certified professional with 20 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-001200000000', '00000000-0000-0000-0000-000000000000', 'shalini_saxena_22_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-001200000000', 'Shalini Saxena', 'expert', 'shalini_saxena_22_18', 'shalini_saxena_22_18@demo.askexpert.com', '+91 98000 00459',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (3+ Yrs Exp)', 'Real Estate Specialist Level 1', 'Real Estate',
    3, ARRAY['English', 'Hindi'], 4.40, 158, 950,
    'Certified professional with 3 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-001300000000', '00000000-0000-0000-0000-000000000000', 'suresh_gupta_22_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-001300000000', 'Suresh Gupta', 'expert', 'suresh_gupta_22_19', 'suresh_gupta_22_19@demo.askexpert.com', '+91 98000 00460',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (4+ Yrs Exp)', 'Real Estate Specialist Level 2', 'Real Estate',
    4, ARRAY['English', 'Hindi'], 4.50, 165, 1100,
    'Certified professional with 4 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-001400000000', '00000000-0000-0000-0000-000000000000', 'ritu_chopra_22_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-001400000000', 'Ritu Chopra', 'expert', 'ritu_chopra_22_20', 'ritu_chopra_22_20@demo.askexpert.com', '+91 98000 00461',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (5+ Yrs Exp)', 'Real Estate Specialist Level 3', 'Real Estate',
    5, ARRAY['English', 'Hindi'], 4.60, 172, 1250,
    'Certified professional with 5 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1600-001500000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_jain_22_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1600-001500000000', 'Vikramaditya Jain', 'expert', 'vikramaditya_jain_22_21', 'vikramaditya_jain_22_21@demo.askexpert.com', '+91 98000 00462',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Real Estate (6+ Yrs Exp)', 'Real Estate Specialist Level 1', 'Real Estate',
    6, ARRAY['English', 'Hindi'], 4.70, 179, 1400,
    'Certified professional with 6 years of expertise in Real Estate. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Real Estate Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000100000000', '00000000-0000-0000-0000-000000000000', 'deepa_saxena_23_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000100000000', 'Deepa Saxena', 'expert', 'deepa_saxena_23_1', 'deepa_saxena_23_1@demo.askexpert.com', '+91 98000 00463',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (4+ Yrs Exp)', 'Insurance Specialist Level 2', 'Insurance',
    4, ARRAY['English', 'Hindi'], 4.30, 51, 650,
    'Certified professional with 4 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000200000000', '00000000-0000-0000-0000-000000000000', 'arvind_gupta_23_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000200000000', 'Arvind Gupta', 'expert', 'arvind_gupta_23_2', 'arvind_gupta_23_2@demo.askexpert.com', '+91 98000 00464',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (5+ Yrs Exp)', 'Insurance Specialist Level 3', 'Insurance',
    5, ARRAY['English', 'Hindi'], 4.40, 58, 800,
    'Certified professional with 5 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000300000000', '00000000-0000-0000-0000-000000000000', 'sneha_chopra_23_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000300000000', 'Sneha Chopra', 'expert', 'sneha_chopra_23_3', 'sneha_chopra_23_3@demo.askexpert.com', '+91 98000 00465',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (6+ Yrs Exp)', 'Insurance Specialist Level 1', 'Insurance',
    6, ARRAY['English', 'Hindi'], 4.50, 65, 950,
    'Certified professional with 6 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000400000000', '00000000-0000-0000-0000-000000000000', 'karthik_jain_23_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000400000000', 'Karthik Jain', 'expert', 'karthik_jain_23_4', 'karthik_jain_23_4@demo.askexpert.com', '+91 98000 00466',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (7+ Yrs Exp)', 'Insurance Specialist Level 2', 'Insurance',
    7, ARRAY['English', 'Hindi'], 4.60, 72, 1100,
    'Certified professional with 7 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000500000000', '00000000-0000-0000-0000-000000000000', 'neha_nair_23_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000500000000', 'Neha Nair', 'expert', 'neha_nair_23_5', 'neha_nair_23_5@demo.askexpert.com', '+91 98000 00467',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (8+ Yrs Exp)', 'Insurance Specialist Level 3', 'Insurance',
    8, ARRAY['English', 'Hindi'], 4.70, 79, 1250,
    'Certified professional with 8 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000600000000', '00000000-0000-0000-0000-000000000000', 'devendra_sharma_23_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000600000000', 'Devendra Sharma', 'expert', 'devendra_sharma_23_6', 'devendra_sharma_23_6@demo.askexpert.com', '+91 98000 00468',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (9+ Yrs Exp)', 'Insurance Specialist Level 1', 'Insurance',
    9, ARRAY['English', 'Hindi'], 4.80, 86, 1400,
    'Certified professional with 9 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000700000000', '00000000-0000-0000-0000-000000000000', 'preeti_reddy_23_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000700000000', 'Preeti Reddy', 'expert', 'preeti_reddy_23_7', 'preeti_reddy_23_7@demo.askexpert.com', '+91 98000 00469',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (10+ Yrs Exp)', 'Insurance Specialist Level 2', 'Insurance',
    10, ARRAY['English', 'Hindi'], 4.90, 93, 1550,
    'Certified professional with 10 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000800000000', '00000000-0000-0000-0000-000000000000', 'alok_kulkarni_23_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000800000000', 'Alok Kulkarni', 'expert', 'alok_kulkarni_23_8', 'alok_kulkarni_23_8@demo.askexpert.com', '+91 98000 00470',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (11+ Yrs Exp)', 'Insurance Specialist Level 3', 'Insurance',
    11, ARRAY['English', 'Hindi'], 4.20, 100, 1700,
    'Certified professional with 11 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000900000000', '00000000-0000-0000-0000-000000000000', 'kavita_malhotra_23_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000900000000', 'Kavita Malhotra', 'expert', 'kavita_malhotra_23_9', 'kavita_malhotra_23_9@demo.askexpert.com', '+91 98000 00471',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (12+ Yrs Exp)', 'Insurance Specialist Level 1', 'Insurance',
    12, ARRAY['English', 'Hindi'], 4.30, 107, 1850,
    'Certified professional with 12 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000a00000000', '00000000-0000-0000-0000-000000000000', 'manish_bhattacharya_23_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000a00000000', 'Manish Bhattacharya', 'expert', 'manish_bhattacharya_23_10', 'manish_bhattacharya_23_10@demo.askexpert.com', '+91 98000 00472',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (13+ Yrs Exp)', 'Insurance Specialist Level 2', 'Insurance',
    13, ARRAY['English', 'Hindi'], 4.40, 114, 2000,
    'Certified professional with 13 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000b00000000', '00000000-0000-0000-0000-000000000000', 'pooja_saxena_23_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000b00000000', 'Pooja Saxena', 'expert', 'pooja_saxena_23_11', 'pooja_saxena_23_11@demo.askexpert.com', '+91 98000 00473',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (14+ Yrs Exp)', 'Insurance Specialist Level 3', 'Insurance',
    14, ARRAY['English', 'Hindi'], 4.50, 121, 2150,
    'Certified professional with 14 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000c00000000', '00000000-0000-0000-0000-000000000000', 'sanjay_gupta_23_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000c00000000', 'Sanjay Gupta', 'expert', 'sanjay_gupta_23_12', 'sanjay_gupta_23_12@demo.askexpert.com', '+91 98000 00474',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (15+ Yrs Exp)', 'Insurance Specialist Level 1', 'Insurance',
    15, ARRAY['English', 'Hindi'], 4.60, 128, 2300,
    'Certified professional with 15 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000d00000000', '00000000-0000-0000-0000-000000000000', 'tanvi_chopra_23_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000d00000000', 'Tanvi Chopra', 'expert', 'tanvi_chopra_23_13', 'tanvi_chopra_23_13@demo.askexpert.com', '+91 98000 00475',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (16+ Yrs Exp)', 'Insurance Specialist Level 2', 'Insurance',
    16, ARRAY['English', 'Hindi'], 4.70, 135, 2450,
    'Certified professional with 16 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000e00000000', '00000000-0000-0000-0000-000000000000', 'varun_jain_23_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000e00000000', 'Varun Jain', 'expert', 'varun_jain_23_14', 'varun_jain_23_14@demo.askexpert.com', '+91 98000 00476',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (17+ Yrs Exp)', 'Insurance Specialist Level 3', 'Insurance',
    17, ARRAY['English', 'Hindi'], 4.80, 142, 2600,
    'Certified professional with 17 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-000f00000000', '00000000-0000-0000-0000-000000000000', 'divya_nair_23_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-000f00000000', 'Divya Nair', 'expert', 'divya_nair_23_15', 'divya_nair_23_15@demo.askexpert.com', '+91 98000 00477',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (18+ Yrs Exp)', 'Insurance Specialist Level 1', 'Insurance',
    18, ARRAY['English', 'Hindi'], 4.90, 149, 500,
    'Certified professional with 18 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-001000000000', '00000000-0000-0000-0000-000000000000', 'gautam_sharma_23_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-001000000000', 'Gautam Sharma', 'expert', 'gautam_sharma_23_16', 'gautam_sharma_23_16@demo.askexpert.com', '+91 98000 00478',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (19+ Yrs Exp)', 'Insurance Specialist Level 2', 'Insurance',
    19, ARRAY['English', 'Hindi'], 4.20, 156, 650,
    'Certified professional with 19 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-001100000000', '00000000-0000-0000-0000-000000000000', 'swati_reddy_23_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-001100000000', 'Swati Reddy', 'expert', 'swati_reddy_23_17', 'swati_reddy_23_17@demo.askexpert.com', '+91 98000 00479',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (20+ Yrs Exp)', 'Insurance Specialist Level 3', 'Insurance',
    20, ARRAY['English', 'Hindi'], 4.30, 163, 800,
    'Certified professional with 20 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-001200000000', '00000000-0000-0000-0000-000000000000', 'rajesh_kulkarni_23_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-001200000000', 'Rajesh Kulkarni', 'expert', 'rajesh_kulkarni_23_18', 'rajesh_kulkarni_23_18@demo.askexpert.com', '+91 98000 00480',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (3+ Yrs Exp)', 'Insurance Specialist Level 1', 'Insurance',
    3, ARRAY['English', 'Hindi'], 4.40, 170, 950,
    'Certified professional with 3 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-001300000000', '00000000-0000-0000-0000-000000000000', 'priya_malhotra_23_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-001300000000', 'Priya Malhotra', 'expert', 'priya_malhotra_23_19', 'priya_malhotra_23_19@demo.askexpert.com', '+91 98000 00481',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (4+ Yrs Exp)', 'Insurance Specialist Level 2', 'Insurance',
    4, ARRAY['English', 'Hindi'], 4.50, 177, 1100,
    'Certified professional with 4 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-001400000000', '00000000-0000-0000-0000-000000000000', 'vikram_bhattacharya_23_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-001400000000', 'Vikram Bhattacharya', 'expert', 'vikram_bhattacharya_23_20', 'vikram_bhattacharya_23_20@demo.askexpert.com', '+91 98000 00482',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (5+ Yrs Exp)', 'Insurance Specialist Level 3', 'Insurance',
    5, ARRAY['English', 'Hindi'], 4.60, 184, 1250,
    'Certified professional with 5 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1700-001500000000', '00000000-0000-0000-0000-000000000000', 'ananya_saxena_23_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1700-001500000000', 'Ananya Saxena', 'expert', 'ananya_saxena_23_21', 'ananya_saxena_23_21@demo.askexpert.com', '+91 98000 00483',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Insurance (6+ Yrs Exp)', 'Insurance Specialist Level 1', 'Insurance',
    6, ARRAY['English', 'Hindi'], 4.70, 191, 1400,
    'Certified professional with 6 years of expertise in Insurance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Insurance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000100000000', '00000000-0000-0000-0000-000000000000', 'siddharth_kulkarni_24_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000100000000', 'Siddharth Kulkarni', 'expert', 'siddharth_kulkarni_24_1', 'siddharth_kulkarni_24_1@demo.askexpert.com', '+91 98000 00484',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (4+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 2', 'Investment & Wealth Management',
    4, ARRAY['English', 'Hindi'], 4.30, 63, 650,
    'Certified professional with 4 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000200000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_malhotra_24_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000200000000', 'Meenakshi Malhotra', 'expert', 'meenakshi_malhotra_24_2', 'meenakshi_malhotra_24_2@demo.askexpert.com', '+91 98000 00485',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (5+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 3', 'Investment & Wealth Management',
    5, ARRAY['English', 'Hindi'], 4.40, 70, 800,
    'Certified professional with 5 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000300000000', '00000000-0000-0000-0000-000000000000', 'amitabh_bhattacharya_24_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000300000000', 'Amitabh Bhattacharya', 'expert', 'amitabh_bhattacharya_24_3', 'amitabh_bhattacharya_24_3@demo.askexpert.com', '+91 98000 00486',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (6+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 1', 'Investment & Wealth Management',
    6, ARRAY['English', 'Hindi'], 4.50, 77, 950,
    'Certified professional with 6 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000400000000', '00000000-0000-0000-0000-000000000000', 'sunita_saxena_24_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000400000000', 'Sunita Saxena', 'expert', 'sunita_saxena_24_4', 'sunita_saxena_24_4@demo.askexpert.com', '+91 98000 00487',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (7+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 2', 'Investment & Wealth Management',
    7, ARRAY['English', 'Hindi'], 4.60, 84, 1100,
    'Certified professional with 7 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000500000000', '00000000-0000-0000-0000-000000000000', 'rohan_gupta_24_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000500000000', 'Rohan Gupta', 'expert', 'rohan_gupta_24_5', 'rohan_gupta_24_5@demo.askexpert.com', '+91 98000 00488',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (8+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 3', 'Investment & Wealth Management',
    8, ARRAY['English', 'Hindi'], 4.70, 91, 1250,
    'Certified professional with 8 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000600000000', '00000000-0000-0000-0000-000000000000', 'shalini_chopra_24_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000600000000', 'Shalini Chopra', 'expert', 'shalini_chopra_24_6', 'shalini_chopra_24_6@demo.askexpert.com', '+91 98000 00489',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (9+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 1', 'Investment & Wealth Management',
    9, ARRAY['English', 'Hindi'], 4.80, 98, 1400,
    'Certified professional with 9 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000700000000', '00000000-0000-0000-0000-000000000000', 'suresh_jain_24_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000700000000', 'Suresh Jain', 'expert', 'suresh_jain_24_7', 'suresh_jain_24_7@demo.askexpert.com', '+91 98000 00490',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (10+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 2', 'Investment & Wealth Management',
    10, ARRAY['English', 'Hindi'], 4.90, 105, 1550,
    'Certified professional with 10 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000800000000', '00000000-0000-0000-0000-000000000000', 'ritu_nair_24_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000800000000', 'Ritu Nair', 'expert', 'ritu_nair_24_8', 'ritu_nair_24_8@demo.askexpert.com', '+91 98000 00491',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (11+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 3', 'Investment & Wealth Management',
    11, ARRAY['English', 'Hindi'], 4.20, 112, 1700,
    'Certified professional with 11 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000900000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_sharma_24_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000900000000', 'Vikramaditya Sharma', 'expert', 'vikramaditya_sharma_24_9', 'vikramaditya_sharma_24_9@demo.askexpert.com', '+91 98000 00492',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (12+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 1', 'Investment & Wealth Management',
    12, ARRAY['English', 'Hindi'], 4.30, 119, 1850,
    'Certified professional with 12 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000a00000000', '00000000-0000-0000-0000-000000000000', 'deepa_reddy_24_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000a00000000', 'Deepa Reddy', 'expert', 'deepa_reddy_24_10', 'deepa_reddy_24_10@demo.askexpert.com', '+91 98000 00493',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (13+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 2', 'Investment & Wealth Management',
    13, ARRAY['English', 'Hindi'], 4.40, 126, 2000,
    'Certified professional with 13 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000b00000000', '00000000-0000-0000-0000-000000000000', 'arvind_kulkarni_24_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000b00000000', 'Arvind Kulkarni', 'expert', 'arvind_kulkarni_24_11', 'arvind_kulkarni_24_11@demo.askexpert.com', '+91 98000 00494',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (14+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 3', 'Investment & Wealth Management',
    14, ARRAY['English', 'Hindi'], 4.50, 133, 2150,
    'Certified professional with 14 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000c00000000', '00000000-0000-0000-0000-000000000000', 'sneha_malhotra_24_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000c00000000', 'Sneha Malhotra', 'expert', 'sneha_malhotra_24_12', 'sneha_malhotra_24_12@demo.askexpert.com', '+91 98000 00495',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (15+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 1', 'Investment & Wealth Management',
    15, ARRAY['English', 'Hindi'], 4.60, 140, 2300,
    'Certified professional with 15 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000d00000000', '00000000-0000-0000-0000-000000000000', 'karthik_bhattacharya_24_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000d00000000', 'Karthik Bhattacharya', 'expert', 'karthik_bhattacharya_24_13', 'karthik_bhattacharya_24_13@demo.askexpert.com', '+91 98000 00496',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (16+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 2', 'Investment & Wealth Management',
    16, ARRAY['English', 'Hindi'], 4.70, 147, 2450,
    'Certified professional with 16 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000e00000000', '00000000-0000-0000-0000-000000000000', 'neha_saxena_24_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000e00000000', 'Neha Saxena', 'expert', 'neha_saxena_24_14', 'neha_saxena_24_14@demo.askexpert.com', '+91 98000 00497',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (17+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 3', 'Investment & Wealth Management',
    17, ARRAY['English', 'Hindi'], 4.80, 154, 2600,
    'Certified professional with 17 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-000f00000000', '00000000-0000-0000-0000-000000000000', 'devendra_gupta_24_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-000f00000000', 'Devendra Gupta', 'expert', 'devendra_gupta_24_15', 'devendra_gupta_24_15@demo.askexpert.com', '+91 98000 00498',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (18+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 1', 'Investment & Wealth Management',
    18, ARRAY['English', 'Hindi'], 4.90, 161, 500,
    'Certified professional with 18 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-001000000000', '00000000-0000-0000-0000-000000000000', 'preeti_chopra_24_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-001000000000', 'Preeti Chopra', 'expert', 'preeti_chopra_24_16', 'preeti_chopra_24_16@demo.askexpert.com', '+91 98000 00499',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (19+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 2', 'Investment & Wealth Management',
    19, ARRAY['English', 'Hindi'], 4.20, 168, 650,
    'Certified professional with 19 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-001100000000', '00000000-0000-0000-0000-000000000000', 'alok_jain_24_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-001100000000', 'Alok Jain', 'expert', 'alok_jain_24_17', 'alok_jain_24_17@demo.askexpert.com', '+91 98000 00500',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (20+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 3', 'Investment & Wealth Management',
    20, ARRAY['English', 'Hindi'], 4.30, 175, 800,
    'Certified professional with 20 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-001200000000', '00000000-0000-0000-0000-000000000000', 'kavita_nair_24_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-001200000000', 'Kavita Nair', 'expert', 'kavita_nair_24_18', 'kavita_nair_24_18@demo.askexpert.com', '+91 98000 00501',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (3+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 1', 'Investment & Wealth Management',
    3, ARRAY['English', 'Hindi'], 4.40, 182, 950,
    'Certified professional with 3 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-001300000000', '00000000-0000-0000-0000-000000000000', 'manish_sharma_24_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-001300000000', 'Manish Sharma', 'expert', 'manish_sharma_24_19', 'manish_sharma_24_19@demo.askexpert.com', '+91 98000 00502',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (4+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 2', 'Investment & Wealth Management',
    4, ARRAY['English', 'Hindi'], 4.50, 189, 1100,
    'Certified professional with 4 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-001400000000', '00000000-0000-0000-0000-000000000000', 'pooja_reddy_24_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-001400000000', 'Pooja Reddy', 'expert', 'pooja_reddy_24_20', 'pooja_reddy_24_20@demo.askexpert.com', '+91 98000 00503',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (5+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 3', 'Investment & Wealth Management',
    5, ARRAY['English', 'Hindi'], 4.60, 196, 1250,
    'Certified professional with 5 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1800-001500000000', '00000000-0000-0000-0000-000000000000', 'sanjay_kulkarni_24_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1800-001500000000', 'Sanjay Kulkarni', 'expert', 'sanjay_kulkarni_24_21', 'sanjay_kulkarni_24_21@demo.askexpert.com', '+91 98000 00504',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Investment & Wealth Management (6+ Yrs Exp)', 'Investment & Wealth Management Specialist Level 1', 'Investment & Wealth Management',
    6, ARRAY['English', 'Hindi'], 4.70, 203, 1400,
    'Certified professional with 6 years of expertise in Investment & Wealth Management. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Investment & Wealth Management Advisory', 'Consultation', 'Strategy'],
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

END $;

-- ENSURE ALL EXPERTS HAVE IS_VERIFIED = TRUE
UPDATE public.profiles SET is_verified = true WHERE role = 'expert';

SELECT count(*) AS chunk_3_demo_experts FROM public.profiles WHERE is_demo = true;
