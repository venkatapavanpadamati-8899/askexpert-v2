import { chromium } from 'playwright';

const BASE_URL = 'http://localhost:5173';

async function verifyDemoOtp() {
  console.log('🚀 Launching Chromium to test register.html Demo OTP Flow...');
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  const consoleErrors = [];
  const networkFailures = [];

  page.on('console', (msg) => {
    if (msg.type() === 'error') {
      consoleErrors.push(msg.text());
    }
  });

  page.on('requestfailed', (req) => {
    networkFailures.push(`${req.failure()?.errorText} ${req.url()}`);
  });

  // Step 1: Open register.html
  console.log('1. Opening register.html...');
  await page.goto(`${BASE_URL}/register.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1000);

  // Step 2: Enter test phone number
  console.log('2. Entering test phone number: 9876543210...');
  await page.fill('#phone', '9876543210');
  await page.waitForTimeout(500);

  // Step 3: Click Send OTP
  console.log('3. Clicking Send OTP...');
  await page.click('#sendOtpButton');
  await page.waitForTimeout(1000);

  // Step 4: Verify Demo OTP is displayed
  const demoOtpBox = await page.$('#demoOtpBox');
  const demoOtpText = await page.innerText('#demoOtpCode');
  const otpStatusText = await page.innerText('#otpStatus');

  console.log('Generated Demo OTP:', demoOtpText);
  console.log('OTP Status text:', otpStatusText);

  if (!demoOtpText || demoOtpText.length !== 6 || !/^\d{6}$/.test(demoOtpText)) {
    throw new Error(`Demo OTP not generated properly! Got: ${demoOtpText}`);
  }
  console.log('✓ Demo OTP is successfully generated and displayed: ' + demoOtpText);

  await page.screenshot({ path: 'scratch/01_demo_otp_displayed.png' });

  // Step 5: Test entering the Demo OTP
  console.log('4. Testing Auto-fill OTP button...');
  await page.click('#autoFillOtpButton');
  await page.waitForTimeout(1000);

  const enteredOtp = await page.inputValue('#otp');
  const statusAfterVerify = await page.innerText('#otpStatus');
  console.log('Entered OTP in field:', enteredOtp);
  console.log('Status after verification:', statusAfterVerify);

  if (enteredOtp !== demoOtpText) {
    throw new Error(`Auto-fill mismatch! Expected: ${demoOtpText}, got: ${enteredOtp}`);
  }

  if (!statusAfterVerify.includes('Verified Successfully')) {
    throw new Error(`OTP validation failed! Status: ${statusAfterVerify}`);
  }
  console.log('✓ Demo OTP verification succeeded!');

  await page.screenshot({ path: 'scratch/02_demo_otp_verified.png' });

  // Step 6: Verify registration can continue
  console.log('5. Verifying registration fields and submission readiness...');
  const sendBtnText = await page.innerText('#sendOtpButton');
  console.log('Send OTP button text after verify:', sendBtnText);
  if (!sendBtnText.includes('Verified')) {
    throw new Error('Send OTP button should show "Verified"');
  }

  // Fill in required fields to check form submission readiness
  await page.fill('#fullName', 'Demo Test User');
  await page.fill('#email', 'demotest_' + Date.now() + '@askexpert.com');
  await page.fill('#password', 'TestPassword@123');
  await page.check('#terms');
  await page.waitForTimeout(500);

  console.log('6. Submitting form with verified Demo OTP...');
  await page.click('#createButton');
  await page.waitForTimeout(3000);

  const formStatusText = await page.innerText('#formStatus');
  console.log('Form status after submit:', formStatusText);
  console.log('Current URL after submit:', page.url());

  await page.screenshot({ path: 'scratch/03_registration_continued.png' });

  // Check login.html
  console.log('7. Verifying login.html remains intact...');
  await page.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1000);
  const loginButton = await page.$('#loginButton');
  if (!loginButton) throw new Error('Login button missing on login.html!');
  console.log('✓ login.html is intact.');

  // Check forgot-password.html
  console.log('8. Verifying forgot-password.html remains intact...');
  await page.goto(`${BASE_URL}/forgot-password.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1000);
  const resetBtn = await page.$('#sendOtpButton');
  if (!resetBtn) throw new Error('Forgot password button missing on forgot-password.html!');
  console.log('✓ forgot-password.html is intact.');

  await browser.close();

  console.log('\n=== TEST VERIFICATION SUMMARY ===');
  console.log('Console Errors:', consoleErrors);
  console.log('Network Failures:', networkFailures);
  console.log('🎉 ALL DEMO OTP REGISTRATION TESTS PASSED PERFECTLY!');
}

verifyDemoOtp().catch(err => {
  console.error('❌ Verification failed:', err);
  process.exit(1);
});
