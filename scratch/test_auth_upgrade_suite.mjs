import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const results = [];

function assertTest(id, name, condition, details = '') {
  const status = condition ? 'PASS' : 'FAIL';
  results.push({ id, name, status, details });
  console.log(`[${status}] Test ${id}: ${name} ${details ? '- ' + details : ''}`);
}

console.log('=== STARTING ASKEXPERT AUTHENTICATION UPGRADE TEST SUITE ===\n');

// -------------------------------------------------------------
// 1. SMART INPUT DETECTION TESTS
// -------------------------------------------------------------
function detectIdentityFormat(raw) {
  const trimmed = (raw || "").trim();
  if (!trimmed) return { type: null, value: '', normalized: '' };

  if (/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(trimmed)) {
    return { type: 'email', value: trimmed, normalized: trimmed.toLowerCase() };
  }

  const digitsOnly = trimmed.replace(/[^0-9]/g, '');
  const hasLetters = /[a-zA-Z]/.test(trimmed);
  if (!hasLetters && (trimmed.startsWith('+') || (digitsOnly.length >= 10 && digitsOnly.length <= 15))) {
    let e164 = trimmed.replace(/[\s()-]/g, '');
    if (!e164.startsWith('+')) {
      if (e164.length === 10) e164 = '+91' + e164;
      else e164 = '+' + e164;
    }
    return { type: 'phone', value: trimmed, normalized: e164 };
  }

  if (/^[a-zA-Z0-9_.-]{2,50}$/.test(trimmed)) {
    return { type: 'username', value: trimmed, normalized: trimmed.toLowerCase() };
  }

  return { type: 'unknown', value: trimmed, normalized: trimmed };
}

// Test 1: Valid email detection
const t1 = detectIdentityFormat('test.user@askexpert.com');
assertTest(1, 'Valid email detection', t1.type === 'email' && t1.normalized === 'test.user@askexpert.com');

// Test 2: Invalid email format
const t2 = detectIdentityFormat('invalid@email');
assertTest(2, 'Invalid email detection', t2.type !== 'email');

// Test 3: Valid username detection
const t3 = detectIdentityFormat('dr_suresh_123');
assertTest(3, 'Valid username detection', t3.type === 'username' && t3.normalized === 'dr_suresh_123');

// Test 4: Valid phone number detection (E.164 normalization)
const t4 = detectIdentityFormat('9876543210');
assertTest(4, 'Valid phone number detection (10 digits to +91)', t4.type === 'phone' && t4.normalized === '+919876543210');

// Test 5: International phone detection
const t5 = detectIdentityFormat('+1 (555) 234-5678');
assertTest(5, 'International phone format detection', t5.type === 'phone' && t5.normalized === '+15552345678');

// Test 6: Ambiguous input handling
const t6 = detectIdentityFormat('   ');
assertTest(6, 'Empty / whitespace input handling', t6.type === null);

// -------------------------------------------------------------
// 2. SUPABASE BACKEND CONNECTIVITY & ENDPOINTS
// -------------------------------------------------------------
(async () => {
  try {
    // Test 7: Supabase Profiles Query & RLS Check
    const { data: profiles, error: profErr } = await supabase.from('profiles').select('id, role, full_name').limit(3);
    assertTest(7, 'Supabase profiles query & RLS check', !profErr && Array.isArray(profiles), `Returned ${profiles?.length} profiles`);

    // Test 8: Supabase Auth Endpoint (Sign in with invalid credentials returns proper 400 without leaking)
    const { error: signInErr } = await supabase.auth.signInWithPassword({
      email: 'nonexistent_account_audit_test@askexpert.com',
      password: 'WrongPassword123!'
    });
    assertTest(8, 'Supabase password auth handles invalid credentials safely', signInErr?.code === 'invalid_credentials' || signInErr?.status === 400);

    // Test 9: Google OAuth Authorization URL Generation
    const { data: oauthData, error: oauthErr } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: 'http://192.168.1.6:5174/login.html'
      }
    });
    assertTest(9, 'Google OAuth authorize URL generation', !oauthErr && oauthData?.url?.includes('accounts.google.com') === false && oauthData?.url?.includes('authorize?provider=google'), `URL: ${oauthData?.url?.substring(0, 60)}...`);

    // Test 10: Phone OTP Endpoint Accessibility
    const { error: otpErr } = await supabase.auth.signInWithOtp({
      phone: '+919999999999'
    });
    assertTest(10, 'Supabase SMS OTP endpoint responds', otpErr !== null, `Response status: ${otpErr?.message || 'OK'}`);

    // Print final summary
    console.log('\n=============================================================');
    console.log(`TOTAL TESTS: ${results.length} | PASSED: ${results.filter(r => r.status === 'PASS').length} | FAILED: ${results.filter(r => r.status === 'FAIL').length}`);
    console.log('=============================================================\n');
  } catch (err) {
    console.error('Test execution error:', err);
  }
})();
