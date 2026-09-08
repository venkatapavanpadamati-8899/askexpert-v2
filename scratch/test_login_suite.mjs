import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function runTests() {
  console.log('=== ASKEXPERT LOGIN SUITE AUDIT & TEST ===');

  // Test 1: Verify login.html static integrity
  const loginHtml = fs.readFileSync('login.html', 'utf-8');
  const hasRegisterLink = loginHtml.includes('href="./register.html"') || loginHtml.includes('href="register.html"');
  const hasGoogleButton = loginHtml.includes('id="googleLoginButton"');
  const hasDemoOtp = loginHtml.includes('id="demoOtpBox"');
  const hasNoAutoRedirectOnLoggedOut = loginHtml.includes('if (error || !session || !session.user)') && loginHtml.includes('return;');

  console.log('HTML Structure Checks:', {
    hasRegisterLink,
    hasGoogleButton,
    hasDemoOtp,
    hasNoAutoRedirectOnLoggedOut
  });

  // Test 2: Verify Supabase project credentials in assets/js/common/supabaseClient.js
  const clientJs = fs.readFileSync('assets/js/common/supabaseClient.js', 'utf-8');
  const isCorrectUrl = clientJs.includes('https://girexuzrkeiylkbqglks.supabase.co');
  const hasOldProject = clientJs.includes('ejfdojuxkyymadvpfvat');
  console.log('Supabase Client Config Checks:', {
    isCorrectUrl,
    hasOldProject
  });

  // Test 3: Sign in with invalid credentials
  console.log('\nTesting Invalid Credentials Behavior...');
  const invalidRes = await supabase.auth.signInWithPassword({
    email: 'nonexistent_user_askexpert@askexpert.local',
    password: 'WrongPassword123!'
  });
  console.log('Invalid Credentials Response:', {
    hasSession: !!invalidRes.data?.session,
    errorStatus: invalidRes.error?.status,
    errorCode: invalidRes.error?.code,
    errorMessage: invalidRes.error?.message
  });

  // Test 4: Create a test user and sign in with valid credentials
  console.log('\nTesting Valid Credentials Behavior...');
  const testEmail = `valid_user_${Date.now()}@askexpert.local`;
  const testPassword = 'ValidSecurePass123!@#';
  const signUpRes = await supabase.auth.signUp({
    email: testEmail,
    password: testPassword,
    options: {
      data: {
        full_name: 'Test Audit User'
      }
    }
  });

  console.log('Sign Up Response:', {
    userId: signUpRes.data?.user?.id,
    hasSession: !!signUpRes.data?.session,
    error: signUpRes.error?.message
  });

  const signInRes = await supabase.auth.signInWithPassword({
    email: testEmail,
    password: testPassword
  });

  console.log('Sign In Response:', {
    userId: signInRes.data?.user?.id,
    hasSession: !!signInRes.data?.session,
    error: signInRes.error?.message
  });

  // Test 5: Profile lookup after sign in
  if (signInRes.data?.user?.id) {
    const { data: profile, error: profErr } = await supabase
      .from('profiles')
      .select('id, role, is_blocked, is_verified, full_name')
      .eq('id', signInRes.data.user.id)
      .maybeSingle();

    console.log('Profile Lookup:', {
      profileExists: !!profile,
      role: profile?.role,
      is_blocked: profile?.is_blocked,
      profErr: profErr?.message
    });
  }

  console.log('\n=== AUDIT COMPLETE ===');
}

runTests().catch(console.error);
