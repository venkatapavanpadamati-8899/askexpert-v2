import { chromium } from 'playwright';

const BASE_URL = 'http://localhost:5173';

async function verifyAllNewFixes() {
  console.log('🚀 Starting Verification of Admin Login, User/Expert Login, Demo OTP, and Expert Aadhaar Upload...\n');
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({ viewport: { width: 412, height: 915 } });

  // ========================================================
  // TEST 1: login.html Admin Login
  // ========================================================
  console.log('>>> TEST 1: Admin Login from login.html <<<');
  const adminLoginPage = await context.newPage();
  await adminLoginPage.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
  await adminLoginPage.waitForTimeout(500);

  console.log('1.1 Entering admin username "admin" and password "admin123"...');
  await adminLoginPage.fill('#email', 'admin');
  await adminLoginPage.fill('#password', 'admin123');
  await adminLoginPage.click('#loginButton');

  console.log('1.2 Waiting for navigation to admin-dashboard.html...');
  await adminLoginPage.waitForURL('**/admin-dashboard.html', { timeout: 10000 });
  console.log('✓ PASS: Admin successfully logged in and redirected to admin-dashboard.html! URL:', adminLoginPage.url());
  await adminLoginPage.close();

  // ========================================================
  // TEST 2: admin-login.html Direct Login
  // ========================================================
  console.log('\n>>> TEST 2: Direct Admin Login from admin-login.html <<<');
  const directAdminPage = await context.newPage();
  await directAdminPage.goto(`${BASE_URL}/admin-login.html`, { waitUntil: 'domcontentloaded' });
  await directAdminPage.waitForTimeout(500);

  console.log('2.1 Submitting admin credentials in admin-login.html...');
  await directAdminPage.fill('#adminEmailInput', 'admin');
  await directAdminPage.fill('#adminPasswordInput', 'admin123');
  await directAdminPage.click('#adminSubmitBtn');

  await directAdminPage.waitForURL('**/admin-dashboard.html', { timeout: 10000 });
  console.log('✓ PASS: Direct Admin Login working 100%! URL:', directAdminPage.url());
  await directAdminPage.close();

  // ========================================================
  // TEST 3: login.html Expert Login & User Login
  // ========================================================
  console.log('\n>>> TEST 3: Expert & User Login from login.html <<<');
  const euPage = await context.newPage();
  await euPage.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
  await euPage.waitForTimeout(500);

  console.log('3.1 Entering "expert" and "expert123"...');
  await euPage.fill('#email', 'expert');
  await euPage.fill('#password', 'expert123');
  await euPage.click('#loginButton');

  await euPage.waitForURL('**/professional-dashboard.html', { timeout: 10000 });
  console.log('✓ PASS: Expert successfully logged in and redirected to professional-dashboard.html! URL:', euPage.url());

  // Test User Login
  await euPage.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
  await euPage.waitForTimeout(500);
  console.log('3.2 Entering "user" and "user123"...');
  await euPage.fill('#email', 'user');
  await euPage.fill('#password', 'user123');
  await euPage.click('#loginButton');

  await euPage.waitForURL('**/user-dashboard.html', { timeout: 10000 });
  console.log('✓ PASS: User successfully logged in and redirected to user-dashboard.html! URL:', euPage.url());
  await euPage.close();

  // ========================================================
  // TEST 4: register.html Demo OTP & Expert Aadhaar Upload
  // ========================================================
  console.log('\n>>> TEST 4: register.html Demo OTP & Expert Aadhaar Section <<<');
  const regPage = await context.newPage();
  await regPage.goto(`${BASE_URL}/register.html`, { waitUntil: 'domcontentloaded' });
  await regPage.waitForTimeout(500);

  // 4.1 Clicking Send OTP without typing phone number
  console.log('4.1 Clicking Send OTP without manually typing phone...');
  await regPage.click('#sendOtpButton');
  await regPage.waitForTimeout(600);

  const phoneValue = await regPage.inputValue('#phone');
  const demoCode = await regPage.innerText('#demoOtpCode');
  const otpInputValue = await regPage.inputValue('#otp');
  const isDemoBoxVisible = await regPage.$eval('#demoOtpBox', el => el.classList.contains('show'));

  console.log('Auto-filled phone:', phoneValue);
  console.log('Demo OTP Code:', demoCode);
  console.log('Auto-filled OTP input:', otpInputValue);
  console.log('Is Demo Box Visible?', isDemoBoxVisible);

  if (!isDemoBoxVisible || !demoCode || demoCode.length !== 6 || otpInputValue !== demoCode) {
    throw new Error('Demo OTP auto-generation or input auto-fill failed!');
  }
  console.log('✓ PASS: Send OTP automatically generates Demo OTP and fills OTP field without blocking!');

  // 4.2 Verify OTP
  await regPage.click('#verifyOtpButton');
  await regPage.waitForTimeout(500);
  const verifyStatus = await regPage.innerText('#otpStatus');
  console.log('Verify Status:', verifyStatus);
  if (!verifyStatus.includes('Verified')) {
    throw new Error('OTP verification failed!');
  }
  console.log('✓ PASS: Demo OTP verification succeeded!');

  // 4.3 Select Professional / Expert to reveal Aadhaar Section
  console.log('4.3 Selecting "Professional / Expert" in Account Type...');
  await regPage.selectOption('#accountType', 'professional');
  await regPage.waitForTimeout(500);

  const isAadhaarVisible = await regPage.$eval('#expertVerificationFields', el => el.style.display !== 'none');
  console.log('Is Expert Aadhaar Section visible?', isAadhaarVisible);
  if (!isAadhaarVisible) {
    throw new Error('Expert Aadhaar verification fields not displayed when Professional is selected!');
  }
  console.log('✓ PASS: Expert Aadhaar section is displayed dynamically on Professional selection!');

  // 4.4 Enter 12-digit Aadhaar Number
  console.log('4.4 Typing 12-digit Aadhaar Number 543212348765...');
  await regPage.fill('#aadhaarNumber', '543212348765');
  const formattedAadhaar = await regPage.inputValue('#aadhaarNumber');
  console.log('Formatted Aadhaar in field:', formattedAadhaar);
  if (formattedAadhaar !== '5432 1234 8765') {
    throw new Error(`Aadhaar auto-formatting failed: expected "5432 1234 8765", got "${formattedAadhaar}"`);
  }
  console.log('✓ PASS: Aadhaar number auto-formatted with spaces cleanly!');

  // 4.5 Fill remaining details and submit expert registration
  const expertEmail = `test_expert_${Date.now()}@askexpert.local`;
  await regPage.fill('#fullName', 'Dr. Ramesh Sharma');
  await regPage.fill('#email', expertEmail);
  await regPage.fill('#password', 'ExpertPass@123');

  console.log('4.5 Submitting Expert Registration form...');
  await regPage.click('#createButton');

  await regPage.waitForURL('**/professional-verification.html', { timeout: 10000 });
  console.log('✓ PASS: Expert registered and redirected to Professional Verification to upload remaining certificates! URL:', regPage.url());

  await regPage.screenshot({ path: 'scratch/expert_registration_aadhaar_verified.png' });
  await regPage.close();
  await browser.close();

  console.log('\n========================================================');
  console.log('🎉 ALL TESTS PASSED! ADMIN LOGIN, EXPERT AADHAAR, AND DEMO OTP VERIFIED 100%!');
  console.log('========================================================');
}

verifyAllNewFixes().catch(err => {
  console.error('❌ Verification failed:', err);
  process.exit(1);
});
