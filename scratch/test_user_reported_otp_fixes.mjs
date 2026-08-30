import { chromium } from 'playwright';

const BASE_URL = 'http://localhost:5173';

async function testUserReportedFixes() {
  console.log('🚀 Starting Verification of User Reported OTP & Default User Fixes...\n');
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({ viewport: { width: 412, height: 915 } }); // Mobile viewport matching reference

  // ========================================================
  // TEST 1: register.html
  // ========================================================
  console.log('>>> TEST 1: register.html <<<');
  const regPage = await context.newPage();
  await regPage.goto(`${BASE_URL}/register.html`, { waitUntil: 'domcontentloaded' });
  await regPage.waitForTimeout(500);

  // 1. Verify default user selection in accountType dropdown
  const defaultAccountType = await regPage.$eval('#accountType', el => el.value);
  console.log('1. Account Type default value:', defaultAccountType);
  if (defaultAccountType !== 'user') {
    throw new Error(`Expected default accountType to be 'user', but got '${defaultAccountType}'`);
  }
  console.log('✓ PASS: Default user account type is automatically selected as "user"!');

  // 2. Test Phone OTP Sending & Receiving
  console.log('2. Entering mobile number 9876543210 and clicking Send OTP...');
  await regPage.fill('#phone', '9876543210');
  await regPage.click('#sendOtpButton');
  await regPage.waitForTimeout(600);

  // Verify Demo OTP Box is shown
  const isBoxVisible = await regPage.$eval('#demoOtpBox', el => el.classList.contains('show'));
  const demoCode = await regPage.innerText('#demoOtpCode');
  const otpInputValue = await regPage.inputValue('#otp');
  const otpStatusText = await regPage.innerText('#otpStatus');

  console.log('Demo OTP Box visible:', isBoxVisible);
  console.log('Generated Demo OTP Code:', demoCode);
  console.log('Received OTP in input field:', otpInputValue);
  console.log('OTP Status text:', otpStatusText);

  if (!isBoxVisible) {
    throw new Error('Demo OTP box was not shown after Send OTP!');
  }
  if (!demoCode || demoCode.length !== 6) {
    throw new Error(`Invalid demoCode: ${demoCode}`);
  }
  if (otpInputValue !== demoCode) {
    throw new Error(`OTP input was not automatically populated! Expected: ${demoCode}, Got: ${otpInputValue}`);
  }
  console.log('✓ PASS: OTP successfully sent, received, and auto-populated in register.html!');

  // 3. Verify OTP
  console.log('3. Clicking Verify OTP...');
  await regPage.click('#verifyOtpButton');
  await regPage.waitForTimeout(600);
  const statusAfterVerify = await regPage.innerText('#otpStatus');
  console.log('Status after verify:', statusAfterVerify);
  if (!statusAfterVerify.includes('Verified')) {
    throw new Error('OTP verification failed in register.html');
  }
  console.log('✓ PASS: OTP verification succeeded!\n');
  await regPage.screenshot({ path: 'scratch/verified_register_otp_fixed.png' });
  await regPage.close();

  // ========================================================
  // TEST 2: forgot-password.html
  // ========================================================
  console.log('>>> TEST 2: forgot-password.html <<<');
  const forgotPage = await context.newPage();
  await forgotPage.goto(`${BASE_URL}/forgot-password.html`, { waitUntil: 'domcontentloaded' });
  await forgotPage.waitForTimeout(500);

  console.log('1. Entering email user@askexpert.com and clicking Send OTP...');
  await forgotPage.fill('#identifier', 'user@askexpert.com');
  await forgotPage.click('#sendOtpButton');
  await forgotPage.waitForTimeout(600);

  const forgotDemoCode = await forgotPage.innerText('#demoOtpCode');
  const forgotOtpInputValue = await forgotPage.inputValue('#otp');
  const forgotOtpStatus = await forgotPage.innerText('#otpStatus');

  console.log('Forgot Password Demo OTP Code:', forgotDemoCode);
  console.log('Forgot Password OTP in input field:', forgotOtpInputValue);
  console.log('Forgot Password OTP status:', forgotOtpStatus);

  if (!forgotDemoCode || forgotDemoCode.length !== 6) {
    throw new Error(`Forgot password Demo OTP code invalid: ${forgotDemoCode}`);
  }
  if (forgotOtpInputValue !== forgotDemoCode) {
    throw new Error(`Forgot password OTP not auto-filled! Expected: ${forgotDemoCode}, Got: ${forgotOtpInputValue}`);
  }
  console.log('✓ PASS: Demo OTP is generated, received, and auto-populated in forgot-password.html!');

  // 2. Click Verify OTP
  console.log('2. Clicking Verify OTP in forgot-password.html...');
  await forgotPage.click('#verifyOtpButton');
  await forgotPage.waitForTimeout(1000);

  const isResetActive = await forgotPage.$eval('#resetScreen', el => el.classList.contains('active'));
  console.log('Transitioned to Reset Password Screen:', isResetActive);
  if (!isResetActive) {
    throw new Error('Did not transition to Reset Password Screen after OTP verification!');
  }
  console.log('✓ PASS: Transitioned to Reset Password Screen successfully!');

  // Also test with Phone Number recovery
  console.log('3. Testing phone number recovery in forgot-password.html...');
  await forgotPage.goto(`${BASE_URL}/forgot-password.html`, { waitUntil: 'domcontentloaded' });
  await forgotPage.waitForTimeout(500);
  await forgotPage.fill('#identifier', '9876543210');
  await forgotPage.click('#sendOtpButton');
  await forgotPage.waitForTimeout(600);

  const phoneDemoCode = await forgotPage.innerText('#demoOtpCode');
  const phoneOtpInput = await forgotPage.inputValue('#otp');
  console.log('Phone recovery Demo OTP:', phoneDemoCode, 'Filled in input:', phoneOtpInput);
  if (!phoneDemoCode || phoneDemoCode.length !== 6 || phoneOtpInput !== phoneDemoCode) {
    throw new Error('Phone recovery Demo OTP flow failed!');
  }
  console.log('✓ PASS: Phone recovery Demo OTP working cleanly!');

  await forgotPage.screenshot({ path: 'scratch/verified_forgot_otp_fixed.png' });
  await forgotPage.close();
  await browser.close();

  console.log('\n========================================================');
  console.log('🎉 ALL USER-REQUESTED FIXES VERIFIED AND PASSING 100%!');
  console.log('========================================================');
}

testUserReportedFixes().catch(err => {
  console.error('❌ Verification failed:', err);
  process.exit(1);
});
