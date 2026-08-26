-- ==============================================================================
-- ASKEXPERT - SEED CHUNK 1 OF 5 (CATEGORIES 1 TO 8)
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
    'a0000000-0000-0000-0100-000100000000', '00000000-0000-0000-0000-000000000000', 'priya_reddy_1_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000100000000', 'Priya Reddy', 'expert', 'priya_reddy_1_1', 'priya_reddy_1_1@demo.askexpert.com', '+91 98000 00001',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (4+ Yrs Exp)', 'Agriculture & Farming Specialist Level 2', 'Agriculture & Farming',
    4, ARRAY['English', 'Hindi'], 4.30, 27, 650,
    'Certified professional with 4 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000200000000', '00000000-0000-0000-0000-000000000000', 'vikram_kulkarni_1_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000200000000', 'Vikram Kulkarni', 'expert', 'vikram_kulkarni_1_2', 'vikram_kulkarni_1_2@demo.askexpert.com', '+91 98000 00002',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (5+ Yrs Exp)', 'Agriculture & Farming Specialist Level 3', 'Agriculture & Farming',
    5, ARRAY['English', 'Hindi'], 4.40, 34, 800,
    'Certified professional with 5 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000300000000', '00000000-0000-0000-0000-000000000000', 'ananya_malhotra_1_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000300000000', 'Ananya Malhotra', 'expert', 'ananya_malhotra_1_3', 'ananya_malhotra_1_3@demo.askexpert.com', '+91 98000 00003',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (6+ Yrs Exp)', 'Agriculture & Farming Specialist Level 1', 'Agriculture & Farming',
    6, ARRAY['English', 'Hindi'], 4.50, 41, 950,
    'Certified professional with 6 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000400000000', '00000000-0000-0000-0000-000000000000', 'siddharth_bhattacharya_1_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000400000000', 'Siddharth Bhattacharya', 'expert', 'siddharth_bhattacharya_1_4', 'siddharth_bhattacharya_1_4@demo.askexpert.com', '+91 98000 00004',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (7+ Yrs Exp)', 'Agriculture & Farming Specialist Level 2', 'Agriculture & Farming',
    7, ARRAY['English', 'Hindi'], 4.60, 48, 1100,
    'Certified professional with 7 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000500000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_saxena_1_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000500000000', 'Meenakshi Saxena', 'expert', 'meenakshi_saxena_1_5', 'meenakshi_saxena_1_5@demo.askexpert.com', '+91 98000 00005',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (8+ Yrs Exp)', 'Agriculture & Farming Specialist Level 3', 'Agriculture & Farming',
    8, ARRAY['English', 'Hindi'], 4.70, 55, 1250,
    'Certified professional with 8 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000600000000', '00000000-0000-0000-0000-000000000000', 'amitabh_gupta_1_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000600000000', 'Amitabh Gupta', 'expert', 'amitabh_gupta_1_6', 'amitabh_gupta_1_6@demo.askexpert.com', '+91 98000 00006',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (9+ Yrs Exp)', 'Agriculture & Farming Specialist Level 1', 'Agriculture & Farming',
    9, ARRAY['English', 'Hindi'], 4.80, 62, 1400,
    'Certified professional with 9 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000700000000', '00000000-0000-0000-0000-000000000000', 'sunita_chopra_1_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000700000000', 'Sunita Chopra', 'expert', 'sunita_chopra_1_7', 'sunita_chopra_1_7@demo.askexpert.com', '+91 98000 00007',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (10+ Yrs Exp)', 'Agriculture & Farming Specialist Level 2', 'Agriculture & Farming',
    10, ARRAY['English', 'Hindi'], 4.90, 69, 1550,
    'Certified professional with 10 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000800000000', '00000000-0000-0000-0000-000000000000', 'rohan_jain_1_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000800000000', 'Rohan Jain', 'expert', 'rohan_jain_1_8', 'rohan_jain_1_8@demo.askexpert.com', '+91 98000 00008',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (11+ Yrs Exp)', 'Agriculture & Farming Specialist Level 3', 'Agriculture & Farming',
    11, ARRAY['English', 'Hindi'], 4.20, 76, 1700,
    'Certified professional with 11 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000900000000', '00000000-0000-0000-0000-000000000000', 'shalini_nair_1_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000900000000', 'Shalini Nair', 'expert', 'shalini_nair_1_9', 'shalini_nair_1_9@demo.askexpert.com', '+91 98000 00009',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (12+ Yrs Exp)', 'Agriculture & Farming Specialist Level 1', 'Agriculture & Farming',
    12, ARRAY['English', 'Hindi'], 4.30, 83, 1850,
    'Certified professional with 12 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000a00000000', '00000000-0000-0000-0000-000000000000', 'suresh_sharma_1_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000a00000000', 'Suresh Sharma', 'expert', 'suresh_sharma_1_10', 'suresh_sharma_1_10@demo.askexpert.com', '+91 98000 00010',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (13+ Yrs Exp)', 'Agriculture & Farming Specialist Level 2', 'Agriculture & Farming',
    13, ARRAY['English', 'Hindi'], 4.40, 90, 2000,
    'Certified professional with 13 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000b00000000', '00000000-0000-0000-0000-000000000000', 'ritu_reddy_1_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000b00000000', 'Ritu Reddy', 'expert', 'ritu_reddy_1_11', 'ritu_reddy_1_11@demo.askexpert.com', '+91 98000 00011',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (14+ Yrs Exp)', 'Agriculture & Farming Specialist Level 3', 'Agriculture & Farming',
    14, ARRAY['English', 'Hindi'], 4.50, 97, 2150,
    'Certified professional with 14 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000c00000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_kulkarni_1_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000c00000000', 'Vikramaditya Kulkarni', 'expert', 'vikramaditya_kulkarni_1_12', 'vikramaditya_kulkarni_1_12@demo.askexpert.com', '+91 98000 00012',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (15+ Yrs Exp)', 'Agriculture & Farming Specialist Level 1', 'Agriculture & Farming',
    15, ARRAY['English', 'Hindi'], 4.60, 104, 2300,
    'Certified professional with 15 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000d00000000', '00000000-0000-0000-0000-000000000000', 'deepa_malhotra_1_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000d00000000', 'Deepa Malhotra', 'expert', 'deepa_malhotra_1_13', 'deepa_malhotra_1_13@demo.askexpert.com', '+91 98000 00013',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (16+ Yrs Exp)', 'Agriculture & Farming Specialist Level 2', 'Agriculture & Farming',
    16, ARRAY['English', 'Hindi'], 4.70, 111, 2450,
    'Certified professional with 16 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000e00000000', '00000000-0000-0000-0000-000000000000', 'arvind_bhattacharya_1_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000e00000000', 'Arvind Bhattacharya', 'expert', 'arvind_bhattacharya_1_14', 'arvind_bhattacharya_1_14@demo.askexpert.com', '+91 98000 00014',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (17+ Yrs Exp)', 'Agriculture & Farming Specialist Level 3', 'Agriculture & Farming',
    17, ARRAY['English', 'Hindi'], 4.80, 118, 2600,
    'Certified professional with 17 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-000f00000000', '00000000-0000-0000-0000-000000000000', 'sneha_saxena_1_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-000f00000000', 'Sneha Saxena', 'expert', 'sneha_saxena_1_15', 'sneha_saxena_1_15@demo.askexpert.com', '+91 98000 00015',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (18+ Yrs Exp)', 'Agriculture & Farming Specialist Level 1', 'Agriculture & Farming',
    18, ARRAY['English', 'Hindi'], 4.90, 125, 500,
    'Certified professional with 18 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-001000000000', '00000000-0000-0000-0000-000000000000', 'karthik_gupta_1_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-001000000000', 'Karthik Gupta', 'expert', 'karthik_gupta_1_16', 'karthik_gupta_1_16@demo.askexpert.com', '+91 98000 00016',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (19+ Yrs Exp)', 'Agriculture & Farming Specialist Level 2', 'Agriculture & Farming',
    19, ARRAY['English', 'Hindi'], 4.20, 132, 650,
    'Certified professional with 19 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-001100000000', '00000000-0000-0000-0000-000000000000', 'neha_chopra_1_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-001100000000', 'Neha Chopra', 'expert', 'neha_chopra_1_17', 'neha_chopra_1_17@demo.askexpert.com', '+91 98000 00017',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (20+ Yrs Exp)', 'Agriculture & Farming Specialist Level 3', 'Agriculture & Farming',
    20, ARRAY['English', 'Hindi'], 4.30, 139, 800,
    'Certified professional with 20 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-001200000000', '00000000-0000-0000-0000-000000000000', 'devendra_jain_1_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-001200000000', 'Devendra Jain', 'expert', 'devendra_jain_1_18', 'devendra_jain_1_18@demo.askexpert.com', '+91 98000 00018',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (3+ Yrs Exp)', 'Agriculture & Farming Specialist Level 1', 'Agriculture & Farming',
    3, ARRAY['English', 'Hindi'], 4.40, 146, 950,
    'Certified professional with 3 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-001300000000', '00000000-0000-0000-0000-000000000000', 'preeti_nair_1_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-001300000000', 'Preeti Nair', 'expert', 'preeti_nair_1_19', 'preeti_nair_1_19@demo.askexpert.com', '+91 98000 00019',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (4+ Yrs Exp)', 'Agriculture & Farming Specialist Level 2', 'Agriculture & Farming',
    4, ARRAY['English', 'Hindi'], 4.50, 153, 1100,
    'Certified professional with 4 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-001400000000', '00000000-0000-0000-0000-000000000000', 'alok_sharma_1_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-001400000000', 'Alok Sharma', 'expert', 'alok_sharma_1_20', 'alok_sharma_1_20@demo.askexpert.com', '+91 98000 00020',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (5+ Yrs Exp)', 'Agriculture & Farming Specialist Level 3', 'Agriculture & Farming',
    5, ARRAY['English', 'Hindi'], 4.60, 160, 1250,
    'Certified professional with 5 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0100-001500000000', '00000000-0000-0000-0000-000000000000', 'kavita_reddy_1_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0100-001500000000', 'Kavita Reddy', 'expert', 'kavita_reddy_1_21', 'kavita_reddy_1_21@demo.askexpert.com', '+91 98000 00021',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Agriculture & Farming (6+ Yrs Exp)', 'Agriculture & Farming Specialist Level 1', 'Agriculture & Farming',
    6, ARRAY['English', 'Hindi'], 4.70, 167, 1400,
    'Certified professional with 6 years of expertise in Agriculture & Farming. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Agriculture & Farming Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000100000000', '00000000-0000-0000-0000-000000000000', 'manish_jain_2_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000100000000', 'Manish Jain', 'expert', 'manish_jain_2_1', 'manish_jain_2_1@demo.askexpert.com', '+91 98000 00022',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (4+ Yrs Exp)', 'Technology & Software Specialist Level 2', 'Technology & Software',
    4, ARRAY['English', 'Hindi'], 4.30, 39, 650,
    'Certified professional with 4 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000200000000', '00000000-0000-0000-0000-000000000000', 'pooja_nair_2_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000200000000', 'Pooja Nair', 'expert', 'pooja_nair_2_2', 'pooja_nair_2_2@demo.askexpert.com', '+91 98000 00023',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (5+ Yrs Exp)', 'Technology & Software Specialist Level 3', 'Technology & Software',
    5, ARRAY['English', 'Hindi'], 4.40, 46, 800,
    'Certified professional with 5 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000300000000', '00000000-0000-0000-0000-000000000000', 'sanjay_sharma_2_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000300000000', 'Sanjay Sharma', 'expert', 'sanjay_sharma_2_3', 'sanjay_sharma_2_3@demo.askexpert.com', '+91 98000 00024',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (6+ Yrs Exp)', 'Technology & Software Specialist Level 1', 'Technology & Software',
    6, ARRAY['English', 'Hindi'], 4.50, 53, 950,
    'Certified professional with 6 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000400000000', '00000000-0000-0000-0000-000000000000', 'tanvi_reddy_2_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000400000000', 'Tanvi Reddy', 'expert', 'tanvi_reddy_2_4', 'tanvi_reddy_2_4@demo.askexpert.com', '+91 98000 00025',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (7+ Yrs Exp)', 'Technology & Software Specialist Level 2', 'Technology & Software',
    7, ARRAY['English', 'Hindi'], 4.60, 60, 1100,
    'Certified professional with 7 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000500000000', '00000000-0000-0000-0000-000000000000', 'varun_kulkarni_2_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000500000000', 'Varun Kulkarni', 'expert', 'varun_kulkarni_2_5', 'varun_kulkarni_2_5@demo.askexpert.com', '+91 98000 00026',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (8+ Yrs Exp)', 'Technology & Software Specialist Level 3', 'Technology & Software',
    8, ARRAY['English', 'Hindi'], 4.70, 67, 1250,
    'Certified professional with 8 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000600000000', '00000000-0000-0000-0000-000000000000', 'divya_malhotra_2_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000600000000', 'Divya Malhotra', 'expert', 'divya_malhotra_2_6', 'divya_malhotra_2_6@demo.askexpert.com', '+91 98000 00027',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (9+ Yrs Exp)', 'Technology & Software Specialist Level 1', 'Technology & Software',
    9, ARRAY['English', 'Hindi'], 4.80, 74, 1400,
    'Certified professional with 9 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000700000000', '00000000-0000-0000-0000-000000000000', 'gautam_bhattacharya_2_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000700000000', 'Gautam Bhattacharya', 'expert', 'gautam_bhattacharya_2_7', 'gautam_bhattacharya_2_7@demo.askexpert.com', '+91 98000 00028',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (10+ Yrs Exp)', 'Technology & Software Specialist Level 2', 'Technology & Software',
    10, ARRAY['English', 'Hindi'], 4.90, 81, 1550,
    'Certified professional with 10 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000800000000', '00000000-0000-0000-0000-000000000000', 'swati_saxena_2_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000800000000', 'Swati Saxena', 'expert', 'swati_saxena_2_8', 'swati_saxena_2_8@demo.askexpert.com', '+91 98000 00029',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (11+ Yrs Exp)', 'Technology & Software Specialist Level 3', 'Technology & Software',
    11, ARRAY['English', 'Hindi'], 4.20, 88, 1700,
    'Certified professional with 11 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000900000000', '00000000-0000-0000-0000-000000000000', 'rajesh_gupta_2_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000900000000', 'Rajesh Gupta', 'expert', 'rajesh_gupta_2_9', 'rajesh_gupta_2_9@demo.askexpert.com', '+91 98000 00030',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (12+ Yrs Exp)', 'Technology & Software Specialist Level 1', 'Technology & Software',
    12, ARRAY['English', 'Hindi'], 4.30, 95, 1850,
    'Certified professional with 12 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000a00000000', '00000000-0000-0000-0000-000000000000', 'priya_chopra_2_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000a00000000', 'Priya Chopra', 'expert', 'priya_chopra_2_10', 'priya_chopra_2_10@demo.askexpert.com', '+91 98000 00031',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (13+ Yrs Exp)', 'Technology & Software Specialist Level 2', 'Technology & Software',
    13, ARRAY['English', 'Hindi'], 4.40, 102, 2000,
    'Certified professional with 13 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000b00000000', '00000000-0000-0000-0000-000000000000', 'vikram_jain_2_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000b00000000', 'Vikram Jain', 'expert', 'vikram_jain_2_11', 'vikram_jain_2_11@demo.askexpert.com', '+91 98000 00032',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (14+ Yrs Exp)', 'Technology & Software Specialist Level 3', 'Technology & Software',
    14, ARRAY['English', 'Hindi'], 4.50, 109, 2150,
    'Certified professional with 14 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000c00000000', '00000000-0000-0000-0000-000000000000', 'ananya_nair_2_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000c00000000', 'Ananya Nair', 'expert', 'ananya_nair_2_12', 'ananya_nair_2_12@demo.askexpert.com', '+91 98000 00033',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (15+ Yrs Exp)', 'Technology & Software Specialist Level 1', 'Technology & Software',
    15, ARRAY['English', 'Hindi'], 4.60, 116, 2300,
    'Certified professional with 15 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000d00000000', '00000000-0000-0000-0000-000000000000', 'siddharth_sharma_2_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000d00000000', 'Siddharth Sharma', 'expert', 'siddharth_sharma_2_13', 'siddharth_sharma_2_13@demo.askexpert.com', '+91 98000 00034',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (16+ Yrs Exp)', 'Technology & Software Specialist Level 2', 'Technology & Software',
    16, ARRAY['English', 'Hindi'], 4.70, 123, 2450,
    'Certified professional with 16 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000e00000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_reddy_2_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000e00000000', 'Meenakshi Reddy', 'expert', 'meenakshi_reddy_2_14', 'meenakshi_reddy_2_14@demo.askexpert.com', '+91 98000 00035',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (17+ Yrs Exp)', 'Technology & Software Specialist Level 3', 'Technology & Software',
    17, ARRAY['English', 'Hindi'], 4.80, 130, 2600,
    'Certified professional with 17 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-000f00000000', '00000000-0000-0000-0000-000000000000', 'amitabh_kulkarni_2_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-000f00000000', 'Amitabh Kulkarni', 'expert', 'amitabh_kulkarni_2_15', 'amitabh_kulkarni_2_15@demo.askexpert.com', '+91 98000 00036',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (18+ Yrs Exp)', 'Technology & Software Specialist Level 1', 'Technology & Software',
    18, ARRAY['English', 'Hindi'], 4.90, 137, 500,
    'Certified professional with 18 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-001000000000', '00000000-0000-0000-0000-000000000000', 'sunita_malhotra_2_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-001000000000', 'Sunita Malhotra', 'expert', 'sunita_malhotra_2_16', 'sunita_malhotra_2_16@demo.askexpert.com', '+91 98000 00037',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (19+ Yrs Exp)', 'Technology & Software Specialist Level 2', 'Technology & Software',
    19, ARRAY['English', 'Hindi'], 4.20, 144, 650,
    'Certified professional with 19 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-001100000000', '00000000-0000-0000-0000-000000000000', 'rohan_bhattacharya_2_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-001100000000', 'Rohan Bhattacharya', 'expert', 'rohan_bhattacharya_2_17', 'rohan_bhattacharya_2_17@demo.askexpert.com', '+91 98000 00038',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (20+ Yrs Exp)', 'Technology & Software Specialist Level 3', 'Technology & Software',
    20, ARRAY['English', 'Hindi'], 4.30, 151, 800,
    'Certified professional with 20 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-001200000000', '00000000-0000-0000-0000-000000000000', 'shalini_saxena_2_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-001200000000', 'Shalini Saxena', 'expert', 'shalini_saxena_2_18', 'shalini_saxena_2_18@demo.askexpert.com', '+91 98000 00039',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (3+ Yrs Exp)', 'Technology & Software Specialist Level 1', 'Technology & Software',
    3, ARRAY['English', 'Hindi'], 4.40, 158, 950,
    'Certified professional with 3 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-001300000000', '00000000-0000-0000-0000-000000000000', 'suresh_gupta_2_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-001300000000', 'Suresh Gupta', 'expert', 'suresh_gupta_2_19', 'suresh_gupta_2_19@demo.askexpert.com', '+91 98000 00040',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (4+ Yrs Exp)', 'Technology & Software Specialist Level 2', 'Technology & Software',
    4, ARRAY['English', 'Hindi'], 4.50, 165, 1100,
    'Certified professional with 4 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-001400000000', '00000000-0000-0000-0000-000000000000', 'ritu_chopra_2_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-001400000000', 'Ritu Chopra', 'expert', 'ritu_chopra_2_20', 'ritu_chopra_2_20@demo.askexpert.com', '+91 98000 00041',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (5+ Yrs Exp)', 'Technology & Software Specialist Level 3', 'Technology & Software',
    5, ARRAY['English', 'Hindi'], 4.60, 172, 1250,
    'Certified professional with 5 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0200-001500000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_jain_2_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0200-001500000000', 'Vikramaditya Jain', 'expert', 'vikramaditya_jain_2_21', 'vikramaditya_jain_2_21@demo.askexpert.com', '+91 98000 00042',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Technology & Software (6+ Yrs Exp)', 'Technology & Software Specialist Level 1', 'Technology & Software',
    6, ARRAY['English', 'Hindi'], 4.70, 179, 1400,
    'Certified professional with 6 years of expertise in Technology & Software. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Technology & Software Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000100000000', '00000000-0000-0000-0000-000000000000', 'deepa_saxena_3_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000100000000', 'Deepa Saxena', 'expert', 'deepa_saxena_3_1', 'deepa_saxena_3_1@demo.askexpert.com', '+91 98000 00043',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (4+ Yrs Exp)', 'AI & Machine Learning Specialist Level 2', 'AI & Machine Learning',
    4, ARRAY['English', 'Hindi'], 4.30, 51, 650,
    'Certified professional with 4 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000200000000', '00000000-0000-0000-0000-000000000000', 'arvind_gupta_3_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000200000000', 'Arvind Gupta', 'expert', 'arvind_gupta_3_2', 'arvind_gupta_3_2@demo.askexpert.com', '+91 98000 00044',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (5+ Yrs Exp)', 'AI & Machine Learning Specialist Level 3', 'AI & Machine Learning',
    5, ARRAY['English', 'Hindi'], 4.40, 58, 800,
    'Certified professional with 5 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000300000000', '00000000-0000-0000-0000-000000000000', 'sneha_chopra_3_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000300000000', 'Sneha Chopra', 'expert', 'sneha_chopra_3_3', 'sneha_chopra_3_3@demo.askexpert.com', '+91 98000 00045',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (6+ Yrs Exp)', 'AI & Machine Learning Specialist Level 1', 'AI & Machine Learning',
    6, ARRAY['English', 'Hindi'], 4.50, 65, 950,
    'Certified professional with 6 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000400000000', '00000000-0000-0000-0000-000000000000', 'karthik_jain_3_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000400000000', 'Karthik Jain', 'expert', 'karthik_jain_3_4', 'karthik_jain_3_4@demo.askexpert.com', '+91 98000 00046',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (7+ Yrs Exp)', 'AI & Machine Learning Specialist Level 2', 'AI & Machine Learning',
    7, ARRAY['English', 'Hindi'], 4.60, 72, 1100,
    'Certified professional with 7 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000500000000', '00000000-0000-0000-0000-000000000000', 'neha_nair_3_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000500000000', 'Neha Nair', 'expert', 'neha_nair_3_5', 'neha_nair_3_5@demo.askexpert.com', '+91 98000 00047',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (8+ Yrs Exp)', 'AI & Machine Learning Specialist Level 3', 'AI & Machine Learning',
    8, ARRAY['English', 'Hindi'], 4.70, 79, 1250,
    'Certified professional with 8 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000600000000', '00000000-0000-0000-0000-000000000000', 'devendra_sharma_3_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000600000000', 'Devendra Sharma', 'expert', 'devendra_sharma_3_6', 'devendra_sharma_3_6@demo.askexpert.com', '+91 98000 00048',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (9+ Yrs Exp)', 'AI & Machine Learning Specialist Level 1', 'AI & Machine Learning',
    9, ARRAY['English', 'Hindi'], 4.80, 86, 1400,
    'Certified professional with 9 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000700000000', '00000000-0000-0000-0000-000000000000', 'preeti_reddy_3_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000700000000', 'Preeti Reddy', 'expert', 'preeti_reddy_3_7', 'preeti_reddy_3_7@demo.askexpert.com', '+91 98000 00049',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (10+ Yrs Exp)', 'AI & Machine Learning Specialist Level 2', 'AI & Machine Learning',
    10, ARRAY['English', 'Hindi'], 4.90, 93, 1550,
    'Certified professional with 10 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000800000000', '00000000-0000-0000-0000-000000000000', 'alok_kulkarni_3_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000800000000', 'Alok Kulkarni', 'expert', 'alok_kulkarni_3_8', 'alok_kulkarni_3_8@demo.askexpert.com', '+91 98000 00050',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (11+ Yrs Exp)', 'AI & Machine Learning Specialist Level 3', 'AI & Machine Learning',
    11, ARRAY['English', 'Hindi'], 4.20, 100, 1700,
    'Certified professional with 11 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000900000000', '00000000-0000-0000-0000-000000000000', 'kavita_malhotra_3_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000900000000', 'Kavita Malhotra', 'expert', 'kavita_malhotra_3_9', 'kavita_malhotra_3_9@demo.askexpert.com', '+91 98000 00051',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (12+ Yrs Exp)', 'AI & Machine Learning Specialist Level 1', 'AI & Machine Learning',
    12, ARRAY['English', 'Hindi'], 4.30, 107, 1850,
    'Certified professional with 12 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000a00000000', '00000000-0000-0000-0000-000000000000', 'manish_bhattacharya_3_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000a00000000', 'Manish Bhattacharya', 'expert', 'manish_bhattacharya_3_10', 'manish_bhattacharya_3_10@demo.askexpert.com', '+91 98000 00052',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (13+ Yrs Exp)', 'AI & Machine Learning Specialist Level 2', 'AI & Machine Learning',
    13, ARRAY['English', 'Hindi'], 4.40, 114, 2000,
    'Certified professional with 13 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000b00000000', '00000000-0000-0000-0000-000000000000', 'pooja_saxena_3_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000b00000000', 'Pooja Saxena', 'expert', 'pooja_saxena_3_11', 'pooja_saxena_3_11@demo.askexpert.com', '+91 98000 00053',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (14+ Yrs Exp)', 'AI & Machine Learning Specialist Level 3', 'AI & Machine Learning',
    14, ARRAY['English', 'Hindi'], 4.50, 121, 2150,
    'Certified professional with 14 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000c00000000', '00000000-0000-0000-0000-000000000000', 'sanjay_gupta_3_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000c00000000', 'Sanjay Gupta', 'expert', 'sanjay_gupta_3_12', 'sanjay_gupta_3_12@demo.askexpert.com', '+91 98000 00054',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (15+ Yrs Exp)', 'AI & Machine Learning Specialist Level 1', 'AI & Machine Learning',
    15, ARRAY['English', 'Hindi'], 4.60, 128, 2300,
    'Certified professional with 15 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000d00000000', '00000000-0000-0000-0000-000000000000', 'tanvi_chopra_3_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000d00000000', 'Tanvi Chopra', 'expert', 'tanvi_chopra_3_13', 'tanvi_chopra_3_13@demo.askexpert.com', '+91 98000 00055',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (16+ Yrs Exp)', 'AI & Machine Learning Specialist Level 2', 'AI & Machine Learning',
    16, ARRAY['English', 'Hindi'], 4.70, 135, 2450,
    'Certified professional with 16 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000e00000000', '00000000-0000-0000-0000-000000000000', 'varun_jain_3_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000e00000000', 'Varun Jain', 'expert', 'varun_jain_3_14', 'varun_jain_3_14@demo.askexpert.com', '+91 98000 00056',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (17+ Yrs Exp)', 'AI & Machine Learning Specialist Level 3', 'AI & Machine Learning',
    17, ARRAY['English', 'Hindi'], 4.80, 142, 2600,
    'Certified professional with 17 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-000f00000000', '00000000-0000-0000-0000-000000000000', 'divya_nair_3_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-000f00000000', 'Divya Nair', 'expert', 'divya_nair_3_15', 'divya_nair_3_15@demo.askexpert.com', '+91 98000 00057',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (18+ Yrs Exp)', 'AI & Machine Learning Specialist Level 1', 'AI & Machine Learning',
    18, ARRAY['English', 'Hindi'], 4.90, 149, 500,
    'Certified professional with 18 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-001000000000', '00000000-0000-0000-0000-000000000000', 'gautam_sharma_3_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-001000000000', 'Gautam Sharma', 'expert', 'gautam_sharma_3_16', 'gautam_sharma_3_16@demo.askexpert.com', '+91 98000 00058',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (19+ Yrs Exp)', 'AI & Machine Learning Specialist Level 2', 'AI & Machine Learning',
    19, ARRAY['English', 'Hindi'], 4.20, 156, 650,
    'Certified professional with 19 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-001100000000', '00000000-0000-0000-0000-000000000000', 'swati_reddy_3_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-001100000000', 'Swati Reddy', 'expert', 'swati_reddy_3_17', 'swati_reddy_3_17@demo.askexpert.com', '+91 98000 00059',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (20+ Yrs Exp)', 'AI & Machine Learning Specialist Level 3', 'AI & Machine Learning',
    20, ARRAY['English', 'Hindi'], 4.30, 163, 800,
    'Certified professional with 20 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-001200000000', '00000000-0000-0000-0000-000000000000', 'rajesh_kulkarni_3_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-001200000000', 'Rajesh Kulkarni', 'expert', 'rajesh_kulkarni_3_18', 'rajesh_kulkarni_3_18@demo.askexpert.com', '+91 98000 00060',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (3+ Yrs Exp)', 'AI & Machine Learning Specialist Level 1', 'AI & Machine Learning',
    3, ARRAY['English', 'Hindi'], 4.40, 170, 950,
    'Certified professional with 3 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-001300000000', '00000000-0000-0000-0000-000000000000', 'priya_malhotra_3_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-001300000000', 'Priya Malhotra', 'expert', 'priya_malhotra_3_19', 'priya_malhotra_3_19@demo.askexpert.com', '+91 98000 00061',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (4+ Yrs Exp)', 'AI & Machine Learning Specialist Level 2', 'AI & Machine Learning',
    4, ARRAY['English', 'Hindi'], 4.50, 177, 1100,
    'Certified professional with 4 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-001400000000', '00000000-0000-0000-0000-000000000000', 'vikram_bhattacharya_3_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-001400000000', 'Vikram Bhattacharya', 'expert', 'vikram_bhattacharya_3_20', 'vikram_bhattacharya_3_20@demo.askexpert.com', '+91 98000 00062',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (5+ Yrs Exp)', 'AI & Machine Learning Specialist Level 3', 'AI & Machine Learning',
    5, ARRAY['English', 'Hindi'], 4.60, 184, 1250,
    'Certified professional with 5 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0300-001500000000', '00000000-0000-0000-0000-000000000000', 'ananya_saxena_3_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0300-001500000000', 'Ananya Saxena', 'expert', 'ananya_saxena_3_21', 'ananya_saxena_3_21@demo.askexpert.com', '+91 98000 00063',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in AI & Machine Learning (6+ Yrs Exp)', 'AI & Machine Learning Specialist Level 1', 'AI & Machine Learning',
    6, ARRAY['English', 'Hindi'], 4.70, 191, 1400,
    'Certified professional with 6 years of expertise in AI & Machine Learning. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['AI & Machine Learning Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000100000000', '00000000-0000-0000-0000-000000000000', 'siddharth_kulkarni_4_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000100000000', 'Siddharth Kulkarni', 'expert', 'siddharth_kulkarni_4_1', 'siddharth_kulkarni_4_1@demo.askexpert.com', '+91 98000 00064',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (4+ Yrs Exp)', 'Cybersecurity Specialist Level 2', 'Cybersecurity',
    4, ARRAY['English', 'Hindi'], 4.30, 63, 650,
    'Certified professional with 4 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000200000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_malhotra_4_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000200000000', 'Meenakshi Malhotra', 'expert', 'meenakshi_malhotra_4_2', 'meenakshi_malhotra_4_2@demo.askexpert.com', '+91 98000 00065',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (5+ Yrs Exp)', 'Cybersecurity Specialist Level 3', 'Cybersecurity',
    5, ARRAY['English', 'Hindi'], 4.40, 70, 800,
    'Certified professional with 5 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000300000000', '00000000-0000-0000-0000-000000000000', 'amitabh_bhattacharya_4_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000300000000', 'Amitabh Bhattacharya', 'expert', 'amitabh_bhattacharya_4_3', 'amitabh_bhattacharya_4_3@demo.askexpert.com', '+91 98000 00066',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (6+ Yrs Exp)', 'Cybersecurity Specialist Level 1', 'Cybersecurity',
    6, ARRAY['English', 'Hindi'], 4.50, 77, 950,
    'Certified professional with 6 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000400000000', '00000000-0000-0000-0000-000000000000', 'sunita_saxena_4_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000400000000', 'Sunita Saxena', 'expert', 'sunita_saxena_4_4', 'sunita_saxena_4_4@demo.askexpert.com', '+91 98000 00067',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (7+ Yrs Exp)', 'Cybersecurity Specialist Level 2', 'Cybersecurity',
    7, ARRAY['English', 'Hindi'], 4.60, 84, 1100,
    'Certified professional with 7 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000500000000', '00000000-0000-0000-0000-000000000000', 'rohan_gupta_4_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000500000000', 'Rohan Gupta', 'expert', 'rohan_gupta_4_5', 'rohan_gupta_4_5@demo.askexpert.com', '+91 98000 00068',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (8+ Yrs Exp)', 'Cybersecurity Specialist Level 3', 'Cybersecurity',
    8, ARRAY['English', 'Hindi'], 4.70, 91, 1250,
    'Certified professional with 8 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000600000000', '00000000-0000-0000-0000-000000000000', 'shalini_chopra_4_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000600000000', 'Shalini Chopra', 'expert', 'shalini_chopra_4_6', 'shalini_chopra_4_6@demo.askexpert.com', '+91 98000 00069',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (9+ Yrs Exp)', 'Cybersecurity Specialist Level 1', 'Cybersecurity',
    9, ARRAY['English', 'Hindi'], 4.80, 98, 1400,
    'Certified professional with 9 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000700000000', '00000000-0000-0000-0000-000000000000', 'suresh_jain_4_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000700000000', 'Suresh Jain', 'expert', 'suresh_jain_4_7', 'suresh_jain_4_7@demo.askexpert.com', '+91 98000 00070',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (10+ Yrs Exp)', 'Cybersecurity Specialist Level 2', 'Cybersecurity',
    10, ARRAY['English', 'Hindi'], 4.90, 105, 1550,
    'Certified professional with 10 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000800000000', '00000000-0000-0000-0000-000000000000', 'ritu_nair_4_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000800000000', 'Ritu Nair', 'expert', 'ritu_nair_4_8', 'ritu_nair_4_8@demo.askexpert.com', '+91 98000 00071',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (11+ Yrs Exp)', 'Cybersecurity Specialist Level 3', 'Cybersecurity',
    11, ARRAY['English', 'Hindi'], 4.20, 112, 1700,
    'Certified professional with 11 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000900000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_sharma_4_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000900000000', 'Vikramaditya Sharma', 'expert', 'vikramaditya_sharma_4_9', 'vikramaditya_sharma_4_9@demo.askexpert.com', '+91 98000 00072',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (12+ Yrs Exp)', 'Cybersecurity Specialist Level 1', 'Cybersecurity',
    12, ARRAY['English', 'Hindi'], 4.30, 119, 1850,
    'Certified professional with 12 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000a00000000', '00000000-0000-0000-0000-000000000000', 'deepa_reddy_4_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000a00000000', 'Deepa Reddy', 'expert', 'deepa_reddy_4_10', 'deepa_reddy_4_10@demo.askexpert.com', '+91 98000 00073',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (13+ Yrs Exp)', 'Cybersecurity Specialist Level 2', 'Cybersecurity',
    13, ARRAY['English', 'Hindi'], 4.40, 126, 2000,
    'Certified professional with 13 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000b00000000', '00000000-0000-0000-0000-000000000000', 'arvind_kulkarni_4_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000b00000000', 'Arvind Kulkarni', 'expert', 'arvind_kulkarni_4_11', 'arvind_kulkarni_4_11@demo.askexpert.com', '+91 98000 00074',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (14+ Yrs Exp)', 'Cybersecurity Specialist Level 3', 'Cybersecurity',
    14, ARRAY['English', 'Hindi'], 4.50, 133, 2150,
    'Certified professional with 14 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000c00000000', '00000000-0000-0000-0000-000000000000', 'sneha_malhotra_4_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000c00000000', 'Sneha Malhotra', 'expert', 'sneha_malhotra_4_12', 'sneha_malhotra_4_12@demo.askexpert.com', '+91 98000 00075',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (15+ Yrs Exp)', 'Cybersecurity Specialist Level 1', 'Cybersecurity',
    15, ARRAY['English', 'Hindi'], 4.60, 140, 2300,
    'Certified professional with 15 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000d00000000', '00000000-0000-0000-0000-000000000000', 'karthik_bhattacharya_4_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000d00000000', 'Karthik Bhattacharya', 'expert', 'karthik_bhattacharya_4_13', 'karthik_bhattacharya_4_13@demo.askexpert.com', '+91 98000 00076',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (16+ Yrs Exp)', 'Cybersecurity Specialist Level 2', 'Cybersecurity',
    16, ARRAY['English', 'Hindi'], 4.70, 147, 2450,
    'Certified professional with 16 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000e00000000', '00000000-0000-0000-0000-000000000000', 'neha_saxena_4_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000e00000000', 'Neha Saxena', 'expert', 'neha_saxena_4_14', 'neha_saxena_4_14@demo.askexpert.com', '+91 98000 00077',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (17+ Yrs Exp)', 'Cybersecurity Specialist Level 3', 'Cybersecurity',
    17, ARRAY['English', 'Hindi'], 4.80, 154, 2600,
    'Certified professional with 17 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-000f00000000', '00000000-0000-0000-0000-000000000000', 'devendra_gupta_4_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-000f00000000', 'Devendra Gupta', 'expert', 'devendra_gupta_4_15', 'devendra_gupta_4_15@demo.askexpert.com', '+91 98000 00078',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (18+ Yrs Exp)', 'Cybersecurity Specialist Level 1', 'Cybersecurity',
    18, ARRAY['English', 'Hindi'], 4.90, 161, 500,
    'Certified professional with 18 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-001000000000', '00000000-0000-0000-0000-000000000000', 'preeti_chopra_4_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-001000000000', 'Preeti Chopra', 'expert', 'preeti_chopra_4_16', 'preeti_chopra_4_16@demo.askexpert.com', '+91 98000 00079',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (19+ Yrs Exp)', 'Cybersecurity Specialist Level 2', 'Cybersecurity',
    19, ARRAY['English', 'Hindi'], 4.20, 168, 650,
    'Certified professional with 19 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-001100000000', '00000000-0000-0000-0000-000000000000', 'alok_jain_4_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-001100000000', 'Alok Jain', 'expert', 'alok_jain_4_17', 'alok_jain_4_17@demo.askexpert.com', '+91 98000 00080',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (20+ Yrs Exp)', 'Cybersecurity Specialist Level 3', 'Cybersecurity',
    20, ARRAY['English', 'Hindi'], 4.30, 175, 800,
    'Certified professional with 20 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-001200000000', '00000000-0000-0000-0000-000000000000', 'kavita_nair_4_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-001200000000', 'Kavita Nair', 'expert', 'kavita_nair_4_18', 'kavita_nair_4_18@demo.askexpert.com', '+91 98000 00081',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (3+ Yrs Exp)', 'Cybersecurity Specialist Level 1', 'Cybersecurity',
    3, ARRAY['English', 'Hindi'], 4.40, 182, 950,
    'Certified professional with 3 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-001300000000', '00000000-0000-0000-0000-000000000000', 'manish_sharma_4_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-001300000000', 'Manish Sharma', 'expert', 'manish_sharma_4_19', 'manish_sharma_4_19@demo.askexpert.com', '+91 98000 00082',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (4+ Yrs Exp)', 'Cybersecurity Specialist Level 2', 'Cybersecurity',
    4, ARRAY['English', 'Hindi'], 4.50, 189, 1100,
    'Certified professional with 4 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-001400000000', '00000000-0000-0000-0000-000000000000', 'pooja_reddy_4_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-001400000000', 'Pooja Reddy', 'expert', 'pooja_reddy_4_20', 'pooja_reddy_4_20@demo.askexpert.com', '+91 98000 00083',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (5+ Yrs Exp)', 'Cybersecurity Specialist Level 3', 'Cybersecurity',
    5, ARRAY['English', 'Hindi'], 4.60, 196, 1250,
    'Certified professional with 5 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0400-001500000000', '00000000-0000-0000-0000-000000000000', 'sanjay_kulkarni_4_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0400-001500000000', 'Sanjay Kulkarni', 'expert', 'sanjay_kulkarni_4_21', 'sanjay_kulkarni_4_21@demo.askexpert.com', '+91 98000 00084',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cybersecurity (6+ Yrs Exp)', 'Cybersecurity Specialist Level 1', 'Cybersecurity',
    6, ARRAY['English', 'Hindi'], 4.70, 203, 1400,
    'Certified professional with 6 years of expertise in Cybersecurity. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cybersecurity Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000100000000', '00000000-0000-0000-0000-000000000000', 'tanvi_nair_5_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000100000000', 'Tanvi Nair', 'expert', 'tanvi_nair_5_1', 'tanvi_nair_5_1@demo.askexpert.com', '+91 98000 00085',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (4+ Yrs Exp)', 'Education & Teachers Specialist Level 2', 'Education & Teachers',
    4, ARRAY['English', 'Hindi'], 4.30, 75, 650,
    'Certified professional with 4 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000200000000', '00000000-0000-0000-0000-000000000000', 'varun_sharma_5_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000200000000', 'Varun Sharma', 'expert', 'varun_sharma_5_2', 'varun_sharma_5_2@demo.askexpert.com', '+91 98000 00086',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (5+ Yrs Exp)', 'Education & Teachers Specialist Level 3', 'Education & Teachers',
    5, ARRAY['English', 'Hindi'], 4.40, 82, 800,
    'Certified professional with 5 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000300000000', '00000000-0000-0000-0000-000000000000', 'divya_reddy_5_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000300000000', 'Divya Reddy', 'expert', 'divya_reddy_5_3', 'divya_reddy_5_3@demo.askexpert.com', '+91 98000 00087',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (6+ Yrs Exp)', 'Education & Teachers Specialist Level 1', 'Education & Teachers',
    6, ARRAY['English', 'Hindi'], 4.50, 89, 950,
    'Certified professional with 6 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000400000000', '00000000-0000-0000-0000-000000000000', 'gautam_kulkarni_5_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000400000000', 'Gautam Kulkarni', 'expert', 'gautam_kulkarni_5_4', 'gautam_kulkarni_5_4@demo.askexpert.com', '+91 98000 00088',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (7+ Yrs Exp)', 'Education & Teachers Specialist Level 2', 'Education & Teachers',
    7, ARRAY['English', 'Hindi'], 4.60, 96, 1100,
    'Certified professional with 7 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000500000000', '00000000-0000-0000-0000-000000000000', 'swati_malhotra_5_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000500000000', 'Swati Malhotra', 'expert', 'swati_malhotra_5_5', 'swati_malhotra_5_5@demo.askexpert.com', '+91 98000 00089',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (8+ Yrs Exp)', 'Education & Teachers Specialist Level 3', 'Education & Teachers',
    8, ARRAY['English', 'Hindi'], 4.70, 103, 1250,
    'Certified professional with 8 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000600000000', '00000000-0000-0000-0000-000000000000', 'rajesh_bhattacharya_5_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000600000000', 'Rajesh Bhattacharya', 'expert', 'rajesh_bhattacharya_5_6', 'rajesh_bhattacharya_5_6@demo.askexpert.com', '+91 98000 00090',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (9+ Yrs Exp)', 'Education & Teachers Specialist Level 1', 'Education & Teachers',
    9, ARRAY['English', 'Hindi'], 4.80, 110, 1400,
    'Certified professional with 9 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000700000000', '00000000-0000-0000-0000-000000000000', 'priya_saxena_5_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000700000000', 'Priya Saxena', 'expert', 'priya_saxena_5_7', 'priya_saxena_5_7@demo.askexpert.com', '+91 98000 00091',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (10+ Yrs Exp)', 'Education & Teachers Specialist Level 2', 'Education & Teachers',
    10, ARRAY['English', 'Hindi'], 4.90, 117, 1550,
    'Certified professional with 10 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000800000000', '00000000-0000-0000-0000-000000000000', 'vikram_gupta_5_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000800000000', 'Vikram Gupta', 'expert', 'vikram_gupta_5_8', 'vikram_gupta_5_8@demo.askexpert.com', '+91 98000 00092',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (11+ Yrs Exp)', 'Education & Teachers Specialist Level 3', 'Education & Teachers',
    11, ARRAY['English', 'Hindi'], 4.20, 124, 1700,
    'Certified professional with 11 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000900000000', '00000000-0000-0000-0000-000000000000', 'ananya_chopra_5_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000900000000', 'Ananya Chopra', 'expert', 'ananya_chopra_5_9', 'ananya_chopra_5_9@demo.askexpert.com', '+91 98000 00093',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (12+ Yrs Exp)', 'Education & Teachers Specialist Level 1', 'Education & Teachers',
    12, ARRAY['English', 'Hindi'], 4.30, 131, 1850,
    'Certified professional with 12 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000a00000000', '00000000-0000-0000-0000-000000000000', 'siddharth_jain_5_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000a00000000', 'Siddharth Jain', 'expert', 'siddharth_jain_5_10', 'siddharth_jain_5_10@demo.askexpert.com', '+91 98000 00094',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (13+ Yrs Exp)', 'Education & Teachers Specialist Level 2', 'Education & Teachers',
    13, ARRAY['English', 'Hindi'], 4.40, 138, 2000,
    'Certified professional with 13 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000b00000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_nair_5_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000b00000000', 'Meenakshi Nair', 'expert', 'meenakshi_nair_5_11', 'meenakshi_nair_5_11@demo.askexpert.com', '+91 98000 00095',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (14+ Yrs Exp)', 'Education & Teachers Specialist Level 3', 'Education & Teachers',
    14, ARRAY['English', 'Hindi'], 4.50, 145, 2150,
    'Certified professional with 14 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000c00000000', '00000000-0000-0000-0000-000000000000', 'amitabh_sharma_5_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000c00000000', 'Amitabh Sharma', 'expert', 'amitabh_sharma_5_12', 'amitabh_sharma_5_12@demo.askexpert.com', '+91 98000 00096',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (15+ Yrs Exp)', 'Education & Teachers Specialist Level 1', 'Education & Teachers',
    15, ARRAY['English', 'Hindi'], 4.60, 152, 2300,
    'Certified professional with 15 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000d00000000', '00000000-0000-0000-0000-000000000000', 'sunita_reddy_5_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000d00000000', 'Sunita Reddy', 'expert', 'sunita_reddy_5_13', 'sunita_reddy_5_13@demo.askexpert.com', '+91 98000 00097',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (16+ Yrs Exp)', 'Education & Teachers Specialist Level 2', 'Education & Teachers',
    16, ARRAY['English', 'Hindi'], 4.70, 159, 2450,
    'Certified professional with 16 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000e00000000', '00000000-0000-0000-0000-000000000000', 'rohan_kulkarni_5_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000e00000000', 'Rohan Kulkarni', 'expert', 'rohan_kulkarni_5_14', 'rohan_kulkarni_5_14@demo.askexpert.com', '+91 98000 00098',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (17+ Yrs Exp)', 'Education & Teachers Specialist Level 3', 'Education & Teachers',
    17, ARRAY['English', 'Hindi'], 4.80, 166, 2600,
    'Certified professional with 17 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-000f00000000', '00000000-0000-0000-0000-000000000000', 'shalini_malhotra_5_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-000f00000000', 'Shalini Malhotra', 'expert', 'shalini_malhotra_5_15', 'shalini_malhotra_5_15@demo.askexpert.com', '+91 98000 00099',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (18+ Yrs Exp)', 'Education & Teachers Specialist Level 1', 'Education & Teachers',
    18, ARRAY['English', 'Hindi'], 4.90, 173, 500,
    'Certified professional with 18 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-001000000000', '00000000-0000-0000-0000-000000000000', 'suresh_bhattacharya_5_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-001000000000', 'Suresh Bhattacharya', 'expert', 'suresh_bhattacharya_5_16', 'suresh_bhattacharya_5_16@demo.askexpert.com', '+91 98000 00100',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (19+ Yrs Exp)', 'Education & Teachers Specialist Level 2', 'Education & Teachers',
    19, ARRAY['English', 'Hindi'], 4.20, 180, 650,
    'Certified professional with 19 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-001100000000', '00000000-0000-0000-0000-000000000000', 'ritu_saxena_5_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-001100000000', 'Ritu Saxena', 'expert', 'ritu_saxena_5_17', 'ritu_saxena_5_17@demo.askexpert.com', '+91 98000 00101',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (20+ Yrs Exp)', 'Education & Teachers Specialist Level 3', 'Education & Teachers',
    20, ARRAY['English', 'Hindi'], 4.30, 187, 800,
    'Certified professional with 20 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-001200000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_gupta_5_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-001200000000', 'Vikramaditya Gupta', 'expert', 'vikramaditya_gupta_5_18', 'vikramaditya_gupta_5_18@demo.askexpert.com', '+91 98000 00102',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (3+ Yrs Exp)', 'Education & Teachers Specialist Level 1', 'Education & Teachers',
    3, ARRAY['English', 'Hindi'], 4.40, 194, 950,
    'Certified professional with 3 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-001300000000', '00000000-0000-0000-0000-000000000000', 'deepa_chopra_5_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-001300000000', 'Deepa Chopra', 'expert', 'deepa_chopra_5_19', 'deepa_chopra_5_19@demo.askexpert.com', '+91 98000 00103',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (4+ Yrs Exp)', 'Education & Teachers Specialist Level 2', 'Education & Teachers',
    4, ARRAY['English', 'Hindi'], 4.50, 201, 1100,
    'Certified professional with 4 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-001400000000', '00000000-0000-0000-0000-000000000000', 'arvind_jain_5_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-001400000000', 'Arvind Jain', 'expert', 'arvind_jain_5_20', 'arvind_jain_5_20@demo.askexpert.com', '+91 98000 00104',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (5+ Yrs Exp)', 'Education & Teachers Specialist Level 3', 'Education & Teachers',
    5, ARRAY['English', 'Hindi'], 4.60, 208, 1250,
    'Certified professional with 5 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0500-001500000000', '00000000-0000-0000-0000-000000000000', 'sneha_nair_5_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0500-001500000000', 'Sneha Nair', 'expert', 'sneha_nair_5_21', 'sneha_nair_5_21@demo.askexpert.com', '+91 98000 00105',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Teachers (6+ Yrs Exp)', 'Education & Teachers Specialist Level 1', 'Education & Teachers',
    6, ARRAY['English', 'Hindi'], 4.70, 215, 1400,
    'Certified professional with 6 years of expertise in Education & Teachers. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Teachers Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000100000000', '00000000-0000-0000-0000-000000000000', 'karthik_gupta_6_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000100000000', 'Karthik Gupta', 'expert', 'karthik_gupta_6_1', 'karthik_gupta_6_1@demo.askexpert.com', '+91 98000 00106',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (4+ Yrs Exp)', 'Law & Legal Specialist Level 2', 'Law & Legal',
    4, ARRAY['English', 'Hindi'], 4.30, 27, 650,
    'Certified professional with 4 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000200000000', '00000000-0000-0000-0000-000000000000', 'neha_chopra_6_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000200000000', 'Neha Chopra', 'expert', 'neha_chopra_6_2', 'neha_chopra_6_2@demo.askexpert.com', '+91 98000 00107',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (5+ Yrs Exp)', 'Law & Legal Specialist Level 3', 'Law & Legal',
    5, ARRAY['English', 'Hindi'], 4.40, 34, 800,
    'Certified professional with 5 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000300000000', '00000000-0000-0000-0000-000000000000', 'devendra_jain_6_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000300000000', 'Devendra Jain', 'expert', 'devendra_jain_6_3', 'devendra_jain_6_3@demo.askexpert.com', '+91 98000 00108',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (6+ Yrs Exp)', 'Law & Legal Specialist Level 1', 'Law & Legal',
    6, ARRAY['English', 'Hindi'], 4.50, 41, 950,
    'Certified professional with 6 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000400000000', '00000000-0000-0000-0000-000000000000', 'preeti_nair_6_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000400000000', 'Preeti Nair', 'expert', 'preeti_nair_6_4', 'preeti_nair_6_4@demo.askexpert.com', '+91 98000 00109',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (7+ Yrs Exp)', 'Law & Legal Specialist Level 2', 'Law & Legal',
    7, ARRAY['English', 'Hindi'], 4.60, 48, 1100,
    'Certified professional with 7 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000500000000', '00000000-0000-0000-0000-000000000000', 'alok_sharma_6_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000500000000', 'Alok Sharma', 'expert', 'alok_sharma_6_5', 'alok_sharma_6_5@demo.askexpert.com', '+91 98000 00110',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (8+ Yrs Exp)', 'Law & Legal Specialist Level 3', 'Law & Legal',
    8, ARRAY['English', 'Hindi'], 4.70, 55, 1250,
    'Certified professional with 8 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000600000000', '00000000-0000-0000-0000-000000000000', 'kavita_reddy_6_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000600000000', 'Kavita Reddy', 'expert', 'kavita_reddy_6_6', 'kavita_reddy_6_6@demo.askexpert.com', '+91 98000 00111',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (9+ Yrs Exp)', 'Law & Legal Specialist Level 1', 'Law & Legal',
    9, ARRAY['English', 'Hindi'], 4.80, 62, 1400,
    'Certified professional with 9 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000700000000', '00000000-0000-0000-0000-000000000000', 'manish_kulkarni_6_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000700000000', 'Manish Kulkarni', 'expert', 'manish_kulkarni_6_7', 'manish_kulkarni_6_7@demo.askexpert.com', '+91 98000 00112',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (10+ Yrs Exp)', 'Law & Legal Specialist Level 2', 'Law & Legal',
    10, ARRAY['English', 'Hindi'], 4.90, 69, 1550,
    'Certified professional with 10 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000800000000', '00000000-0000-0000-0000-000000000000', 'pooja_malhotra_6_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000800000000', 'Pooja Malhotra', 'expert', 'pooja_malhotra_6_8', 'pooja_malhotra_6_8@demo.askexpert.com', '+91 98000 00113',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (11+ Yrs Exp)', 'Law & Legal Specialist Level 3', 'Law & Legal',
    11, ARRAY['English', 'Hindi'], 4.20, 76, 1700,
    'Certified professional with 11 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000900000000', '00000000-0000-0000-0000-000000000000', 'sanjay_bhattacharya_6_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000900000000', 'Sanjay Bhattacharya', 'expert', 'sanjay_bhattacharya_6_9', 'sanjay_bhattacharya_6_9@demo.askexpert.com', '+91 98000 00114',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (12+ Yrs Exp)', 'Law & Legal Specialist Level 1', 'Law & Legal',
    12, ARRAY['English', 'Hindi'], 4.30, 83, 1850,
    'Certified professional with 12 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000a00000000', '00000000-0000-0000-0000-000000000000', 'tanvi_saxena_6_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000a00000000', 'Tanvi Saxena', 'expert', 'tanvi_saxena_6_10', 'tanvi_saxena_6_10@demo.askexpert.com', '+91 98000 00115',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (13+ Yrs Exp)', 'Law & Legal Specialist Level 2', 'Law & Legal',
    13, ARRAY['English', 'Hindi'], 4.40, 90, 2000,
    'Certified professional with 13 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000b00000000', '00000000-0000-0000-0000-000000000000', 'varun_gupta_6_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000b00000000', 'Varun Gupta', 'expert', 'varun_gupta_6_11', 'varun_gupta_6_11@demo.askexpert.com', '+91 98000 00116',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (14+ Yrs Exp)', 'Law & Legal Specialist Level 3', 'Law & Legal',
    14, ARRAY['English', 'Hindi'], 4.50, 97, 2150,
    'Certified professional with 14 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000c00000000', '00000000-0000-0000-0000-000000000000', 'divya_chopra_6_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000c00000000', 'Divya Chopra', 'expert', 'divya_chopra_6_12', 'divya_chopra_6_12@demo.askexpert.com', '+91 98000 00117',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (15+ Yrs Exp)', 'Law & Legal Specialist Level 1', 'Law & Legal',
    15, ARRAY['English', 'Hindi'], 4.60, 104, 2300,
    'Certified professional with 15 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000d00000000', '00000000-0000-0000-0000-000000000000', 'gautam_jain_6_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000d00000000', 'Gautam Jain', 'expert', 'gautam_jain_6_13', 'gautam_jain_6_13@demo.askexpert.com', '+91 98000 00118',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (16+ Yrs Exp)', 'Law & Legal Specialist Level 2', 'Law & Legal',
    16, ARRAY['English', 'Hindi'], 4.70, 111, 2450,
    'Certified professional with 16 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000e00000000', '00000000-0000-0000-0000-000000000000', 'swati_nair_6_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000e00000000', 'Swati Nair', 'expert', 'swati_nair_6_14', 'swati_nair_6_14@demo.askexpert.com', '+91 98000 00119',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (17+ Yrs Exp)', 'Law & Legal Specialist Level 3', 'Law & Legal',
    17, ARRAY['English', 'Hindi'], 4.80, 118, 2600,
    'Certified professional with 17 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-000f00000000', '00000000-0000-0000-0000-000000000000', 'rajesh_sharma_6_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-000f00000000', 'Rajesh Sharma', 'expert', 'rajesh_sharma_6_15', 'rajesh_sharma_6_15@demo.askexpert.com', '+91 98000 00120',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (18+ Yrs Exp)', 'Law & Legal Specialist Level 1', 'Law & Legal',
    18, ARRAY['English', 'Hindi'], 4.90, 125, 500,
    'Certified professional with 18 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-001000000000', '00000000-0000-0000-0000-000000000000', 'priya_reddy_6_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-001000000000', 'Priya Reddy', 'expert', 'priya_reddy_6_16', 'priya_reddy_6_16@demo.askexpert.com', '+91 98000 00121',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (19+ Yrs Exp)', 'Law & Legal Specialist Level 2', 'Law & Legal',
    19, ARRAY['English', 'Hindi'], 4.20, 132, 650,
    'Certified professional with 19 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-001100000000', '00000000-0000-0000-0000-000000000000', 'vikram_kulkarni_6_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-001100000000', 'Vikram Kulkarni', 'expert', 'vikram_kulkarni_6_17', 'vikram_kulkarni_6_17@demo.askexpert.com', '+91 98000 00122',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (20+ Yrs Exp)', 'Law & Legal Specialist Level 3', 'Law & Legal',
    20, ARRAY['English', 'Hindi'], 4.30, 139, 800,
    'Certified professional with 20 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-001200000000', '00000000-0000-0000-0000-000000000000', 'ananya_malhotra_6_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-001200000000', 'Ananya Malhotra', 'expert', 'ananya_malhotra_6_18', 'ananya_malhotra_6_18@demo.askexpert.com', '+91 98000 00123',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (3+ Yrs Exp)', 'Law & Legal Specialist Level 1', 'Law & Legal',
    3, ARRAY['English', 'Hindi'], 4.40, 146, 950,
    'Certified professional with 3 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-001300000000', '00000000-0000-0000-0000-000000000000', 'siddharth_bhattacharya_6_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-001300000000', 'Siddharth Bhattacharya', 'expert', 'siddharth_bhattacharya_6_19', 'siddharth_bhattacharya_6_19@demo.askexpert.com', '+91 98000 00124',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (4+ Yrs Exp)', 'Law & Legal Specialist Level 2', 'Law & Legal',
    4, ARRAY['English', 'Hindi'], 4.50, 153, 1100,
    'Certified professional with 4 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-001400000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_saxena_6_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-001400000000', 'Meenakshi Saxena', 'expert', 'meenakshi_saxena_6_20', 'meenakshi_saxena_6_20@demo.askexpert.com', '+91 98000 00125',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (5+ Yrs Exp)', 'Law & Legal Specialist Level 3', 'Law & Legal',
    5, ARRAY['English', 'Hindi'], 4.60, 160, 1250,
    'Certified professional with 5 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0600-001500000000', '00000000-0000-0000-0000-000000000000', 'amitabh_gupta_6_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0600-001500000000', 'Amitabh Gupta', 'expert', 'amitabh_gupta_6_21', 'amitabh_gupta_6_21@demo.askexpert.com', '+91 98000 00126',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Law & Legal (6+ Yrs Exp)', 'Law & Legal Specialist Level 1', 'Law & Legal',
    6, ARRAY['English', 'Hindi'], 4.70, 167, 1400,
    'Certified professional with 6 years of expertise in Law & Legal. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Law & Legal Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000100000000', '00000000-0000-0000-0000-000000000000', 'sunita_malhotra_7_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000100000000', 'Sunita Malhotra', 'expert', 'sunita_malhotra_7_1', 'sunita_malhotra_7_1@demo.askexpert.com', '+91 98000 00127',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (4+ Yrs Exp)', 'Finance & Accounting Specialist Level 2', 'Finance & Accounting',
    4, ARRAY['English', 'Hindi'], 4.30, 39, 650,
    'Certified professional with 4 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000200000000', '00000000-0000-0000-0000-000000000000', 'rohan_bhattacharya_7_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000200000000', 'Rohan Bhattacharya', 'expert', 'rohan_bhattacharya_7_2', 'rohan_bhattacharya_7_2@demo.askexpert.com', '+91 98000 00128',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (5+ Yrs Exp)', 'Finance & Accounting Specialist Level 3', 'Finance & Accounting',
    5, ARRAY['English', 'Hindi'], 4.40, 46, 800,
    'Certified professional with 5 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000300000000', '00000000-0000-0000-0000-000000000000', 'shalini_saxena_7_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000300000000', 'Shalini Saxena', 'expert', 'shalini_saxena_7_3', 'shalini_saxena_7_3@demo.askexpert.com', '+91 98000 00129',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (6+ Yrs Exp)', 'Finance & Accounting Specialist Level 1', 'Finance & Accounting',
    6, ARRAY['English', 'Hindi'], 4.50, 53, 950,
    'Certified professional with 6 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000400000000', '00000000-0000-0000-0000-000000000000', 'suresh_gupta_7_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000400000000', 'Suresh Gupta', 'expert', 'suresh_gupta_7_4', 'suresh_gupta_7_4@demo.askexpert.com', '+91 98000 00130',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (7+ Yrs Exp)', 'Finance & Accounting Specialist Level 2', 'Finance & Accounting',
    7, ARRAY['English', 'Hindi'], 4.60, 60, 1100,
    'Certified professional with 7 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000500000000', '00000000-0000-0000-0000-000000000000', 'ritu_chopra_7_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000500000000', 'Ritu Chopra', 'expert', 'ritu_chopra_7_5', 'ritu_chopra_7_5@demo.askexpert.com', '+91 98000 00131',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (8+ Yrs Exp)', 'Finance & Accounting Specialist Level 3', 'Finance & Accounting',
    8, ARRAY['English', 'Hindi'], 4.70, 67, 1250,
    'Certified professional with 8 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000600000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_jain_7_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000600000000', 'Vikramaditya Jain', 'expert', 'vikramaditya_jain_7_6', 'vikramaditya_jain_7_6@demo.askexpert.com', '+91 98000 00132',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (9+ Yrs Exp)', 'Finance & Accounting Specialist Level 1', 'Finance & Accounting',
    9, ARRAY['English', 'Hindi'], 4.80, 74, 1400,
    'Certified professional with 9 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000700000000', '00000000-0000-0000-0000-000000000000', 'deepa_nair_7_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000700000000', 'Deepa Nair', 'expert', 'deepa_nair_7_7', 'deepa_nair_7_7@demo.askexpert.com', '+91 98000 00133',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (10+ Yrs Exp)', 'Finance & Accounting Specialist Level 2', 'Finance & Accounting',
    10, ARRAY['English', 'Hindi'], 4.90, 81, 1550,
    'Certified professional with 10 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000800000000', '00000000-0000-0000-0000-000000000000', 'arvind_sharma_7_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000800000000', 'Arvind Sharma', 'expert', 'arvind_sharma_7_8', 'arvind_sharma_7_8@demo.askexpert.com', '+91 98000 00134',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (11+ Yrs Exp)', 'Finance & Accounting Specialist Level 3', 'Finance & Accounting',
    11, ARRAY['English', 'Hindi'], 4.20, 88, 1700,
    'Certified professional with 11 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000900000000', '00000000-0000-0000-0000-000000000000', 'sneha_reddy_7_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000900000000', 'Sneha Reddy', 'expert', 'sneha_reddy_7_9', 'sneha_reddy_7_9@demo.askexpert.com', '+91 98000 00135',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (12+ Yrs Exp)', 'Finance & Accounting Specialist Level 1', 'Finance & Accounting',
    12, ARRAY['English', 'Hindi'], 4.30, 95, 1850,
    'Certified professional with 12 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000a00000000', '00000000-0000-0000-0000-000000000000', 'karthik_kulkarni_7_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000a00000000', 'Karthik Kulkarni', 'expert', 'karthik_kulkarni_7_10', 'karthik_kulkarni_7_10@demo.askexpert.com', '+91 98000 00136',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (13+ Yrs Exp)', 'Finance & Accounting Specialist Level 2', 'Finance & Accounting',
    13, ARRAY['English', 'Hindi'], 4.40, 102, 2000,
    'Certified professional with 13 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000b00000000', '00000000-0000-0000-0000-000000000000', 'neha_malhotra_7_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000b00000000', 'Neha Malhotra', 'expert', 'neha_malhotra_7_11', 'neha_malhotra_7_11@demo.askexpert.com', '+91 98000 00137',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (14+ Yrs Exp)', 'Finance & Accounting Specialist Level 3', 'Finance & Accounting',
    14, ARRAY['English', 'Hindi'], 4.50, 109, 2150,
    'Certified professional with 14 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000c00000000', '00000000-0000-0000-0000-000000000000', 'devendra_bhattacharya_7_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000c00000000', 'Devendra Bhattacharya', 'expert', 'devendra_bhattacharya_7_12', 'devendra_bhattacharya_7_12@demo.askexpert.com', '+91 98000 00138',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (15+ Yrs Exp)', 'Finance & Accounting Specialist Level 1', 'Finance & Accounting',
    15, ARRAY['English', 'Hindi'], 4.60, 116, 2300,
    'Certified professional with 15 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000d00000000', '00000000-0000-0000-0000-000000000000', 'preeti_saxena_7_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000d00000000', 'Preeti Saxena', 'expert', 'preeti_saxena_7_13', 'preeti_saxena_7_13@demo.askexpert.com', '+91 98000 00139',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (16+ Yrs Exp)', 'Finance & Accounting Specialist Level 2', 'Finance & Accounting',
    16, ARRAY['English', 'Hindi'], 4.70, 123, 2450,
    'Certified professional with 16 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000e00000000', '00000000-0000-0000-0000-000000000000', 'alok_gupta_7_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000e00000000', 'Alok Gupta', 'expert', 'alok_gupta_7_14', 'alok_gupta_7_14@demo.askexpert.com', '+91 98000 00140',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (17+ Yrs Exp)', 'Finance & Accounting Specialist Level 3', 'Finance & Accounting',
    17, ARRAY['English', 'Hindi'], 4.80, 130, 2600,
    'Certified professional with 17 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-000f00000000', '00000000-0000-0000-0000-000000000000', 'kavita_chopra_7_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-000f00000000', 'Kavita Chopra', 'expert', 'kavita_chopra_7_15', 'kavita_chopra_7_15@demo.askexpert.com', '+91 98000 00141',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (18+ Yrs Exp)', 'Finance & Accounting Specialist Level 1', 'Finance & Accounting',
    18, ARRAY['English', 'Hindi'], 4.90, 137, 500,
    'Certified professional with 18 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-001000000000', '00000000-0000-0000-0000-000000000000', 'manish_jain_7_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-001000000000', 'Manish Jain', 'expert', 'manish_jain_7_16', 'manish_jain_7_16@demo.askexpert.com', '+91 98000 00142',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (19+ Yrs Exp)', 'Finance & Accounting Specialist Level 2', 'Finance & Accounting',
    19, ARRAY['English', 'Hindi'], 4.20, 144, 650,
    'Certified professional with 19 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-001100000000', '00000000-0000-0000-0000-000000000000', 'pooja_nair_7_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-001100000000', 'Pooja Nair', 'expert', 'pooja_nair_7_17', 'pooja_nair_7_17@demo.askexpert.com', '+91 98000 00143',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (20+ Yrs Exp)', 'Finance & Accounting Specialist Level 3', 'Finance & Accounting',
    20, ARRAY['English', 'Hindi'], 4.30, 151, 800,
    'Certified professional with 20 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-001200000000', '00000000-0000-0000-0000-000000000000', 'sanjay_sharma_7_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-001200000000', 'Sanjay Sharma', 'expert', 'sanjay_sharma_7_18', 'sanjay_sharma_7_18@demo.askexpert.com', '+91 98000 00144',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (3+ Yrs Exp)', 'Finance & Accounting Specialist Level 1', 'Finance & Accounting',
    3, ARRAY['English', 'Hindi'], 4.40, 158, 950,
    'Certified professional with 3 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-001300000000', '00000000-0000-0000-0000-000000000000', 'tanvi_reddy_7_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-001300000000', 'Tanvi Reddy', 'expert', 'tanvi_reddy_7_19', 'tanvi_reddy_7_19@demo.askexpert.com', '+91 98000 00145',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (4+ Yrs Exp)', 'Finance & Accounting Specialist Level 2', 'Finance & Accounting',
    4, ARRAY['English', 'Hindi'], 4.50, 165, 1100,
    'Certified professional with 4 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-001400000000', '00000000-0000-0000-0000-000000000000', 'varun_kulkarni_7_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-001400000000', 'Varun Kulkarni', 'expert', 'varun_kulkarni_7_20', 'varun_kulkarni_7_20@demo.askexpert.com', '+91 98000 00146',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (5+ Yrs Exp)', 'Finance & Accounting Specialist Level 3', 'Finance & Accounting',
    5, ARRAY['English', 'Hindi'], 4.60, 172, 1250,
    'Certified professional with 5 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0700-001500000000', '00000000-0000-0000-0000-000000000000', 'divya_malhotra_7_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0700-001500000000', 'Divya Malhotra', 'expert', 'divya_malhotra_7_21', 'divya_malhotra_7_21@demo.askexpert.com', '+91 98000 00147',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Finance & Accounting (6+ Yrs Exp)', 'Finance & Accounting Specialist Level 1', 'Finance & Accounting',
    6, ARRAY['English', 'Hindi'], 4.70, 179, 1400,
    'Certified professional with 6 years of expertise in Finance & Accounting. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Finance & Accounting Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000100000000', '00000000-0000-0000-0000-000000000000', 'gautam_sharma_8_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000100000000', 'Gautam Sharma', 'expert', 'gautam_sharma_8_1', 'gautam_sharma_8_1@demo.askexpert.com', '+91 98000 00148',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (4+ Yrs Exp)', 'Banking Specialist Level 2', 'Banking',
    4, ARRAY['English', 'Hindi'], 4.30, 51, 650,
    'Certified professional with 4 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000200000000', '00000000-0000-0000-0000-000000000000', 'swati_reddy_8_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000200000000', 'Swati Reddy', 'expert', 'swati_reddy_8_2', 'swati_reddy_8_2@demo.askexpert.com', '+91 98000 00149',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (5+ Yrs Exp)', 'Banking Specialist Level 3', 'Banking',
    5, ARRAY['English', 'Hindi'], 4.40, 58, 800,
    'Certified professional with 5 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000300000000', '00000000-0000-0000-0000-000000000000', 'rajesh_kulkarni_8_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000300000000', 'Rajesh Kulkarni', 'expert', 'rajesh_kulkarni_8_3', 'rajesh_kulkarni_8_3@demo.askexpert.com', '+91 98000 00150',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (6+ Yrs Exp)', 'Banking Specialist Level 1', 'Banking',
    6, ARRAY['English', 'Hindi'], 4.50, 65, 950,
    'Certified professional with 6 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000400000000', '00000000-0000-0000-0000-000000000000', 'priya_malhotra_8_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000400000000', 'Priya Malhotra', 'expert', 'priya_malhotra_8_4', 'priya_malhotra_8_4@demo.askexpert.com', '+91 98000 00151',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (7+ Yrs Exp)', 'Banking Specialist Level 2', 'Banking',
    7, ARRAY['English', 'Hindi'], 4.60, 72, 1100,
    'Certified professional with 7 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000500000000', '00000000-0000-0000-0000-000000000000', 'vikram_bhattacharya_8_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000500000000', 'Vikram Bhattacharya', 'expert', 'vikram_bhattacharya_8_5', 'vikram_bhattacharya_8_5@demo.askexpert.com', '+91 98000 00152',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (8+ Yrs Exp)', 'Banking Specialist Level 3', 'Banking',
    8, ARRAY['English', 'Hindi'], 4.70, 79, 1250,
    'Certified professional with 8 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000600000000', '00000000-0000-0000-0000-000000000000', 'ananya_saxena_8_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000600000000', 'Ananya Saxena', 'expert', 'ananya_saxena_8_6', 'ananya_saxena_8_6@demo.askexpert.com', '+91 98000 00153',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (9+ Yrs Exp)', 'Banking Specialist Level 1', 'Banking',
    9, ARRAY['English', 'Hindi'], 4.80, 86, 1400,
    'Certified professional with 9 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000700000000', '00000000-0000-0000-0000-000000000000', 'siddharth_gupta_8_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000700000000', 'Siddharth Gupta', 'expert', 'siddharth_gupta_8_7', 'siddharth_gupta_8_7@demo.askexpert.com', '+91 98000 00154',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (10+ Yrs Exp)', 'Banking Specialist Level 2', 'Banking',
    10, ARRAY['English', 'Hindi'], 4.90, 93, 1550,
    'Certified professional with 10 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000800000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_chopra_8_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000800000000', 'Meenakshi Chopra', 'expert', 'meenakshi_chopra_8_8', 'meenakshi_chopra_8_8@demo.askexpert.com', '+91 98000 00155',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (11+ Yrs Exp)', 'Banking Specialist Level 3', 'Banking',
    11, ARRAY['English', 'Hindi'], 4.20, 100, 1700,
    'Certified professional with 11 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000900000000', '00000000-0000-0000-0000-000000000000', 'amitabh_jain_8_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000900000000', 'Amitabh Jain', 'expert', 'amitabh_jain_8_9', 'amitabh_jain_8_9@demo.askexpert.com', '+91 98000 00156',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (12+ Yrs Exp)', 'Banking Specialist Level 1', 'Banking',
    12, ARRAY['English', 'Hindi'], 4.30, 107, 1850,
    'Certified professional with 12 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000a00000000', '00000000-0000-0000-0000-000000000000', 'sunita_nair_8_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000a00000000', 'Sunita Nair', 'expert', 'sunita_nair_8_10', 'sunita_nair_8_10@demo.askexpert.com', '+91 98000 00157',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (13+ Yrs Exp)', 'Banking Specialist Level 2', 'Banking',
    13, ARRAY['English', 'Hindi'], 4.40, 114, 2000,
    'Certified professional with 13 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000b00000000', '00000000-0000-0000-0000-000000000000', 'rohan_sharma_8_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000b00000000', 'Rohan Sharma', 'expert', 'rohan_sharma_8_11', 'rohan_sharma_8_11@demo.askexpert.com', '+91 98000 00158',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (14+ Yrs Exp)', 'Banking Specialist Level 3', 'Banking',
    14, ARRAY['English', 'Hindi'], 4.50, 121, 2150,
    'Certified professional with 14 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000c00000000', '00000000-0000-0000-0000-000000000000', 'shalini_reddy_8_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000c00000000', 'Shalini Reddy', 'expert', 'shalini_reddy_8_12', 'shalini_reddy_8_12@demo.askexpert.com', '+91 98000 00159',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (15+ Yrs Exp)', 'Banking Specialist Level 1', 'Banking',
    15, ARRAY['English', 'Hindi'], 4.60, 128, 2300,
    'Certified professional with 15 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000d00000000', '00000000-0000-0000-0000-000000000000', 'suresh_kulkarni_8_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000d00000000', 'Suresh Kulkarni', 'expert', 'suresh_kulkarni_8_13', 'suresh_kulkarni_8_13@demo.askexpert.com', '+91 98000 00160',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (16+ Yrs Exp)', 'Banking Specialist Level 2', 'Banking',
    16, ARRAY['English', 'Hindi'], 4.70, 135, 2450,
    'Certified professional with 16 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000e00000000', '00000000-0000-0000-0000-000000000000', 'ritu_malhotra_8_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000e00000000', 'Ritu Malhotra', 'expert', 'ritu_malhotra_8_14', 'ritu_malhotra_8_14@demo.askexpert.com', '+91 98000 00161',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (17+ Yrs Exp)', 'Banking Specialist Level 3', 'Banking',
    17, ARRAY['English', 'Hindi'], 4.80, 142, 2600,
    'Certified professional with 17 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-000f00000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_bhattacharya_8_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-000f00000000', 'Vikramaditya Bhattacharya', 'expert', 'vikramaditya_bhattacharya_8_15', 'vikramaditya_bhattacharya_8_15@demo.askexpert.com', '+91 98000 00162',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (18+ Yrs Exp)', 'Banking Specialist Level 1', 'Banking',
    18, ARRAY['English', 'Hindi'], 4.90, 149, 500,
    'Certified professional with 18 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-001000000000', '00000000-0000-0000-0000-000000000000', 'deepa_saxena_8_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-001000000000', 'Deepa Saxena', 'expert', 'deepa_saxena_8_16', 'deepa_saxena_8_16@demo.askexpert.com', '+91 98000 00163',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (19+ Yrs Exp)', 'Banking Specialist Level 2', 'Banking',
    19, ARRAY['English', 'Hindi'], 4.20, 156, 650,
    'Certified professional with 19 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-001100000000', '00000000-0000-0000-0000-000000000000', 'arvind_gupta_8_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-001100000000', 'Arvind Gupta', 'expert', 'arvind_gupta_8_17', 'arvind_gupta_8_17@demo.askexpert.com', '+91 98000 00164',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (20+ Yrs Exp)', 'Banking Specialist Level 3', 'Banking',
    20, ARRAY['English', 'Hindi'], 4.30, 163, 800,
    'Certified professional with 20 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-001200000000', '00000000-0000-0000-0000-000000000000', 'sneha_chopra_8_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-001200000000', 'Sneha Chopra', 'expert', 'sneha_chopra_8_18', 'sneha_chopra_8_18@demo.askexpert.com', '+91 98000 00165',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (3+ Yrs Exp)', 'Banking Specialist Level 1', 'Banking',
    3, ARRAY['English', 'Hindi'], 4.40, 170, 950,
    'Certified professional with 3 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-001300000000', '00000000-0000-0000-0000-000000000000', 'karthik_jain_8_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-001300000000', 'Karthik Jain', 'expert', 'karthik_jain_8_19', 'karthik_jain_8_19@demo.askexpert.com', '+91 98000 00166',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (4+ Yrs Exp)', 'Banking Specialist Level 2', 'Banking',
    4, ARRAY['English', 'Hindi'], 4.50, 177, 1100,
    'Certified professional with 4 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-001400000000', '00000000-0000-0000-0000-000000000000', 'neha_nair_8_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-001400000000', 'Neha Nair', 'expert', 'neha_nair_8_20', 'neha_nair_8_20@demo.askexpert.com', '+91 98000 00167',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (5+ Yrs Exp)', 'Banking Specialist Level 3', 'Banking',
    5, ARRAY['English', 'Hindi'], 4.60, 184, 1250,
    'Certified professional with 5 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-0800-001500000000', '00000000-0000-0000-0000-000000000000', 'devendra_sharma_8_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-0800-001500000000', 'Devendra Sharma', 'expert', 'devendra_sharma_8_21', 'devendra_sharma_8_21@demo.askexpert.com', '+91 98000 00168',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Banking (6+ Yrs Exp)', 'Banking Specialist Level 1', 'Banking',
    6, ARRAY['English', 'Hindi'], 4.70, 191, 1400,
    'Certified professional with 6 years of expertise in Banking. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Banking Advisory', 'Consultation', 'Strategy'],
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

END $;

-- ENSURE ALL EXPERTS HAVE IS_VERIFIED = TRUE
UPDATE public.profiles SET is_verified = true WHERE role = 'expert';

SELECT count(*) AS chunk_1_demo_experts FROM public.profiles WHERE is_demo = true;
