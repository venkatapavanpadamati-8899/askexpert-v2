-- =============================================================================
-- ASKEXPERT - COLLEGE SAFETY TEST DATA SETUP
-- =============================================================================
-- Synthetic test data only.
-- DO NOT use real student data.
--
-- Auth users must already exist in Supabase Authentication.
-- =============================================================================

DO $$
DECLARE
  v_student_a_id uuid := 'deeba323-4644-48a2-bf51-ba2c5627c784';
  v_student_b_id uuid := '547b7525-6021-4b6e-9869-a571954bf251';
  v_staff_a_id   uuid := 'f4a1a2bf-97cd-4d40-9085-a699e543de7d';
  v_staff_b_id   uuid := 'ee1c1a87-a6ba-4939-8d34-baaed7443c8c';
  v_unauth_id    uuid := '99ce795d-b098-4156-944f-a8b2f02d691c';

  v_college_a_id uuid;
  v_college_b_id uuid;

  v_inc_a_id     uuid := gen_random_uuid();
  v_inc_b_id     uuid := gen_random_uuid();
  v_inc_sos_id   uuid := gen_random_uuid();

BEGIN

  -- ===========================================================================
  -- 1. CREATE / REUSE TEST COLLEGES
  -- ===========================================================================

  INSERT INTO public.colleges (id, name, code)
  VALUES
    (gen_random_uuid(), 'TEST_COLLEGE_A', 'TCOL_A'),
    (gen_random_uuid(), 'TEST_COLLEGE_B', 'TCOL_B')
  ON CONFLICT (code)
  DO UPDATE SET
    name = EXCLUDED.name;

  -- Re-fetch the actual IDs.
  SELECT id
  INTO v_college_a_id
  FROM public.colleges
  WHERE code = 'TCOL_A';

  SELECT id
  INTO v_college_b_id
  FROM public.colleges
  WHERE code = 'TCOL_B';

  IF v_college_a_id IS NULL THEN
    RAISE EXCEPTION 'TEST_COLLEGE_A was not created/found';
  END IF;

  IF v_college_b_id IS NULL THEN
    RAISE EXCEPTION 'TEST_COLLEGE_B was not created/found';
  END IF;


  -- ===========================================================================
  -- 2. CREATE / UPDATE TEST PROFILES
  -- ===========================================================================
  --
  -- IMPORTANT:
  -- Use role values supported by the existing profiles.role constraint.
  -- Existing AskExpert installations normally use:
  -- user / expert / admin
  --
  -- Safety authorization is controlled by safety_staff, not by inventing
  -- unsupported profiles.role values.
  --

  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud,
    confirmation_token, recovery_token, email_change_token_new, email_change
  ) VALUES 
    (v_student_a_id, '00000000-0000-0000-0000-000000000000', 'studenta@testcollegea.edu', crypt('TestStudentA!2026', gen_salt('bf', 10)), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"TEST Student A"}', NOW(), NOW(), 'authenticated', 'authenticated', '', '', '', ''),
    (v_student_b_id, '00000000-0000-0000-0000-000000000000', 'studentb@testcollegeb.edu', crypt('TestStudentB!2026', gen_salt('bf', 10)), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"TEST Student B"}', NOW(), NOW(), 'authenticated', 'authenticated', '', '', '', ''),
    (v_staff_a_id, '00000000-0000-0000-0000-000000000000', 'staffa@testcollegea.edu', crypt('TestStaffA!2026', gen_salt('bf', 10)), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"TEST Safety Officer A"}', NOW(), NOW(), 'authenticated', 'authenticated', '', '', '', ''),
    (v_staff_b_id, '00000000-0000-0000-0000-000000000000', 'staffb@testcollegeb.edu', crypt('TestStaffB!2026', gen_salt('bf', 10)), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"TEST Safety Officer B"}', NOW(), NOW(), 'authenticated', 'authenticated', '', '', '', ''),
    (v_unauth_id, '00000000-0000-0000-0000-000000000000', 'unauthorized@random.com', crypt('TestUnauth!2026', gen_salt('bf', 10)), NOW(), '{"provider":"email","providers":["email"]}', '{"full_name":"Unauthorized User"}', NOW(), NOW(), 'authenticated', 'authenticated', '', '', '', '')
  ON CONFLICT (id) DO UPDATE SET 
    encrypted_password = EXCLUDED.encrypted_password,
    confirmation_token = '',
    recovery_token = '',
    email_change_token_new = '',
    email_change = '';

  INSERT INTO auth.identities (
    id, user_id, provider_id, identity_data, provider, created_at, updated_at
  ) VALUES 
    (gen_random_uuid(), v_student_a_id, v_student_a_id::text, jsonb_build_object('sub', v_student_a_id::text, 'email', 'studenta@testcollegea.edu'), 'email', NOW(), NOW()),
    (gen_random_uuid(), v_student_b_id, v_student_b_id::text, jsonb_build_object('sub', v_student_b_id::text, 'email', 'studentb@testcollegeb.edu'), 'email', NOW(), NOW()),
    (gen_random_uuid(), v_staff_a_id, v_staff_a_id::text, jsonb_build_object('sub', v_staff_a_id::text, 'email', 'staffa@testcollegea.edu'), 'email', NOW(), NOW()),
    (gen_random_uuid(), v_staff_b_id, v_staff_b_id::text, jsonb_build_object('sub', v_staff_b_id::text, 'email', 'staffb@testcollegeb.edu'), 'email', NOW(), NOW()),
    (gen_random_uuid(), v_unauth_id, v_unauth_id::text, jsonb_build_object('sub', v_unauth_id::text, 'email', 'unauthorized@random.com'), 'email', NOW(), NOW())
  ON CONFLICT (provider_id, provider) DO NOTHING;

  INSERT INTO public.profiles
    (id, full_name, role, email, college_id, department)
  VALUES
    (
      v_student_a_id,
      'TEST Student A',
      'user',
      'studenta@testcollegea.edu',
      v_college_a_id,
      'CSE'
    ),
    (
      v_student_b_id,
      'TEST Student B',
      'user',
      'studentb@testcollegeb.edu',
      v_college_b_id,
      'ECE'
    ),
    (
      v_staff_a_id,
      'TEST Safety Officer A',
      'admin',
      'staffa@testcollegea.edu',
      v_college_a_id,
      'Administration'
    ),
    (
      v_staff_b_id,
      'TEST Safety Officer B',
      'admin',
      'staffb@testcollegeb.edu',
      v_college_b_id,
      'Administration'
    ),
    (
      v_unauth_id,
      'Unauthorized User',
      'user',
      'unauthorized@random.com',
      v_college_b_id,
      'ME'
    )
  ON CONFLICT (id)
  DO UPDATE SET
    full_name = EXCLUDED.full_name,
    role = EXCLUDED.role,
    college_id = EXCLUDED.college_id,
    department = EXCLUDED.department;


  -- ===========================================================================
  -- 3. ASSIGN SAFETY STAFF ROLE
  -- ===========================================================================

  INSERT INTO public.safety_staff
    (profile_id, college_id, staff_role, is_active)
  VALUES
    (
      v_staff_a_id,
      v_college_a_id,
      'manager',
      true
    ),
    (
      v_staff_b_id,
      v_college_b_id,
      'manager',
      true
    )
  ON CONFLICT (college_id, profile_id)
  DO UPDATE SET
    staff_role = EXCLUDED.staff_role,
    is_active = true;


  -- ===========================================================================
  -- 4. TEST SAFETY CONTACTS
  -- ===========================================================================

  INSERT INTO public.safety_contacts
    (
      college_id,
      name,
      contact_role,
      phone,
      email,
      is_active
    )
  VALUES
    (
      v_college_a_id,
      'TEST Safety Cell',
      'Women Safety Cell',
      '+91-9999900001',
      'safety@testcollegea.edu',
      true
    ),
    (
      v_college_a_id,
      'TEST Security',
      'Security Officer',
      '+91-9999900002',
      'security@testcollegea.edu',
      true
    ),
    (
      v_college_b_id,
      'TEST Safety Cell B',
      'Women Safety Cell',
      '+91-9999900003',
      'safety@testcollegeb.edu',
      true
    );


  -- ===========================================================================
  -- 5. TEST INCIDENTS
  -- ===========================================================================


  INSERT INTO public.safety_incidents
    (
      id,
      college_id,
      student_id,
      incident_type,
      severity,
      status,
      message
    )
  VALUES
    (
      v_inc_b_id,
      v_college_b_id,
      v_student_b_id,
      'bullying',
      'MEDIUM',
      'ACTIVE',
      'TEST_FIXTURE: Student B complaint about bullying'
    ),
    (
      v_inc_a_id,
      v_college_a_id,
      v_student_a_id,
      'harassment',
      'HIGH',
      'ACTIVE',
      'TEST_FIXTURE: Student A complaint for isolated testing'
    )
  ON CONFLICT (id)
  DO NOTHING;



  -- (Removed location for SOS as SOS was removed)

  -- ===========================================================================
  -- 7. VERIFICATION OUTPUT
  -- ===========================================================================

  RAISE NOTICE '===========================================';
  RAISE NOTICE 'TEST DATA SETUP COMPLETE';
  RAISE NOTICE '===========================================';
  RAISE NOTICE 'College A ID: %', v_college_a_id;
  RAISE NOTICE 'College B ID: %', v_college_b_id;
  RAISE NOTICE 'Student A: %', v_student_a_id;
  RAISE NOTICE 'Student B: %', v_student_b_id;
  RAISE NOTICE 'Staff A: %', v_staff_a_id;
  RAISE NOTICE 'Staff B: %', v_staff_b_id;
  RAISE NOTICE 'Unauthorized: %', v_unauth_id;
  RAISE NOTICE '===========================================';

END
$$;


-- =============================================================================
-- VERIFY TEST FIXTURES
-- =============================================================================

SELECT
  code,
  name,
  id
FROM public.colleges
WHERE code IN ('TCOL_A', 'TCOL_B')
ORDER BY code;


SELECT
  id,
  full_name,
  role,
  college_id,
  department
FROM public.profiles
WHERE id IN
(
  'deeba323-4644-48a2-bf51-ba2c5627c784',
  '547b7525-6021-4b6e-9869-a571954bf251',
  'f4a1a2bf-97cd-4d40-9085-a699e543de7d',
  'ee1c1a87-a6ba-4939-8d34-baaed7443c8c',
  '99ce795d-b098-4156-944f-a8b2f02d691c'
);


SELECT
  profile_id,
  college_id,
  staff_role,
  is_active
FROM public.safety_staff
WHERE profile_id IN
(
  'f4a1a2bf-97cd-4d40-9085-a699e543de7d',
  'ee1c1a87-a6ba-4939-8d34-baaed7443c8c'
);


SELECT
  id,
  college_id,
  student_id,
  incident_type,
  severity,
  status,
  message
FROM public.safety_incidents
WHERE message LIKE 'TEST_FIXTURE:%'
ORDER BY created_at DESC;
