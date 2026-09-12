import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://girexuzrkeiylkbqglks.supabase.co';
const anonKey = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(supabaseUrl, anonKey);

async function simulateAdminLogin() {
  console.log('--- Simulating Admin Login Flow ---');
  const email = 'venkatapavanpadamati1@gmail.com';
  const password = 'Pavan@123';

  // 1. Authenticate with Supabase Auth
  const { data, error } = await supabase.auth.signInWithPassword({
    email,
    password
  });

  if (error || !data?.user) {
    console.error('FAIL: Auth failed:', error?.message);
    return;
  }
  console.log('SUCCESS: Supabase Auth passed, user ID:', data.user.id);

  // 2. Query public.profiles
  const { data: prof, error: profError } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', data.user.id)
    .maybeSingle();

  console.log('Profile query result:', prof, profError);

  if (profError || !prof) {
    console.error('FAIL: Profile not found');
    return;
  }

  // 3. Check role === 'admin'
  if (prof.role === 'admin') {
    console.log('SUCCESS: Verified as ADMIN! Ready to redirect to admin-dashboard.html');
  } else {
    console.error('FAIL: Role is not admin:', prof.role);
  }
}

simulateAdminLogin();
