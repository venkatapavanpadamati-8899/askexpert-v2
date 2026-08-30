-- ==============================================================================
-- ASKEXPERT - SEED 24 EXPERT PROFILES ACROSS 9 PROFESSIONAL CATEGORIES
-- ==============================================================================

-- STEP 1: CREATE AUTH USERS (IF MISSING)
INSERT INTO auth.users (id, instance_id, email, encrypted_password, email_confirmed_at, raw_user_meta_data, created_at, updated_at, role, aud)
VALUES
  ('11111111-1111-1111-1111-111111111111', '00000000-0000-0000-0000-000000000000', 'vikram.rao@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Adv. Vikram Rao", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('11111111-1111-1111-1111-222222222222', '00000000-0000-0000-0000-000000000000', 'sunita.reddy@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Adv. Sunita Reddy", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('11111111-1111-1111-1111-333333333333', '00000000-0000-0000-0000-000000000000', 'devendra.sharma@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Adv. Devendra Sharma", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('22222222-2222-2222-2222-222222222222', '00000000-0000-0000-0000-000000000000', 'ananya.sharma@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "CA Ananya Sharma", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('22222222-2222-2222-2222-333333333333', '00000000-0000-0000-0000-000000000000', 'rajesh.agarwal@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "CA Rajesh Agarwal", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('22222222-2222-2222-2222-444444444444', '00000000-0000-0000-0000-000000000000', 'preeti.kulkarni@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "CA Preeti Kulkarni", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('33333333-3333-3333-3333-333333333333', '00000000-0000-0000-0000-000000000000', 'rahul.kumar@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Dr. Rahul Kumar", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('33333333-3333-3333-3333-444444444444', '00000000-0000-0000-0000-000000000000', 'karthik.v@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Karthik Viswanathan", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('33333333-3333-3333-3333-555555555555', '00000000-0000-0000-0000-000000000000', 'neha.gupta@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Neha Gupta", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('44444444-4444-4444-4444-444444444444', '00000000-0000-0000-0000-000000000000', 'priya.patel@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Dr. Priya Patel", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('44444444-4444-4444-4444-555555555555', '00000000-0000-0000-0000-000000000000', 'siddharth.verma@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Dr. Siddharth Verma", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('44444444-4444-4444-4444-666666666666', '00000000-0000-0000-0000-000000000000', 'meenakshi.s@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Dr. Meenakshi Sundaram", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('55555555-5555-5555-5555-555555555555', '00000000-0000-0000-0000-000000000000', 'rajesh.menon@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Rajesh Menon", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('55555555-5555-5555-5555-666666666666', '00000000-0000-0000-0000-000000000000', 'pooja.singhania@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Pooja Singhania", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('55555555-5555-5555-5555-777777777777', '00000000-0000-0000-0000-000000000000', 'amitava.b@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Amitava Bannerjee", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('66666666-6666-6666-6666-666666666666', '00000000-0000-0000-0000-000000000000', 'meera.deshmukh@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Meera Deshmukh", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('66666666-6666-6666-6666-777777777777', '00000000-0000-0000-0000-000000000000', 'rohan.malhotra@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Rohan Malhotra", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('66666666-6666-6666-6666-888888888888', '00000000-0000-0000-0000-000000000000', 'shalini.nambiar@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Shalini Nambiar", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('77777777-7777-7777-7777-111111111111', '00000000-0000-0000-0000-000000000000', 'suresh.hegde@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Engr. Suresh Hegde", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('77777777-7777-7777-7777-222222222222', '00000000-0000-0000-0000-000000000000', 'ritu.b@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Ar. Ritu Bhattacharya", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('88888888-8888-8888-8888-111111111111', '00000000-0000-0000-0000-000000000000', 'vikram.joshi@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Vikramaditya Joshi", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('88888888-8888-8888-8888-222222222222', '00000000-0000-0000-0000-000000000000', 'deepa.s@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Deepa Swaminathan", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('99999999-9999-9999-9999-111111111111', '00000000-0000-0000-0000-000000000000', 'arvind.saxena@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Prof. Arvind Saxena", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated'),
  ('99999999-9999-9999-9999-222222222222', '00000000-0000-0000-0000-000000000000', 'sneha.roy@askexpert.com', '$2a$10$abcdefghijklmnopqrstuv', now(), '{"full_name": "Sneha Roy", "role": "expert"}'::jsonb, now(), now(), 'authenticated', 'authenticated')
ON CONFLICT (id) DO NOTHING;

-- STEP 2: INSERT / UPDATE PUBLIC.PROFILES
INSERT INTO public.profiles (
  id, full_name, role, username, email, phone, avatar_url, headline, specialization,
  experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
  availability_status, account_status
) VALUES
  -- 1. Legal Advisor / Lawyer
  ('11111111-1111-1111-1111-111111111111', 'Adv. Vikram Rao', 'expert', 'vikram_rao', 'vikram.rao@askexpert.com', '+91 98765 11111',
   'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
   'Senior Corporate & Regulatory Attorney', 'Legal Advisor / Lawyer', 12,
   ARRAY['English', 'Hindi', 'Marathi'], 4.90, 184, 1200.00,
   'Over 12 years of experience handling corporate litigation, merger agreements, compliance and arbitration.',
   ARRAY['Corporate Law', 'Contract Negotiation', 'Arbitration', 'MCA Filings'], 'available', 'active'),

  ('11111111-1111-1111-1111-222222222222', 'Adv. Sunita Reddy', 'expert', 'sunita_reddy', 'sunita.reddy@askexpert.com', '+91 98765 11112',
   'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80',
   'High Court Criminal & Constitutional Law Specialist', 'Legal Advisor / Lawyer', 15,
   ARRAY['English', 'Telugu', 'Hindi'], 4.95, 240, 1800.00,
   'Senior advocate specializing in criminal defense, marital disputes, and property litigation.',
   ARRAY['Criminal Defense', 'Family Law', 'Property Disputes', 'Bail Applications'], 'available', 'active'),

  ('11111111-1111-1111-1111-333333333333', 'Adv. Devendra Sharma', 'expert', 'devendra_sharma', 'devendra.sharma@askexpert.com', '+91 98765 11113',
   'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80',
   'Cyber Law, Data Privacy & IP Rights Advocate', 'Legal Advisor / Lawyer', 8,
   ARRAY['English', 'Hindi'], 4.80, 112, 1000.00,
   'Cyber security legal consultant advising tech startups and digital enterprises.',
   ARRAY['Cyber Law', 'GDPR/DPDP Compliance', 'IT Act', 'Copyrights & Trademarks'], 'available', 'active'),

  -- 2. Chartered Accountant / Tax Expert
  ('22222222-2222-2222-2222-222222222222', 'CA Ananya Sharma', 'expert', 'ananya_sharma', 'ananya.sharma@askexpert.com', '+91 98765 22221',
   'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80',
   'Chartered Accountant & Corporate Tax Consultant', 'Chartered Accountant / Tax Expert', 9,
   ARRAY['English', 'Hindi', 'Gujarati'], 5.00, 210, 1500.00,
   'Chartered Accountant with expert knowledge in GST compliance and corporate tax planning.',
   ARRAY['GST Audit', 'Corporate Tax', 'Transfer Pricing', 'TDS Returns'], 'available', 'active'),

  ('22222222-2222-2222-2222-333333333333', 'CA Rajesh Agarwal', 'expert', 'rajesh_agarwal', 'rajesh.agarwal@askexpert.com', '+91 98765 22222',
   'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80',
   'Income Tax Appeals & NRI Taxation Specialist', 'Chartered Accountant / Tax Expert', 14,
   ARRAY['English', 'Hindi', 'Bengali'], 4.90, 165, 2200.00,
   'Senior CA handling high-net-worth tax litigation, income tax tribunals, and cross-border assets.',
   ARRAY['NRI Tax', 'Scrutiny Assessment', 'Capital Gains', 'Tax Structuring'], 'available', 'active'),

  ('22222222-2222-2222-2222-444444444444', 'CA Preeti Kulkarni', 'expert', 'preeti_kulkarni', 'preeti.kulkarni@askexpert.com', '+91 98765 22223',
   'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80',
   'Startup Financial Audit & Bookkeeping Advisor', 'Chartered Accountant / Tax Expert', 7,
   ARRAY['English', 'Marathi', 'Hindi'], 4.85, 98, 950.00,
   'Helping early-stage startups build clean books, tax compliance, and investor-ready reporting.',
   ARRAY['Startup Compliance', 'MCA Audit', 'Financial Modeling', 'Payroll Management'], 'available', 'active'),

  -- 3. Software & Cloud Architect
  ('33333333-3333-3333-3333-333333333333', 'Dr. Rahul Kumar', 'expert', 'rahul_kumar', 'rahul.kumar@askexpert.com', '+91 98765 33331',
   'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80',
   'Software Architect & Tech Patent Specialist', 'Software & Cloud Architect', 15,
   ARRAY['English', 'Hindi', 'Kannada'], 4.80, 95, 2000.00,
   'Software architect and IP consultant guiding enterprises through cloud modernization.',
   ARRAY['Cloud Architecture', 'Enterprise Systems', 'Patent Prosecution', 'Tech Licensing'], 'available', 'active'),

  ('33333333-3333-3333-3333-444444444444', 'Karthik Viswanathan', 'expert', 'karthik_v', 'karthik.v@askexpert.com', '+91 98765 33332',
   'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80',
   'Principal AWS & Kubernetes Infrastructure Architect', 'Software & Cloud Architect', 11,
   ARRAY['English', 'Tamil', 'Telugu'], 4.95, 178, 1800.00,
   'Ex-Amazon Cloud Architect helping companies scale infrastructure to millions of users.',
   ARRAY['AWS Cloud', 'Kubernetes', 'DevOps Pipelines', 'System Scalability', 'Microservices'], 'available', 'active'),

  ('33333333-3333-3333-3333-555555555555', 'Neha Gupta', 'expert', 'neha_gupta', 'neha.gupta@askexpert.com', '+91 98765 33333',
   'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80',
   'Full Stack & AI Applications Lead Consultant', 'Software & Cloud Architect', 8,
   ARRAY['English', 'Hindi'], 4.88, 134, 1400.00,
   'Full-stack architect specializing in Generative AI integration, modern web applications, and web performance.',
   ARRAY['React & Node.js', 'Python AI/ML', 'PostgreSQL Optimization', 'System Code Reviews'], 'available', 'active'),

  -- 4. Doctor / Healthcare Specialist
  ('44444444-4444-4444-4444-444444444444', 'Dr. Priya Patel', 'expert', 'priya_patel', 'priya.patel@askexpert.com', '+91 98765 44441',
   'https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80',
   'Medical Regulatory & Telehealth Advisor', 'Doctor / Healthcare Specialist', 10,
   ARRAY['English', 'Hindi', 'Gujarati'], 4.90, 142, 1000.00,
   'Physician and medical health advisor guiding digital health platforms and clinical compliance.',
   ARRAY['Clinical Protocols', 'Telehealth Law', 'Ayush & Pharma', 'Diagnostics'], 'available', 'active'),

  ('44444444-4444-4444-4444-555555555555', 'Dr. Siddharth Verma', 'expert', 'siddharth_verma', 'siddharth.verma@askexpert.com', '+91 98765 44442',
   'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80',
   'Senior Physician & Health-Tech Operations Strategist', 'Doctor / Healthcare Specialist', 16,
   ARRAY['English', 'Hindi', 'Punjabi'], 4.92, 205, 1600.00,
   'Experienced MD consulting on healthcare management, clinical trials, and preventive medicine.',
   ARRAY['Medical Consultation', 'Preventive Health', 'Clinical Trials', 'Hospital Compliance'], 'available', 'active'),

  ('44444444-4444-4444-4444-666666666666', 'Dr. Meenakshi Sundaram', 'expert', 'meenakshi_s', 'meenakshi.s@askexpert.com', '+91 98765 44443',
   'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80',
   'Public Health Advisor & Nutrition Specialist', 'Doctor / Healthcare Specialist', 12,
   ARRAY['English', 'Tamil', 'Hindi'], 4.87, 156, 1100.00,
   'Public health strategist providing personalized nutrition plans and corporate wellness advising.',
   ARRAY['Clinical Nutrition', 'Wellness Programs', 'Disease Prevention', 'Public Health Policy'], 'available', 'active'),

  -- 5. Financial Planner & Wealth Advisor
  ('55555555-5555-5555-5555-555555555555', 'Rajesh Menon', 'expert', 'rajesh_menon', 'rajesh.menon@askexpert.com', '+91 98765 55551',
   'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80',
   'SEBI Registered Investment Advisor & Wealth Strategist', 'Financial Planner & Wealth Advisor', 14,
   ARRAY['English', 'Hindi', 'Malayalam', 'Tamil'], 4.70, 118, 1800.00,
   'Certified wealth consultant helping families and professionals build multi-asset portfolios.',
   ARRAY['Portfolio Structuring', 'Mutual Funds', 'Equities', 'Risk Hedging'], 'offline', 'active'),

  ('55555555-5555-5555-5555-666666666666', 'Pooja Singhania', 'expert', 'pooja_singhania', 'pooja.singhania@askexpert.com', '+91 98765 55552',
   'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80',
   'CFP & High Net-Worth Wealth Management Specialist', 'Financial Planner & Wealth Advisor', 10,
   ARRAY['English', 'Hindi', 'Marwari'], 4.90, 140, 2100.00,
   'Certified Financial Planner advising HNI clients on tax-efficient wealth management.',
   ARRAY['Retirement Planning', 'Estate Planning', 'Tax-Saving Investments', 'Mutual Funds'], 'available', 'active'),

  ('55555555-5555-5555-5555-777777777777', 'Amitava Bannerjee', 'expert', 'amitava_b', 'amitava.b@askexpert.com', '+91 98765 55553',
   'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80',
   'Personal Finance & Debt Restructuring Consultant', 'Financial Planner & Wealth Advisor', 9,
   ARRAY['English', 'Bengali', 'Hindi'], 4.82, 92, 1200.00,
   'Helping salaried professionals optimize budget savings, clear high-interest debt, and invest wisely.',
   ARRAY['Debt Management', 'Emergency Funds', 'Insurance Planning', 'SIP Portfolios'], 'available', 'active'),

  -- 6. Business & Startup Consultant
  ('66666666-6666-6666-6666-666666666666', 'Meera Deshmukh', 'expert', 'meera_deshmukh', 'meera.deshmukh@askexpert.com', '+91 98765 66661',
   'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80',
   'Startup Expansion & Business Strategist', 'Business & Startup Consultant', 11,
   ARRAY['English', 'Hindi', 'Marathi'], 4.80, 88, 1600.00,
   'Business strategist mentoring founders on pitch deck presentation, GTM planning, and operational scaling.',
   ARRAY['Go-to-Market', 'Venture Structuring', 'Pitch Decks', 'Operations'], 'available', 'active'),

  ('66666666-6666-6666-6666-777777777777', 'Rohan Malhotra', 'expert', 'rohan_malhotra', 'rohan.malhotra@askexpert.com', '+91 98765 66662',
   'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80',
   'Venture Capital Fundraising & Business Model Specialist', 'Business & Startup Consultant', 13,
   ARRAY['English', 'Hindi'], 4.93, 160, 2500.00,
   'Ex-VC partner assisting startups in raising seed to Series-A capital.',
   ARRAY['Pitch Decks', 'Investor Readiness', 'Unit Economics', 'Valuation Modeling'], 'available', 'active'),

  ('66666666-6666-6666-6666-888888888888', 'Shalini Nambiar', 'expert', 'shalini_nambiar', 'shalini.nambiar@askexpert.com', '+91 98765 66663',
   'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
   'D2C E-Commerce & Retail Operations Consultant', 'Business & Startup Consultant', 8,
   ARRAY['English', 'Malayalam', 'Hindi'], 4.86, 104, 1300.00,
   'Growth consultant specializing in online DTC brands, customer acquisition, and logistics operations.',
   ARRAY['E-Commerce Growth', 'Supply Chain', 'Brand Strategy', 'Digital Marketing'], 'available', 'active'),

  -- 7. Civil Engineer / Architect
  ('77777777-7777-7777-7777-111111111111', 'Engr. Suresh Hegde', 'expert', 'suresh_hegde', 'suresh.hegde@askexpert.com', '+91 98765 77771',
   'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80',
   'Chief Structural Engineer & Infrastructure Consultant', 'Civil Engineer / Architect', 18,
   ARRAY['English', 'Kannada', 'Hindi'], 4.91, 215, 2000.00,
   'Chartered structural engineer providing safety audits, structural designs, and site inspections.',
   ARRAY['Structural Audit', 'Building Codes', 'RCC Design', 'Construction Management'], 'available', 'active'),

  ('77777777-7777-7777-7777-222222222222', 'Ar. Ritu Bhattacharya', 'expert', 'ritu_b', 'ritu.b@askexpert.com', '+91 98765 77772',
   'https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80',
   'Sustainable Architecture & Interior Design Consultant', 'Civil Engineer / Architect', 10,
   ARRAY['English', 'Bengali', 'Hindi'], 4.88, 125, 1500.00,
   'Principal Architect consulting on eco-friendly residential designs and commercial interiors.',
   ARRAY['Sustainable Design', '3D Architectural Blueprints', 'Space Planning', 'LEED Certification'], 'available', 'active'),

  -- 8. Career & HR Counselor
  ('88888888-8888-8888-8888-111111111111', 'Vikramaditya Joshi', 'expert', 'vikram_joshi', 'vikram.joshi@askexpert.com', '+91 98765 88881',
   'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80',
   'Executive Leadership Coach & HR Transformation Consultant', 'Career & HR Counselor', 15,
   ARRAY['English', 'Hindi', 'Gujarati'], 4.94, 190, 1750.00,
   'HR Leader guiding mid-to-executive level professionals on career growth and leadership transition.',
   ARRAY['Executive Coaching', 'Performance Management', 'HR Policy', 'Leadership Strategy'], 'available', 'active'),

  ('88888888-8888-8888-8888-222222222222', 'Deepa Swaminathan', 'expert', 'deepa_s', 'deepa.s@askexpert.com', '+91 98765 88882',
   'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80',
   'Career Transition & Interview Success Coach', 'Career & HR Counselor', 7,
   ARRAY['English', 'Tamil', 'Hindi'], 4.89, 145, 900.00,
   'Career coach helping candidates clear tech and corporate interviews with confidence.',
   ARRAY['Resume Optimization', 'Mock Interviews', 'LinkedIn Branding', 'Salary Negotiation'], 'available', 'active'),

  -- 9. Education & Study Abroad Mentor
  ('99999999-9999-9999-9999-111111111111', 'Prof. Arvind Saxena', 'expert', 'arvind_saxena', 'arvind.saxena@askexpert.com', '+91 98765 99991',
   'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80',
   'Ivy League & US/UK University Admissions Mentor', 'Education & Study Abroad Mentor', 16,
   ARRAY['English', 'Hindi'], 4.96, 230, 2400.00,
   'Former admissions evaluator guiding students into Top 20 global universities.',
   ARRAY['SOP Editing', 'LOR Strategy', 'US/UK Applications', 'Scholarship Guidance'], 'available', 'active'),

  ('99999999-9999-9999-9999-222222222222', 'Sneha Roy', 'expert', 'sneha_roy', 'sneha.roy@askexpert.com', '+91 98765 99992',
   'https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80',
   'European University Admissions & Visa Consultant', 'Education & Study Abroad Mentor', 8,
   ARRAY['English', 'German', 'Hindi'], 4.85, 110, 1250.00,
   'Study abroad advisor specialized in tuition-free and low-cost European higher education.',
   ARRAY['Germany/Nordic Admissions', 'Student Visa Process', 'IELTS Prep', 'Course Selection'], 'available', 'active')
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  headline = EXCLUDED.headline,
  specialization = EXCLUDED.specialization,
  experience_years = EXCLUDED.experience_years,
  languages = EXCLUDED.languages,
  rating = EXCLUDED.rating,
  reviews_count = EXCLUDED.reviews_count,
  consultation_fee = EXCLUDED.consultation_fee,
  avatar_url = EXCLUDED.avatar_url,
  skills = EXCLUDED.skills,
  availability_status = EXCLUDED.availability_status,
  is_verified = true;

-- ENSURE ALL EXPERT PROFILES ARE MARKED AS VERIFIED
UPDATE public.profiles SET is_verified = true WHERE role = 'expert';

-- VERIFY COUNT OF SEEDED EXPERTS
SELECT count(*) AS total_seeded_experts FROM public.profiles WHERE role = 'expert' AND is_verified = true;
