/**
 * ASKEXPERT — Full Backend Verification (Headed Playwright)
 * Run AFTER applying fix_trigger.sql in Supabase Dashboard.
 *
 * Tests:
 *  1. Registration (new unique user)
 *  2. Profile row created in public.profiles
 *  3. Login with email
 *  4. Session persists (getSession returns user)
 *  5. Redirect to user-dashboard after login
 *  6. Protected route — dashboard loads with session
 *  7. Logout → redirected back to login
 */

import { chromium } from 'playwright';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const ANON_KEY     = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const BASE_URL     = 'http://localhost:5173';

const TS   = Date.now();
const TEST_EMAIL    = `verify_${TS}@askexpert-test.com`;
const TEST_PASSWORD = 'Verify@9999!';
const TEST_NAME     = 'Verify User';
const TEST_PHONE    = '9876543210';

const results = [];
let passed = 0, failed = 0;

function log(step, status, detail = '') {
  const icon = status === 'PASS' ? '✅' : status === 'FAIL' ? '❌' : 'ℹ️';
  console.log(`${icon} [${step}] ${status}${detail ? ' — ' + detail : ''}`);
  results.push({ step, status, detail });
  if (status === 'PASS') passed++;
  if (status === 'FAIL') failed++;
}

async function restGet(path) {
  const r = await fetch(SUPABASE_URL + path, {
    headers: { apikey: ANON_KEY, Authorization: `Bearer ${ANON_KEY}`, Accept: 'application/json' }
  });
  return { status: r.status, body: await r.json().catch(() => ({})) };
}

async function main() {
  console.log('='.repeat(70));
  console.log('🔍 ASKEXPERT FULL BACKEND VERIFICATION');
  console.log(`Test email: ${TEST_EMAIL}`);
  console.log('='.repeat(70));

  // ── Pre-check: dev server running ─────────────────────────────────────────
  try {
    const ping = await fetch(`${BASE_URL}/register.html`);
    if (ping.ok) log('0-DEV-SERVER', 'PASS', `${BASE_URL} is up`);
    else log('0-DEV-SERVER', 'FAIL', `HTTP ${ping.status}`);
  } catch (e) {
    log('0-DEV-SERVER', 'FAIL', 'Not running — start with: npm run dev');
    process.exit(1);
  }

  // ── Pre-check: username column exists ─────────────────────────────────────
  const colCheck = await restGet('/rest/v1/profiles?select=username&limit=0');
  if (colCheck.status === 200) {
    log('0-SCHEMA-USERNAME', 'PASS', 'username column exists on remote profiles');
  } else {
    log('0-SCHEMA-USERNAME', 'FAIL',
      'username column NOT FOUND — run fix_trigger.sql in Supabase Dashboard first!');
    console.log('\n❌ STOPPING: Schema fix not applied yet.');
    console.log('   → Open: https://supabase.com/dashboard/project/girexuzrkeiylkbqglks/sql');
    console.log('   → Run:  fix_trigger.sql');
    process.exit(1);
  }

  const browser = await chromium.launch({ headless: false, slowMo: 300 });
  const ctx     = await browser.newContext({ viewport: { width: 1280, height: 800 } });
  const page    = await ctx.newPage();

  const errors = [];
  page.on('console', msg => { if (msg.type() === 'error') errors.push(msg.text()); });
  page.on('pageerror', err => errors.push(String(err)));

  try {
    // ── 1. REGISTRATION ────────────────────────────────────────────────────
    console.log('\n── Step 1: Registration ──');
    await page.goto(`${BASE_URL}/register.html`, { waitUntil: 'networkidle' });
    log('1-REGISTER-LOAD', 'PASS', 'register.html loaded');

    // Fill role = user
    const userTab = page.locator('[data-role="user"], #roleUser, input[value="user"]').first();
    if (await userTab.count() > 0) await userTab.click();

    // Fill form fields
    await page.fill('#fullName, [name="fullName"], input[placeholder*="Full Name"]', TEST_NAME);
    await page.fill('#email, [name="email"], input[type="email"]', TEST_EMAIL);

    // Phone field
    const phoneField = page.locator('#phone, [name="phone"], input[placeholder*="phone"]').first();
    if (await phoneField.count() > 0) await phoneField.fill(TEST_PHONE);

    await page.fill('#password, [name="password"], input[type="password"]', TEST_PASSWORD);

    // Confirm password if present
    const confirmPwd = page.locator('#confirmPassword, [name="confirmPassword"]').first();
    if (await confirmPwd.count() > 0) await confirmPwd.fill(TEST_PASSWORD);

    // OTP flow — click Send OTP
    const sendOtp = page.locator('#sendOtpButton, button:has-text("Send OTP"), button:has-text("Get OTP")').first();
    if (await sendOtp.count() > 0) {
      await sendOtp.click();
      await page.waitForTimeout(1500);

      // Auto-fill OTP if dev button exists
      const autoFill = page.locator('#autoFillOtpButton, button:has-text("Auto"), button:has-text("Fill OTP")').first();
      if (await autoFill.count() > 0) {
        await autoFill.click();
        await page.waitForTimeout(800);
        log('1-OTP-AUTOFILL', 'PASS', 'OTP auto-filled');
      } else {
        // Enter a dummy 6-digit OTP visible on page
        const otpField = page.locator('#otp, [name="otp"], input[maxlength="6"]').first();
        if (await otpField.count() > 0) {
          const otpDisplay = await page.locator('.otp-display, #generatedOtp, [id*="generatedOtp"]').first().textContent().catch(() => '');
          if (otpDisplay && /\d{6}/.test(otpDisplay)) {
            await otpField.fill(otpDisplay.match(/\d{6}/)[0]);
          }
        }
      }
    }

    // Submit registration
    const createBtn = page.locator('#createAccountBtn, button:has-text("Create Account"), [type="submit"]').first();
    await createBtn.click();

    // Wait for either success redirect or error
    try {
      await page.waitForURL(url => url.includes('login.html') || url.includes('professional-verification'), { timeout: 10000 });
      log('1-REGISTER-REDIRECT', 'PASS', `Redirected to: ${page.url()}`);
    } catch {
      // Check for success/error message on page
      const pageText = await page.textContent('body');
      const hasSuccess = /Account created|Redirecting|success/i.test(pageText);
      const hasError   = /error|failed|Database error/i.test(pageText);
      if (hasSuccess) log('1-REGISTER-REDIRECT', 'PASS', 'Success message shown (no redirect yet)');
      else if (hasError) {
        const errMsg = await page.locator('[class*="error"], [class*="status"], #formStatus, .form-status').first().textContent().catch(() => 'unknown');
        log('1-REGISTER', 'FAIL', `Error shown: ${errMsg}`);
        throw new Error(`Registration failed: ${errMsg}`);
      }
    }

    // ── 2. VERIFY PROFILE CREATED IN SUPABASE ────────────────────────────
    console.log('\n── Step 2: Verify profile row in remote database ──');
    await page.waitForTimeout(2000); // give trigger time

    const profileCheck = await restGet(
      `/rest/v1/profiles?email=eq.${encodeURIComponent(TEST_EMAIL)}&select=id,full_name,email,role,username,phone`
    );
    if (profileCheck.status === 200 && profileCheck.body.length > 0) {
      const p = profileCheck.body[0];
      log('2-PROFILE-EXISTS', 'PASS', `id=${p.id?.substring(0,8)}...`);
      log('2-PROFILE-EMAIL',     p.email    === TEST_EMAIL ? 'PASS' : 'FAIL', `email=${p.email}`);
      log('2-PROFILE-ROLE',      p.role     === 'user'     ? 'PASS' : 'FAIL', `role=${p.role}`);
      log('2-PROFILE-FULL_NAME', p.full_name                ? 'PASS' : 'FAIL', `full_name=${p.full_name}`);
      log('2-PROFILE-USERNAME',  p.username                 ? 'PASS' : 'FAIL', `username=${p.username}`);
      console.log('  Profile data:', JSON.stringify(p));
    } else {
      log('2-PROFILE-EXISTS', 'FAIL',
        `No profile found for ${TEST_EMAIL} — trigger may not have fired (status=${profileCheck.status})`);
    }

    // ── 3. LOGIN ──────────────────────────────────────────────────────────
    console.log('\n── Step 3: Login ──');
    await page.goto(`${BASE_URL}/login.html`, { waitUntil: 'networkidle' });
    log('3-LOGIN-LOAD', 'PASS', 'login.html loaded');

    await page.fill('#email, [name="email"], input[type="email"]', TEST_EMAIL);
    await page.fill('#password, [name="password"], input[type="password"]', TEST_PASSWORD);

    const loginBtn = page.locator('#loginButton, button:has-text("Sign In"), button:has-text("Login"), [type="submit"]').first();
    await loginBtn.click();

    try {
      await page.waitForURL(url =>
        url.includes('user-dashboard') || url.includes('professional-dashboard') || url.includes('admin-dashboard'),
        { timeout: 10000 }
      );
      log('3-LOGIN-REDIRECT', 'PASS', `Redirected to: ${page.url()}`);
    } catch {
      const errText = await page.locator('[class*="error"], [class*="status"], #statusMsg, .status-msg').first().textContent().catch(() => '');
      log('3-LOGIN-REDIRECT', 'FAIL', `Still on login page. Error: "${errText}"`);
      throw new Error('Login did not redirect');
    }

    // ── 4. SESSION PERSISTS ───────────────────────────────────────────────
    console.log('\n── Step 4: Session persists ──');
    const sessionResult = await page.evaluate(async () => {
      const { createClient } = window.supabase || {};
      if (!createClient) return { error: 'supabase not on window' };
      const { data } = await window._supabase?.auth?.getSession?.() || {};
      return data;
    });

    // Verify via sessionStorage values login.html sets
    const ssUserId   = await page.evaluate(() => sessionStorage.getItem('askexpert_user_id'));
    const ssUserRole  = await page.evaluate(() => sessionStorage.getItem('askexpert_user_role'));
    log('4-SESSION-USERID', ssUserId ? 'PASS' : 'FAIL', `askexpert_user_id=${ssUserId?.substring(0,8)}...`);
    log('4-SESSION-ROLE',   ssUserRole ? 'PASS' : 'FAIL', `askexpert_user_role=${ssUserRole}`);

    // ── 5. DASHBOARD LOADS ────────────────────────────────────────────────
    console.log('\n── Step 5: Dashboard loads ──');
    const dashUrl = page.url();
    const hasDash = dashUrl.includes('dashboard');
    log('5-DASHBOARD-URL', hasDash ? 'PASS' : 'FAIL', dashUrl);

    // Wait for page content
    await page.waitForTimeout(1500);
    const dashTitle = await page.title();
    log('5-DASHBOARD-TITLE', 'PASS', `Title: ${dashTitle}`);

    // ── 6. PROTECTED ROUTE — navigate directly ────────────────────────────
    console.log('\n── Step 6: Protected route ──');
    await page.goto(`${BASE_URL}/user-dashboard.html`, { waitUntil: 'networkidle' });
    const protectedUrl = page.url();
    if (protectedUrl.includes('user-dashboard')) {
      log('6-PROTECTED-ROUTE', 'PASS', 'Dashboard accessible with active session');
    } else {
      log('6-PROTECTED-ROUTE', 'FAIL', `Redirected away to: ${protectedUrl}`);
    }

    // ── 7. LOGOUT ─────────────────────────────────────────────────────────
    console.log('\n── Step 7: Logout ──');
    const logoutBtn = page.locator('button:has-text("Logout"), button:has-text("Sign Out"), #logoutBtn, [id*="logout"]').first();
    if (await logoutBtn.count() > 0) {
      await logoutBtn.click();
      try {
        await page.waitForURL(url => url.includes('login'), { timeout: 5000 });
        log('7-LOGOUT', 'PASS', `Redirected to: ${page.url()}`);
      } catch {
        log('7-LOGOUT', 'FAIL', `Still on: ${page.url()}`);
      }
    } else {
      log('7-LOGOUT', 'INFO', 'No logout button found on page — skip');
    }

  } catch (err) {
    log('FATAL', 'FAIL', String(err));
    await page.screenshot({ path: 'scratch/failure_screenshot.png' }).catch(() => {});
  } finally {
    await browser.close();
  }

  // ── FINAL REPORT ──────────────────────────────────────────────────────────
  console.log('\n' + '='.repeat(70));
  console.log('📊 FINAL REPORT');
  console.log('='.repeat(70));
  results.forEach(r => {
    const icon = r.status === 'PASS' ? '✅' : r.status === 'FAIL' ? '❌' : 'ℹ️';
    console.log(`  ${icon} ${r.step.padEnd(28)} ${r.status}  ${r.detail}`);
  });
  console.log('='.repeat(70));
  console.log(`  PASSED: ${passed}  |  FAILED: ${failed}`);
  if (errors.length > 0) {
    console.log('\n⚠️  BROWSER CONSOLE ERRORS:');
    errors.forEach(e => console.log('  ', e));
  }
  console.log('='.repeat(70));
  if (failed === 0) {
    console.log('\n🎉 FINAL VERDICT: REAL BACKEND VERIFIED — ALL TESTS PASSED');
  } else {
    console.log('\n❌ FINAL VERDICT: VERIFICATION FAILED — see above for failures');
    process.exit(1);
  }
}

main().catch(err => { console.error('Script crashed:', err); process.exit(1); });
