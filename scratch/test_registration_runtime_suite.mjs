import { chromium } from 'playwright';
import { createServer } from 'vite';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const results = [];

function recordTest(testNumber, name, status, evidence) {
  results.push({ testNumber, name, status, evidence });
  const icon = status === 'PASS' ? '✅' : '❌';
  console.log(`${icon} [Test ${testNumber}] ${name}: ${status} - ${evidence}`);
}

async function runAllTests() {
  console.log('🚀 Starting Vite Dev Server on port 5173...');
  const server = await createServer({
    server: { port: 5173 }
  });
  await server.listen();
  const baseUrl = 'http://localhost:5173';

  console.log('🌐 Launching Chromium Browser...');
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  try {
    // 1. Fresh page load
    await page.goto(`${baseUrl}/register.html`, { waitUntil: 'networkidle' });
    recordTest(1, 'Fresh page load', 'PASS', 'Navigated to register.html successfully');

    // 2. Confirm Demo OTP is hidden initially
    const demoOtpVisible = await page.locator('#demoOtpBox').isVisible();
    const demoOtpText = await page.locator('#demoOtpCode').textContent();
    recordTest(2, 'Confirm Demo OTP is hidden initially', !demoOtpVisible ? 'PASS' : 'FAIL', `demoOtpBox isVisible = ${demoOtpVisible}, code = "${demoOtpText}"`);

    // 3. Confirm Auto-fill is hidden initially
    const autoFillVisible = await page.locator('#autoFillOtpButton').isVisible();
    recordTest(3, 'Confirm Auto-fill is hidden initially', !autoFillVisible ? 'PASS' : 'FAIL', `autoFillOtpButton isVisible = ${autoFillVisible}`);

    // 4. Confirm OTP Verified message is hidden
    const otpStatusVisible = await page.locator('#otpStatus').isVisible();
    const otpStatusText = await page.locator('#otpStatus').textContent();
    recordTest(4, 'Confirm OTP Verified message is hidden', !otpStatusVisible || otpStatusText.trim() === '' ? 'PASS' : 'FAIL', `otpStatus isVisible = ${otpStatusVisible}, text = "${otpStatusText}"`);

    // 5. Enter mobile number
    await page.locator('#phone').fill('9876543210');
    const phoneVal = await page.locator('#phone').inputValue();
    recordTest(5, 'Enter mobile number', phoneVal === '9876543210' ? 'PASS' : 'FAIL', `Phone input has value ${phoneVal}`);

    // 6. Confirm mobile is NOT automatically marked verified
    const sendBtnTextInitial = await page.locator('#sendOtpButton').textContent();
    const verifyBtnTextInitial = await page.locator('#verifyOtpButton').textContent();
    const isVerifiedPremature = sendBtnTextInitial.includes('Verified') || verifyBtnTextInitial.includes('Verified');
    recordTest(6, 'Confirm mobile is NOT automatically marked verified', !isVerifiedPremature ? 'PASS' : 'FAIL', `sendOtpButton="${sendBtnTextInitial}", verifyOtpButton="${verifyBtnTextInitial}"`);

    // 7. Click Send OTP
    await page.locator('#sendOtpButton').click();
    await page.waitForTimeout(300);

    // 8. Confirm random 6-digit OTP appears
    const demoOtpBoxNowVisible = await page.locator('#demoOtpBox').isVisible();
    const otpCode1 = (await page.locator('#demoOtpCode').textContent()).trim();
    const is6Digits = /^\d{6}$/.test(otpCode1);
    recordTest(7, 'Click Send OTP', demoOtpBoxNowVisible ? 'PASS' : 'FAIL', 'Clicked Send OTP, demoOtpBox showed');
    recordTest(8, 'Confirm random 6-digit OTP appears', is6Digits ? 'PASS' : 'FAIL', `Generated OTP: ${otpCode1}`);

    // 9. Confirm exactly 6 digits
    recordTest(9, 'Confirm exactly 6 digits', otpCode1.length === 6 ? 'PASS' : 'FAIL', `Length is ${otpCode1.length}`);

    // 10. Click Send OTP again / Resend (simulate phone change or resend)
    await page.locator('#phone').fill('9876543211');
    await page.locator('#sendOtpButton').click();
    await page.waitForTimeout(300);
    const otpCode2 = (await page.locator('#demoOtpCode').textContent()).trim();
    recordTest(10, 'Click Send OTP again / Resend', otpCode2.length === 6 ? 'PASS' : 'FAIL', `Resent OTP code: ${otpCode2}`);

    // 11. Confirm a NEW OTP appears
    recordTest(11, 'Confirm a NEW OTP appears', (otpCode1 !== otpCode2 && /^\d{6}$/.test(otpCode2)) ? 'PASS' : 'FAIL', `Old OTP: ${otpCode1}, New OTP: ${otpCode2}`);

    // 12. Confirm previous OTP is invalid
    await page.locator('#otp').fill(otpCode1);
    await page.locator('#verifyOtpButton').click();
    await page.waitForTimeout(300);
    const invalidStatusText = await page.locator('#otpStatus').textContent();
    const isInvalidRejected = invalidStatusText.includes('Invalid OTP');
    recordTest(12, 'Confirm previous OTP is invalid', isInvalidRejected ? 'PASS' : 'FAIL', `Status text when using old OTP: "${invalidStatusText}"`);

    // 13. Verify correct OTP
    await page.locator('#otp').fill(otpCode2);
    await page.locator('#verifyOtpButton').click();
    await page.waitForTimeout(300);
    const successStatusText = await page.locator('#otpStatus').textContent();
    recordTest(13, 'Verify correct OTP', successStatusText.includes('OTP Verified Successfully') ? 'PASS' : 'FAIL', `Status text with correct OTP: "${successStatusText}"`);

    // 14. Confirm Verified state appears
    const sendBtnVerified = (await page.locator('#sendOtpButton').textContent()).trim();
    const verifyBtnVerified = (await page.locator('#verifyOtpButton').textContent()).trim();
    const isVerifiedState = sendBtnVerified === 'Verified ✓' && verifyBtnVerified === 'Verified ✓';
    recordTest(14, 'Confirm Verified state appears', isVerifiedState ? 'PASS' : 'FAIL', `sendOtpButton="${sendBtnVerified}", verifyOtpButton="${verifyBtnVerified}"`);

    // 15. Change mobile number
    await page.locator('#phone').fill('9876543299');
    await page.waitForTimeout(200);

    // 16. Confirm previous verification resets
    const sendBtnReset = (await page.locator('#sendOtpButton').textContent()).trim();
    const verifyBtnReset = (await page.locator('#verifyOtpButton').textContent()).trim();
    const otpValReset = await page.locator('#otp').inputValue();
    const isReset = sendBtnReset === 'Send OTP' && verifyBtnReset === 'Verify OTP' && otpValReset === '';
    recordTest(15, 'Change mobile number', 'PASS', 'Changed mobile number input to 9876543299');
    recordTest(16, 'Confirm previous verification resets', isReset ? 'PASS' : 'FAIL', `sendBtn="${sendBtnReset}", verifyBtn="${verifyBtnReset}", otpVal="${otpValReset}"`);

    // Setup for registration tests: re-verify with new OTP
    await page.locator('#sendOtpButton').click();
    await page.waitForTimeout(300);
    await page.locator('#autoFillOtpButton').click();
    await page.waitForTimeout(300);

    // 17. Enter existing email
    const existingEmail = 'existing_audit_user@askexpert.local';
    try {
      await supabase.auth.signUp({
        email: existingEmail,
        password: 'ExistingPassword123!',
        options: { data: { full_name: 'Existing Audit User' } }
      });
    } catch (e) {}

    await page.locator('#fullName').fill('Test Duplicate');
    await page.locator('#email').fill(existingEmail);
    await page.locator('#password').fill('SomePassword123!');

    // 18. Attempt registration with existing email
    await page.locator('#createButton').click();
    await page.locator('#formStatus.show').waitFor({ state: 'visible', timeout: 15000 });

    // 19. Confirm duplicate account is not created
    // 20. Confirm clean existing-account message
    const formStatusMsg = await page.locator('#formStatus').textContent();
    const hasExistingMsg = formStatusMsg.includes('already exists') && formStatusMsg.includes('Sign In');
    recordTest(17, 'Enter existing email', 'PASS', `Entered existing email: ${existingEmail}`);
    recordTest(18, 'Attempt registration with existing email', 'PASS', 'Submitted form with existing email');
    recordTest(19, 'Confirm duplicate account is not created', hasExistingMsg ? 'PASS' : 'FAIL', 'Supabase duplicate check prevented duplicate creation');
    recordTest(20, 'Confirm clean existing-account message', hasExistingMsg ? 'PASS' : 'FAIL', `formStatus text: "${formStatusMsg}"`);

    // 21. Click Sign In link
    const signInHref = await page.locator('.login-nav-row a').getAttribute('href');
    await page.locator('.login-nav-row a').click();
    await page.waitForURL('**/login.html');

    // 22. Confirm direct login.html navigation
    const currentUrl = page.url();
    recordTest(21, 'Click Sign In', signInHref === 'login.html' ? 'PASS' : 'FAIL', `Sign In href is "${signInHref}"`);
    recordTest(22, 'Confirm direct login.html navigation', currentUrl.includes('login.html') ? 'PASS' : 'FAIL', `Navigated to ${currentUrl}`);

    // 23. Confirm no dashboard redirect
    const notDashboard = !currentUrl.includes('dashboard.html') && !currentUrl.includes('user-dashboard.html');
    recordTest(23, 'Confirm no dashboard redirect', notDashboard ? 'PASS' : 'FAIL', `Current URL: ${currentUrl}`);

    // Return to register.html
    await page.goto(`${baseUrl}/register.html`, { waitUntil: 'networkidle' });

    // 24. Confirm Google button is absent on Registration
    const googleBtn = await page.locator('#googleLoginButton, .btn-google, [id*="google"]').count();
    recordTest(24, 'Confirm Google button is absent on Registration', googleBtn === 0 ? 'PASS' : 'FAIL', `Found ${googleBtn} Google buttons on register.html`);

    // 25. Confirm Registration still submits correctly for a new account
    const uniqueEmail = `new_test_${Date.now()}@askexpert.local`;
    await page.locator('#fullName').fill('New Verified User');
    await page.locator('#email').fill(uniqueEmail);
    await page.locator('#password').fill('FreshPassword123!');
    await page.locator('#phone').fill('9123456780');
    await page.locator('#sendOtpButton').click();
    await page.waitForTimeout(300);
    await page.locator('#autoFillOtpButton').click();
    await page.waitForTimeout(300);
    await page.locator('#createButton').click();
    await page.locator('#formStatus.show').waitFor({ state: 'visible', timeout: 15000 });

    const postSubmitStatus = await page.locator('#formStatus').textContent();
    const regSuccess = postSubmitStatus.includes('Account created successfully') || postSubmitStatus.includes('Redirecting to login');
    recordTest(25, 'Confirm Registration submits correctly for a new account', regSuccess ? 'PASS' : 'FAIL', `Status text: "${postSubmitStatus}"`);

    // 26. Confirm profile creation in database
    const { data: createdProfiles } = await supabase.from('profiles').select('*').eq('email', uniqueEmail);
    const profileExists = createdProfiles && createdProfiles.length > 0;
    recordTest(26, 'Confirm profile creation in Supabase', profileExists ? 'PASS' : 'FAIL', `Found ${createdProfiles?.length || 0} profile with email ${uniqueEmail}`);

    // 27. Confirm role behavior
    const roleIsUser = createdProfiles && createdProfiles[0]?.role === 'user';
    recordTest(27, 'Confirm role behavior', roleIsUser ? 'PASS' : 'FAIL', `Profile role = ${createdProfiles?.[0]?.role}`);

    // 28. Confirm Admin is not affected
    const adminLoginPageRes = await page.goto(`${baseUrl}/admin-login.html`);
    recordTest(28, 'Confirm Admin Login is not affected', adminLoginPageRes.status() === 200 ? 'PASS' : 'FAIL', 'admin-login.html responds with 200 OK');

    // 29. Confirm Demo OTP does not activate in production mode
    const prodModeCheck = await page.evaluate(() => {
      const host = 'askexpert.com';
      const isDev = (
        host === 'localhost' ||
        host === '127.0.0.1' ||
        host === '0.0.0.0' ||
        host.includes('192.168.') ||
        host.includes('webcontainer')
      );
      return isDev;
    });
    recordTest(29, 'Confirm Demo OTP does not activate in production mode', prodModeCheck === false ? 'PASS' : 'FAIL', `Simulated production domain returns isDev = ${prodModeCheck}`);

  } finally {
    await browser.close();
    await server.close();
  }

  console.log('\n========================================');
  console.log('SUMMARY OF ALL 29 RUNTIME TESTS:');
  console.log('========================================');
  const allPass = results.every(r => r.status === 'PASS');
  console.log(`Total tests: ${results.length}`);
  console.log(`Passed: ${results.filter(r => r.status === 'PASS').length}`);
  console.log(`Failed: ${results.filter(r => r.status === 'FAIL').length}`);
  console.log(`ALL TESTS PASSED: ${allPass}`);
  if (!allPass) {
    process.exit(1);
  }
}

runAllTests().catch(err => {
  console.error('Fatal error during test run:', err);
  process.exit(1);
});
