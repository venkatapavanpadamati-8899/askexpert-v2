import { chromium } from 'playwright';

const BASE_URL = 'http://localhost:5173';

async function testForgotPasswordOtp() {
  console.log('🚀 Testing forgot-password.html OTP flow in Chromium...');
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  const consoleErrors = [];
  const networkFailures = [];

  page.on('console', (msg) => {
    if (msg.type() === 'error') consoleErrors.push(msg.text());
  });

  page.on('requestfailed', (req) => {
    networkFailures.push(`${req.failure()?.errorText} ${req.url()}`);
  });

  // 1. Load forgot-password.html
  console.log('1. Loading forgot-password.html...');
  await page.goto(`${BASE_URL}/forgot-password.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1000);

  // 2. Test Phone number recovery
  console.log('2. Entering mobile number 9876543210...');
  await page.fill('#identifier', '9876543210');
  await page.click('#sendOtpButton');
  await page.waitForTimeout(1000);

  // Check generated OTP
  const demoCode = await page.innerText('#demoOtpCode');
  const otpStatus = await page.innerText('#otpStatus');
  console.log('Generated Demo OTP (phone):', demoCode);
  console.log('OTP Status text:', otpStatus);

  if (!demoCode || demoCode.length !== 6 || !/^\d{6}$/.test(demoCode)) {
    throw new Error(`Invalid Demo OTP: ${demoCode}`);
  }
  console.log('✓ Demo OTP generated successfully for phone recovery: ' + demoCode);

  // 3. Test Auto-fill
  console.log('3. Clicking Auto-fill button...');
  await page.click('#autoFillOtpButton');
  await page.waitForTimeout(500);

  const filledOtp = await page.inputValue('#otp');
  if (filledOtp !== demoCode) {
    throw new Error(`Auto-fill mismatch: expected ${demoCode}, got ${filledOtp}`);
  }
  console.log('✓ OTP auto-filled into field: ' + filledOtp);

  // 4. Click Verify OTP
  console.log('4. Clicking Verify OTP...');
  await page.click('#verifyOtpButton');
  await page.waitForTimeout(1500);

  // Verify transition to Screen 2 (Reset Password)
  const isResetScreenActive = await page.$eval('#resetScreen', el => el.classList.contains('active'));
  console.log('Is Reset Screen Active?', isResetScreenActive);
  if (!isResetScreenActive) {
    throw new Error('Verification did not transition to Reset Screen!');
  }
  console.log('✓ Successfully verified OTP and transitioned to Reset Screen!');

  await page.screenshot({ path: 'scratch/forgot_password_screen2.png' });

  // 5. Test Password Reset on Screen 2
  console.log('5. Entering new password...');
  await page.fill('#newPassword', 'NewSecretPass@123');
  await page.fill('#confirmPassword', 'NewSecretPass@123');
  await page.click('#updatePasswordButton');
  await page.waitForTimeout(2000);

  // Verify transition to Screen 3 (Success)
  const isSuccessScreenShown = await page.$eval('#successScreen', el => el.classList.contains('show'));
  console.log('Is Success Screen Shown?', isSuccessScreenShown);
  if (!isSuccessScreenShown) {
    throw new Error('Failed to reach password updated success screen!');
  }
  console.log('✓ Password reset flow completed with success screen!');

  await page.screenshot({ path: 'scratch/forgot_password_success.png' });

  // 6. Test with Email as well
  console.log('\n6. Testing Email recovery flow...');
  await page.goto(`${BASE_URL}/forgot-password.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1000);

  await page.fill('#identifier', 'user.recovery@askexpert.com');
  await page.click('#sendOtpButton');
  await page.waitForTimeout(1000);

  const emailDemoCode = await page.innerText('#demoOtpCode');
  console.log('Generated Demo OTP (email):', emailDemoCode);
  if (!emailDemoCode || emailDemoCode.length !== 6) {
    throw new Error(`Invalid Email Demo OTP: ${emailDemoCode}`);
  }

  await page.click('#autoFillOtpButton');
  await page.click('#verifyOtpButton');
  await page.waitForTimeout(1500);

  const emailResetActive = await page.$eval('#resetScreen', el => el.classList.contains('active'));
  if (!emailResetActive) {
    throw new Error('Email recovery failed to transition to Reset Screen!');
  }
  console.log('✓ Email recovery OTP flow succeeded perfectly!');

  await browser.close();

  console.log('\n=== SUMMARY ===');
  console.log('Console Errors:', consoleErrors);
  console.log('Network Failures:', networkFailures);
  console.log('🎉 FORGOT PASSWORD OTP FULLY VERIFIED & WORKING!');
}

testForgotPasswordOtp().catch((err) => {
  console.error('❌ Test failed:', err);
  process.exit(1);
});
