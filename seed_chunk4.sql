-- ==============================================================================
-- ASKEXPERT - SEED CHUNK 4 OF 5 (CATEGORIES 25 TO 32)
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
    'a0000000-0000-0000-1900-000100000000', '00000000-0000-0000-0000-000000000000', 'tanvi_nair_25_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000100000000', 'Tanvi Nair', 'expert', 'tanvi_nair_25_1', 'tanvi_nair_25_1@demo.askexpert.com', '+91 98000 00505',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (4+ Yrs Exp)', 'Science & Research Specialist Level 2', 'Science & Research',
    4, ARRAY['English', 'Hindi'], 4.30, 75, 650,
    'Certified professional with 4 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000200000000', '00000000-0000-0000-0000-000000000000', 'varun_sharma_25_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000200000000', 'Varun Sharma', 'expert', 'varun_sharma_25_2', 'varun_sharma_25_2@demo.askexpert.com', '+91 98000 00506',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (5+ Yrs Exp)', 'Science & Research Specialist Level 3', 'Science & Research',
    5, ARRAY['English', 'Hindi'], 4.40, 82, 800,
    'Certified professional with 5 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000300000000', '00000000-0000-0000-0000-000000000000', 'divya_reddy_25_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000300000000', 'Divya Reddy', 'expert', 'divya_reddy_25_3', 'divya_reddy_25_3@demo.askexpert.com', '+91 98000 00507',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (6+ Yrs Exp)', 'Science & Research Specialist Level 1', 'Science & Research',
    6, ARRAY['English', 'Hindi'], 4.50, 89, 950,
    'Certified professional with 6 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000400000000', '00000000-0000-0000-0000-000000000000', 'gautam_kulkarni_25_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000400000000', 'Gautam Kulkarni', 'expert', 'gautam_kulkarni_25_4', 'gautam_kulkarni_25_4@demo.askexpert.com', '+91 98000 00508',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (7+ Yrs Exp)', 'Science & Research Specialist Level 2', 'Science & Research',
    7, ARRAY['English', 'Hindi'], 4.60, 96, 1100,
    'Certified professional with 7 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000500000000', '00000000-0000-0000-0000-000000000000', 'swati_malhotra_25_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000500000000', 'Swati Malhotra', 'expert', 'swati_malhotra_25_5', 'swati_malhotra_25_5@demo.askexpert.com', '+91 98000 00509',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (8+ Yrs Exp)', 'Science & Research Specialist Level 3', 'Science & Research',
    8, ARRAY['English', 'Hindi'], 4.70, 103, 1250,
    'Certified professional with 8 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000600000000', '00000000-0000-0000-0000-000000000000', 'rajesh_bhattacharya_25_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000600000000', 'Rajesh Bhattacharya', 'expert', 'rajesh_bhattacharya_25_6', 'rajesh_bhattacharya_25_6@demo.askexpert.com', '+91 98000 00510',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (9+ Yrs Exp)', 'Science & Research Specialist Level 1', 'Science & Research',
    9, ARRAY['English', 'Hindi'], 4.80, 110, 1400,
    'Certified professional with 9 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000700000000', '00000000-0000-0000-0000-000000000000', 'priya_saxena_25_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000700000000', 'Priya Saxena', 'expert', 'priya_saxena_25_7', 'priya_saxena_25_7@demo.askexpert.com', '+91 98000 00511',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (10+ Yrs Exp)', 'Science & Research Specialist Level 2', 'Science & Research',
    10, ARRAY['English', 'Hindi'], 4.90, 117, 1550,
    'Certified professional with 10 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000800000000', '00000000-0000-0000-0000-000000000000', 'vikram_gupta_25_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000800000000', 'Vikram Gupta', 'expert', 'vikram_gupta_25_8', 'vikram_gupta_25_8@demo.askexpert.com', '+91 98000 00512',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (11+ Yrs Exp)', 'Science & Research Specialist Level 3', 'Science & Research',
    11, ARRAY['English', 'Hindi'], 4.20, 124, 1700,
    'Certified professional with 11 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000900000000', '00000000-0000-0000-0000-000000000000', 'ananya_chopra_25_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000900000000', 'Ananya Chopra', 'expert', 'ananya_chopra_25_9', 'ananya_chopra_25_9@demo.askexpert.com', '+91 98000 00513',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (12+ Yrs Exp)', 'Science & Research Specialist Level 1', 'Science & Research',
    12, ARRAY['English', 'Hindi'], 4.30, 131, 1850,
    'Certified professional with 12 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000a00000000', '00000000-0000-0000-0000-000000000000', 'siddharth_jain_25_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000a00000000', 'Siddharth Jain', 'expert', 'siddharth_jain_25_10', 'siddharth_jain_25_10@demo.askexpert.com', '+91 98000 00514',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (13+ Yrs Exp)', 'Science & Research Specialist Level 2', 'Science & Research',
    13, ARRAY['English', 'Hindi'], 4.40, 138, 2000,
    'Certified professional with 13 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000b00000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_nair_25_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000b00000000', 'Meenakshi Nair', 'expert', 'meenakshi_nair_25_11', 'meenakshi_nair_25_11@demo.askexpert.com', '+91 98000 00515',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (14+ Yrs Exp)', 'Science & Research Specialist Level 3', 'Science & Research',
    14, ARRAY['English', 'Hindi'], 4.50, 145, 2150,
    'Certified professional with 14 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000c00000000', '00000000-0000-0000-0000-000000000000', 'amitabh_sharma_25_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000c00000000', 'Amitabh Sharma', 'expert', 'amitabh_sharma_25_12', 'amitabh_sharma_25_12@demo.askexpert.com', '+91 98000 00516',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (15+ Yrs Exp)', 'Science & Research Specialist Level 1', 'Science & Research',
    15, ARRAY['English', 'Hindi'], 4.60, 152, 2300,
    'Certified professional with 15 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000d00000000', '00000000-0000-0000-0000-000000000000', 'sunita_reddy_25_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000d00000000', 'Sunita Reddy', 'expert', 'sunita_reddy_25_13', 'sunita_reddy_25_13@demo.askexpert.com', '+91 98000 00517',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (16+ Yrs Exp)', 'Science & Research Specialist Level 2', 'Science & Research',
    16, ARRAY['English', 'Hindi'], 4.70, 159, 2450,
    'Certified professional with 16 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000e00000000', '00000000-0000-0000-0000-000000000000', 'rohan_kulkarni_25_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000e00000000', 'Rohan Kulkarni', 'expert', 'rohan_kulkarni_25_14', 'rohan_kulkarni_25_14@demo.askexpert.com', '+91 98000 00518',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (17+ Yrs Exp)', 'Science & Research Specialist Level 3', 'Science & Research',
    17, ARRAY['English', 'Hindi'], 4.80, 166, 2600,
    'Certified professional with 17 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-000f00000000', '00000000-0000-0000-0000-000000000000', 'shalini_malhotra_25_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-000f00000000', 'Shalini Malhotra', 'expert', 'shalini_malhotra_25_15', 'shalini_malhotra_25_15@demo.askexpert.com', '+91 98000 00519',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (18+ Yrs Exp)', 'Science & Research Specialist Level 1', 'Science & Research',
    18, ARRAY['English', 'Hindi'], 4.90, 173, 500,
    'Certified professional with 18 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-001000000000', '00000000-0000-0000-0000-000000000000', 'suresh_bhattacharya_25_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-001000000000', 'Suresh Bhattacharya', 'expert', 'suresh_bhattacharya_25_16', 'suresh_bhattacharya_25_16@demo.askexpert.com', '+91 98000 00520',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (19+ Yrs Exp)', 'Science & Research Specialist Level 2', 'Science & Research',
    19, ARRAY['English', 'Hindi'], 4.20, 180, 650,
    'Certified professional with 19 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-001100000000', '00000000-0000-0000-0000-000000000000', 'ritu_saxena_25_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-001100000000', 'Ritu Saxena', 'expert', 'ritu_saxena_25_17', 'ritu_saxena_25_17@demo.askexpert.com', '+91 98000 00521',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (20+ Yrs Exp)', 'Science & Research Specialist Level 3', 'Science & Research',
    20, ARRAY['English', 'Hindi'], 4.30, 187, 800,
    'Certified professional with 20 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-001200000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_gupta_25_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-001200000000', 'Vikramaditya Gupta', 'expert', 'vikramaditya_gupta_25_18', 'vikramaditya_gupta_25_18@demo.askexpert.com', '+91 98000 00522',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (3+ Yrs Exp)', 'Science & Research Specialist Level 1', 'Science & Research',
    3, ARRAY['English', 'Hindi'], 4.40, 194, 950,
    'Certified professional with 3 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-001300000000', '00000000-0000-0000-0000-000000000000', 'deepa_chopra_25_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-001300000000', 'Deepa Chopra', 'expert', 'deepa_chopra_25_19', 'deepa_chopra_25_19@demo.askexpert.com', '+91 98000 00523',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (4+ Yrs Exp)', 'Science & Research Specialist Level 2', 'Science & Research',
    4, ARRAY['English', 'Hindi'], 4.50, 201, 1100,
    'Certified professional with 4 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-001400000000', '00000000-0000-0000-0000-000000000000', 'arvind_jain_25_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-001400000000', 'Arvind Jain', 'expert', 'arvind_jain_25_20', 'arvind_jain_25_20@demo.askexpert.com', '+91 98000 00524',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (5+ Yrs Exp)', 'Science & Research Specialist Level 3', 'Science & Research',
    5, ARRAY['English', 'Hindi'], 4.60, 208, 1250,
    'Certified professional with 5 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1900-001500000000', '00000000-0000-0000-0000-000000000000', 'sneha_nair_25_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1900-001500000000', 'Sneha Nair', 'expert', 'sneha_nair_25_21', 'sneha_nair_25_21@demo.askexpert.com', '+91 98000 00525',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Science & Research (6+ Yrs Exp)', 'Science & Research Specialist Level 1', 'Science & Research',
    6, ARRAY['English', 'Hindi'], 4.70, 215, 1400,
    'Certified professional with 6 years of expertise in Science & Research. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Science & Research Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000100000000', '00000000-0000-0000-0000-000000000000', 'karthik_gupta_26_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000100000000', 'Karthik Gupta', 'expert', 'karthik_gupta_26_1', 'karthik_gupta_26_1@demo.askexpert.com', '+91 98000 00526',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (4+ Yrs Exp)', 'Environment Specialist Level 2', 'Environment',
    4, ARRAY['English', 'Hindi'], 4.30, 27, 650,
    'Certified professional with 4 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000200000000', '00000000-0000-0000-0000-000000000000', 'neha_chopra_26_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000200000000', 'Neha Chopra', 'expert', 'neha_chopra_26_2', 'neha_chopra_26_2@demo.askexpert.com', '+91 98000 00527',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (5+ Yrs Exp)', 'Environment Specialist Level 3', 'Environment',
    5, ARRAY['English', 'Hindi'], 4.40, 34, 800,
    'Certified professional with 5 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000300000000', '00000000-0000-0000-0000-000000000000', 'devendra_jain_26_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000300000000', 'Devendra Jain', 'expert', 'devendra_jain_26_3', 'devendra_jain_26_3@demo.askexpert.com', '+91 98000 00528',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (6+ Yrs Exp)', 'Environment Specialist Level 1', 'Environment',
    6, ARRAY['English', 'Hindi'], 4.50, 41, 950,
    'Certified professional with 6 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000400000000', '00000000-0000-0000-0000-000000000000', 'preeti_nair_26_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000400000000', 'Preeti Nair', 'expert', 'preeti_nair_26_4', 'preeti_nair_26_4@demo.askexpert.com', '+91 98000 00529',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (7+ Yrs Exp)', 'Environment Specialist Level 2', 'Environment',
    7, ARRAY['English', 'Hindi'], 4.60, 48, 1100,
    'Certified professional with 7 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000500000000', '00000000-0000-0000-0000-000000000000', 'alok_sharma_26_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000500000000', 'Alok Sharma', 'expert', 'alok_sharma_26_5', 'alok_sharma_26_5@demo.askexpert.com', '+91 98000 00530',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (8+ Yrs Exp)', 'Environment Specialist Level 3', 'Environment',
    8, ARRAY['English', 'Hindi'], 4.70, 55, 1250,
    'Certified professional with 8 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000600000000', '00000000-0000-0000-0000-000000000000', 'kavita_reddy_26_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000600000000', 'Kavita Reddy', 'expert', 'kavita_reddy_26_6', 'kavita_reddy_26_6@demo.askexpert.com', '+91 98000 00531',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (9+ Yrs Exp)', 'Environment Specialist Level 1', 'Environment',
    9, ARRAY['English', 'Hindi'], 4.80, 62, 1400,
    'Certified professional with 9 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000700000000', '00000000-0000-0000-0000-000000000000', 'manish_kulkarni_26_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000700000000', 'Manish Kulkarni', 'expert', 'manish_kulkarni_26_7', 'manish_kulkarni_26_7@demo.askexpert.com', '+91 98000 00532',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (10+ Yrs Exp)', 'Environment Specialist Level 2', 'Environment',
    10, ARRAY['English', 'Hindi'], 4.90, 69, 1550,
    'Certified professional with 10 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000800000000', '00000000-0000-0000-0000-000000000000', 'pooja_malhotra_26_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000800000000', 'Pooja Malhotra', 'expert', 'pooja_malhotra_26_8', 'pooja_malhotra_26_8@demo.askexpert.com', '+91 98000 00533',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (11+ Yrs Exp)', 'Environment Specialist Level 3', 'Environment',
    11, ARRAY['English', 'Hindi'], 4.20, 76, 1700,
    'Certified professional with 11 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000900000000', '00000000-0000-0000-0000-000000000000', 'sanjay_bhattacharya_26_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000900000000', 'Sanjay Bhattacharya', 'expert', 'sanjay_bhattacharya_26_9', 'sanjay_bhattacharya_26_9@demo.askexpert.com', '+91 98000 00534',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (12+ Yrs Exp)', 'Environment Specialist Level 1', 'Environment',
    12, ARRAY['English', 'Hindi'], 4.30, 83, 1850,
    'Certified professional with 12 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000a00000000', '00000000-0000-0000-0000-000000000000', 'tanvi_saxena_26_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000a00000000', 'Tanvi Saxena', 'expert', 'tanvi_saxena_26_10', 'tanvi_saxena_26_10@demo.askexpert.com', '+91 98000 00535',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (13+ Yrs Exp)', 'Environment Specialist Level 2', 'Environment',
    13, ARRAY['English', 'Hindi'], 4.40, 90, 2000,
    'Certified professional with 13 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000b00000000', '00000000-0000-0000-0000-000000000000', 'varun_gupta_26_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000b00000000', 'Varun Gupta', 'expert', 'varun_gupta_26_11', 'varun_gupta_26_11@demo.askexpert.com', '+91 98000 00536',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (14+ Yrs Exp)', 'Environment Specialist Level 3', 'Environment',
    14, ARRAY['English', 'Hindi'], 4.50, 97, 2150,
    'Certified professional with 14 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000c00000000', '00000000-0000-0000-0000-000000000000', 'divya_chopra_26_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000c00000000', 'Divya Chopra', 'expert', 'divya_chopra_26_12', 'divya_chopra_26_12@demo.askexpert.com', '+91 98000 00537',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (15+ Yrs Exp)', 'Environment Specialist Level 1', 'Environment',
    15, ARRAY['English', 'Hindi'], 4.60, 104, 2300,
    'Certified professional with 15 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000d00000000', '00000000-0000-0000-0000-000000000000', 'gautam_jain_26_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000d00000000', 'Gautam Jain', 'expert', 'gautam_jain_26_13', 'gautam_jain_26_13@demo.askexpert.com', '+91 98000 00538',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (16+ Yrs Exp)', 'Environment Specialist Level 2', 'Environment',
    16, ARRAY['English', 'Hindi'], 4.70, 111, 2450,
    'Certified professional with 16 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000e00000000', '00000000-0000-0000-0000-000000000000', 'swati_nair_26_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000e00000000', 'Swati Nair', 'expert', 'swati_nair_26_14', 'swati_nair_26_14@demo.askexpert.com', '+91 98000 00539',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (17+ Yrs Exp)', 'Environment Specialist Level 3', 'Environment',
    17, ARRAY['English', 'Hindi'], 4.80, 118, 2600,
    'Certified professional with 17 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-000f00000000', '00000000-0000-0000-0000-000000000000', 'rajesh_sharma_26_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-000f00000000', 'Rajesh Sharma', 'expert', 'rajesh_sharma_26_15', 'rajesh_sharma_26_15@demo.askexpert.com', '+91 98000 00540',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (18+ Yrs Exp)', 'Environment Specialist Level 1', 'Environment',
    18, ARRAY['English', 'Hindi'], 4.90, 125, 500,
    'Certified professional with 18 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-001000000000', '00000000-0000-0000-0000-000000000000', 'priya_reddy_26_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-001000000000', 'Priya Reddy', 'expert', 'priya_reddy_26_16', 'priya_reddy_26_16@demo.askexpert.com', '+91 98000 00541',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (19+ Yrs Exp)', 'Environment Specialist Level 2', 'Environment',
    19, ARRAY['English', 'Hindi'], 4.20, 132, 650,
    'Certified professional with 19 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-001100000000', '00000000-0000-0000-0000-000000000000', 'vikram_kulkarni_26_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-001100000000', 'Vikram Kulkarni', 'expert', 'vikram_kulkarni_26_17', 'vikram_kulkarni_26_17@demo.askexpert.com', '+91 98000 00542',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (20+ Yrs Exp)', 'Environment Specialist Level 3', 'Environment',
    20, ARRAY['English', 'Hindi'], 4.30, 139, 800,
    'Certified professional with 20 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-001200000000', '00000000-0000-0000-0000-000000000000', 'ananya_malhotra_26_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-001200000000', 'Ananya Malhotra', 'expert', 'ananya_malhotra_26_18', 'ananya_malhotra_26_18@demo.askexpert.com', '+91 98000 00543',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (3+ Yrs Exp)', 'Environment Specialist Level 1', 'Environment',
    3, ARRAY['English', 'Hindi'], 4.40, 146, 950,
    'Certified professional with 3 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-001300000000', '00000000-0000-0000-0000-000000000000', 'siddharth_bhattacharya_26_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-001300000000', 'Siddharth Bhattacharya', 'expert', 'siddharth_bhattacharya_26_19', 'siddharth_bhattacharya_26_19@demo.askexpert.com', '+91 98000 00544',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (4+ Yrs Exp)', 'Environment Specialist Level 2', 'Environment',
    4, ARRAY['English', 'Hindi'], 4.50, 153, 1100,
    'Certified professional with 4 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-001400000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_saxena_26_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-001400000000', 'Meenakshi Saxena', 'expert', 'meenakshi_saxena_26_20', 'meenakshi_saxena_26_20@demo.askexpert.com', '+91 98000 00545',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (5+ Yrs Exp)', 'Environment Specialist Level 3', 'Environment',
    5, ARRAY['English', 'Hindi'], 4.60, 160, 1250,
    'Certified professional with 5 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1a00-001500000000', '00000000-0000-0000-0000-000000000000', 'amitabh_gupta_26_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1a00-001500000000', 'Amitabh Gupta', 'expert', 'amitabh_gupta_26_21', 'amitabh_gupta_26_21@demo.askexpert.com', '+91 98000 00546',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Environment (6+ Yrs Exp)', 'Environment Specialist Level 1', 'Environment',
    6, ARRAY['English', 'Hindi'], 4.70, 167, 1400,
    'Certified professional with 6 years of expertise in Environment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Environment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000100000000', '00000000-0000-0000-0000-000000000000', 'sunita_malhotra_27_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000100000000', 'Sunita Malhotra', 'expert', 'sunita_malhotra_27_1', 'sunita_malhotra_27_1@demo.askexpert.com', '+91 98000 00547',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (4+ Yrs Exp)', 'Construction Specialist Level 2', 'Construction',
    4, ARRAY['English', 'Hindi'], 4.30, 39, 650,
    'Certified professional with 4 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000200000000', '00000000-0000-0000-0000-000000000000', 'rohan_bhattacharya_27_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000200000000', 'Rohan Bhattacharya', 'expert', 'rohan_bhattacharya_27_2', 'rohan_bhattacharya_27_2@demo.askexpert.com', '+91 98000 00548',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (5+ Yrs Exp)', 'Construction Specialist Level 3', 'Construction',
    5, ARRAY['English', 'Hindi'], 4.40, 46, 800,
    'Certified professional with 5 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000300000000', '00000000-0000-0000-0000-000000000000', 'shalini_saxena_27_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000300000000', 'Shalini Saxena', 'expert', 'shalini_saxena_27_3', 'shalini_saxena_27_3@demo.askexpert.com', '+91 98000 00549',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (6+ Yrs Exp)', 'Construction Specialist Level 1', 'Construction',
    6, ARRAY['English', 'Hindi'], 4.50, 53, 950,
    'Certified professional with 6 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000400000000', '00000000-0000-0000-0000-000000000000', 'suresh_gupta_27_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000400000000', 'Suresh Gupta', 'expert', 'suresh_gupta_27_4', 'suresh_gupta_27_4@demo.askexpert.com', '+91 98000 00550',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (7+ Yrs Exp)', 'Construction Specialist Level 2', 'Construction',
    7, ARRAY['English', 'Hindi'], 4.60, 60, 1100,
    'Certified professional with 7 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000500000000', '00000000-0000-0000-0000-000000000000', 'ritu_chopra_27_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000500000000', 'Ritu Chopra', 'expert', 'ritu_chopra_27_5', 'ritu_chopra_27_5@demo.askexpert.com', '+91 98000 00551',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (8+ Yrs Exp)', 'Construction Specialist Level 3', 'Construction',
    8, ARRAY['English', 'Hindi'], 4.70, 67, 1250,
    'Certified professional with 8 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000600000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_jain_27_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000600000000', 'Vikramaditya Jain', 'expert', 'vikramaditya_jain_27_6', 'vikramaditya_jain_27_6@demo.askexpert.com', '+91 98000 00552',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (9+ Yrs Exp)', 'Construction Specialist Level 1', 'Construction',
    9, ARRAY['English', 'Hindi'], 4.80, 74, 1400,
    'Certified professional with 9 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000700000000', '00000000-0000-0000-0000-000000000000', 'deepa_nair_27_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000700000000', 'Deepa Nair', 'expert', 'deepa_nair_27_7', 'deepa_nair_27_7@demo.askexpert.com', '+91 98000 00553',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (10+ Yrs Exp)', 'Construction Specialist Level 2', 'Construction',
    10, ARRAY['English', 'Hindi'], 4.90, 81, 1550,
    'Certified professional with 10 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000800000000', '00000000-0000-0000-0000-000000000000', 'arvind_sharma_27_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000800000000', 'Arvind Sharma', 'expert', 'arvind_sharma_27_8', 'arvind_sharma_27_8@demo.askexpert.com', '+91 98000 00554',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (11+ Yrs Exp)', 'Construction Specialist Level 3', 'Construction',
    11, ARRAY['English', 'Hindi'], 4.20, 88, 1700,
    'Certified professional with 11 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000900000000', '00000000-0000-0000-0000-000000000000', 'sneha_reddy_27_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000900000000', 'Sneha Reddy', 'expert', 'sneha_reddy_27_9', 'sneha_reddy_27_9@demo.askexpert.com', '+91 98000 00555',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (12+ Yrs Exp)', 'Construction Specialist Level 1', 'Construction',
    12, ARRAY['English', 'Hindi'], 4.30, 95, 1850,
    'Certified professional with 12 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000a00000000', '00000000-0000-0000-0000-000000000000', 'karthik_kulkarni_27_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000a00000000', 'Karthik Kulkarni', 'expert', 'karthik_kulkarni_27_10', 'karthik_kulkarni_27_10@demo.askexpert.com', '+91 98000 00556',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (13+ Yrs Exp)', 'Construction Specialist Level 2', 'Construction',
    13, ARRAY['English', 'Hindi'], 4.40, 102, 2000,
    'Certified professional with 13 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000b00000000', '00000000-0000-0000-0000-000000000000', 'neha_malhotra_27_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000b00000000', 'Neha Malhotra', 'expert', 'neha_malhotra_27_11', 'neha_malhotra_27_11@demo.askexpert.com', '+91 98000 00557',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (14+ Yrs Exp)', 'Construction Specialist Level 3', 'Construction',
    14, ARRAY['English', 'Hindi'], 4.50, 109, 2150,
    'Certified professional with 14 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000c00000000', '00000000-0000-0000-0000-000000000000', 'devendra_bhattacharya_27_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000c00000000', 'Devendra Bhattacharya', 'expert', 'devendra_bhattacharya_27_12', 'devendra_bhattacharya_27_12@demo.askexpert.com', '+91 98000 00558',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (15+ Yrs Exp)', 'Construction Specialist Level 1', 'Construction',
    15, ARRAY['English', 'Hindi'], 4.60, 116, 2300,
    'Certified professional with 15 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000d00000000', '00000000-0000-0000-0000-000000000000', 'preeti_saxena_27_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000d00000000', 'Preeti Saxena', 'expert', 'preeti_saxena_27_13', 'preeti_saxena_27_13@demo.askexpert.com', '+91 98000 00559',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (16+ Yrs Exp)', 'Construction Specialist Level 2', 'Construction',
    16, ARRAY['English', 'Hindi'], 4.70, 123, 2450,
    'Certified professional with 16 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000e00000000', '00000000-0000-0000-0000-000000000000', 'alok_gupta_27_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000e00000000', 'Alok Gupta', 'expert', 'alok_gupta_27_14', 'alok_gupta_27_14@demo.askexpert.com', '+91 98000 00560',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (17+ Yrs Exp)', 'Construction Specialist Level 3', 'Construction',
    17, ARRAY['English', 'Hindi'], 4.80, 130, 2600,
    'Certified professional with 17 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-000f00000000', '00000000-0000-0000-0000-000000000000', 'kavita_chopra_27_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-000f00000000', 'Kavita Chopra', 'expert', 'kavita_chopra_27_15', 'kavita_chopra_27_15@demo.askexpert.com', '+91 98000 00561',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (18+ Yrs Exp)', 'Construction Specialist Level 1', 'Construction',
    18, ARRAY['English', 'Hindi'], 4.90, 137, 500,
    'Certified professional with 18 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-001000000000', '00000000-0000-0000-0000-000000000000', 'manish_jain_27_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-001000000000', 'Manish Jain', 'expert', 'manish_jain_27_16', 'manish_jain_27_16@demo.askexpert.com', '+91 98000 00562',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (19+ Yrs Exp)', 'Construction Specialist Level 2', 'Construction',
    19, ARRAY['English', 'Hindi'], 4.20, 144, 650,
    'Certified professional with 19 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-001100000000', '00000000-0000-0000-0000-000000000000', 'pooja_nair_27_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-001100000000', 'Pooja Nair', 'expert', 'pooja_nair_27_17', 'pooja_nair_27_17@demo.askexpert.com', '+91 98000 00563',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (20+ Yrs Exp)', 'Construction Specialist Level 3', 'Construction',
    20, ARRAY['English', 'Hindi'], 4.30, 151, 800,
    'Certified professional with 20 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-001200000000', '00000000-0000-0000-0000-000000000000', 'sanjay_sharma_27_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-001200000000', 'Sanjay Sharma', 'expert', 'sanjay_sharma_27_18', 'sanjay_sharma_27_18@demo.askexpert.com', '+91 98000 00564',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (3+ Yrs Exp)', 'Construction Specialist Level 1', 'Construction',
    3, ARRAY['English', 'Hindi'], 4.40, 158, 950,
    'Certified professional with 3 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-001300000000', '00000000-0000-0000-0000-000000000000', 'tanvi_reddy_27_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-001300000000', 'Tanvi Reddy', 'expert', 'tanvi_reddy_27_19', 'tanvi_reddy_27_19@demo.askexpert.com', '+91 98000 00565',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (4+ Yrs Exp)', 'Construction Specialist Level 2', 'Construction',
    4, ARRAY['English', 'Hindi'], 4.50, 165, 1100,
    'Certified professional with 4 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-001400000000', '00000000-0000-0000-0000-000000000000', 'varun_kulkarni_27_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-001400000000', 'Varun Kulkarni', 'expert', 'varun_kulkarni_27_20', 'varun_kulkarni_27_20@demo.askexpert.com', '+91 98000 00566',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (5+ Yrs Exp)', 'Construction Specialist Level 3', 'Construction',
    5, ARRAY['English', 'Hindi'], 4.60, 172, 1250,
    'Certified professional with 5 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1b00-001500000000', '00000000-0000-0000-0000-000000000000', 'divya_malhotra_27_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1b00-001500000000', 'Divya Malhotra', 'expert', 'divya_malhotra_27_21', 'divya_malhotra_27_21@demo.askexpert.com', '+91 98000 00567',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Construction (6+ Yrs Exp)', 'Construction Specialist Level 1', 'Construction',
    6, ARRAY['English', 'Hindi'], 4.70, 179, 1400,
    'Certified professional with 6 years of expertise in Construction. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Construction Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000100000000', '00000000-0000-0000-0000-000000000000', 'gautam_sharma_28_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000100000000', 'Gautam Sharma', 'expert', 'gautam_sharma_28_1', 'gautam_sharma_28_1@demo.askexpert.com', '+91 98000 00568',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (4+ Yrs Exp)', 'Automobile Specialist Level 2', 'Automobile',
    4, ARRAY['English', 'Hindi'], 4.30, 51, 650,
    'Certified professional with 4 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000200000000', '00000000-0000-0000-0000-000000000000', 'swati_reddy_28_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000200000000', 'Swati Reddy', 'expert', 'swati_reddy_28_2', 'swati_reddy_28_2@demo.askexpert.com', '+91 98000 00569',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (5+ Yrs Exp)', 'Automobile Specialist Level 3', 'Automobile',
    5, ARRAY['English', 'Hindi'], 4.40, 58, 800,
    'Certified professional with 5 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000300000000', '00000000-0000-0000-0000-000000000000', 'rajesh_kulkarni_28_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000300000000', 'Rajesh Kulkarni', 'expert', 'rajesh_kulkarni_28_3', 'rajesh_kulkarni_28_3@demo.askexpert.com', '+91 98000 00570',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (6+ Yrs Exp)', 'Automobile Specialist Level 1', 'Automobile',
    6, ARRAY['English', 'Hindi'], 4.50, 65, 950,
    'Certified professional with 6 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000400000000', '00000000-0000-0000-0000-000000000000', 'priya_malhotra_28_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000400000000', 'Priya Malhotra', 'expert', 'priya_malhotra_28_4', 'priya_malhotra_28_4@demo.askexpert.com', '+91 98000 00571',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (7+ Yrs Exp)', 'Automobile Specialist Level 2', 'Automobile',
    7, ARRAY['English', 'Hindi'], 4.60, 72, 1100,
    'Certified professional with 7 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000500000000', '00000000-0000-0000-0000-000000000000', 'vikram_bhattacharya_28_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000500000000', 'Vikram Bhattacharya', 'expert', 'vikram_bhattacharya_28_5', 'vikram_bhattacharya_28_5@demo.askexpert.com', '+91 98000 00572',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (8+ Yrs Exp)', 'Automobile Specialist Level 3', 'Automobile',
    8, ARRAY['English', 'Hindi'], 4.70, 79, 1250,
    'Certified professional with 8 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000600000000', '00000000-0000-0000-0000-000000000000', 'ananya_saxena_28_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000600000000', 'Ananya Saxena', 'expert', 'ananya_saxena_28_6', 'ananya_saxena_28_6@demo.askexpert.com', '+91 98000 00573',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (9+ Yrs Exp)', 'Automobile Specialist Level 1', 'Automobile',
    9, ARRAY['English', 'Hindi'], 4.80, 86, 1400,
    'Certified professional with 9 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000700000000', '00000000-0000-0000-0000-000000000000', 'siddharth_gupta_28_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000700000000', 'Siddharth Gupta', 'expert', 'siddharth_gupta_28_7', 'siddharth_gupta_28_7@demo.askexpert.com', '+91 98000 00574',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (10+ Yrs Exp)', 'Automobile Specialist Level 2', 'Automobile',
    10, ARRAY['English', 'Hindi'], 4.90, 93, 1550,
    'Certified professional with 10 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000800000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_chopra_28_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000800000000', 'Meenakshi Chopra', 'expert', 'meenakshi_chopra_28_8', 'meenakshi_chopra_28_8@demo.askexpert.com', '+91 98000 00575',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (11+ Yrs Exp)', 'Automobile Specialist Level 3', 'Automobile',
    11, ARRAY['English', 'Hindi'], 4.20, 100, 1700,
    'Certified professional with 11 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000900000000', '00000000-0000-0000-0000-000000000000', 'amitabh_jain_28_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000900000000', 'Amitabh Jain', 'expert', 'amitabh_jain_28_9', 'amitabh_jain_28_9@demo.askexpert.com', '+91 98000 00576',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (12+ Yrs Exp)', 'Automobile Specialist Level 1', 'Automobile',
    12, ARRAY['English', 'Hindi'], 4.30, 107, 1850,
    'Certified professional with 12 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000a00000000', '00000000-0000-0000-0000-000000000000', 'sunita_nair_28_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000a00000000', 'Sunita Nair', 'expert', 'sunita_nair_28_10', 'sunita_nair_28_10@demo.askexpert.com', '+91 98000 00577',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (13+ Yrs Exp)', 'Automobile Specialist Level 2', 'Automobile',
    13, ARRAY['English', 'Hindi'], 4.40, 114, 2000,
    'Certified professional with 13 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000b00000000', '00000000-0000-0000-0000-000000000000', 'rohan_sharma_28_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000b00000000', 'Rohan Sharma', 'expert', 'rohan_sharma_28_11', 'rohan_sharma_28_11@demo.askexpert.com', '+91 98000 00578',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (14+ Yrs Exp)', 'Automobile Specialist Level 3', 'Automobile',
    14, ARRAY['English', 'Hindi'], 4.50, 121, 2150,
    'Certified professional with 14 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000c00000000', '00000000-0000-0000-0000-000000000000', 'shalini_reddy_28_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000c00000000', 'Shalini Reddy', 'expert', 'shalini_reddy_28_12', 'shalini_reddy_28_12@demo.askexpert.com', '+91 98000 00579',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (15+ Yrs Exp)', 'Automobile Specialist Level 1', 'Automobile',
    15, ARRAY['English', 'Hindi'], 4.60, 128, 2300,
    'Certified professional with 15 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000d00000000', '00000000-0000-0000-0000-000000000000', 'suresh_kulkarni_28_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000d00000000', 'Suresh Kulkarni', 'expert', 'suresh_kulkarni_28_13', 'suresh_kulkarni_28_13@demo.askexpert.com', '+91 98000 00580',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (16+ Yrs Exp)', 'Automobile Specialist Level 2', 'Automobile',
    16, ARRAY['English', 'Hindi'], 4.70, 135, 2450,
    'Certified professional with 16 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000e00000000', '00000000-0000-0000-0000-000000000000', 'ritu_malhotra_28_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000e00000000', 'Ritu Malhotra', 'expert', 'ritu_malhotra_28_14', 'ritu_malhotra_28_14@demo.askexpert.com', '+91 98000 00581',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (17+ Yrs Exp)', 'Automobile Specialist Level 3', 'Automobile',
    17, ARRAY['English', 'Hindi'], 4.80, 142, 2600,
    'Certified professional with 17 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-000f00000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_bhattacharya_28_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-000f00000000', 'Vikramaditya Bhattacharya', 'expert', 'vikramaditya_bhattacharya_28_15', 'vikramaditya_bhattacharya_28_15@demo.askexpert.com', '+91 98000 00582',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (18+ Yrs Exp)', 'Automobile Specialist Level 1', 'Automobile',
    18, ARRAY['English', 'Hindi'], 4.90, 149, 500,
    'Certified professional with 18 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-001000000000', '00000000-0000-0000-0000-000000000000', 'deepa_saxena_28_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-001000000000', 'Deepa Saxena', 'expert', 'deepa_saxena_28_16', 'deepa_saxena_28_16@demo.askexpert.com', '+91 98000 00583',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (19+ Yrs Exp)', 'Automobile Specialist Level 2', 'Automobile',
    19, ARRAY['English', 'Hindi'], 4.20, 156, 650,
    'Certified professional with 19 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-001100000000', '00000000-0000-0000-0000-000000000000', 'arvind_gupta_28_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-001100000000', 'Arvind Gupta', 'expert', 'arvind_gupta_28_17', 'arvind_gupta_28_17@demo.askexpert.com', '+91 98000 00584',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (20+ Yrs Exp)', 'Automobile Specialist Level 3', 'Automobile',
    20, ARRAY['English', 'Hindi'], 4.30, 163, 800,
    'Certified professional with 20 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-001200000000', '00000000-0000-0000-0000-000000000000', 'sneha_chopra_28_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-001200000000', 'Sneha Chopra', 'expert', 'sneha_chopra_28_18', 'sneha_chopra_28_18@demo.askexpert.com', '+91 98000 00585',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (3+ Yrs Exp)', 'Automobile Specialist Level 1', 'Automobile',
    3, ARRAY['English', 'Hindi'], 4.40, 170, 950,
    'Certified professional with 3 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-001300000000', '00000000-0000-0000-0000-000000000000', 'karthik_jain_28_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-001300000000', 'Karthik Jain', 'expert', 'karthik_jain_28_19', 'karthik_jain_28_19@demo.askexpert.com', '+91 98000 00586',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (4+ Yrs Exp)', 'Automobile Specialist Level 2', 'Automobile',
    4, ARRAY['English', 'Hindi'], 4.50, 177, 1100,
    'Certified professional with 4 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-001400000000', '00000000-0000-0000-0000-000000000000', 'neha_nair_28_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-001400000000', 'Neha Nair', 'expert', 'neha_nair_28_20', 'neha_nair_28_20@demo.askexpert.com', '+91 98000 00587',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (5+ Yrs Exp)', 'Automobile Specialist Level 3', 'Automobile',
    5, ARRAY['English', 'Hindi'], 4.60, 184, 1250,
    'Certified professional with 5 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1c00-001500000000', '00000000-0000-0000-0000-000000000000', 'devendra_sharma_28_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1c00-001500000000', 'Devendra Sharma', 'expert', 'devendra_sharma_28_21', 'devendra_sharma_28_21@demo.askexpert.com', '+91 98000 00588',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Automobile (6+ Yrs Exp)', 'Automobile Specialist Level 1', 'Automobile',
    6, ARRAY['English', 'Hindi'], 4.70, 191, 1400,
    'Certified professional with 6 years of expertise in Automobile. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Automobile Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000100000000', '00000000-0000-0000-0000-000000000000', 'preeti_chopra_29_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000100000000', 'Preeti Chopra', 'expert', 'preeti_chopra_29_1', 'preeti_chopra_29_1@demo.askexpert.com', '+91 98000 00589',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (4+ Yrs Exp)', 'Travel & Tourism Specialist Level 2', 'Travel & Tourism',
    4, ARRAY['English', 'Hindi'], 4.30, 63, 650,
    'Certified professional with 4 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000200000000', '00000000-0000-0000-0000-000000000000', 'alok_jain_29_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000200000000', 'Alok Jain', 'expert', 'alok_jain_29_2', 'alok_jain_29_2@demo.askexpert.com', '+91 98000 00590',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (5+ Yrs Exp)', 'Travel & Tourism Specialist Level 3', 'Travel & Tourism',
    5, ARRAY['English', 'Hindi'], 4.40, 70, 800,
    'Certified professional with 5 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000300000000', '00000000-0000-0000-0000-000000000000', 'kavita_nair_29_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000300000000', 'Kavita Nair', 'expert', 'kavita_nair_29_3', 'kavita_nair_29_3@demo.askexpert.com', '+91 98000 00591',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (6+ Yrs Exp)', 'Travel & Tourism Specialist Level 1', 'Travel & Tourism',
    6, ARRAY['English', 'Hindi'], 4.50, 77, 950,
    'Certified professional with 6 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000400000000', '00000000-0000-0000-0000-000000000000', 'manish_sharma_29_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000400000000', 'Manish Sharma', 'expert', 'manish_sharma_29_4', 'manish_sharma_29_4@demo.askexpert.com', '+91 98000 00592',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (7+ Yrs Exp)', 'Travel & Tourism Specialist Level 2', 'Travel & Tourism',
    7, ARRAY['English', 'Hindi'], 4.60, 84, 1100,
    'Certified professional with 7 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000500000000', '00000000-0000-0000-0000-000000000000', 'pooja_reddy_29_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000500000000', 'Pooja Reddy', 'expert', 'pooja_reddy_29_5', 'pooja_reddy_29_5@demo.askexpert.com', '+91 98000 00593',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (8+ Yrs Exp)', 'Travel & Tourism Specialist Level 3', 'Travel & Tourism',
    8, ARRAY['English', 'Hindi'], 4.70, 91, 1250,
    'Certified professional with 8 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000600000000', '00000000-0000-0000-0000-000000000000', 'sanjay_kulkarni_29_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000600000000', 'Sanjay Kulkarni', 'expert', 'sanjay_kulkarni_29_6', 'sanjay_kulkarni_29_6@demo.askexpert.com', '+91 98000 00594',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (9+ Yrs Exp)', 'Travel & Tourism Specialist Level 1', 'Travel & Tourism',
    9, ARRAY['English', 'Hindi'], 4.80, 98, 1400,
    'Certified professional with 9 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000700000000', '00000000-0000-0000-0000-000000000000', 'tanvi_malhotra_29_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000700000000', 'Tanvi Malhotra', 'expert', 'tanvi_malhotra_29_7', 'tanvi_malhotra_29_7@demo.askexpert.com', '+91 98000 00595',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (10+ Yrs Exp)', 'Travel & Tourism Specialist Level 2', 'Travel & Tourism',
    10, ARRAY['English', 'Hindi'], 4.90, 105, 1550,
    'Certified professional with 10 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000800000000', '00000000-0000-0000-0000-000000000000', 'varun_bhattacharya_29_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000800000000', 'Varun Bhattacharya', 'expert', 'varun_bhattacharya_29_8', 'varun_bhattacharya_29_8@demo.askexpert.com', '+91 98000 00596',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (11+ Yrs Exp)', 'Travel & Tourism Specialist Level 3', 'Travel & Tourism',
    11, ARRAY['English', 'Hindi'], 4.20, 112, 1700,
    'Certified professional with 11 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000900000000', '00000000-0000-0000-0000-000000000000', 'divya_saxena_29_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000900000000', 'Divya Saxena', 'expert', 'divya_saxena_29_9', 'divya_saxena_29_9@demo.askexpert.com', '+91 98000 00597',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (12+ Yrs Exp)', 'Travel & Tourism Specialist Level 1', 'Travel & Tourism',
    12, ARRAY['English', 'Hindi'], 4.30, 119, 1850,
    'Certified professional with 12 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000a00000000', '00000000-0000-0000-0000-000000000000', 'gautam_gupta_29_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000a00000000', 'Gautam Gupta', 'expert', 'gautam_gupta_29_10', 'gautam_gupta_29_10@demo.askexpert.com', '+91 98000 00598',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (13+ Yrs Exp)', 'Travel & Tourism Specialist Level 2', 'Travel & Tourism',
    13, ARRAY['English', 'Hindi'], 4.40, 126, 2000,
    'Certified professional with 13 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000b00000000', '00000000-0000-0000-0000-000000000000', 'swati_chopra_29_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000b00000000', 'Swati Chopra', 'expert', 'swati_chopra_29_11', 'swati_chopra_29_11@demo.askexpert.com', '+91 98000 00599',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (14+ Yrs Exp)', 'Travel & Tourism Specialist Level 3', 'Travel & Tourism',
    14, ARRAY['English', 'Hindi'], 4.50, 133, 2150,
    'Certified professional with 14 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000c00000000', '00000000-0000-0000-0000-000000000000', 'rajesh_jain_29_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000c00000000', 'Rajesh Jain', 'expert', 'rajesh_jain_29_12', 'rajesh_jain_29_12@demo.askexpert.com', '+91 98000 00600',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (15+ Yrs Exp)', 'Travel & Tourism Specialist Level 1', 'Travel & Tourism',
    15, ARRAY['English', 'Hindi'], 4.60, 140, 2300,
    'Certified professional with 15 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000d00000000', '00000000-0000-0000-0000-000000000000', 'priya_nair_29_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000d00000000', 'Priya Nair', 'expert', 'priya_nair_29_13', 'priya_nair_29_13@demo.askexpert.com', '+91 98000 00601',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (16+ Yrs Exp)', 'Travel & Tourism Specialist Level 2', 'Travel & Tourism',
    16, ARRAY['English', 'Hindi'], 4.70, 147, 2450,
    'Certified professional with 16 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000e00000000', '00000000-0000-0000-0000-000000000000', 'vikram_sharma_29_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000e00000000', 'Vikram Sharma', 'expert', 'vikram_sharma_29_14', 'vikram_sharma_29_14@demo.askexpert.com', '+91 98000 00602',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (17+ Yrs Exp)', 'Travel & Tourism Specialist Level 3', 'Travel & Tourism',
    17, ARRAY['English', 'Hindi'], 4.80, 154, 2600,
    'Certified professional with 17 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-000f00000000', '00000000-0000-0000-0000-000000000000', 'ananya_reddy_29_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-000f00000000', 'Ananya Reddy', 'expert', 'ananya_reddy_29_15', 'ananya_reddy_29_15@demo.askexpert.com', '+91 98000 00603',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (18+ Yrs Exp)', 'Travel & Tourism Specialist Level 1', 'Travel & Tourism',
    18, ARRAY['English', 'Hindi'], 4.90, 161, 500,
    'Certified professional with 18 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-001000000000', '00000000-0000-0000-0000-000000000000', 'siddharth_kulkarni_29_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-001000000000', 'Siddharth Kulkarni', 'expert', 'siddharth_kulkarni_29_16', 'siddharth_kulkarni_29_16@demo.askexpert.com', '+91 98000 00604',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (19+ Yrs Exp)', 'Travel & Tourism Specialist Level 2', 'Travel & Tourism',
    19, ARRAY['English', 'Hindi'], 4.20, 168, 650,
    'Certified professional with 19 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-001100000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_malhotra_29_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-001100000000', 'Meenakshi Malhotra', 'expert', 'meenakshi_malhotra_29_17', 'meenakshi_malhotra_29_17@demo.askexpert.com', '+91 98000 00605',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (20+ Yrs Exp)', 'Travel & Tourism Specialist Level 3', 'Travel & Tourism',
    20, ARRAY['English', 'Hindi'], 4.30, 175, 800,
    'Certified professional with 20 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-001200000000', '00000000-0000-0000-0000-000000000000', 'amitabh_bhattacharya_29_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-001200000000', 'Amitabh Bhattacharya', 'expert', 'amitabh_bhattacharya_29_18', 'amitabh_bhattacharya_29_18@demo.askexpert.com', '+91 98000 00606',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (3+ Yrs Exp)', 'Travel & Tourism Specialist Level 1', 'Travel & Tourism',
    3, ARRAY['English', 'Hindi'], 4.40, 182, 950,
    'Certified professional with 3 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-001300000000', '00000000-0000-0000-0000-000000000000', 'sunita_saxena_29_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-001300000000', 'Sunita Saxena', 'expert', 'sunita_saxena_29_19', 'sunita_saxena_29_19@demo.askexpert.com', '+91 98000 00607',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (4+ Yrs Exp)', 'Travel & Tourism Specialist Level 2', 'Travel & Tourism',
    4, ARRAY['English', 'Hindi'], 4.50, 189, 1100,
    'Certified professional with 4 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-001400000000', '00000000-0000-0000-0000-000000000000', 'rohan_gupta_29_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-001400000000', 'Rohan Gupta', 'expert', 'rohan_gupta_29_20', 'rohan_gupta_29_20@demo.askexpert.com', '+91 98000 00608',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (5+ Yrs Exp)', 'Travel & Tourism Specialist Level 3', 'Travel & Tourism',
    5, ARRAY['English', 'Hindi'], 4.60, 196, 1250,
    'Certified professional with 5 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1d00-001500000000', '00000000-0000-0000-0000-000000000000', 'shalini_chopra_29_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1d00-001500000000', 'Shalini Chopra', 'expert', 'shalini_chopra_29_21', 'shalini_chopra_29_21@demo.askexpert.com', '+91 98000 00609',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Travel & Tourism (6+ Yrs Exp)', 'Travel & Tourism Specialist Level 1', 'Travel & Tourism',
    6, ARRAY['English', 'Hindi'], 4.70, 203, 1400,
    'Certified professional with 6 years of expertise in Travel & Tourism. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Travel & Tourism Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000100000000', '00000000-0000-0000-0000-000000000000', 'suresh_bhattacharya_30_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000100000000', 'Suresh Bhattacharya', 'expert', 'suresh_bhattacharya_30_1', 'suresh_bhattacharya_30_1@demo.askexpert.com', '+91 98000 00610',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (4+ Yrs Exp)', 'Food & Nutrition Specialist Level 2', 'Food & Nutrition',
    4, ARRAY['English', 'Hindi'], 4.30, 75, 650,
    'Certified professional with 4 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000200000000', '00000000-0000-0000-0000-000000000000', 'ritu_saxena_30_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000200000000', 'Ritu Saxena', 'expert', 'ritu_saxena_30_2', 'ritu_saxena_30_2@demo.askexpert.com', '+91 98000 00611',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (5+ Yrs Exp)', 'Food & Nutrition Specialist Level 3', 'Food & Nutrition',
    5, ARRAY['English', 'Hindi'], 4.40, 82, 800,
    'Certified professional with 5 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000300000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_gupta_30_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000300000000', 'Vikramaditya Gupta', 'expert', 'vikramaditya_gupta_30_3', 'vikramaditya_gupta_30_3@demo.askexpert.com', '+91 98000 00612',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (6+ Yrs Exp)', 'Food & Nutrition Specialist Level 1', 'Food & Nutrition',
    6, ARRAY['English', 'Hindi'], 4.50, 89, 950,
    'Certified professional with 6 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000400000000', '00000000-0000-0000-0000-000000000000', 'deepa_chopra_30_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000400000000', 'Deepa Chopra', 'expert', 'deepa_chopra_30_4', 'deepa_chopra_30_4@demo.askexpert.com', '+91 98000 00613',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (7+ Yrs Exp)', 'Food & Nutrition Specialist Level 2', 'Food & Nutrition',
    7, ARRAY['English', 'Hindi'], 4.60, 96, 1100,
    'Certified professional with 7 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000500000000', '00000000-0000-0000-0000-000000000000', 'arvind_jain_30_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000500000000', 'Arvind Jain', 'expert', 'arvind_jain_30_5', 'arvind_jain_30_5@demo.askexpert.com', '+91 98000 00614',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (8+ Yrs Exp)', 'Food & Nutrition Specialist Level 3', 'Food & Nutrition',
    8, ARRAY['English', 'Hindi'], 4.70, 103, 1250,
    'Certified professional with 8 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000600000000', '00000000-0000-0000-0000-000000000000', 'sneha_nair_30_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000600000000', 'Sneha Nair', 'expert', 'sneha_nair_30_6', 'sneha_nair_30_6@demo.askexpert.com', '+91 98000 00615',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (9+ Yrs Exp)', 'Food & Nutrition Specialist Level 1', 'Food & Nutrition',
    9, ARRAY['English', 'Hindi'], 4.80, 110, 1400,
    'Certified professional with 9 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000700000000', '00000000-0000-0000-0000-000000000000', 'karthik_sharma_30_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000700000000', 'Karthik Sharma', 'expert', 'karthik_sharma_30_7', 'karthik_sharma_30_7@demo.askexpert.com', '+91 98000 00616',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (10+ Yrs Exp)', 'Food & Nutrition Specialist Level 2', 'Food & Nutrition',
    10, ARRAY['English', 'Hindi'], 4.90, 117, 1550,
    'Certified professional with 10 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000800000000', '00000000-0000-0000-0000-000000000000', 'neha_reddy_30_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000800000000', 'Neha Reddy', 'expert', 'neha_reddy_30_8', 'neha_reddy_30_8@demo.askexpert.com', '+91 98000 00617',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (11+ Yrs Exp)', 'Food & Nutrition Specialist Level 3', 'Food & Nutrition',
    11, ARRAY['English', 'Hindi'], 4.20, 124, 1700,
    'Certified professional with 11 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000900000000', '00000000-0000-0000-0000-000000000000', 'devendra_kulkarni_30_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000900000000', 'Devendra Kulkarni', 'expert', 'devendra_kulkarni_30_9', 'devendra_kulkarni_30_9@demo.askexpert.com', '+91 98000 00618',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (12+ Yrs Exp)', 'Food & Nutrition Specialist Level 1', 'Food & Nutrition',
    12, ARRAY['English', 'Hindi'], 4.30, 131, 1850,
    'Certified professional with 12 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000a00000000', '00000000-0000-0000-0000-000000000000', 'preeti_malhotra_30_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000a00000000', 'Preeti Malhotra', 'expert', 'preeti_malhotra_30_10', 'preeti_malhotra_30_10@demo.askexpert.com', '+91 98000 00619',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (13+ Yrs Exp)', 'Food & Nutrition Specialist Level 2', 'Food & Nutrition',
    13, ARRAY['English', 'Hindi'], 4.40, 138, 2000,
    'Certified professional with 13 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000b00000000', '00000000-0000-0000-0000-000000000000', 'alok_bhattacharya_30_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000b00000000', 'Alok Bhattacharya', 'expert', 'alok_bhattacharya_30_11', 'alok_bhattacharya_30_11@demo.askexpert.com', '+91 98000 00620',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (14+ Yrs Exp)', 'Food & Nutrition Specialist Level 3', 'Food & Nutrition',
    14, ARRAY['English', 'Hindi'], 4.50, 145, 2150,
    'Certified professional with 14 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000c00000000', '00000000-0000-0000-0000-000000000000', 'kavita_saxena_30_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000c00000000', 'Kavita Saxena', 'expert', 'kavita_saxena_30_12', 'kavita_saxena_30_12@demo.askexpert.com', '+91 98000 00621',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (15+ Yrs Exp)', 'Food & Nutrition Specialist Level 1', 'Food & Nutrition',
    15, ARRAY['English', 'Hindi'], 4.60, 152, 2300,
    'Certified professional with 15 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000d00000000', '00000000-0000-0000-0000-000000000000', 'manish_gupta_30_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000d00000000', 'Manish Gupta', 'expert', 'manish_gupta_30_13', 'manish_gupta_30_13@demo.askexpert.com', '+91 98000 00622',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (16+ Yrs Exp)', 'Food & Nutrition Specialist Level 2', 'Food & Nutrition',
    16, ARRAY['English', 'Hindi'], 4.70, 159, 2450,
    'Certified professional with 16 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000e00000000', '00000000-0000-0000-0000-000000000000', 'pooja_chopra_30_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000e00000000', 'Pooja Chopra', 'expert', 'pooja_chopra_30_14', 'pooja_chopra_30_14@demo.askexpert.com', '+91 98000 00623',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (17+ Yrs Exp)', 'Food & Nutrition Specialist Level 3', 'Food & Nutrition',
    17, ARRAY['English', 'Hindi'], 4.80, 166, 2600,
    'Certified professional with 17 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-000f00000000', '00000000-0000-0000-0000-000000000000', 'sanjay_jain_30_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-000f00000000', 'Sanjay Jain', 'expert', 'sanjay_jain_30_15', 'sanjay_jain_30_15@demo.askexpert.com', '+91 98000 00624',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (18+ Yrs Exp)', 'Food & Nutrition Specialist Level 1', 'Food & Nutrition',
    18, ARRAY['English', 'Hindi'], 4.90, 173, 500,
    'Certified professional with 18 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-001000000000', '00000000-0000-0000-0000-000000000000', 'tanvi_nair_30_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-001000000000', 'Tanvi Nair', 'expert', 'tanvi_nair_30_16', 'tanvi_nair_30_16@demo.askexpert.com', '+91 98000 00625',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (19+ Yrs Exp)', 'Food & Nutrition Specialist Level 2', 'Food & Nutrition',
    19, ARRAY['English', 'Hindi'], 4.20, 180, 650,
    'Certified professional with 19 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-001100000000', '00000000-0000-0000-0000-000000000000', 'varun_sharma_30_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-001100000000', 'Varun Sharma', 'expert', 'varun_sharma_30_17', 'varun_sharma_30_17@demo.askexpert.com', '+91 98000 00626',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (20+ Yrs Exp)', 'Food & Nutrition Specialist Level 3', 'Food & Nutrition',
    20, ARRAY['English', 'Hindi'], 4.30, 187, 800,
    'Certified professional with 20 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-001200000000', '00000000-0000-0000-0000-000000000000', 'divya_reddy_30_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-001200000000', 'Divya Reddy', 'expert', 'divya_reddy_30_18', 'divya_reddy_30_18@demo.askexpert.com', '+91 98000 00627',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (3+ Yrs Exp)', 'Food & Nutrition Specialist Level 1', 'Food & Nutrition',
    3, ARRAY['English', 'Hindi'], 4.40, 194, 950,
    'Certified professional with 3 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-001300000000', '00000000-0000-0000-0000-000000000000', 'gautam_kulkarni_30_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-001300000000', 'Gautam Kulkarni', 'expert', 'gautam_kulkarni_30_19', 'gautam_kulkarni_30_19@demo.askexpert.com', '+91 98000 00628',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (4+ Yrs Exp)', 'Food & Nutrition Specialist Level 2', 'Food & Nutrition',
    4, ARRAY['English', 'Hindi'], 4.50, 201, 1100,
    'Certified professional with 4 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-001400000000', '00000000-0000-0000-0000-000000000000', 'swati_malhotra_30_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-001400000000', 'Swati Malhotra', 'expert', 'swati_malhotra_30_20', 'swati_malhotra_30_20@demo.askexpert.com', '+91 98000 00629',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (5+ Yrs Exp)', 'Food & Nutrition Specialist Level 3', 'Food & Nutrition',
    5, ARRAY['English', 'Hindi'], 4.60, 208, 1250,
    'Certified professional with 5 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1e00-001500000000', '00000000-0000-0000-0000-000000000000', 'rajesh_bhattacharya_30_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1e00-001500000000', 'Rajesh Bhattacharya', 'expert', 'rajesh_bhattacharya_30_21', 'rajesh_bhattacharya_30_21@demo.askexpert.com', '+91 98000 00630',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Food & Nutrition (6+ Yrs Exp)', 'Food & Nutrition Specialist Level 1', 'Food & Nutrition',
    6, ARRAY['English', 'Hindi'], 4.70, 215, 1400,
    'Certified professional with 6 years of expertise in Food & Nutrition. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Food & Nutrition Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000100000000', '00000000-0000-0000-0000-000000000000', 'priya_reddy_31_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000100000000', 'Priya Reddy', 'expert', 'priya_reddy_31_1', 'priya_reddy_31_1@demo.askexpert.com', '+91 98000 00631',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (4+ Yrs Exp)', 'Fitness & Sports Specialist Level 2', 'Fitness & Sports',
    4, ARRAY['English', 'Hindi'], 4.30, 27, 650,
    'Certified professional with 4 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000200000000', '00000000-0000-0000-0000-000000000000', 'vikram_kulkarni_31_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000200000000', 'Vikram Kulkarni', 'expert', 'vikram_kulkarni_31_2', 'vikram_kulkarni_31_2@demo.askexpert.com', '+91 98000 00632',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (5+ Yrs Exp)', 'Fitness & Sports Specialist Level 3', 'Fitness & Sports',
    5, ARRAY['English', 'Hindi'], 4.40, 34, 800,
    'Certified professional with 5 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000300000000', '00000000-0000-0000-0000-000000000000', 'ananya_malhotra_31_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000300000000', 'Ananya Malhotra', 'expert', 'ananya_malhotra_31_3', 'ananya_malhotra_31_3@demo.askexpert.com', '+91 98000 00633',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (6+ Yrs Exp)', 'Fitness & Sports Specialist Level 1', 'Fitness & Sports',
    6, ARRAY['English', 'Hindi'], 4.50, 41, 950,
    'Certified professional with 6 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000400000000', '00000000-0000-0000-0000-000000000000', 'siddharth_bhattacharya_31_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000400000000', 'Siddharth Bhattacharya', 'expert', 'siddharth_bhattacharya_31_4', 'siddharth_bhattacharya_31_4@demo.askexpert.com', '+91 98000 00634',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (7+ Yrs Exp)', 'Fitness & Sports Specialist Level 2', 'Fitness & Sports',
    7, ARRAY['English', 'Hindi'], 4.60, 48, 1100,
    'Certified professional with 7 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000500000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_saxena_31_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000500000000', 'Meenakshi Saxena', 'expert', 'meenakshi_saxena_31_5', 'meenakshi_saxena_31_5@demo.askexpert.com', '+91 98000 00635',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (8+ Yrs Exp)', 'Fitness & Sports Specialist Level 3', 'Fitness & Sports',
    8, ARRAY['English', 'Hindi'], 4.70, 55, 1250,
    'Certified professional with 8 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000600000000', '00000000-0000-0000-0000-000000000000', 'amitabh_gupta_31_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000600000000', 'Amitabh Gupta', 'expert', 'amitabh_gupta_31_6', 'amitabh_gupta_31_6@demo.askexpert.com', '+91 98000 00636',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (9+ Yrs Exp)', 'Fitness & Sports Specialist Level 1', 'Fitness & Sports',
    9, ARRAY['English', 'Hindi'], 4.80, 62, 1400,
    'Certified professional with 9 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000700000000', '00000000-0000-0000-0000-000000000000', 'sunita_chopra_31_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000700000000', 'Sunita Chopra', 'expert', 'sunita_chopra_31_7', 'sunita_chopra_31_7@demo.askexpert.com', '+91 98000 00637',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (10+ Yrs Exp)', 'Fitness & Sports Specialist Level 2', 'Fitness & Sports',
    10, ARRAY['English', 'Hindi'], 4.90, 69, 1550,
    'Certified professional with 10 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000800000000', '00000000-0000-0000-0000-000000000000', 'rohan_jain_31_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000800000000', 'Rohan Jain', 'expert', 'rohan_jain_31_8', 'rohan_jain_31_8@demo.askexpert.com', '+91 98000 00638',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (11+ Yrs Exp)', 'Fitness & Sports Specialist Level 3', 'Fitness & Sports',
    11, ARRAY['English', 'Hindi'], 4.20, 76, 1700,
    'Certified professional with 11 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000900000000', '00000000-0000-0000-0000-000000000000', 'shalini_nair_31_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000900000000', 'Shalini Nair', 'expert', 'shalini_nair_31_9', 'shalini_nair_31_9@demo.askexpert.com', '+91 98000 00639',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (12+ Yrs Exp)', 'Fitness & Sports Specialist Level 1', 'Fitness & Sports',
    12, ARRAY['English', 'Hindi'], 4.30, 83, 1850,
    'Certified professional with 12 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000a00000000', '00000000-0000-0000-0000-000000000000', 'suresh_sharma_31_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000a00000000', 'Suresh Sharma', 'expert', 'suresh_sharma_31_10', 'suresh_sharma_31_10@demo.askexpert.com', '+91 98000 00640',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (13+ Yrs Exp)', 'Fitness & Sports Specialist Level 2', 'Fitness & Sports',
    13, ARRAY['English', 'Hindi'], 4.40, 90, 2000,
    'Certified professional with 13 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000b00000000', '00000000-0000-0000-0000-000000000000', 'ritu_reddy_31_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000b00000000', 'Ritu Reddy', 'expert', 'ritu_reddy_31_11', 'ritu_reddy_31_11@demo.askexpert.com', '+91 98000 00641',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (14+ Yrs Exp)', 'Fitness & Sports Specialist Level 3', 'Fitness & Sports',
    14, ARRAY['English', 'Hindi'], 4.50, 97, 2150,
    'Certified professional with 14 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000c00000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_kulkarni_31_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000c00000000', 'Vikramaditya Kulkarni', 'expert', 'vikramaditya_kulkarni_31_12', 'vikramaditya_kulkarni_31_12@demo.askexpert.com', '+91 98000 00642',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (15+ Yrs Exp)', 'Fitness & Sports Specialist Level 1', 'Fitness & Sports',
    15, ARRAY['English', 'Hindi'], 4.60, 104, 2300,
    'Certified professional with 15 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000d00000000', '00000000-0000-0000-0000-000000000000', 'deepa_malhotra_31_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000d00000000', 'Deepa Malhotra', 'expert', 'deepa_malhotra_31_13', 'deepa_malhotra_31_13@demo.askexpert.com', '+91 98000 00643',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (16+ Yrs Exp)', 'Fitness & Sports Specialist Level 2', 'Fitness & Sports',
    16, ARRAY['English', 'Hindi'], 4.70, 111, 2450,
    'Certified professional with 16 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000e00000000', '00000000-0000-0000-0000-000000000000', 'arvind_bhattacharya_31_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000e00000000', 'Arvind Bhattacharya', 'expert', 'arvind_bhattacharya_31_14', 'arvind_bhattacharya_31_14@demo.askexpert.com', '+91 98000 00644',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (17+ Yrs Exp)', 'Fitness & Sports Specialist Level 3', 'Fitness & Sports',
    17, ARRAY['English', 'Hindi'], 4.80, 118, 2600,
    'Certified professional with 17 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-000f00000000', '00000000-0000-0000-0000-000000000000', 'sneha_saxena_31_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-000f00000000', 'Sneha Saxena', 'expert', 'sneha_saxena_31_15', 'sneha_saxena_31_15@demo.askexpert.com', '+91 98000 00645',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (18+ Yrs Exp)', 'Fitness & Sports Specialist Level 1', 'Fitness & Sports',
    18, ARRAY['English', 'Hindi'], 4.90, 125, 500,
    'Certified professional with 18 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-001000000000', '00000000-0000-0000-0000-000000000000', 'karthik_gupta_31_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-001000000000', 'Karthik Gupta', 'expert', 'karthik_gupta_31_16', 'karthik_gupta_31_16@demo.askexpert.com', '+91 98000 00646',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (19+ Yrs Exp)', 'Fitness & Sports Specialist Level 2', 'Fitness & Sports',
    19, ARRAY['English', 'Hindi'], 4.20, 132, 650,
    'Certified professional with 19 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-001100000000', '00000000-0000-0000-0000-000000000000', 'neha_chopra_31_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-001100000000', 'Neha Chopra', 'expert', 'neha_chopra_31_17', 'neha_chopra_31_17@demo.askexpert.com', '+91 98000 00647',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (20+ Yrs Exp)', 'Fitness & Sports Specialist Level 3', 'Fitness & Sports',
    20, ARRAY['English', 'Hindi'], 4.30, 139, 800,
    'Certified professional with 20 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-001200000000', '00000000-0000-0000-0000-000000000000', 'devendra_jain_31_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-001200000000', 'Devendra Jain', 'expert', 'devendra_jain_31_18', 'devendra_jain_31_18@demo.askexpert.com', '+91 98000 00648',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (3+ Yrs Exp)', 'Fitness & Sports Specialist Level 1', 'Fitness & Sports',
    3, ARRAY['English', 'Hindi'], 4.40, 146, 950,
    'Certified professional with 3 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-001300000000', '00000000-0000-0000-0000-000000000000', 'preeti_nair_31_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-001300000000', 'Preeti Nair', 'expert', 'preeti_nair_31_19', 'preeti_nair_31_19@demo.askexpert.com', '+91 98000 00649',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (4+ Yrs Exp)', 'Fitness & Sports Specialist Level 2', 'Fitness & Sports',
    4, ARRAY['English', 'Hindi'], 4.50, 153, 1100,
    'Certified professional with 4 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-001400000000', '00000000-0000-0000-0000-000000000000', 'alok_sharma_31_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-001400000000', 'Alok Sharma', 'expert', 'alok_sharma_31_20', 'alok_sharma_31_20@demo.askexpert.com', '+91 98000 00650',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (5+ Yrs Exp)', 'Fitness & Sports Specialist Level 3', 'Fitness & Sports',
    5, ARRAY['English', 'Hindi'], 4.60, 160, 1250,
    'Certified professional with 5 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-1f00-001500000000', '00000000-0000-0000-0000-000000000000', 'kavita_reddy_31_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-1f00-001500000000', 'Kavita Reddy', 'expert', 'kavita_reddy_31_21', 'kavita_reddy_31_21@demo.askexpert.com', '+91 98000 00651',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Fitness & Sports (6+ Yrs Exp)', 'Fitness & Sports Specialist Level 1', 'Fitness & Sports',
    6, ARRAY['English', 'Hindi'], 4.70, 167, 1400,
    'Certified professional with 6 years of expertise in Fitness & Sports. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Fitness & Sports Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000100000000', '00000000-0000-0000-0000-000000000000', 'manish_jain_32_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000100000000', 'Manish Jain', 'expert', 'manish_jain_32_1', 'manish_jain_32_1@demo.askexpert.com', '+91 98000 00652',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (4+ Yrs Exp)', 'Education & Study Abroad Specialist Level 2', 'Education & Study Abroad',
    4, ARRAY['English', 'Hindi'], 4.30, 39, 650,
    'Certified professional with 4 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000200000000', '00000000-0000-0000-0000-000000000000', 'pooja_nair_32_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000200000000', 'Pooja Nair', 'expert', 'pooja_nair_32_2', 'pooja_nair_32_2@demo.askexpert.com', '+91 98000 00653',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (5+ Yrs Exp)', 'Education & Study Abroad Specialist Level 3', 'Education & Study Abroad',
    5, ARRAY['English', 'Hindi'], 4.40, 46, 800,
    'Certified professional with 5 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000300000000', '00000000-0000-0000-0000-000000000000', 'sanjay_sharma_32_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000300000000', 'Sanjay Sharma', 'expert', 'sanjay_sharma_32_3', 'sanjay_sharma_32_3@demo.askexpert.com', '+91 98000 00654',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (6+ Yrs Exp)', 'Education & Study Abroad Specialist Level 1', 'Education & Study Abroad',
    6, ARRAY['English', 'Hindi'], 4.50, 53, 950,
    'Certified professional with 6 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000400000000', '00000000-0000-0000-0000-000000000000', 'tanvi_reddy_32_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000400000000', 'Tanvi Reddy', 'expert', 'tanvi_reddy_32_4', 'tanvi_reddy_32_4@demo.askexpert.com', '+91 98000 00655',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (7+ Yrs Exp)', 'Education & Study Abroad Specialist Level 2', 'Education & Study Abroad',
    7, ARRAY['English', 'Hindi'], 4.60, 60, 1100,
    'Certified professional with 7 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000500000000', '00000000-0000-0000-0000-000000000000', 'varun_kulkarni_32_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000500000000', 'Varun Kulkarni', 'expert', 'varun_kulkarni_32_5', 'varun_kulkarni_32_5@demo.askexpert.com', '+91 98000 00656',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (8+ Yrs Exp)', 'Education & Study Abroad Specialist Level 3', 'Education & Study Abroad',
    8, ARRAY['English', 'Hindi'], 4.70, 67, 1250,
    'Certified professional with 8 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000600000000', '00000000-0000-0000-0000-000000000000', 'divya_malhotra_32_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000600000000', 'Divya Malhotra', 'expert', 'divya_malhotra_32_6', 'divya_malhotra_32_6@demo.askexpert.com', '+91 98000 00657',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (9+ Yrs Exp)', 'Education & Study Abroad Specialist Level 1', 'Education & Study Abroad',
    9, ARRAY['English', 'Hindi'], 4.80, 74, 1400,
    'Certified professional with 9 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000700000000', '00000000-0000-0000-0000-000000000000', 'gautam_bhattacharya_32_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000700000000', 'Gautam Bhattacharya', 'expert', 'gautam_bhattacharya_32_7', 'gautam_bhattacharya_32_7@demo.askexpert.com', '+91 98000 00658',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (10+ Yrs Exp)', 'Education & Study Abroad Specialist Level 2', 'Education & Study Abroad',
    10, ARRAY['English', 'Hindi'], 4.90, 81, 1550,
    'Certified professional with 10 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000800000000', '00000000-0000-0000-0000-000000000000', 'swati_saxena_32_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000800000000', 'Swati Saxena', 'expert', 'swati_saxena_32_8', 'swati_saxena_32_8@demo.askexpert.com', '+91 98000 00659',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (11+ Yrs Exp)', 'Education & Study Abroad Specialist Level 3', 'Education & Study Abroad',
    11, ARRAY['English', 'Hindi'], 4.20, 88, 1700,
    'Certified professional with 11 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000900000000', '00000000-0000-0000-0000-000000000000', 'rajesh_gupta_32_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000900000000', 'Rajesh Gupta', 'expert', 'rajesh_gupta_32_9', 'rajesh_gupta_32_9@demo.askexpert.com', '+91 98000 00660',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (12+ Yrs Exp)', 'Education & Study Abroad Specialist Level 1', 'Education & Study Abroad',
    12, ARRAY['English', 'Hindi'], 4.30, 95, 1850,
    'Certified professional with 12 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000a00000000', '00000000-0000-0000-0000-000000000000', 'priya_chopra_32_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000a00000000', 'Priya Chopra', 'expert', 'priya_chopra_32_10', 'priya_chopra_32_10@demo.askexpert.com', '+91 98000 00661',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (13+ Yrs Exp)', 'Education & Study Abroad Specialist Level 2', 'Education & Study Abroad',
    13, ARRAY['English', 'Hindi'], 4.40, 102, 2000,
    'Certified professional with 13 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000b00000000', '00000000-0000-0000-0000-000000000000', 'vikram_jain_32_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000b00000000', 'Vikram Jain', 'expert', 'vikram_jain_32_11', 'vikram_jain_32_11@demo.askexpert.com', '+91 98000 00662',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (14+ Yrs Exp)', 'Education & Study Abroad Specialist Level 3', 'Education & Study Abroad',
    14, ARRAY['English', 'Hindi'], 4.50, 109, 2150,
    'Certified professional with 14 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000c00000000', '00000000-0000-0000-0000-000000000000', 'ananya_nair_32_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000c00000000', 'Ananya Nair', 'expert', 'ananya_nair_32_12', 'ananya_nair_32_12@demo.askexpert.com', '+91 98000 00663',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (15+ Yrs Exp)', 'Education & Study Abroad Specialist Level 1', 'Education & Study Abroad',
    15, ARRAY['English', 'Hindi'], 4.60, 116, 2300,
    'Certified professional with 15 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000d00000000', '00000000-0000-0000-0000-000000000000', 'siddharth_sharma_32_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000d00000000', 'Siddharth Sharma', 'expert', 'siddharth_sharma_32_13', 'siddharth_sharma_32_13@demo.askexpert.com', '+91 98000 00664',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (16+ Yrs Exp)', 'Education & Study Abroad Specialist Level 2', 'Education & Study Abroad',
    16, ARRAY['English', 'Hindi'], 4.70, 123, 2450,
    'Certified professional with 16 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000e00000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_reddy_32_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000e00000000', 'Meenakshi Reddy', 'expert', 'meenakshi_reddy_32_14', 'meenakshi_reddy_32_14@demo.askexpert.com', '+91 98000 00665',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (17+ Yrs Exp)', 'Education & Study Abroad Specialist Level 3', 'Education & Study Abroad',
    17, ARRAY['English', 'Hindi'], 4.80, 130, 2600,
    'Certified professional with 17 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-000f00000000', '00000000-0000-0000-0000-000000000000', 'amitabh_kulkarni_32_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-000f00000000', 'Amitabh Kulkarni', 'expert', 'amitabh_kulkarni_32_15', 'amitabh_kulkarni_32_15@demo.askexpert.com', '+91 98000 00666',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (18+ Yrs Exp)', 'Education & Study Abroad Specialist Level 1', 'Education & Study Abroad',
    18, ARRAY['English', 'Hindi'], 4.90, 137, 500,
    'Certified professional with 18 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-001000000000', '00000000-0000-0000-0000-000000000000', 'sunita_malhotra_32_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-001000000000', 'Sunita Malhotra', 'expert', 'sunita_malhotra_32_16', 'sunita_malhotra_32_16@demo.askexpert.com', '+91 98000 00667',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (19+ Yrs Exp)', 'Education & Study Abroad Specialist Level 2', 'Education & Study Abroad',
    19, ARRAY['English', 'Hindi'], 4.20, 144, 650,
    'Certified professional with 19 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-001100000000', '00000000-0000-0000-0000-000000000000', 'rohan_bhattacharya_32_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-001100000000', 'Rohan Bhattacharya', 'expert', 'rohan_bhattacharya_32_17', 'rohan_bhattacharya_32_17@demo.askexpert.com', '+91 98000 00668',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (20+ Yrs Exp)', 'Education & Study Abroad Specialist Level 3', 'Education & Study Abroad',
    20, ARRAY['English', 'Hindi'], 4.30, 151, 800,
    'Certified professional with 20 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-001200000000', '00000000-0000-0000-0000-000000000000', 'shalini_saxena_32_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-001200000000', 'Shalini Saxena', 'expert', 'shalini_saxena_32_18', 'shalini_saxena_32_18@demo.askexpert.com', '+91 98000 00669',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (3+ Yrs Exp)', 'Education & Study Abroad Specialist Level 1', 'Education & Study Abroad',
    3, ARRAY['English', 'Hindi'], 4.40, 158, 950,
    'Certified professional with 3 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-001300000000', '00000000-0000-0000-0000-000000000000', 'suresh_gupta_32_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-001300000000', 'Suresh Gupta', 'expert', 'suresh_gupta_32_19', 'suresh_gupta_32_19@demo.askexpert.com', '+91 98000 00670',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (4+ Yrs Exp)', 'Education & Study Abroad Specialist Level 2', 'Education & Study Abroad',
    4, ARRAY['English', 'Hindi'], 4.50, 165, 1100,
    'Certified professional with 4 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-001400000000', '00000000-0000-0000-0000-000000000000', 'ritu_chopra_32_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-001400000000', 'Ritu Chopra', 'expert', 'ritu_chopra_32_20', 'ritu_chopra_32_20@demo.askexpert.com', '+91 98000 00671',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (5+ Yrs Exp)', 'Education & Study Abroad Specialist Level 3', 'Education & Study Abroad',
    5, ARRAY['English', 'Hindi'], 4.60, 172, 1250,
    'Certified professional with 5 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2000-001500000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_jain_32_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2000-001500000000', 'Vikramaditya Jain', 'expert', 'vikramaditya_jain_32_21', 'vikramaditya_jain_32_21@demo.askexpert.com', '+91 98000 00672',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Education & Study Abroad (6+ Yrs Exp)', 'Education & Study Abroad Specialist Level 1', 'Education & Study Abroad',
    6, ARRAY['English', 'Hindi'], 4.70, 179, 1400,
    'Certified professional with 6 years of expertise in Education & Study Abroad. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Education & Study Abroad Advisory', 'Consultation', 'Strategy'],
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

END $;

-- ENSURE ALL EXPERTS HAVE IS_VERIFIED = TRUE
UPDATE public.profiles SET is_verified = true WHERE role = 'expert';

SELECT count(*) AS chunk_4_demo_experts FROM public.profiles WHERE is_demo = true;
