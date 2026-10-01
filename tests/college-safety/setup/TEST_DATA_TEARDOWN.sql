  DELETE FROM public.safety_incidents
  WHERE student_id IN (
    'deeba323-4644-48a2-bf51-ba2c5627c784',
    '547b7525-6021-4b6e-9869-a571954bf251',
    'f4a1a2bf-97cd-4d40-9085-a699e543de7d',
    'ee1c1a87-a6ba-4939-8d34-baaed7443c8c',
    '99ce795d-b098-4156-944f-a8b2f02d691c'
  );

  DELETE FROM auth.users
  WHERE email IN (
    'studenta@testcollegea.edu',
    'studentb@testcollegeb.edu',
    'staffa@testcollegea.edu',
    'staffb@testcollegeb.edu',
    'unauthorized@random.com'
  );
  
  DELETE FROM public.colleges
  WHERE code IN ('TCOL_A', 'TCOL_B');
