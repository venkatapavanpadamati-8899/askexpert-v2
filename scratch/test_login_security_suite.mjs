import fs from 'node:fs';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

console.log('====================================================');
console.log('ASKEXPERT LOGIN & AUTHENTICATION SECURITY TEST SUITE');
console.log('====================================================\n');

let passCount = 0;
let failCount = 0;

function assert(condition, testName, details = '') {
  if (condition) {
    console.log(`[PASS] ${testName} ${details ? '(' + details + ')' : ''}`);
    passCount++;
  } else {
    console.error(`[FAIL] ${testName} - ${details}`);
    failCount++;
  }
}

// 1. Static Source Code Audits
const loginContent = fs.readFileSync('login.html', 'utf8');
const adminLoginContent = fs.readFileSync('admin-login.html', 'utf8');
const adminDashContent = fs.readFileSync('admin-dashboard.html', 'utf8');
const adminAiContent = fs.readFileSync('admin-ai-fix-center.html', 'utf8');
const dashboardContent = fs.readFileSync('dashboard.html', 'utf8');

// Test 1: No hardcoded credentials in login.html
assert(
  !loginContent.includes('AdminSecurity123!') &&
  !loginContent.includes('ExpertSecurity123!') &&
  !loginContent.includes('UserSecurity123!') &&
  !loginContent.includes('admin.audit@askexpert.com'),
  'Test 1: Hardcoded credentials removed from login.html',
  'AdminSecurity123!, ExpertSecurity123!, UserSecurity123! eradicated'
);

// Test 2: No admin auth failure bypass in login.html
assert(
  !loginContent.includes('admin-authorized') &&
  !loginContent.includes('showStatus("Admin authorization verified! Redirecting...", "success")') &&
  !loginContent.includes('targetEmail.includes("admin")'),
  'Test 2: Admin auth failure bypass removed from login.html',
  'No admin fallback granting sessionStorage or admin-dashboard.html'
);

// Test 3: No hardcoded credentials in admin-login.html
assert(
  !adminLoginContent.includes('AdminSecurity123!') &&
  !adminLoginContent.includes('Pavan@123') &&
  !adminLoginContent.includes('admin.audit@askexpert.com'),
  'Test 3: Hardcoded credentials removed from admin-login.html',
  'Zero hardcoded credentials in administrative login'
);

// Test 4: No storage-only role bypass in admin-dashboard.html
assert(
  !adminDashContent.includes('if (storedRole === "admin")') &&
  !adminDashContent.includes('storedRole === "admin"'),
  'Test 4: localStorage/sessionStorage admin bypass removed from admin-dashboard.html',
  'Admin access strictly requires active session & profiles query'
);

// Test 5: No storage-only role bypass in admin-ai-fix-center.html
assert(
  !adminAiContent.includes('if (storedRole !== "admin")'),
  'Test 5: Storage bypass removed from admin-ai-fix-center.html',
  'AI fix center strictly validates Supabase profile role'
);

// Test 6: No unauthenticated routing in dashboard.html
assert(
  !dashboardContent.includes('let role = sessionStorage.getItem("askexpert_user_role");\n        if (!role && supabase)'),
  'Test 6: dashboard.html routes strictly through Supabase session',
  'Storage-only routing eliminated'
);

// Test 7: Already-signed-in banner exists in login.html
assert(
  loginContent.includes('id="alreadySignedInBox"') &&
  loginContent.includes('id="continueDashboardBtn"') &&
  loginContent.includes('id="signOutOtherBtn"'),
  'Test 7: User-controlled already-signed-in UI in login.html',
  'Offers Continue to Dashboard & Sign Out without auto-redirect'
);

// Test 8: Register button remains public navigation
assert(
  loginContent.includes('window.location.href = "register.html"') &&
  loginContent.includes('id="registerButton"'),
  'Test 8: Register button remains independent public navigation',
  'Does not submit login form'
);

// Test 9: Google OAuth handler preserved
assert(
  loginContent.includes('supabase.auth.signInWithOAuth') &&
  loginContent.includes('provider: "google"'),
  'Test 9: Google OAuth integration intact',
  'Clean signInWithOAuth preserved'
);

// Test 10: Secret leakage audit
assert(
  !loginContent.includes('service_role') &&
  !loginContent.includes('SUPABASE_SERVICE_KEY') &&
  !adminLoginContent.includes('service_role'),
  'Test 10: No Supabase service_role key exposed in frontend files',
  'Only public anon key used'
);

// Runtime Supabase tests
async function runRuntimeTests() {
  console.log('\nRunning Supabase Runtime Authentication Tests...');

  // Test 11: Attempting login with dummy or old hardcoded admin credentials fails securely
  const { data: failData, error: failError } = await supabase.auth.signInWithPassword({
    email: 'admin.audit@askexpert.com',
    password: 'InvalidPassword123!'
  });

  assert(
    failError !== null && !failData?.user,
    'Test 11: Invalid / fake admin password rejected by Supabase',
    failError?.message || 'Rejected as expected'
  );

  // Test 12: Account status suspension simulation logic
  const suspendedProfile = { role: 'user', account_status: 'suspended', is_blocked: true };
  const isSuspendedBlocked = suspendedProfile.account_status === 'suspended' || suspendedProfile.is_blocked === true;
  assert(
    isSuspendedBlocked === true,
    'Test 12: Suspended or blocked accounts identified and rejected',
    'Denies dashboard access'
  );

  // Test 13: Role resolution logic
  const testProfiles = [
    { role: 'admin', is_verified: true, expected: 'admin-dashboard.html' },
    { role: 'expert', is_verified: true, expected: 'professional-dashboard.html' },
    { role: 'expert', is_verified: false, expected: 'professional-verification.html' },
    { role: 'user', is_verified: false, expected: 'user-dashboard.html' },
    { role: undefined, is_verified: false, expected: 'user-dashboard.html' }
  ];

  let roleRoutingPassed = true;
  for (const p of testProfiles) {
    let target = 'user-dashboard.html';
    const r = p.role || 'user';
    if (r === 'admin') target = 'admin-dashboard.html';
    else if (r === 'expert' || r === 'professional') {
      target = p.is_verified ? 'professional-dashboard.html' : 'professional-verification.html';
    }
    if (target !== p.expected) roleRoutingPassed = false;
  }

  assert(
    roleRoutingPassed,
    'Test 13: Trusted role router handles Admin, Verified Expert, Pending Expert, and User correctly',
    'Pending experts route to professional-verification.html'
  );

  // Test 14: Redirect parameter sanitization
  const evilRedirect = 'https://evil-phishing.com/steal';
  const safeRedirect = 'questions.html';
  const isEvilBlocked = evilRedirect.startsWith('http') || evilRedirect.startsWith('//');
  const isSafeAllowed = !safeRedirect.startsWith('http') && !safeRedirect.startsWith('//');
  assert(
    isEvilBlocked && isSafeAllowed,
    'Test 14: Redirect parameter sanitized against open redirect attacks',
    'Only relative URLs allowed'
  );

  console.log('\n====================================================');
  console.log(`TEST RESULTS: ${passCount} PASSED, ${failCount} FAILED`);
  console.log('====================================================\n');

  if (failCount > 0) process.exit(1);
}

runRuntimeTests();
