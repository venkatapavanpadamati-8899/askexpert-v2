-- ==============================================================================
-- ASKEXPERT - SEED CHUNK 5 OF 5 (CATEGORIES 33 TO 40)
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
    'a0000000-0000-0000-2100-000100000000', '00000000-0000-0000-0000-000000000000', 'deepa_saxena_33_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000100000000', 'Deepa Saxena', 'expert', 'deepa_saxena_33_1', 'deepa_saxena_33_1@demo.askexpert.com', '+91 98000 00673',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (4+ Yrs Exp)', 'Digital Marketing Specialist Level 2', 'Digital Marketing',
    4, ARRAY['English', 'Hindi'], 4.30, 51, 650,
    'Certified professional with 4 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000200000000', '00000000-0000-0000-0000-000000000000', 'arvind_gupta_33_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000200000000', 'Arvind Gupta', 'expert', 'arvind_gupta_33_2', 'arvind_gupta_33_2@demo.askexpert.com', '+91 98000 00674',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (5+ Yrs Exp)', 'Digital Marketing Specialist Level 3', 'Digital Marketing',
    5, ARRAY['English', 'Hindi'], 4.40, 58, 800,
    'Certified professional with 5 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000300000000', '00000000-0000-0000-0000-000000000000', 'sneha_chopra_33_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000300000000', 'Sneha Chopra', 'expert', 'sneha_chopra_33_3', 'sneha_chopra_33_3@demo.askexpert.com', '+91 98000 00675',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (6+ Yrs Exp)', 'Digital Marketing Specialist Level 1', 'Digital Marketing',
    6, ARRAY['English', 'Hindi'], 4.50, 65, 950,
    'Certified professional with 6 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000400000000', '00000000-0000-0000-0000-000000000000', 'karthik_jain_33_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000400000000', 'Karthik Jain', 'expert', 'karthik_jain_33_4', 'karthik_jain_33_4@demo.askexpert.com', '+91 98000 00676',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (7+ Yrs Exp)', 'Digital Marketing Specialist Level 2', 'Digital Marketing',
    7, ARRAY['English', 'Hindi'], 4.60, 72, 1100,
    'Certified professional with 7 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000500000000', '00000000-0000-0000-0000-000000000000', 'neha_nair_33_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000500000000', 'Neha Nair', 'expert', 'neha_nair_33_5', 'neha_nair_33_5@demo.askexpert.com', '+91 98000 00677',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (8+ Yrs Exp)', 'Digital Marketing Specialist Level 3', 'Digital Marketing',
    8, ARRAY['English', 'Hindi'], 4.70, 79, 1250,
    'Certified professional with 8 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000600000000', '00000000-0000-0000-0000-000000000000', 'devendra_sharma_33_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000600000000', 'Devendra Sharma', 'expert', 'devendra_sharma_33_6', 'devendra_sharma_33_6@demo.askexpert.com', '+91 98000 00678',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (9+ Yrs Exp)', 'Digital Marketing Specialist Level 1', 'Digital Marketing',
    9, ARRAY['English', 'Hindi'], 4.80, 86, 1400,
    'Certified professional with 9 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000700000000', '00000000-0000-0000-0000-000000000000', 'preeti_reddy_33_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000700000000', 'Preeti Reddy', 'expert', 'preeti_reddy_33_7', 'preeti_reddy_33_7@demo.askexpert.com', '+91 98000 00679',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (10+ Yrs Exp)', 'Digital Marketing Specialist Level 2', 'Digital Marketing',
    10, ARRAY['English', 'Hindi'], 4.90, 93, 1550,
    'Certified professional with 10 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000800000000', '00000000-0000-0000-0000-000000000000', 'alok_kulkarni_33_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000800000000', 'Alok Kulkarni', 'expert', 'alok_kulkarni_33_8', 'alok_kulkarni_33_8@demo.askexpert.com', '+91 98000 00680',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (11+ Yrs Exp)', 'Digital Marketing Specialist Level 3', 'Digital Marketing',
    11, ARRAY['English', 'Hindi'], 4.20, 100, 1700,
    'Certified professional with 11 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000900000000', '00000000-0000-0000-0000-000000000000', 'kavita_malhotra_33_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000900000000', 'Kavita Malhotra', 'expert', 'kavita_malhotra_33_9', 'kavita_malhotra_33_9@demo.askexpert.com', '+91 98000 00681',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (12+ Yrs Exp)', 'Digital Marketing Specialist Level 1', 'Digital Marketing',
    12, ARRAY['English', 'Hindi'], 4.30, 107, 1850,
    'Certified professional with 12 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000a00000000', '00000000-0000-0000-0000-000000000000', 'manish_bhattacharya_33_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000a00000000', 'Manish Bhattacharya', 'expert', 'manish_bhattacharya_33_10', 'manish_bhattacharya_33_10@demo.askexpert.com', '+91 98000 00682',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (13+ Yrs Exp)', 'Digital Marketing Specialist Level 2', 'Digital Marketing',
    13, ARRAY['English', 'Hindi'], 4.40, 114, 2000,
    'Certified professional with 13 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000b00000000', '00000000-0000-0000-0000-000000000000', 'pooja_saxena_33_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000b00000000', 'Pooja Saxena', 'expert', 'pooja_saxena_33_11', 'pooja_saxena_33_11@demo.askexpert.com', '+91 98000 00683',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (14+ Yrs Exp)', 'Digital Marketing Specialist Level 3', 'Digital Marketing',
    14, ARRAY['English', 'Hindi'], 4.50, 121, 2150,
    'Certified professional with 14 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000c00000000', '00000000-0000-0000-0000-000000000000', 'sanjay_gupta_33_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000c00000000', 'Sanjay Gupta', 'expert', 'sanjay_gupta_33_12', 'sanjay_gupta_33_12@demo.askexpert.com', '+91 98000 00684',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (15+ Yrs Exp)', 'Digital Marketing Specialist Level 1', 'Digital Marketing',
    15, ARRAY['English', 'Hindi'], 4.60, 128, 2300,
    'Certified professional with 15 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000d00000000', '00000000-0000-0000-0000-000000000000', 'tanvi_chopra_33_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000d00000000', 'Tanvi Chopra', 'expert', 'tanvi_chopra_33_13', 'tanvi_chopra_33_13@demo.askexpert.com', '+91 98000 00685',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (16+ Yrs Exp)', 'Digital Marketing Specialist Level 2', 'Digital Marketing',
    16, ARRAY['English', 'Hindi'], 4.70, 135, 2450,
    'Certified professional with 16 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000e00000000', '00000000-0000-0000-0000-000000000000', 'varun_jain_33_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000e00000000', 'Varun Jain', 'expert', 'varun_jain_33_14', 'varun_jain_33_14@demo.askexpert.com', '+91 98000 00686',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (17+ Yrs Exp)', 'Digital Marketing Specialist Level 3', 'Digital Marketing',
    17, ARRAY['English', 'Hindi'], 4.80, 142, 2600,
    'Certified professional with 17 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-000f00000000', '00000000-0000-0000-0000-000000000000', 'divya_nair_33_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-000f00000000', 'Divya Nair', 'expert', 'divya_nair_33_15', 'divya_nair_33_15@demo.askexpert.com', '+91 98000 00687',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (18+ Yrs Exp)', 'Digital Marketing Specialist Level 1', 'Digital Marketing',
    18, ARRAY['English', 'Hindi'], 4.90, 149, 500,
    'Certified professional with 18 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-001000000000', '00000000-0000-0000-0000-000000000000', 'gautam_sharma_33_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-001000000000', 'Gautam Sharma', 'expert', 'gautam_sharma_33_16', 'gautam_sharma_33_16@demo.askexpert.com', '+91 98000 00688',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (19+ Yrs Exp)', 'Digital Marketing Specialist Level 2', 'Digital Marketing',
    19, ARRAY['English', 'Hindi'], 4.20, 156, 650,
    'Certified professional with 19 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-001100000000', '00000000-0000-0000-0000-000000000000', 'swati_reddy_33_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-001100000000', 'Swati Reddy', 'expert', 'swati_reddy_33_17', 'swati_reddy_33_17@demo.askexpert.com', '+91 98000 00689',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (20+ Yrs Exp)', 'Digital Marketing Specialist Level 3', 'Digital Marketing',
    20, ARRAY['English', 'Hindi'], 4.30, 163, 800,
    'Certified professional with 20 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-001200000000', '00000000-0000-0000-0000-000000000000', 'rajesh_kulkarni_33_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-001200000000', 'Rajesh Kulkarni', 'expert', 'rajesh_kulkarni_33_18', 'rajesh_kulkarni_33_18@demo.askexpert.com', '+91 98000 00690',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (3+ Yrs Exp)', 'Digital Marketing Specialist Level 1', 'Digital Marketing',
    3, ARRAY['English', 'Hindi'], 4.40, 170, 950,
    'Certified professional with 3 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-001300000000', '00000000-0000-0000-0000-000000000000', 'priya_malhotra_33_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-001300000000', 'Priya Malhotra', 'expert', 'priya_malhotra_33_19', 'priya_malhotra_33_19@demo.askexpert.com', '+91 98000 00691',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (4+ Yrs Exp)', 'Digital Marketing Specialist Level 2', 'Digital Marketing',
    4, ARRAY['English', 'Hindi'], 4.50, 177, 1100,
    'Certified professional with 4 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-001400000000', '00000000-0000-0000-0000-000000000000', 'vikram_bhattacharya_33_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-001400000000', 'Vikram Bhattacharya', 'expert', 'vikram_bhattacharya_33_20', 'vikram_bhattacharya_33_20@demo.askexpert.com', '+91 98000 00692',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (5+ Yrs Exp)', 'Digital Marketing Specialist Level 3', 'Digital Marketing',
    5, ARRAY['English', 'Hindi'], 4.60, 184, 1250,
    'Certified professional with 5 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2100-001500000000', '00000000-0000-0000-0000-000000000000', 'ananya_saxena_33_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2100-001500000000', 'Ananya Saxena', 'expert', 'ananya_saxena_33_21', 'ananya_saxena_33_21@demo.askexpert.com', '+91 98000 00693',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Digital Marketing (6+ Yrs Exp)', 'Digital Marketing Specialist Level 1', 'Digital Marketing',
    6, ARRAY['English', 'Hindi'], 4.70, 191, 1400,
    'Certified professional with 6 years of expertise in Digital Marketing. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Digital Marketing Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000100000000', '00000000-0000-0000-0000-000000000000', 'siddharth_kulkarni_34_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000100000000', 'Siddharth Kulkarni', 'expert', 'siddharth_kulkarni_34_1', 'siddharth_kulkarni_34_1@demo.askexpert.com', '+91 98000 00694',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (4+ Yrs Exp)', 'Design & UI/UX Specialist Level 2', 'Design & UI/UX',
    4, ARRAY['English', 'Hindi'], 4.30, 63, 650,
    'Certified professional with 4 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000200000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_malhotra_34_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000200000000', 'Meenakshi Malhotra', 'expert', 'meenakshi_malhotra_34_2', 'meenakshi_malhotra_34_2@demo.askexpert.com', '+91 98000 00695',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (5+ Yrs Exp)', 'Design & UI/UX Specialist Level 3', 'Design & UI/UX',
    5, ARRAY['English', 'Hindi'], 4.40, 70, 800,
    'Certified professional with 5 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000300000000', '00000000-0000-0000-0000-000000000000', 'amitabh_bhattacharya_34_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000300000000', 'Amitabh Bhattacharya', 'expert', 'amitabh_bhattacharya_34_3', 'amitabh_bhattacharya_34_3@demo.askexpert.com', '+91 98000 00696',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (6+ Yrs Exp)', 'Design & UI/UX Specialist Level 1', 'Design & UI/UX',
    6, ARRAY['English', 'Hindi'], 4.50, 77, 950,
    'Certified professional with 6 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000400000000', '00000000-0000-0000-0000-000000000000', 'sunita_saxena_34_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000400000000', 'Sunita Saxena', 'expert', 'sunita_saxena_34_4', 'sunita_saxena_34_4@demo.askexpert.com', '+91 98000 00697',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (7+ Yrs Exp)', 'Design & UI/UX Specialist Level 2', 'Design & UI/UX',
    7, ARRAY['English', 'Hindi'], 4.60, 84, 1100,
    'Certified professional with 7 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000500000000', '00000000-0000-0000-0000-000000000000', 'rohan_gupta_34_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000500000000', 'Rohan Gupta', 'expert', 'rohan_gupta_34_5', 'rohan_gupta_34_5@demo.askexpert.com', '+91 98000 00698',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (8+ Yrs Exp)', 'Design & UI/UX Specialist Level 3', 'Design & UI/UX',
    8, ARRAY['English', 'Hindi'], 4.70, 91, 1250,
    'Certified professional with 8 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000600000000', '00000000-0000-0000-0000-000000000000', 'shalini_chopra_34_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000600000000', 'Shalini Chopra', 'expert', 'shalini_chopra_34_6', 'shalini_chopra_34_6@demo.askexpert.com', '+91 98000 00699',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (9+ Yrs Exp)', 'Design & UI/UX Specialist Level 1', 'Design & UI/UX',
    9, ARRAY['English', 'Hindi'], 4.80, 98, 1400,
    'Certified professional with 9 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000700000000', '00000000-0000-0000-0000-000000000000', 'suresh_jain_34_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000700000000', 'Suresh Jain', 'expert', 'suresh_jain_34_7', 'suresh_jain_34_7@demo.askexpert.com', '+91 98000 00700',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (10+ Yrs Exp)', 'Design & UI/UX Specialist Level 2', 'Design & UI/UX',
    10, ARRAY['English', 'Hindi'], 4.90, 105, 1550,
    'Certified professional with 10 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000800000000', '00000000-0000-0000-0000-000000000000', 'ritu_nair_34_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000800000000', 'Ritu Nair', 'expert', 'ritu_nair_34_8', 'ritu_nair_34_8@demo.askexpert.com', '+91 98000 00701',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (11+ Yrs Exp)', 'Design & UI/UX Specialist Level 3', 'Design & UI/UX',
    11, ARRAY['English', 'Hindi'], 4.20, 112, 1700,
    'Certified professional with 11 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000900000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_sharma_34_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000900000000', 'Vikramaditya Sharma', 'expert', 'vikramaditya_sharma_34_9', 'vikramaditya_sharma_34_9@demo.askexpert.com', '+91 98000 00702',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (12+ Yrs Exp)', 'Design & UI/UX Specialist Level 1', 'Design & UI/UX',
    12, ARRAY['English', 'Hindi'], 4.30, 119, 1850,
    'Certified professional with 12 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000a00000000', '00000000-0000-0000-0000-000000000000', 'deepa_reddy_34_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000a00000000', 'Deepa Reddy', 'expert', 'deepa_reddy_34_10', 'deepa_reddy_34_10@demo.askexpert.com', '+91 98000 00703',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (13+ Yrs Exp)', 'Design & UI/UX Specialist Level 2', 'Design & UI/UX',
    13, ARRAY['English', 'Hindi'], 4.40, 126, 2000,
    'Certified professional with 13 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000b00000000', '00000000-0000-0000-0000-000000000000', 'arvind_kulkarni_34_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000b00000000', 'Arvind Kulkarni', 'expert', 'arvind_kulkarni_34_11', 'arvind_kulkarni_34_11@demo.askexpert.com', '+91 98000 00704',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (14+ Yrs Exp)', 'Design & UI/UX Specialist Level 3', 'Design & UI/UX',
    14, ARRAY['English', 'Hindi'], 4.50, 133, 2150,
    'Certified professional with 14 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000c00000000', '00000000-0000-0000-0000-000000000000', 'sneha_malhotra_34_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000c00000000', 'Sneha Malhotra', 'expert', 'sneha_malhotra_34_12', 'sneha_malhotra_34_12@demo.askexpert.com', '+91 98000 00705',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (15+ Yrs Exp)', 'Design & UI/UX Specialist Level 1', 'Design & UI/UX',
    15, ARRAY['English', 'Hindi'], 4.60, 140, 2300,
    'Certified professional with 15 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000d00000000', '00000000-0000-0000-0000-000000000000', 'karthik_bhattacharya_34_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000d00000000', 'Karthik Bhattacharya', 'expert', 'karthik_bhattacharya_34_13', 'karthik_bhattacharya_34_13@demo.askexpert.com', '+91 98000 00706',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (16+ Yrs Exp)', 'Design & UI/UX Specialist Level 2', 'Design & UI/UX',
    16, ARRAY['English', 'Hindi'], 4.70, 147, 2450,
    'Certified professional with 16 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000e00000000', '00000000-0000-0000-0000-000000000000', 'neha_saxena_34_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000e00000000', 'Neha Saxena', 'expert', 'neha_saxena_34_14', 'neha_saxena_34_14@demo.askexpert.com', '+91 98000 00707',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (17+ Yrs Exp)', 'Design & UI/UX Specialist Level 3', 'Design & UI/UX',
    17, ARRAY['English', 'Hindi'], 4.80, 154, 2600,
    'Certified professional with 17 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-000f00000000', '00000000-0000-0000-0000-000000000000', 'devendra_gupta_34_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-000f00000000', 'Devendra Gupta', 'expert', 'devendra_gupta_34_15', 'devendra_gupta_34_15@demo.askexpert.com', '+91 98000 00708',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (18+ Yrs Exp)', 'Design & UI/UX Specialist Level 1', 'Design & UI/UX',
    18, ARRAY['English', 'Hindi'], 4.90, 161, 500,
    'Certified professional with 18 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-001000000000', '00000000-0000-0000-0000-000000000000', 'preeti_chopra_34_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-001000000000', 'Preeti Chopra', 'expert', 'preeti_chopra_34_16', 'preeti_chopra_34_16@demo.askexpert.com', '+91 98000 00709',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (19+ Yrs Exp)', 'Design & UI/UX Specialist Level 2', 'Design & UI/UX',
    19, ARRAY['English', 'Hindi'], 4.20, 168, 650,
    'Certified professional with 19 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-001100000000', '00000000-0000-0000-0000-000000000000', 'alok_jain_34_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-001100000000', 'Alok Jain', 'expert', 'alok_jain_34_17', 'alok_jain_34_17@demo.askexpert.com', '+91 98000 00710',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (20+ Yrs Exp)', 'Design & UI/UX Specialist Level 3', 'Design & UI/UX',
    20, ARRAY['English', 'Hindi'], 4.30, 175, 800,
    'Certified professional with 20 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-001200000000', '00000000-0000-0000-0000-000000000000', 'kavita_nair_34_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-001200000000', 'Kavita Nair', 'expert', 'kavita_nair_34_18', 'kavita_nair_34_18@demo.askexpert.com', '+91 98000 00711',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (3+ Yrs Exp)', 'Design & UI/UX Specialist Level 1', 'Design & UI/UX',
    3, ARRAY['English', 'Hindi'], 4.40, 182, 950,
    'Certified professional with 3 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-001300000000', '00000000-0000-0000-0000-000000000000', 'manish_sharma_34_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-001300000000', 'Manish Sharma', 'expert', 'manish_sharma_34_19', 'manish_sharma_34_19@demo.askexpert.com', '+91 98000 00712',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (4+ Yrs Exp)', 'Design & UI/UX Specialist Level 2', 'Design & UI/UX',
    4, ARRAY['English', 'Hindi'], 4.50, 189, 1100,
    'Certified professional with 4 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-001400000000', '00000000-0000-0000-0000-000000000000', 'pooja_reddy_34_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-001400000000', 'Pooja Reddy', 'expert', 'pooja_reddy_34_20', 'pooja_reddy_34_20@demo.askexpert.com', '+91 98000 00713',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (5+ Yrs Exp)', 'Design & UI/UX Specialist Level 3', 'Design & UI/UX',
    5, ARRAY['English', 'Hindi'], 4.60, 196, 1250,
    'Certified professional with 5 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2200-001500000000', '00000000-0000-0000-0000-000000000000', 'sanjay_kulkarni_34_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2200-001500000000', 'Sanjay Kulkarni', 'expert', 'sanjay_kulkarni_34_21', 'sanjay_kulkarni_34_21@demo.askexpert.com', '+91 98000 00714',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Design & UI/UX (6+ Yrs Exp)', 'Design & UI/UX Specialist Level 1', 'Design & UI/UX',
    6, ARRAY['English', 'Hindi'], 4.70, 203, 1400,
    'Certified professional with 6 years of expertise in Design & UI/UX. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Design & UI/UX Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000100000000', '00000000-0000-0000-0000-000000000000', 'tanvi_nair_35_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000100000000', 'Tanvi Nair', 'expert', 'tanvi_nair_35_1', 'tanvi_nair_35_1@demo.askexpert.com', '+91 98000 00715',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (4+ Yrs Exp)', 'Software Development Specialist Level 2', 'Software Development',
    4, ARRAY['English', 'Hindi'], 4.30, 75, 650,
    'Certified professional with 4 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000200000000', '00000000-0000-0000-0000-000000000000', 'varun_sharma_35_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000200000000', 'Varun Sharma', 'expert', 'varun_sharma_35_2', 'varun_sharma_35_2@demo.askexpert.com', '+91 98000 00716',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (5+ Yrs Exp)', 'Software Development Specialist Level 3', 'Software Development',
    5, ARRAY['English', 'Hindi'], 4.40, 82, 800,
    'Certified professional with 5 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000300000000', '00000000-0000-0000-0000-000000000000', 'divya_reddy_35_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000300000000', 'Divya Reddy', 'expert', 'divya_reddy_35_3', 'divya_reddy_35_3@demo.askexpert.com', '+91 98000 00717',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (6+ Yrs Exp)', 'Software Development Specialist Level 1', 'Software Development',
    6, ARRAY['English', 'Hindi'], 4.50, 89, 950,
    'Certified professional with 6 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000400000000', '00000000-0000-0000-0000-000000000000', 'gautam_kulkarni_35_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000400000000', 'Gautam Kulkarni', 'expert', 'gautam_kulkarni_35_4', 'gautam_kulkarni_35_4@demo.askexpert.com', '+91 98000 00718',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (7+ Yrs Exp)', 'Software Development Specialist Level 2', 'Software Development',
    7, ARRAY['English', 'Hindi'], 4.60, 96, 1100,
    'Certified professional with 7 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000500000000', '00000000-0000-0000-0000-000000000000', 'swati_malhotra_35_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000500000000', 'Swati Malhotra', 'expert', 'swati_malhotra_35_5', 'swati_malhotra_35_5@demo.askexpert.com', '+91 98000 00719',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (8+ Yrs Exp)', 'Software Development Specialist Level 3', 'Software Development',
    8, ARRAY['English', 'Hindi'], 4.70, 103, 1250,
    'Certified professional with 8 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000600000000', '00000000-0000-0000-0000-000000000000', 'rajesh_bhattacharya_35_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000600000000', 'Rajesh Bhattacharya', 'expert', 'rajesh_bhattacharya_35_6', 'rajesh_bhattacharya_35_6@demo.askexpert.com', '+91 98000 00720',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (9+ Yrs Exp)', 'Software Development Specialist Level 1', 'Software Development',
    9, ARRAY['English', 'Hindi'], 4.80, 110, 1400,
    'Certified professional with 9 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000700000000', '00000000-0000-0000-0000-000000000000', 'priya_saxena_35_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000700000000', 'Priya Saxena', 'expert', 'priya_saxena_35_7', 'priya_saxena_35_7@demo.askexpert.com', '+91 98000 00721',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (10+ Yrs Exp)', 'Software Development Specialist Level 2', 'Software Development',
    10, ARRAY['English', 'Hindi'], 4.90, 117, 1550,
    'Certified professional with 10 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000800000000', '00000000-0000-0000-0000-000000000000', 'vikram_gupta_35_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000800000000', 'Vikram Gupta', 'expert', 'vikram_gupta_35_8', 'vikram_gupta_35_8@demo.askexpert.com', '+91 98000 00722',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (11+ Yrs Exp)', 'Software Development Specialist Level 3', 'Software Development',
    11, ARRAY['English', 'Hindi'], 4.20, 124, 1700,
    'Certified professional with 11 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000900000000', '00000000-0000-0000-0000-000000000000', 'ananya_chopra_35_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000900000000', 'Ananya Chopra', 'expert', 'ananya_chopra_35_9', 'ananya_chopra_35_9@demo.askexpert.com', '+91 98000 00723',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (12+ Yrs Exp)', 'Software Development Specialist Level 1', 'Software Development',
    12, ARRAY['English', 'Hindi'], 4.30, 131, 1850,
    'Certified professional with 12 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000a00000000', '00000000-0000-0000-0000-000000000000', 'siddharth_jain_35_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000a00000000', 'Siddharth Jain', 'expert', 'siddharth_jain_35_10', 'siddharth_jain_35_10@demo.askexpert.com', '+91 98000 00724',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (13+ Yrs Exp)', 'Software Development Specialist Level 2', 'Software Development',
    13, ARRAY['English', 'Hindi'], 4.40, 138, 2000,
    'Certified professional with 13 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000b00000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_nair_35_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000b00000000', 'Meenakshi Nair', 'expert', 'meenakshi_nair_35_11', 'meenakshi_nair_35_11@demo.askexpert.com', '+91 98000 00725',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (14+ Yrs Exp)', 'Software Development Specialist Level 3', 'Software Development',
    14, ARRAY['English', 'Hindi'], 4.50, 145, 2150,
    'Certified professional with 14 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000c00000000', '00000000-0000-0000-0000-000000000000', 'amitabh_sharma_35_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000c00000000', 'Amitabh Sharma', 'expert', 'amitabh_sharma_35_12', 'amitabh_sharma_35_12@demo.askexpert.com', '+91 98000 00726',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (15+ Yrs Exp)', 'Software Development Specialist Level 1', 'Software Development',
    15, ARRAY['English', 'Hindi'], 4.60, 152, 2300,
    'Certified professional with 15 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000d00000000', '00000000-0000-0000-0000-000000000000', 'sunita_reddy_35_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000d00000000', 'Sunita Reddy', 'expert', 'sunita_reddy_35_13', 'sunita_reddy_35_13@demo.askexpert.com', '+91 98000 00727',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (16+ Yrs Exp)', 'Software Development Specialist Level 2', 'Software Development',
    16, ARRAY['English', 'Hindi'], 4.70, 159, 2450,
    'Certified professional with 16 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000e00000000', '00000000-0000-0000-0000-000000000000', 'rohan_kulkarni_35_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000e00000000', 'Rohan Kulkarni', 'expert', 'rohan_kulkarni_35_14', 'rohan_kulkarni_35_14@demo.askexpert.com', '+91 98000 00728',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (17+ Yrs Exp)', 'Software Development Specialist Level 3', 'Software Development',
    17, ARRAY['English', 'Hindi'], 4.80, 166, 2600,
    'Certified professional with 17 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-000f00000000', '00000000-0000-0000-0000-000000000000', 'shalini_malhotra_35_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-000f00000000', 'Shalini Malhotra', 'expert', 'shalini_malhotra_35_15', 'shalini_malhotra_35_15@demo.askexpert.com', '+91 98000 00729',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (18+ Yrs Exp)', 'Software Development Specialist Level 1', 'Software Development',
    18, ARRAY['English', 'Hindi'], 4.90, 173, 500,
    'Certified professional with 18 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-001000000000', '00000000-0000-0000-0000-000000000000', 'suresh_bhattacharya_35_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-001000000000', 'Suresh Bhattacharya', 'expert', 'suresh_bhattacharya_35_16', 'suresh_bhattacharya_35_16@demo.askexpert.com', '+91 98000 00730',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (19+ Yrs Exp)', 'Software Development Specialist Level 2', 'Software Development',
    19, ARRAY['English', 'Hindi'], 4.20, 180, 650,
    'Certified professional with 19 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-001100000000', '00000000-0000-0000-0000-000000000000', 'ritu_saxena_35_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-001100000000', 'Ritu Saxena', 'expert', 'ritu_saxena_35_17', 'ritu_saxena_35_17@demo.askexpert.com', '+91 98000 00731',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (20+ Yrs Exp)', 'Software Development Specialist Level 3', 'Software Development',
    20, ARRAY['English', 'Hindi'], 4.30, 187, 800,
    'Certified professional with 20 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-001200000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_gupta_35_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-001200000000', 'Vikramaditya Gupta', 'expert', 'vikramaditya_gupta_35_18', 'vikramaditya_gupta_35_18@demo.askexpert.com', '+91 98000 00732',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (3+ Yrs Exp)', 'Software Development Specialist Level 1', 'Software Development',
    3, ARRAY['English', 'Hindi'], 4.40, 194, 950,
    'Certified professional with 3 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-001300000000', '00000000-0000-0000-0000-000000000000', 'deepa_chopra_35_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-001300000000', 'Deepa Chopra', 'expert', 'deepa_chopra_35_19', 'deepa_chopra_35_19@demo.askexpert.com', '+91 98000 00733',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (4+ Yrs Exp)', 'Software Development Specialist Level 2', 'Software Development',
    4, ARRAY['English', 'Hindi'], 4.50, 201, 1100,
    'Certified professional with 4 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-001400000000', '00000000-0000-0000-0000-000000000000', 'arvind_jain_35_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-001400000000', 'Arvind Jain', 'expert', 'arvind_jain_35_20', 'arvind_jain_35_20@demo.askexpert.com', '+91 98000 00734',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (5+ Yrs Exp)', 'Software Development Specialist Level 3', 'Software Development',
    5, ARRAY['English', 'Hindi'], 4.60, 208, 1250,
    'Certified professional with 5 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2300-001500000000', '00000000-0000-0000-0000-000000000000', 'sneha_nair_35_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2300-001500000000', 'Sneha Nair', 'expert', 'sneha_nair_35_21', 'sneha_nair_35_21@demo.askexpert.com', '+91 98000 00735',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Software Development (6+ Yrs Exp)', 'Software Development Specialist Level 1', 'Software Development',
    6, ARRAY['English', 'Hindi'], 4.70, 215, 1400,
    'Certified professional with 6 years of expertise in Software Development. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Software Development Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000100000000', '00000000-0000-0000-0000-000000000000', 'karthik_gupta_36_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000100000000', 'Karthik Gupta', 'expert', 'karthik_gupta_36_1', 'karthik_gupta_36_1@demo.askexpert.com', '+91 98000 00736',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (4+ Yrs Exp)', 'Cloud & DevOps Specialist Level 2', 'Cloud & DevOps',
    4, ARRAY['English', 'Hindi'], 4.30, 27, 650,
    'Certified professional with 4 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000200000000', '00000000-0000-0000-0000-000000000000', 'neha_chopra_36_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000200000000', 'Neha Chopra', 'expert', 'neha_chopra_36_2', 'neha_chopra_36_2@demo.askexpert.com', '+91 98000 00737',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (5+ Yrs Exp)', 'Cloud & DevOps Specialist Level 3', 'Cloud & DevOps',
    5, ARRAY['English', 'Hindi'], 4.40, 34, 800,
    'Certified professional with 5 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000300000000', '00000000-0000-0000-0000-000000000000', 'devendra_jain_36_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000300000000', 'Devendra Jain', 'expert', 'devendra_jain_36_3', 'devendra_jain_36_3@demo.askexpert.com', '+91 98000 00738',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (6+ Yrs Exp)', 'Cloud & DevOps Specialist Level 1', 'Cloud & DevOps',
    6, ARRAY['English', 'Hindi'], 4.50, 41, 950,
    'Certified professional with 6 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000400000000', '00000000-0000-0000-0000-000000000000', 'preeti_nair_36_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000400000000', 'Preeti Nair', 'expert', 'preeti_nair_36_4', 'preeti_nair_36_4@demo.askexpert.com', '+91 98000 00739',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (7+ Yrs Exp)', 'Cloud & DevOps Specialist Level 2', 'Cloud & DevOps',
    7, ARRAY['English', 'Hindi'], 4.60, 48, 1100,
    'Certified professional with 7 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000500000000', '00000000-0000-0000-0000-000000000000', 'alok_sharma_36_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000500000000', 'Alok Sharma', 'expert', 'alok_sharma_36_5', 'alok_sharma_36_5@demo.askexpert.com', '+91 98000 00740',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (8+ Yrs Exp)', 'Cloud & DevOps Specialist Level 3', 'Cloud & DevOps',
    8, ARRAY['English', 'Hindi'], 4.70, 55, 1250,
    'Certified professional with 8 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000600000000', '00000000-0000-0000-0000-000000000000', 'kavita_reddy_36_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000600000000', 'Kavita Reddy', 'expert', 'kavita_reddy_36_6', 'kavita_reddy_36_6@demo.askexpert.com', '+91 98000 00741',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (9+ Yrs Exp)', 'Cloud & DevOps Specialist Level 1', 'Cloud & DevOps',
    9, ARRAY['English', 'Hindi'], 4.80, 62, 1400,
    'Certified professional with 9 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000700000000', '00000000-0000-0000-0000-000000000000', 'manish_kulkarni_36_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000700000000', 'Manish Kulkarni', 'expert', 'manish_kulkarni_36_7', 'manish_kulkarni_36_7@demo.askexpert.com', '+91 98000 00742',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (10+ Yrs Exp)', 'Cloud & DevOps Specialist Level 2', 'Cloud & DevOps',
    10, ARRAY['English', 'Hindi'], 4.90, 69, 1550,
    'Certified professional with 10 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000800000000', '00000000-0000-0000-0000-000000000000', 'pooja_malhotra_36_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000800000000', 'Pooja Malhotra', 'expert', 'pooja_malhotra_36_8', 'pooja_malhotra_36_8@demo.askexpert.com', '+91 98000 00743',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (11+ Yrs Exp)', 'Cloud & DevOps Specialist Level 3', 'Cloud & DevOps',
    11, ARRAY['English', 'Hindi'], 4.20, 76, 1700,
    'Certified professional with 11 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000900000000', '00000000-0000-0000-0000-000000000000', 'sanjay_bhattacharya_36_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000900000000', 'Sanjay Bhattacharya', 'expert', 'sanjay_bhattacharya_36_9', 'sanjay_bhattacharya_36_9@demo.askexpert.com', '+91 98000 00744',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (12+ Yrs Exp)', 'Cloud & DevOps Specialist Level 1', 'Cloud & DevOps',
    12, ARRAY['English', 'Hindi'], 4.30, 83, 1850,
    'Certified professional with 12 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000a00000000', '00000000-0000-0000-0000-000000000000', 'tanvi_saxena_36_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000a00000000', 'Tanvi Saxena', 'expert', 'tanvi_saxena_36_10', 'tanvi_saxena_36_10@demo.askexpert.com', '+91 98000 00745',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (13+ Yrs Exp)', 'Cloud & DevOps Specialist Level 2', 'Cloud & DevOps',
    13, ARRAY['English', 'Hindi'], 4.40, 90, 2000,
    'Certified professional with 13 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000b00000000', '00000000-0000-0000-0000-000000000000', 'varun_gupta_36_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000b00000000', 'Varun Gupta', 'expert', 'varun_gupta_36_11', 'varun_gupta_36_11@demo.askexpert.com', '+91 98000 00746',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (14+ Yrs Exp)', 'Cloud & DevOps Specialist Level 3', 'Cloud & DevOps',
    14, ARRAY['English', 'Hindi'], 4.50, 97, 2150,
    'Certified professional with 14 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000c00000000', '00000000-0000-0000-0000-000000000000', 'divya_chopra_36_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000c00000000', 'Divya Chopra', 'expert', 'divya_chopra_36_12', 'divya_chopra_36_12@demo.askexpert.com', '+91 98000 00747',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (15+ Yrs Exp)', 'Cloud & DevOps Specialist Level 1', 'Cloud & DevOps',
    15, ARRAY['English', 'Hindi'], 4.60, 104, 2300,
    'Certified professional with 15 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000d00000000', '00000000-0000-0000-0000-000000000000', 'gautam_jain_36_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000d00000000', 'Gautam Jain', 'expert', 'gautam_jain_36_13', 'gautam_jain_36_13@demo.askexpert.com', '+91 98000 00748',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (16+ Yrs Exp)', 'Cloud & DevOps Specialist Level 2', 'Cloud & DevOps',
    16, ARRAY['English', 'Hindi'], 4.70, 111, 2450,
    'Certified professional with 16 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000e00000000', '00000000-0000-0000-0000-000000000000', 'swati_nair_36_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000e00000000', 'Swati Nair', 'expert', 'swati_nair_36_14', 'swati_nair_36_14@demo.askexpert.com', '+91 98000 00749',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (17+ Yrs Exp)', 'Cloud & DevOps Specialist Level 3', 'Cloud & DevOps',
    17, ARRAY['English', 'Hindi'], 4.80, 118, 2600,
    'Certified professional with 17 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-000f00000000', '00000000-0000-0000-0000-000000000000', 'rajesh_sharma_36_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-000f00000000', 'Rajesh Sharma', 'expert', 'rajesh_sharma_36_15', 'rajesh_sharma_36_15@demo.askexpert.com', '+91 98000 00750',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (18+ Yrs Exp)', 'Cloud & DevOps Specialist Level 1', 'Cloud & DevOps',
    18, ARRAY['English', 'Hindi'], 4.90, 125, 500,
    'Certified professional with 18 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-001000000000', '00000000-0000-0000-0000-000000000000', 'priya_reddy_36_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-001000000000', 'Priya Reddy', 'expert', 'priya_reddy_36_16', 'priya_reddy_36_16@demo.askexpert.com', '+91 98000 00751',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (19+ Yrs Exp)', 'Cloud & DevOps Specialist Level 2', 'Cloud & DevOps',
    19, ARRAY['English', 'Hindi'], 4.20, 132, 650,
    'Certified professional with 19 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-001100000000', '00000000-0000-0000-0000-000000000000', 'vikram_kulkarni_36_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-001100000000', 'Vikram Kulkarni', 'expert', 'vikram_kulkarni_36_17', 'vikram_kulkarni_36_17@demo.askexpert.com', '+91 98000 00752',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (20+ Yrs Exp)', 'Cloud & DevOps Specialist Level 3', 'Cloud & DevOps',
    20, ARRAY['English', 'Hindi'], 4.30, 139, 800,
    'Certified professional with 20 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-001200000000', '00000000-0000-0000-0000-000000000000', 'ananya_malhotra_36_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-001200000000', 'Ananya Malhotra', 'expert', 'ananya_malhotra_36_18', 'ananya_malhotra_36_18@demo.askexpert.com', '+91 98000 00753',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (3+ Yrs Exp)', 'Cloud & DevOps Specialist Level 1', 'Cloud & DevOps',
    3, ARRAY['English', 'Hindi'], 4.40, 146, 950,
    'Certified professional with 3 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-001300000000', '00000000-0000-0000-0000-000000000000', 'siddharth_bhattacharya_36_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-001300000000', 'Siddharth Bhattacharya', 'expert', 'siddharth_bhattacharya_36_19', 'siddharth_bhattacharya_36_19@demo.askexpert.com', '+91 98000 00754',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (4+ Yrs Exp)', 'Cloud & DevOps Specialist Level 2', 'Cloud & DevOps',
    4, ARRAY['English', 'Hindi'], 4.50, 153, 1100,
    'Certified professional with 4 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-001400000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_saxena_36_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-001400000000', 'Meenakshi Saxena', 'expert', 'meenakshi_saxena_36_20', 'meenakshi_saxena_36_20@demo.askexpert.com', '+91 98000 00755',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (5+ Yrs Exp)', 'Cloud & DevOps Specialist Level 3', 'Cloud & DevOps',
    5, ARRAY['English', 'Hindi'], 4.60, 160, 1250,
    'Certified professional with 5 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2400-001500000000', '00000000-0000-0000-0000-000000000000', 'amitabh_gupta_36_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2400-001500000000', 'Amitabh Gupta', 'expert', 'amitabh_gupta_36_21', 'amitabh_gupta_36_21@demo.askexpert.com', '+91 98000 00756',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Cloud & DevOps (6+ Yrs Exp)', 'Cloud & DevOps Specialist Level 1', 'Cloud & DevOps',
    6, ARRAY['English', 'Hindi'], 4.70, 167, 1400,
    'Certified professional with 6 years of expertise in Cloud & DevOps. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Cloud & DevOps Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000100000000', '00000000-0000-0000-0000-000000000000', 'sunita_malhotra_37_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000100000000', 'Sunita Malhotra', 'expert', 'sunita_malhotra_37_1', 'sunita_malhotra_37_1@demo.askexpert.com', '+91 98000 00757',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (4+ Yrs Exp)', 'Data Science Specialist Level 2', 'Data Science',
    4, ARRAY['English', 'Hindi'], 4.30, 39, 650,
    'Certified professional with 4 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000200000000', '00000000-0000-0000-0000-000000000000', 'rohan_bhattacharya_37_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000200000000', 'Rohan Bhattacharya', 'expert', 'rohan_bhattacharya_37_2', 'rohan_bhattacharya_37_2@demo.askexpert.com', '+91 98000 00758',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (5+ Yrs Exp)', 'Data Science Specialist Level 3', 'Data Science',
    5, ARRAY['English', 'Hindi'], 4.40, 46, 800,
    'Certified professional with 5 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000300000000', '00000000-0000-0000-0000-000000000000', 'shalini_saxena_37_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000300000000', 'Shalini Saxena', 'expert', 'shalini_saxena_37_3', 'shalini_saxena_37_3@demo.askexpert.com', '+91 98000 00759',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (6+ Yrs Exp)', 'Data Science Specialist Level 1', 'Data Science',
    6, ARRAY['English', 'Hindi'], 4.50, 53, 950,
    'Certified professional with 6 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000400000000', '00000000-0000-0000-0000-000000000000', 'suresh_gupta_37_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000400000000', 'Suresh Gupta', 'expert', 'suresh_gupta_37_4', 'suresh_gupta_37_4@demo.askexpert.com', '+91 98000 00760',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (7+ Yrs Exp)', 'Data Science Specialist Level 2', 'Data Science',
    7, ARRAY['English', 'Hindi'], 4.60, 60, 1100,
    'Certified professional with 7 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000500000000', '00000000-0000-0000-0000-000000000000', 'ritu_chopra_37_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000500000000', 'Ritu Chopra', 'expert', 'ritu_chopra_37_5', 'ritu_chopra_37_5@demo.askexpert.com', '+91 98000 00761',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (8+ Yrs Exp)', 'Data Science Specialist Level 3', 'Data Science',
    8, ARRAY['English', 'Hindi'], 4.70, 67, 1250,
    'Certified professional with 8 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000600000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_jain_37_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000600000000', 'Vikramaditya Jain', 'expert', 'vikramaditya_jain_37_6', 'vikramaditya_jain_37_6@demo.askexpert.com', '+91 98000 00762',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (9+ Yrs Exp)', 'Data Science Specialist Level 1', 'Data Science',
    9, ARRAY['English', 'Hindi'], 4.80, 74, 1400,
    'Certified professional with 9 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000700000000', '00000000-0000-0000-0000-000000000000', 'deepa_nair_37_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000700000000', 'Deepa Nair', 'expert', 'deepa_nair_37_7', 'deepa_nair_37_7@demo.askexpert.com', '+91 98000 00763',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (10+ Yrs Exp)', 'Data Science Specialist Level 2', 'Data Science',
    10, ARRAY['English', 'Hindi'], 4.90, 81, 1550,
    'Certified professional with 10 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000800000000', '00000000-0000-0000-0000-000000000000', 'arvind_sharma_37_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000800000000', 'Arvind Sharma', 'expert', 'arvind_sharma_37_8', 'arvind_sharma_37_8@demo.askexpert.com', '+91 98000 00764',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (11+ Yrs Exp)', 'Data Science Specialist Level 3', 'Data Science',
    11, ARRAY['English', 'Hindi'], 4.20, 88, 1700,
    'Certified professional with 11 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000900000000', '00000000-0000-0000-0000-000000000000', 'sneha_reddy_37_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000900000000', 'Sneha Reddy', 'expert', 'sneha_reddy_37_9', 'sneha_reddy_37_9@demo.askexpert.com', '+91 98000 00765',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (12+ Yrs Exp)', 'Data Science Specialist Level 1', 'Data Science',
    12, ARRAY['English', 'Hindi'], 4.30, 95, 1850,
    'Certified professional with 12 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000a00000000', '00000000-0000-0000-0000-000000000000', 'karthik_kulkarni_37_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000a00000000', 'Karthik Kulkarni', 'expert', 'karthik_kulkarni_37_10', 'karthik_kulkarni_37_10@demo.askexpert.com', '+91 98000 00766',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (13+ Yrs Exp)', 'Data Science Specialist Level 2', 'Data Science',
    13, ARRAY['English', 'Hindi'], 4.40, 102, 2000,
    'Certified professional with 13 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000b00000000', '00000000-0000-0000-0000-000000000000', 'neha_malhotra_37_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000b00000000', 'Neha Malhotra', 'expert', 'neha_malhotra_37_11', 'neha_malhotra_37_11@demo.askexpert.com', '+91 98000 00767',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (14+ Yrs Exp)', 'Data Science Specialist Level 3', 'Data Science',
    14, ARRAY['English', 'Hindi'], 4.50, 109, 2150,
    'Certified professional with 14 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000c00000000', '00000000-0000-0000-0000-000000000000', 'devendra_bhattacharya_37_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000c00000000', 'Devendra Bhattacharya', 'expert', 'devendra_bhattacharya_37_12', 'devendra_bhattacharya_37_12@demo.askexpert.com', '+91 98000 00768',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (15+ Yrs Exp)', 'Data Science Specialist Level 1', 'Data Science',
    15, ARRAY['English', 'Hindi'], 4.60, 116, 2300,
    'Certified professional with 15 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000d00000000', '00000000-0000-0000-0000-000000000000', 'preeti_saxena_37_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000d00000000', 'Preeti Saxena', 'expert', 'preeti_saxena_37_13', 'preeti_saxena_37_13@demo.askexpert.com', '+91 98000 00769',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (16+ Yrs Exp)', 'Data Science Specialist Level 2', 'Data Science',
    16, ARRAY['English', 'Hindi'], 4.70, 123, 2450,
    'Certified professional with 16 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000e00000000', '00000000-0000-0000-0000-000000000000', 'alok_gupta_37_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000e00000000', 'Alok Gupta', 'expert', 'alok_gupta_37_14', 'alok_gupta_37_14@demo.askexpert.com', '+91 98000 00770',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (17+ Yrs Exp)', 'Data Science Specialist Level 3', 'Data Science',
    17, ARRAY['English', 'Hindi'], 4.80, 130, 2600,
    'Certified professional with 17 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-000f00000000', '00000000-0000-0000-0000-000000000000', 'kavita_chopra_37_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-000f00000000', 'Kavita Chopra', 'expert', 'kavita_chopra_37_15', 'kavita_chopra_37_15@demo.askexpert.com', '+91 98000 00771',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (18+ Yrs Exp)', 'Data Science Specialist Level 1', 'Data Science',
    18, ARRAY['English', 'Hindi'], 4.90, 137, 500,
    'Certified professional with 18 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-001000000000', '00000000-0000-0000-0000-000000000000', 'manish_jain_37_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-001000000000', 'Manish Jain', 'expert', 'manish_jain_37_16', 'manish_jain_37_16@demo.askexpert.com', '+91 98000 00772',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (19+ Yrs Exp)', 'Data Science Specialist Level 2', 'Data Science',
    19, ARRAY['English', 'Hindi'], 4.20, 144, 650,
    'Certified professional with 19 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-001100000000', '00000000-0000-0000-0000-000000000000', 'pooja_nair_37_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-001100000000', 'Pooja Nair', 'expert', 'pooja_nair_37_17', 'pooja_nair_37_17@demo.askexpert.com', '+91 98000 00773',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (20+ Yrs Exp)', 'Data Science Specialist Level 3', 'Data Science',
    20, ARRAY['English', 'Hindi'], 4.30, 151, 800,
    'Certified professional with 20 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-001200000000', '00000000-0000-0000-0000-000000000000', 'sanjay_sharma_37_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-001200000000', 'Sanjay Sharma', 'expert', 'sanjay_sharma_37_18', 'sanjay_sharma_37_18@demo.askexpert.com', '+91 98000 00774',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (3+ Yrs Exp)', 'Data Science Specialist Level 1', 'Data Science',
    3, ARRAY['English', 'Hindi'], 4.40, 158, 950,
    'Certified professional with 3 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-001300000000', '00000000-0000-0000-0000-000000000000', 'tanvi_reddy_37_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-001300000000', 'Tanvi Reddy', 'expert', 'tanvi_reddy_37_19', 'tanvi_reddy_37_19@demo.askexpert.com', '+91 98000 00775',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (4+ Yrs Exp)', 'Data Science Specialist Level 2', 'Data Science',
    4, ARRAY['English', 'Hindi'], 4.50, 165, 1100,
    'Certified professional with 4 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-001400000000', '00000000-0000-0000-0000-000000000000', 'varun_kulkarni_37_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-001400000000', 'Varun Kulkarni', 'expert', 'varun_kulkarni_37_20', 'varun_kulkarni_37_20@demo.askexpert.com', '+91 98000 00776',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (5+ Yrs Exp)', 'Data Science Specialist Level 3', 'Data Science',
    5, ARRAY['English', 'Hindi'], 4.60, 172, 1250,
    'Certified professional with 5 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2500-001500000000', '00000000-0000-0000-0000-000000000000', 'divya_malhotra_37_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2500-001500000000', 'Divya Malhotra', 'expert', 'divya_malhotra_37_21', 'divya_malhotra_37_21@demo.askexpert.com', '+91 98000 00777',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Data Science (6+ Yrs Exp)', 'Data Science Specialist Level 1', 'Data Science',
    6, ARRAY['English', 'Hindi'], 4.70, 179, 1400,
    'Certified professional with 6 years of expertise in Data Science. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Data Science Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000100000000', '00000000-0000-0000-0000-000000000000', 'gautam_sharma_38_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000100000000', 'Gautam Sharma', 'expert', 'gautam_sharma_38_1', 'gautam_sharma_38_1@demo.askexpert.com', '+91 98000 00778',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (4+ Yrs Exp)', 'HR & Recruitment Specialist Level 2', 'HR & Recruitment',
    4, ARRAY['English', 'Hindi'], 4.30, 51, 650,
    'Certified professional with 4 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000200000000', '00000000-0000-0000-0000-000000000000', 'swati_reddy_38_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000200000000', 'Swati Reddy', 'expert', 'swati_reddy_38_2', 'swati_reddy_38_2@demo.askexpert.com', '+91 98000 00779',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (5+ Yrs Exp)', 'HR & Recruitment Specialist Level 3', 'HR & Recruitment',
    5, ARRAY['English', 'Hindi'], 4.40, 58, 800,
    'Certified professional with 5 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000300000000', '00000000-0000-0000-0000-000000000000', 'rajesh_kulkarni_38_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000300000000', 'Rajesh Kulkarni', 'expert', 'rajesh_kulkarni_38_3', 'rajesh_kulkarni_38_3@demo.askexpert.com', '+91 98000 00780',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (6+ Yrs Exp)', 'HR & Recruitment Specialist Level 1', 'HR & Recruitment',
    6, ARRAY['English', 'Hindi'], 4.50, 65, 950,
    'Certified professional with 6 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000400000000', '00000000-0000-0000-0000-000000000000', 'priya_malhotra_38_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000400000000', 'Priya Malhotra', 'expert', 'priya_malhotra_38_4', 'priya_malhotra_38_4@demo.askexpert.com', '+91 98000 00781',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (7+ Yrs Exp)', 'HR & Recruitment Specialist Level 2', 'HR & Recruitment',
    7, ARRAY['English', 'Hindi'], 4.60, 72, 1100,
    'Certified professional with 7 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000500000000', '00000000-0000-0000-0000-000000000000', 'vikram_bhattacharya_38_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000500000000', 'Vikram Bhattacharya', 'expert', 'vikram_bhattacharya_38_5', 'vikram_bhattacharya_38_5@demo.askexpert.com', '+91 98000 00782',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (8+ Yrs Exp)', 'HR & Recruitment Specialist Level 3', 'HR & Recruitment',
    8, ARRAY['English', 'Hindi'], 4.70, 79, 1250,
    'Certified professional with 8 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000600000000', '00000000-0000-0000-0000-000000000000', 'ananya_saxena_38_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000600000000', 'Ananya Saxena', 'expert', 'ananya_saxena_38_6', 'ananya_saxena_38_6@demo.askexpert.com', '+91 98000 00783',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (9+ Yrs Exp)', 'HR & Recruitment Specialist Level 1', 'HR & Recruitment',
    9, ARRAY['English', 'Hindi'], 4.80, 86, 1400,
    'Certified professional with 9 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000700000000', '00000000-0000-0000-0000-000000000000', 'siddharth_gupta_38_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000700000000', 'Siddharth Gupta', 'expert', 'siddharth_gupta_38_7', 'siddharth_gupta_38_7@demo.askexpert.com', '+91 98000 00784',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (10+ Yrs Exp)', 'HR & Recruitment Specialist Level 2', 'HR & Recruitment',
    10, ARRAY['English', 'Hindi'], 4.90, 93, 1550,
    'Certified professional with 10 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000800000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_chopra_38_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000800000000', 'Meenakshi Chopra', 'expert', 'meenakshi_chopra_38_8', 'meenakshi_chopra_38_8@demo.askexpert.com', '+91 98000 00785',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (11+ Yrs Exp)', 'HR & Recruitment Specialist Level 3', 'HR & Recruitment',
    11, ARRAY['English', 'Hindi'], 4.20, 100, 1700,
    'Certified professional with 11 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000900000000', '00000000-0000-0000-0000-000000000000', 'amitabh_jain_38_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000900000000', 'Amitabh Jain', 'expert', 'amitabh_jain_38_9', 'amitabh_jain_38_9@demo.askexpert.com', '+91 98000 00786',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (12+ Yrs Exp)', 'HR & Recruitment Specialist Level 1', 'HR & Recruitment',
    12, ARRAY['English', 'Hindi'], 4.30, 107, 1850,
    'Certified professional with 12 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000a00000000', '00000000-0000-0000-0000-000000000000', 'sunita_nair_38_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000a00000000', 'Sunita Nair', 'expert', 'sunita_nair_38_10', 'sunita_nair_38_10@demo.askexpert.com', '+91 98000 00787',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (13+ Yrs Exp)', 'HR & Recruitment Specialist Level 2', 'HR & Recruitment',
    13, ARRAY['English', 'Hindi'], 4.40, 114, 2000,
    'Certified professional with 13 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000b00000000', '00000000-0000-0000-0000-000000000000', 'rohan_sharma_38_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000b00000000', 'Rohan Sharma', 'expert', 'rohan_sharma_38_11', 'rohan_sharma_38_11@demo.askexpert.com', '+91 98000 00788',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (14+ Yrs Exp)', 'HR & Recruitment Specialist Level 3', 'HR & Recruitment',
    14, ARRAY['English', 'Hindi'], 4.50, 121, 2150,
    'Certified professional with 14 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000c00000000', '00000000-0000-0000-0000-000000000000', 'shalini_reddy_38_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000c00000000', 'Shalini Reddy', 'expert', 'shalini_reddy_38_12', 'shalini_reddy_38_12@demo.askexpert.com', '+91 98000 00789',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (15+ Yrs Exp)', 'HR & Recruitment Specialist Level 1', 'HR & Recruitment',
    15, ARRAY['English', 'Hindi'], 4.60, 128, 2300,
    'Certified professional with 15 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000d00000000', '00000000-0000-0000-0000-000000000000', 'suresh_kulkarni_38_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000d00000000', 'Suresh Kulkarni', 'expert', 'suresh_kulkarni_38_13', 'suresh_kulkarni_38_13@demo.askexpert.com', '+91 98000 00790',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (16+ Yrs Exp)', 'HR & Recruitment Specialist Level 2', 'HR & Recruitment',
    16, ARRAY['English', 'Hindi'], 4.70, 135, 2450,
    'Certified professional with 16 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000e00000000', '00000000-0000-0000-0000-000000000000', 'ritu_malhotra_38_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000e00000000', 'Ritu Malhotra', 'expert', 'ritu_malhotra_38_14', 'ritu_malhotra_38_14@demo.askexpert.com', '+91 98000 00791',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (17+ Yrs Exp)', 'HR & Recruitment Specialist Level 3', 'HR & Recruitment',
    17, ARRAY['English', 'Hindi'], 4.80, 142, 2600,
    'Certified professional with 17 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-000f00000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_bhattacharya_38_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-000f00000000', 'Vikramaditya Bhattacharya', 'expert', 'vikramaditya_bhattacharya_38_15', 'vikramaditya_bhattacharya_38_15@demo.askexpert.com', '+91 98000 00792',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (18+ Yrs Exp)', 'HR & Recruitment Specialist Level 1', 'HR & Recruitment',
    18, ARRAY['English', 'Hindi'], 4.90, 149, 500,
    'Certified professional with 18 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-001000000000', '00000000-0000-0000-0000-000000000000', 'deepa_saxena_38_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-001000000000', 'Deepa Saxena', 'expert', 'deepa_saxena_38_16', 'deepa_saxena_38_16@demo.askexpert.com', '+91 98000 00793',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (19+ Yrs Exp)', 'HR & Recruitment Specialist Level 2', 'HR & Recruitment',
    19, ARRAY['English', 'Hindi'], 4.20, 156, 650,
    'Certified professional with 19 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-001100000000', '00000000-0000-0000-0000-000000000000', 'arvind_gupta_38_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-001100000000', 'Arvind Gupta', 'expert', 'arvind_gupta_38_17', 'arvind_gupta_38_17@demo.askexpert.com', '+91 98000 00794',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (20+ Yrs Exp)', 'HR & Recruitment Specialist Level 3', 'HR & Recruitment',
    20, ARRAY['English', 'Hindi'], 4.30, 163, 800,
    'Certified professional with 20 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-001200000000', '00000000-0000-0000-0000-000000000000', 'sneha_chopra_38_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-001200000000', 'Sneha Chopra', 'expert', 'sneha_chopra_38_18', 'sneha_chopra_38_18@demo.askexpert.com', '+91 98000 00795',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (3+ Yrs Exp)', 'HR & Recruitment Specialist Level 1', 'HR & Recruitment',
    3, ARRAY['English', 'Hindi'], 4.40, 170, 950,
    'Certified professional with 3 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-001300000000', '00000000-0000-0000-0000-000000000000', 'karthik_jain_38_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-001300000000', 'Karthik Jain', 'expert', 'karthik_jain_38_19', 'karthik_jain_38_19@demo.askexpert.com', '+91 98000 00796',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (4+ Yrs Exp)', 'HR & Recruitment Specialist Level 2', 'HR & Recruitment',
    4, ARRAY['English', 'Hindi'], 4.50, 177, 1100,
    'Certified professional with 4 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-001400000000', '00000000-0000-0000-0000-000000000000', 'neha_nair_38_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-001400000000', 'Neha Nair', 'expert', 'neha_nair_38_20', 'neha_nair_38_20@demo.askexpert.com', '+91 98000 00797',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (5+ Yrs Exp)', 'HR & Recruitment Specialist Level 3', 'HR & Recruitment',
    5, ARRAY['English', 'Hindi'], 4.60, 184, 1250,
    'Certified professional with 5 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2600-001500000000', '00000000-0000-0000-0000-000000000000', 'devendra_sharma_38_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2600-001500000000', 'Devendra Sharma', 'expert', 'devendra_sharma_38_21', 'devendra_sharma_38_21@demo.askexpert.com', '+91 98000 00798',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in HR & Recruitment (6+ Yrs Exp)', 'HR & Recruitment Specialist Level 1', 'HR & Recruitment',
    6, ARRAY['English', 'Hindi'], 4.70, 191, 1400,
    'Certified professional with 6 years of expertise in HR & Recruitment. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['HR & Recruitment Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000100000000', '00000000-0000-0000-0000-000000000000', 'preeti_chopra_39_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000100000000', 'Preeti Chopra', 'expert', 'preeti_chopra_39_1', 'preeti_chopra_39_1@demo.askexpert.com', '+91 98000 00799',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (4+ Yrs Exp)', 'Legal Compliance Specialist Level 2', 'Legal Compliance',
    4, ARRAY['English', 'Hindi'], 4.30, 63, 650,
    'Certified professional with 4 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000200000000', '00000000-0000-0000-0000-000000000000', 'alok_jain_39_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000200000000', 'Alok Jain', 'expert', 'alok_jain_39_2', 'alok_jain_39_2@demo.askexpert.com', '+91 98000 00800',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (5+ Yrs Exp)', 'Legal Compliance Specialist Level 3', 'Legal Compliance',
    5, ARRAY['English', 'Hindi'], 4.40, 70, 800,
    'Certified professional with 5 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000300000000', '00000000-0000-0000-0000-000000000000', 'kavita_nair_39_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000300000000', 'Kavita Nair', 'expert', 'kavita_nair_39_3', 'kavita_nair_39_3@demo.askexpert.com', '+91 98000 00801',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (6+ Yrs Exp)', 'Legal Compliance Specialist Level 1', 'Legal Compliance',
    6, ARRAY['English', 'Hindi'], 4.50, 77, 950,
    'Certified professional with 6 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000400000000', '00000000-0000-0000-0000-000000000000', 'manish_sharma_39_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000400000000', 'Manish Sharma', 'expert', 'manish_sharma_39_4', 'manish_sharma_39_4@demo.askexpert.com', '+91 98000 00802',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (7+ Yrs Exp)', 'Legal Compliance Specialist Level 2', 'Legal Compliance',
    7, ARRAY['English', 'Hindi'], 4.60, 84, 1100,
    'Certified professional with 7 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000500000000', '00000000-0000-0000-0000-000000000000', 'pooja_reddy_39_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000500000000', 'Pooja Reddy', 'expert', 'pooja_reddy_39_5', 'pooja_reddy_39_5@demo.askexpert.com', '+91 98000 00803',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (8+ Yrs Exp)', 'Legal Compliance Specialist Level 3', 'Legal Compliance',
    8, ARRAY['English', 'Hindi'], 4.70, 91, 1250,
    'Certified professional with 8 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000600000000', '00000000-0000-0000-0000-000000000000', 'sanjay_kulkarni_39_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000600000000', 'Sanjay Kulkarni', 'expert', 'sanjay_kulkarni_39_6', 'sanjay_kulkarni_39_6@demo.askexpert.com', '+91 98000 00804',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (9+ Yrs Exp)', 'Legal Compliance Specialist Level 1', 'Legal Compliance',
    9, ARRAY['English', 'Hindi'], 4.80, 98, 1400,
    'Certified professional with 9 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000700000000', '00000000-0000-0000-0000-000000000000', 'tanvi_malhotra_39_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000700000000', 'Tanvi Malhotra', 'expert', 'tanvi_malhotra_39_7', 'tanvi_malhotra_39_7@demo.askexpert.com', '+91 98000 00805',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (10+ Yrs Exp)', 'Legal Compliance Specialist Level 2', 'Legal Compliance',
    10, ARRAY['English', 'Hindi'], 4.90, 105, 1550,
    'Certified professional with 10 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000800000000', '00000000-0000-0000-0000-000000000000', 'varun_bhattacharya_39_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000800000000', 'Varun Bhattacharya', 'expert', 'varun_bhattacharya_39_8', 'varun_bhattacharya_39_8@demo.askexpert.com', '+91 98000 00806',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (11+ Yrs Exp)', 'Legal Compliance Specialist Level 3', 'Legal Compliance',
    11, ARRAY['English', 'Hindi'], 4.20, 112, 1700,
    'Certified professional with 11 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000900000000', '00000000-0000-0000-0000-000000000000', 'divya_saxena_39_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000900000000', 'Divya Saxena', 'expert', 'divya_saxena_39_9', 'divya_saxena_39_9@demo.askexpert.com', '+91 98000 00807',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (12+ Yrs Exp)', 'Legal Compliance Specialist Level 1', 'Legal Compliance',
    12, ARRAY['English', 'Hindi'], 4.30, 119, 1850,
    'Certified professional with 12 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000a00000000', '00000000-0000-0000-0000-000000000000', 'gautam_gupta_39_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000a00000000', 'Gautam Gupta', 'expert', 'gautam_gupta_39_10', 'gautam_gupta_39_10@demo.askexpert.com', '+91 98000 00808',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (13+ Yrs Exp)', 'Legal Compliance Specialist Level 2', 'Legal Compliance',
    13, ARRAY['English', 'Hindi'], 4.40, 126, 2000,
    'Certified professional with 13 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000b00000000', '00000000-0000-0000-0000-000000000000', 'swati_chopra_39_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000b00000000', 'Swati Chopra', 'expert', 'swati_chopra_39_11', 'swati_chopra_39_11@demo.askexpert.com', '+91 98000 00809',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (14+ Yrs Exp)', 'Legal Compliance Specialist Level 3', 'Legal Compliance',
    14, ARRAY['English', 'Hindi'], 4.50, 133, 2150,
    'Certified professional with 14 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000c00000000', '00000000-0000-0000-0000-000000000000', 'rajesh_jain_39_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000c00000000', 'Rajesh Jain', 'expert', 'rajesh_jain_39_12', 'rajesh_jain_39_12@demo.askexpert.com', '+91 98000 00810',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (15+ Yrs Exp)', 'Legal Compliance Specialist Level 1', 'Legal Compliance',
    15, ARRAY['English', 'Hindi'], 4.60, 140, 2300,
    'Certified professional with 15 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000d00000000', '00000000-0000-0000-0000-000000000000', 'priya_nair_39_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Priya Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000d00000000', 'Priya Nair', 'expert', 'priya_nair_39_13', 'priya_nair_39_13@demo.askexpert.com', '+91 98000 00811',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (16+ Yrs Exp)', 'Legal Compliance Specialist Level 2', 'Legal Compliance',
    16, ARRAY['English', 'Hindi'], 4.70, 147, 2450,
    'Certified professional with 16 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000e00000000', '00000000-0000-0000-0000-000000000000', 'vikram_sharma_39_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikram Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000e00000000', 'Vikram Sharma', 'expert', 'vikram_sharma_39_14', 'vikram_sharma_39_14@demo.askexpert.com', '+91 98000 00812',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (17+ Yrs Exp)', 'Legal Compliance Specialist Level 3', 'Legal Compliance',
    17, ARRAY['English', 'Hindi'], 4.80, 154, 2600,
    'Certified professional with 17 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-000f00000000', '00000000-0000-0000-0000-000000000000', 'ananya_reddy_39_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ananya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-000f00000000', 'Ananya Reddy', 'expert', 'ananya_reddy_39_15', 'ananya_reddy_39_15@demo.askexpert.com', '+91 98000 00813',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (18+ Yrs Exp)', 'Legal Compliance Specialist Level 1', 'Legal Compliance',
    18, ARRAY['English', 'Hindi'], 4.90, 161, 500,
    'Certified professional with 18 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-001000000000', '00000000-0000-0000-0000-000000000000', 'siddharth_kulkarni_39_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Siddharth Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-001000000000', 'Siddharth Kulkarni', 'expert', 'siddharth_kulkarni_39_16', 'siddharth_kulkarni_39_16@demo.askexpert.com', '+91 98000 00814',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (19+ Yrs Exp)', 'Legal Compliance Specialist Level 2', 'Legal Compliance',
    19, ARRAY['English', 'Hindi'], 4.20, 168, 650,
    'Certified professional with 19 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-001100000000', '00000000-0000-0000-0000-000000000000', 'meenakshi_malhotra_39_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Meenakshi Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-001100000000', 'Meenakshi Malhotra', 'expert', 'meenakshi_malhotra_39_17', 'meenakshi_malhotra_39_17@demo.askexpert.com', '+91 98000 00815',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (20+ Yrs Exp)', 'Legal Compliance Specialist Level 3', 'Legal Compliance',
    20, ARRAY['English', 'Hindi'], 4.30, 175, 800,
    'Certified professional with 20 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-001200000000', '00000000-0000-0000-0000-000000000000', 'amitabh_bhattacharya_39_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Amitabh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-001200000000', 'Amitabh Bhattacharya', 'expert', 'amitabh_bhattacharya_39_18', 'amitabh_bhattacharya_39_18@demo.askexpert.com', '+91 98000 00816',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (3+ Yrs Exp)', 'Legal Compliance Specialist Level 1', 'Legal Compliance',
    3, ARRAY['English', 'Hindi'], 4.40, 182, 950,
    'Certified professional with 3 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-001300000000', '00000000-0000-0000-0000-000000000000', 'sunita_saxena_39_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sunita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-001300000000', 'Sunita Saxena', 'expert', 'sunita_saxena_39_19', 'sunita_saxena_39_19@demo.askexpert.com', '+91 98000 00817',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (4+ Yrs Exp)', 'Legal Compliance Specialist Level 2', 'Legal Compliance',
    4, ARRAY['English', 'Hindi'], 4.50, 189, 1100,
    'Certified professional with 4 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-001400000000', '00000000-0000-0000-0000-000000000000', 'rohan_gupta_39_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rohan Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-001400000000', 'Rohan Gupta', 'expert', 'rohan_gupta_39_20', 'rohan_gupta_39_20@demo.askexpert.com', '+91 98000 00818',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (5+ Yrs Exp)', 'Legal Compliance Specialist Level 3', 'Legal Compliance',
    5, ARRAY['English', 'Hindi'], 4.60, 196, 1250,
    'Certified professional with 5 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2700-001500000000', '00000000-0000-0000-0000-000000000000', 'shalini_chopra_39_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Shalini Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2700-001500000000', 'Shalini Chopra', 'expert', 'shalini_chopra_39_21', 'shalini_chopra_39_21@demo.askexpert.com', '+91 98000 00819',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Legal Compliance (6+ Yrs Exp)', 'Legal Compliance Specialist Level 1', 'Legal Compliance',
    6, ARRAY['English', 'Hindi'], 4.70, 203, 1400,
    'Certified professional with 6 years of expertise in Legal Compliance. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Legal Compliance Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000100000000', '00000000-0000-0000-0000-000000000000', 'suresh_bhattacharya_40_1@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Suresh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000100000000', 'Suresh Bhattacharya', 'expert', 'suresh_bhattacharya_40_1', 'suresh_bhattacharya_40_1@demo.askexpert.com', '+91 98000 00820',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (4+ Yrs Exp)', 'Other Professional Services Specialist Level 2', 'Other Professional Services',
    4, ARRAY['English', 'Hindi'], 4.30, 75, 650,
    'Certified professional with 4 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000200000000', '00000000-0000-0000-0000-000000000000', 'ritu_saxena_40_2@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Ritu Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000200000000', 'Ritu Saxena', 'expert', 'ritu_saxena_40_2', 'ritu_saxena_40_2@demo.askexpert.com', '+91 98000 00821',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (5+ Yrs Exp)', 'Other Professional Services Specialist Level 3', 'Other Professional Services',
    5, ARRAY['English', 'Hindi'], 4.40, 82, 800,
    'Certified professional with 5 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000300000000', '00000000-0000-0000-0000-000000000000', 'vikramaditya_gupta_40_3@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Vikramaditya Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000300000000', 'Vikramaditya Gupta', 'expert', 'vikramaditya_gupta_40_3', 'vikramaditya_gupta_40_3@demo.askexpert.com', '+91 98000 00822',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (6+ Yrs Exp)', 'Other Professional Services Specialist Level 1', 'Other Professional Services',
    6, ARRAY['English', 'Hindi'], 4.50, 89, 950,
    'Certified professional with 6 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000400000000', '00000000-0000-0000-0000-000000000000', 'deepa_chopra_40_4@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Deepa Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000400000000', 'Deepa Chopra', 'expert', 'deepa_chopra_40_4', 'deepa_chopra_40_4@demo.askexpert.com', '+91 98000 00823',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (7+ Yrs Exp)', 'Other Professional Services Specialist Level 2', 'Other Professional Services',
    7, ARRAY['English', 'Hindi'], 4.60, 96, 1100,
    'Certified professional with 7 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000500000000', '00000000-0000-0000-0000-000000000000', 'arvind_jain_40_5@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Arvind Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000500000000', 'Arvind Jain', 'expert', 'arvind_jain_40_5', 'arvind_jain_40_5@demo.askexpert.com', '+91 98000 00824',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (8+ Yrs Exp)', 'Other Professional Services Specialist Level 3', 'Other Professional Services',
    8, ARRAY['English', 'Hindi'], 4.70, 103, 1250,
    'Certified professional with 8 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000600000000', '00000000-0000-0000-0000-000000000000', 'sneha_nair_40_6@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sneha Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000600000000', 'Sneha Nair', 'expert', 'sneha_nair_40_6', 'sneha_nair_40_6@demo.askexpert.com', '+91 98000 00825',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (9+ Yrs Exp)', 'Other Professional Services Specialist Level 1', 'Other Professional Services',
    9, ARRAY['English', 'Hindi'], 4.80, 110, 1400,
    'Certified professional with 9 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000700000000', '00000000-0000-0000-0000-000000000000', 'karthik_sharma_40_7@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Karthik Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000700000000', 'Karthik Sharma', 'expert', 'karthik_sharma_40_7', 'karthik_sharma_40_7@demo.askexpert.com', '+91 98000 00826',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (10+ Yrs Exp)', 'Other Professional Services Specialist Level 2', 'Other Professional Services',
    10, ARRAY['English', 'Hindi'], 4.90, 117, 1550,
    'Certified professional with 10 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000800000000', '00000000-0000-0000-0000-000000000000', 'neha_reddy_40_8@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Neha Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000800000000', 'Neha Reddy', 'expert', 'neha_reddy_40_8', 'neha_reddy_40_8@demo.askexpert.com', '+91 98000 00827',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (11+ Yrs Exp)', 'Other Professional Services Specialist Level 3', 'Other Professional Services',
    11, ARRAY['English', 'Hindi'], 4.20, 124, 1700,
    'Certified professional with 11 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000900000000', '00000000-0000-0000-0000-000000000000', 'devendra_kulkarni_40_9@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Devendra Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000900000000', 'Devendra Kulkarni', 'expert', 'devendra_kulkarni_40_9', 'devendra_kulkarni_40_9@demo.askexpert.com', '+91 98000 00828',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (12+ Yrs Exp)', 'Other Professional Services Specialist Level 1', 'Other Professional Services',
    12, ARRAY['English', 'Hindi'], 4.30, 131, 1850,
    'Certified professional with 12 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000a00000000', '00000000-0000-0000-0000-000000000000', 'preeti_malhotra_40_10@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Preeti Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000a00000000', 'Preeti Malhotra', 'expert', 'preeti_malhotra_40_10', 'preeti_malhotra_40_10@demo.askexpert.com', '+91 98000 00829',
    'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (13+ Yrs Exp)', 'Other Professional Services Specialist Level 2', 'Other Professional Services',
    13, ARRAY['English', 'Hindi'], 4.40, 138, 2000,
    'Certified professional with 13 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000b00000000', '00000000-0000-0000-0000-000000000000', 'alok_bhattacharya_40_11@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Alok Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000b00000000', 'Alok Bhattacharya', 'expert', 'alok_bhattacharya_40_11', 'alok_bhattacharya_40_11@demo.askexpert.com', '+91 98000 00830',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (14+ Yrs Exp)', 'Other Professional Services Specialist Level 3', 'Other Professional Services',
    14, ARRAY['English', 'Hindi'], 4.50, 145, 2150,
    'Certified professional with 14 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000c00000000', '00000000-0000-0000-0000-000000000000', 'kavita_saxena_40_12@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Kavita Saxena"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000c00000000', 'Kavita Saxena', 'expert', 'kavita_saxena_40_12', 'kavita_saxena_40_12@demo.askexpert.com', '+91 98000 00831',
    'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (15+ Yrs Exp)', 'Other Professional Services Specialist Level 1', 'Other Professional Services',
    15, ARRAY['English', 'Hindi'], 4.60, 152, 2300,
    'Certified professional with 15 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000d00000000', '00000000-0000-0000-0000-000000000000', 'manish_gupta_40_13@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Manish Gupta"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000d00000000', 'Manish Gupta', 'expert', 'manish_gupta_40_13', 'manish_gupta_40_13@demo.askexpert.com', '+91 98000 00832',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (16+ Yrs Exp)', 'Other Professional Services Specialist Level 2', 'Other Professional Services',
    16, ARRAY['English', 'Hindi'], 4.70, 159, 2450,
    'Certified professional with 16 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000e00000000', '00000000-0000-0000-0000-000000000000', 'pooja_chopra_40_14@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Pooja Chopra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000e00000000', 'Pooja Chopra', 'expert', 'pooja_chopra_40_14', 'pooja_chopra_40_14@demo.askexpert.com', '+91 98000 00833',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (17+ Yrs Exp)', 'Other Professional Services Specialist Level 3', 'Other Professional Services',
    17, ARRAY['English', 'Hindi'], 4.80, 166, 2600,
    'Certified professional with 17 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-000f00000000', '00000000-0000-0000-0000-000000000000', 'sanjay_jain_40_15@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Sanjay Jain"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-000f00000000', 'Sanjay Jain', 'expert', 'sanjay_jain_40_15', 'sanjay_jain_40_15@demo.askexpert.com', '+91 98000 00834',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (18+ Yrs Exp)', 'Other Professional Services Specialist Level 1', 'Other Professional Services',
    18, ARRAY['English', 'Hindi'], 4.90, 173, 500,
    'Certified professional with 18 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-001000000000', '00000000-0000-0000-0000-000000000000', 'tanvi_nair_40_16@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Tanvi Nair"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-001000000000', 'Tanvi Nair', 'expert', 'tanvi_nair_40_16', 'tanvi_nair_40_16@demo.askexpert.com', '+91 98000 00835',
    'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (19+ Yrs Exp)', 'Other Professional Services Specialist Level 2', 'Other Professional Services',
    19, ARRAY['English', 'Hindi'], 4.20, 180, 650,
    'Certified professional with 19 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-001100000000', '00000000-0000-0000-0000-000000000000', 'varun_sharma_40_17@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Varun Sharma"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-001100000000', 'Varun Sharma', 'expert', 'varun_sharma_40_17', 'varun_sharma_40_17@demo.askexpert.com', '+91 98000 00836',
    'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (20+ Yrs Exp)', 'Other Professional Services Specialist Level 3', 'Other Professional Services',
    20, ARRAY['English', 'Hindi'], 4.30, 187, 800,
    'Certified professional with 20 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-001200000000', '00000000-0000-0000-0000-000000000000', 'divya_reddy_40_18@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Divya Reddy"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-001200000000', 'Divya Reddy', 'expert', 'divya_reddy_40_18', 'divya_reddy_40_18@demo.askexpert.com', '+91 98000 00837',
    'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (3+ Yrs Exp)', 'Other Professional Services Specialist Level 1', 'Other Professional Services',
    3, ARRAY['English', 'Hindi'], 4.40, 194, 950,
    'Certified professional with 3 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-001300000000', '00000000-0000-0000-0000-000000000000', 'gautam_kulkarni_40_19@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Gautam Kulkarni"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-001300000000', 'Gautam Kulkarni', 'expert', 'gautam_kulkarni_40_19', 'gautam_kulkarni_40_19@demo.askexpert.com', '+91 98000 00838',
    'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (4+ Yrs Exp)', 'Other Professional Services Specialist Level 2', 'Other Professional Services',
    4, ARRAY['English', 'Hindi'], 4.50, 201, 1100,
    'Certified professional with 4 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-001400000000', '00000000-0000-0000-0000-000000000000', 'swati_malhotra_40_20@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Swati Malhotra"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-001400000000', 'Swati Malhotra', 'expert', 'swati_malhotra_40_20', 'swati_malhotra_40_20@demo.askexpert.com', '+91 98000 00839',
    'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (5+ Yrs Exp)', 'Other Professional Services Specialist Level 3', 'Other Professional Services',
    5, ARRAY['English', 'Hindi'], 4.60, 208, 1250,
    'Certified professional with 5 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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
    'a0000000-0000-0000-2800-001500000000', '00000000-0000-0000-0000-000000000000', 'rajesh_bhattacharya_40_21@demo.askexpert.com',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"Rajesh Bhattacharya"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;

  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    'a0000000-0000-0000-2800-001500000000', 'Rajesh Bhattacharya', 'expert', 'rajesh_bhattacharya_40_21', 'rajesh_bhattacharya_40_21@demo.askexpert.com', '+91 98000 00840',
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80', 'Senior Consultant in Other Professional Services (6+ Yrs Exp)', 'Other Professional Services Specialist Level 1', 'Other Professional Services',
    6, ARRAY['English', 'Hindi'], 4.70, 215, 1400,
    'Certified professional with 6 years of expertise in Other Professional Services. Providing high quality consultation and strategic advisory on AskExpert platform.', ARRAY['Other Professional Services Advisory', 'Consultation', 'Strategy'],
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

END $;

-- ENSURE ALL EXPERTS HAVE IS_VERIFIED = TRUE
UPDATE public.profiles SET is_verified = true WHERE role = 'expert';

SELECT count(*) AS chunk_5_demo_experts FROM public.profiles WHERE is_demo = true;
