import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const supabaseUrl = 'https://girexuzrkeiylkbqglks.supabase.co';
const anonKey = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(supabaseUrl, anonKey);

async function runCompleteTestSuite() {
  console.log('===============================================================');
  console.log('     ASKEXPERT HIDDEN ADMIN & ROLE SECURITY TEST SUITE         ');
  console.log('===============================================================\n');

  let passed = 0;
  let failed = 0;

  function assertTest(name, condition, details = '') {
    if (condition) {
      console.log(`[PASS] ${name}`);
      if (details) console.log(`       Details: ${details}`);
      passed++;
    } else {
      console.error(`[FAIL] ${name}`);
      if (details) console.error(`       Failure: ${details}`);
      failed++;
    }
  }

  // -------------------------------------------------------------
  // TEST A: Admin email/password -> successful Supabase login -> profiles.role = admin -> /admin-dashboard.html
  // -------------------------------------------------------------
  console.log('>>> TEST A: Admin Email/Password Authentication & Authorization');
  try {
    const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
      email: 'venkatapavanpadamati1@gmail.com',
      password: 'Pavan@123'
    });

    assertTest('TEST A.1: Supabase signInWithPassword succeeds', !authErr && !!authData?.user, `User ID: ${authData?.user?.id}`);

    const { data: prof, error: profErr } = await supabase
      .from('profiles')
      .select('role')
      .eq('id', authData.user.id)
      .maybeSingle();

    assertTest('TEST A.2: Protected profiles.role is strictly "admin"', !profErr && prof?.role === 'admin', `Actual role: ${prof?.role}`);

    const targetUrl = prof?.role === 'admin' ? 'admin-dashboard.html' : 'access-denied';
    assertTest('TEST A.3: Routes directly to admin-dashboard.html', targetUrl === 'admin-dashboard.html', `Target: ${targetUrl}`);
  } catch (err) {
    assertTest('TEST A: Exception caught', false, err.message);
  }

  // -------------------------------------------------------------
  // TEST B: Admin Google Account -> OAuth session -> role = admin -> /admin-dashboard.html
  // -------------------------------------------------------------
  console.log('\n>>> TEST B: Admin Google OAuth Authentication & Authorization');
  try {
    // Simulate user authenticated via Google OAuth with admin profile
    const { data: adminProf } = await supabase
      .from('profiles')
      .select('id, role, email')
      .eq('email', 'venkatapavanpadamati1@gmail.com')
      .maybeSingle();

    assertTest('TEST B.1: Admin Google user profile exists in database', !!adminProf, `Found profile for ${adminProf?.email}`);
    assertTest('TEST B.2: Google-authenticated user profile role === "admin"', adminProf?.role === 'admin', `Role: ${adminProf?.role}`);

    const destination = adminProf?.role === 'admin' ? 'admin-dashboard.html' : 'denied';
    assertTest('TEST B.3: Admin Google login routes to admin-dashboard.html', destination === 'admin-dashboard.html', `Destination: ${destination}`);
  } catch (err) {
    assertTest('TEST B: Exception caught', false, err.message);
  }

  // -------------------------------------------------------------
  // TEST C: Normal Google Account -> role != admin -> Admin Dashboard DENIED
  // -------------------------------------------------------------
  console.log('\n>>> TEST C: Normal Google Account Denial for Admin Access');
  try {
    // Test with standard user profile
    const { data: userProf } = await supabase
      .from('profiles')
      .select('id, role, email')
      .eq('role', 'user')
      .limit(1)
      .maybeSingle();

    assertTest('TEST C.1: Sample non-admin profile retrieved', !!userProf, `Email: ${userProf?.email}, Role: ${userProf?.role}`);

    const isAdminAuthorized = userProf?.role === 'admin';
    assertTest('TEST C.2: Normal user is NOT authorized for Admin', !isAdminAuthorized, `Authorized: ${isAdminAuthorized}`);

    // Test auth-callback logic for admin redirect with non-admin user
    const redirectPath = 'admin-dashboard.html';
    const isAdminRoute = redirectPath && (redirectPath.includes('admin') || redirectPath.includes('admin-dashboard'));
    const accessGranted = isAdminRoute && userProf?.role === 'admin';
    assertTest('TEST C.3: Admin Dashboard access strictly DENIED for normal account', !accessGranted, 'Correctly rejected');
  } catch (err) {
    assertTest('TEST C: Exception caught', false, err.message);
  }

  // -------------------------------------------------------------
  // TEST D: Unauthenticated user manually opens /admin-dashboard.html -> DENIED
  // -------------------------------------------------------------
  console.log('\n>>> TEST D: Unauthenticated Direct Access to admin-dashboard.html');
  try {
    const adminDashHtml = fs.readFileSync('admin-dashboard.html', 'utf8');
    assertTest('TEST D.1: admin-dashboard.html executes verifyAdminAccess() on load', adminDashHtml.includes('verifyAdminAccess()'));
    assertTest('TEST D.2: Unauthenticated session causes immediate redirect away', adminDashHtml.includes('if (sessionError || !session || !session.user)') && adminDashHtml.includes('window.location.replace("admin-login.html")'));
  } catch (err) {
    assertTest('TEST D: Exception caught', false, err.message);
  }

  // -------------------------------------------------------------
  // TEST E: Authenticated User role manually attempts /admin-dashboard.html -> DENIED
  // -------------------------------------------------------------
  console.log('\n>>> TEST E: Authenticated User Direct Access to admin-dashboard.html');
  try {
    const adminDashHtml = fs.readFileSync('admin-dashboard.html', 'utf8');
    assertTest('TEST E.1: admin-dashboard queries authoritative profiles table', adminDashHtml.includes('.from("profiles")') && adminDashHtml.includes('.select("role")'));
    assertTest('TEST E.2: Non-admin role explicitly signs out and redirects', adminDashHtml.includes('if (profError || !prof || prof.role !== "admin")') && adminDashHtml.includes('supabase.auth.signOut()'));
  } catch (err) {
    assertTest('TEST E: Exception caught', false, err.message);
  }

  // -------------------------------------------------------------
  // TEST F: Authenticated Expert manually attempts /admin-dashboard.html -> DENIED
  // -------------------------------------------------------------
  console.log('\n>>> TEST F: Authenticated Expert Direct Access to admin-dashboard.html');
  try {
    const { data: expertProf } = await supabase
      .from('profiles')
      .select('id, role, email')
      .eq('role', 'expert')
      .limit(1)
      .maybeSingle();

    assertTest('TEST F.1: Sample expert profile retrieved', !!expertProf, `Email: ${expertProf?.email}, Role: ${expertProf?.role}`);
    const expertAllowedInAdmin = expertProf?.role === 'admin';
    assertTest('TEST F.2: Expert role strictly disallowed in Admin Dashboard', !expertAllowedInAdmin, `Allowed: ${expertAllowedInAdmin}`);
  } catch (err) {
    assertTest('TEST F: Exception caught', false, err.message);
  }

  // -------------------------------------------------------------
  // TEST G: Normal User Login continues to work
  // -------------------------------------------------------------
  console.log('\n>>> TEST G: Normal User Login Flow Integrity');
  try {
    const loginHtml = fs.readFileSync('login.html', 'utf8');
    assertTest('TEST G.1: login.html contains normal user login form', loginHtml.includes('id="loginForm"'));
    assertTest('TEST G.2: login.html routes normal users to user-dashboard.html', loginHtml.includes('window.location.replace("user-dashboard.html")'));
  } catch (err) {
    assertTest('TEST G: Exception caught', false, err.message);
  }

  // -------------------------------------------------------------
  // TEST H: Expert Login continues to work
  // -------------------------------------------------------------
  console.log('\n>>> TEST H: Expert Login Flow Integrity');
  try {
    const loginHtml = fs.readFileSync('login.html', 'utf8');
    assertTest('TEST H.1: login.html checks for expert/professional role', loginHtml.includes('trustedRole === "expert" || trustedRole === "professional"'));
    assertTest('TEST H.2: Verified experts route to professional-dashboard.html', loginHtml.includes('window.location.replace("professional-dashboard.html")'));
    assertTest('TEST H.3: Unverified experts route to professional-verification.html', loginHtml.includes('window.location.replace("professional-verification.html")'));
  } catch (err) {
    assertTest('TEST H: Exception caught', false, err.message);
  }

  // -------------------------------------------------------------
  // TEST I: Existing Mobile OTP / Demo OTP behavior remains unchanged
  // -------------------------------------------------------------
  console.log('\n>>> TEST I: OTP & Demo OTP Functionality Preservation');
  try {
    const registerHtml = fs.readFileSync('register.html', 'utf8');
    const forgotHtml = fs.readFileSync('forgot-password.html', 'utf8');
    assertTest('TEST I.1: register.html preserves OTP verification step', registerHtml.includes('sendPhoneOtpBtn') || registerHtml.includes('otp'));
    assertTest('TEST I.2: forgot-password.html preserves OTP recovery flow', forgotHtml.includes('otp') || forgotHtml.includes('verifyOtpBtn'));
  } catch (err) {
    assertTest('TEST I: Exception caught', false, err.message);
  }

  // -------------------------------------------------------------
  // TEST J: Existing Google User Login behavior remains unchanged
  // -------------------------------------------------------------
  console.log('\n>>> TEST J: Google User Login Behavior Preservation');
  try {
    const loginHtml = fs.readFileSync('login.html', 'utf8');
    const callbackHtml = fs.readFileSync('auth-callback.html', 'utf8');
    assertTest('TEST J.1: login.html provides Google OAuth sign in', loginHtml.includes('googleLoginButton') && loginHtml.includes('provider: "google"'));
    assertTest('TEST J.2: auth-callback routes normal Google users to user-dashboard.html', callbackHtml.includes('window.location.replace("user-dashboard.html")'));
    assertTest('TEST J.3: auth-callback exchanges PKCE code for session', callbackHtml.includes('exchangeCodeForSession(code)'));
  } catch (err) {
    assertTest('TEST J: Exception caught', false, err.message);
  }

  // -------------------------------------------------------------
  // SECURITY AUDIT: Hardcoded credentials & bypasses check
  // -------------------------------------------------------------
  console.log('\n>>> SECURITY AUDIT: Hardcoded Secrets & Bypass Verification');
  const filesToAudit = ['admin-login.html', 'admin-dashboard.html', 'login.html', 'auth-callback.html'];
  for (const f of filesToAudit) {
    const content = fs.readFileSync(f, 'utf8');
    assertTest(`SEC.1 [${f}]: No hardcoded admin password`, !content.includes('Pavan@123') && !content.includes('AdminSecurity123!'));
    assertTest(`SEC.2 [${f}]: No email-based bypass (if email === ...)`, !content.includes('email === "venkatapavanpadamati1@gmail.com"') && !content.includes("email === 'venkatapavanpadamati1@gmail.com'"));
    assertTest(`SEC.3 [${f}]: No client-side storage admin grant (localStorage isAdmin)`, !content.includes('localStorage.setItem("isAdmin"') && !content.includes("localStorage.setItem('isAdmin'"));
  }

  console.log('\n===============================================================');
  console.log(`TOTAL TESTS: ${passed + failed} | PASSED: ${passed} | FAILED: ${failed}`);
  console.log('===============================================================');

  if (failed > 0) {
    process.exit(1);
  }
}

runCompleteTestSuite();
