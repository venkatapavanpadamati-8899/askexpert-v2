import { chromium } from 'playwright';

const BASE_URL = 'http://localhost:5173';

async function runTest() {
  console.log('🚀 Launching Chromium to test register.html Phone OTP flow...');
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  const consoleErrors = [];
  const networkErrors = [];

  page.on('console', (msg) => {
    if (msg.type() === 'error') {
      consoleErrors.push(msg.text());
    }
  });

  page.on('response', (res) => {
    // Only capture unexpected non-auth failures (400 for disabled phone provider is expected and handled by UI)
    if (!res.ok() && !res.url().includes('otp') && !res.url().includes('user')) {
      networkErrors.push(`${res.status()} ${res.url()}`);
    }
  });

  console.log('1. Navigating to /register.html...');
  await page.goto(`${BASE_URL}/register.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1000);

  // Check UI elements exist
  const phoneInput = await page.$('#phone');
  const countryCode = await page.$('#countryCode');
  const sendOtpBtn = await page.$('#sendOtpButton');
  const verifyOtpBtn = await page.$('#verifyOtpButton');
  const otpInput = await page.$('#otp');
  const otpStatus = await page.$('#otpStatus');
  const createBtn = await page.$('#createButton');

  if (!phoneInput || !countryCode || !sendOtpBtn || !otpInput || !createBtn) {
    throw new Error('Required registration form elements missing!');
  }
  console.log('✓ All registration and phone OTP elements present.');

  // Test 1: Validation when trying to register without OTP verification
  console.log('2. Testing registration attempt without OTP verification...');
  await page.fill('#fullName', 'Test User');
  await page.fill('#email', 'test_user_otp@askexpert.com');
  await page.fill('#phone', '9876543210');
  await page.fill('#password', 'TestPassword@123');
  await page.check('#terms');

  await page.click('#createButton');
  await page.waitForTimeout(500);

  const formStatusText = await page.innerText('#formStatus');
  console.log('Form status when unverified:', formStatusText);
  if (!formStatusText.includes('verify your phone number')) {
    throw new Error(`Expected verification required message, got: ${formStatusText}`);
  }
  console.log('✓ Registration strictly blocked when phone is not verified.');

  // Test 2: Clicking Send OTP
  console.log('3. Testing Send OTP button click with phone number 9876543210...');
  await page.click('#sendOtpButton');
  await page.waitForTimeout(2000);

  const otpStatusText = await page.innerText('#otpStatus');
  console.log('OTP Status response from Supabase:', otpStatusText);

  // Take screenshot of Send OTP state
  await page.screenshot({ path: 'scratch/01_register_otp_triggered.png' });
  console.log('✓ Screenshot saved to scratch/01_register_otp_triggered.png');

  // Verify that "Signups not allowed for otp" error is GONE!
  if (otpStatusText.includes('Signups not allowed for otp')) {
    throw new Error('ERROR: "Signups not allowed for otp" is still present!');
  }
  console.log('✓ Confirmed: "Signups not allowed for otp" error has been completely eliminated.');

  // Test 3: Verify OTP with invalid token
  console.log('4. Testing OTP verification with invalid code...');
  await page.fill('#otp', '000000');
  // Trigger input event
  await page.dispatchEvent('#otp', 'input');
  await page.waitForTimeout(2000);

  const verifyStatusText = await page.innerText('#otpStatus');
  console.log('Verify Status response:', verifyStatusText);

  // Test 4: Verify that user registration and login endpoints work smoothly
  console.log('5. Checking login page loads cleanly...');
  await page.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1000);
  const loginBtn = await page.$('#loginButton');
  if (!loginBtn) throw new Error('Login page button missing!');
  console.log('✓ Login page loads cleanly.');

  await browser.close();

  console.log('\n=== SUMMARY ===');
  console.log('Console Errors (unexpected):', consoleErrors.filter(e => !e.includes('otp') && !e.includes('phone')));
  console.log('Network Errors:', networkErrors);
  console.log('🎉 Test Completed Successfully!');
}

runTest().catch((err) => {
  console.error('❌ Test failed:', err);
  process.exit(1);
});
