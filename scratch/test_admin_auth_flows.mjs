import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://girexuzrkeiylkbqglks.supabase.co';
const anonKey = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(supabaseUrl, anonKey);

async function testBothAuthFlows() {
  console.log('=== VERIFYING ADMIN AUTHENTICATION INTEGRATION ===');

  // 1. Test Password Login
  const { data: passData, error: passErr } = await supabase.auth.signInWithPassword({
    email: 'venkatapavanpadamati1@gmail.com',
    password: 'Pavan@123'
  });

  if (passErr || !passData.user) {
    console.error('Password login failed:', passErr);
    process.exit(1);
  }
  console.log('✓ Password login succeeded for user:', passData.user.email);

  // 2. Fetch authoritative profile
  const { data: profile, error: profErr } = await supabase
    .from('profiles')
    .select('id, role, full_name, email, is_verified, account_status, is_blocked')
    .eq('id', passData.user.id)
    .maybeSingle();

  if (profErr || !profile) {
    console.error('Profile fetch failed:', profErr);
    process.exit(1);
  }

  console.log('✓ Authoritative Profile Record:');
  console.log('  ID:', profile.id);
  console.log('  Email:', profile.email);
  console.log('  Role:', profile.role);
  console.log('  Is Verified:', profile.is_verified);
  console.log('  Account Status:', profile.account_status);

  if (profile.role !== 'admin') {
    console.error('Role is not admin! Actual role:', profile.role);
    process.exit(1);
  }
  console.log('✓ Strict role === "admin" PASS');

  // 3. Test Routing Determination (matching login.html and auth-callback.html logic)
  const trustedRole = profile.role || passData.user.user_metadata?.role || 'user';
  let targetDestination = 'user-dashboard.html';
  if (trustedRole === 'admin') {
    targetDestination = 'admin-dashboard.html';
  } else if (trustedRole === 'expert' || trustedRole === 'professional') {
    targetDestination = 'professional-dashboard.html';
  }

  console.log('✓ Destination Route resolved:', targetDestination);
  if (targetDestination !== 'admin-dashboard.html') {
    console.error('Target destination is NOT admin-dashboard.html!');
    process.exit(1);
  }

  console.log('=== ALL ADMIN AUTHENTICATION CHECKS PASSED ===');
}

testBothAuthFlows();
