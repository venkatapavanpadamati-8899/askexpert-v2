// scratch/test_oauth_and_ui.mjs
import fs from 'fs';
import path from 'path';
import { createClient } from '@supabase/supabase-js';

console.log('=== RUNNING GOOGLE OAUTH & USER-TO-EXPERT UI TEST SUITE ===\n');

let total = 0;
let passed = 0;

function assert(cond, name) {
  total++;
  if (cond) {
    console.log(`✅ [PASS] ${name}`);
    passed++;
  } else {
    console.error(`❌ [FAIL] ${name}`);
    throw new Error(`Test failed: ${name}`);
  }
}

// -------------------------------------------------------------
// 1. Google OAuth Flow & Configuration Audit
// -------------------------------------------------------------
console.log('1. Auditing Google OAuth Configuration in login.html...');
const loginPath = path.resolve('login.html');
const loginHtml = fs.readFileSync(loginPath, 'utf8');

assert(loginHtml.includes('const callbackPath = window.location.protocol === "file:" ? "/auth-callback.html" : "/auth-callback";'), 'login.html computes clean canonical callback path');
assert(loginHtml.includes('redirectTo: callbackUrl.toString()'), 'login.html passes canonical callbackUrl to signInWithOAuth');
assert(loginHtml.includes('access_type: "offline"'), 'Offline access requested for refresh tokens');

// Test live Supabase signInWithOAuth URL generation
const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const prodCallback = 'https://askexpert-v2.vercel.app/auth-callback';
const { data: oauthData, error: oauthErr } = await supabase.auth.signInWithOAuth({
  provider: 'google',
  options: {
    redirectTo: prodCallback
  }
});

assert(!oauthErr && oauthData?.url, 'Supabase successfully generated Google OAuth URL');
assert(oauthData.url.includes('provider=google'), 'OAuth URL specifies provider=google');
assert(oauthData.url.includes(encodeURIComponent(prodCallback)), 'OAuth URL contains exact clean callback URL');

// -------------------------------------------------------------
// 2. Vercel Clean Routing Verification (No 308 on clean URL)
// -------------------------------------------------------------
console.log('\n2. Verifying Vercel Routing Behavior on Live Production...');
const resClean = await fetch('https://askexpert-v2.vercel.app/auth-callback', { redirect: 'manual' });
assert(resClean.status === 200, `Production /auth-callback returns HTTP 200 directly without 308 (Status: ${resClean.status})`);

const resCleanWithCode = await fetch('https://askexpert-v2.vercel.app/auth-callback?code=mock_code_123', { redirect: 'manual' });
assert(resCleanWithCode.status === 200, `Production /auth-callback?code=... returns HTTP 200 directly (Status: ${resCleanWithCode.status})`);

// -------------------------------------------------------------
// 3. auth-callback.html Logic Audit
// -------------------------------------------------------------
console.log('\n3. Auditing auth-callback.html Structure & Safety...');
const callbackPath = path.resolve('auth-callback.html');
const callbackHtml = fs.readFileSync(callbackPath, 'utf8');

assert(callbackHtml.includes('sanitizeRedirectUrl'), 'auth-callback.html sanitizes redirect parameters against open redirects');
assert(callbackHtml.includes('exchangeCodeForSession(code)'), 'auth-callback.html explicitly supports PKCE authorization code exchange');
assert(callbackHtml.includes('account_status === "suspended"') && callbackHtml.includes('is_blocked === true'), 'auth-callback.html checks account status and blocks restricted users');
assert(callbackHtml.includes('isProcessed = true'), 'auth-callback.html guards against double-processing and redirect loops');
assert(callbackHtml.includes('userRole === "admin"') && callbackHtml.includes('admin-dashboard.html'), 'Authoritative admin routing preserved');
assert(callbackHtml.includes('userRole === "expert"') && callbackHtml.includes('professional-dashboard.html'), 'Authoritative expert routing preserved');
assert(callbackHtml.includes('access_denied') && callbackHtml.includes('cancelled'), 'Friendly user message for cancelled OAuth');

// -------------------------------------------------------------
// 4. User -> Expert UI Enhancement Audit
// -------------------------------------------------------------
console.log('\n4. Auditing User-to-Expert Dashboard UI Enhancements...');
const expertProfilePath = path.resolve('expert-profile.html');
const expertProfileHtml = fs.readFileSync(expertProfilePath, 'utf8');

assert(expertProfileHtml.includes('experts_hero_art.jpg'), 'expert-profile.html uses existing AskExpert experts_hero_art.jpg asset');
assert(expertProfileHtml.includes('linear-gradient(135deg'), 'expert-profile.html applies deep contrast linear-gradient overlay');
assert(expertProfileHtml.includes('.hero-left, .hero-mid, .hero-actions') && expertProfileHtml.includes('z-index: 2'), 'hero-card content layers properly positioned on top of background art');

const userDashPath = path.resolve('user-dashboard.html');
const userDashHtml = fs.readFileSync(userDashPath, 'utf8');

assert(userDashHtml.includes('expert-showcase-card'), 'user-dashboard.html defines .expert-showcase-card');
assert(userDashHtml.includes('experts_hero_art.jpg'), 'user-dashboard.html uses experts_hero_art.jpg in followed experts widget');
assert(userDashHtml.includes('rgba(22, 12, 6, 0.72)'), 'user-dashboard.html expert-widget-item uses theme-matching glass treatment');

console.log(`\n🎉 ALL ${passed} OF ${total} TESTS PASSED!`);
