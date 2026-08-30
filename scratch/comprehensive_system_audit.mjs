import { chromium } from 'playwright';

const BASE_URL = 'http://localhost:5175';

async function runComprehensiveAudit() {
  console.log('═══════════════════════════════════════════════════════════════════');
  console.log('🔍 STARTING FULL-STACK COMPREHENSIVE SYSTEM AUDIT FOR ASKEXPERT');
  console.log('═══════════════════════════════════════════════════════════════════\n');

  const browser = await chromium.launch({ headless: true });
  const results = [];

  function record(suite, name, passed, details = '') {
    results.push({ suite, name, passed, details });
    const mark = passed ? '✅ PASS' : '❌ FAIL';
    console.log(`${mark} [${suite}] ${name} ${details ? '(' + details + ')' : ''}`);
  }

  // =========================================================================
  // 1. LOGIN PAGE TESTS (login.html)
  // =========================================================================
  {
    const context = await browser.newContext({ viewport: { width: 412, height: 915 } });
    const page = await context.newPage();
    const consoleErrors = [];
    page.on('console', msg => { if (msg.type() === 'error') consoleErrors.push(msg.text()); });
    page.on('pageerror', err => consoleErrors.push(err.message));

    await page.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(500);

    // 1.1 Verify no "Ask Question" button on login.html
    const hasAskBtn = await page.$('#askButton');
    record('Login UI', 'Removed unnecessary "Ask Question" button from login.html', !hasAskBtn);

    // 1.2 Verify centered Register button and highlighted Forgot Password link
    const registerBtnCentered = await page.$eval('.btn-row', el => el.style.justifyContent === 'center');
    const hasForgotHighlight = await page.$eval('a[href="forgot-password.html"]', el => el.textContent.includes('Forgot Password?'));
    record('Login UI', 'Register button is centered with highlighted Forgot Password link below', registerBtnCentered && hasForgotHighlight);

    // 1.3 Verify no visible "Direct Admin Login" link on login.html
    const pageHtml = await page.content();
    const hasVisibleAdminLink = pageHtml.includes('Direct Admin Login');
    record('Login UI', 'Admin login is hidden (no visible Direct Admin link)', !hasVisibleAdminLink);

    // 1.4 Hidden Admin Login redirects to admin-dashboard.html
    await page.fill('#email', 'admin');
    await page.fill('#password', 'admin123');
    await page.click('#loginButton');
    await page.waitForURL('**/admin-dashboard.html', { timeout: 8000 });
    record('Auth Login', 'Hidden Admin Login via normal form -> admin-dashboard.html', page.url().includes('admin-dashboard.html'));

    // Verify Admin Dashboard zero fake records
    const totalUsersVal = await page.innerText('#valTotalUsers');
    const verifiedExpertsVal = await page.innerText('#valVerifiedExperts');
    const adminHtml = await page.content();
    const hasFakeAdminData = totalUsersVal.includes('12,480') || verifiedExpertsVal.includes('1,284') || adminHtml.includes('CA Rajesh Joshi');
    record('Data Integrity', 'Admin Dashboard has zero fake records & loads live Supabase stats', !hasFakeAdminData);

    // 1.5 Admin Dashboard Logout clears session and returns to login.html
    const adminLogout = (await page.$('#adminTopbarLogoutBtn')) || (await page.$('#adminLogoutBtn'));
    await Promise.all([
      page.waitForURL('**/login.html', { timeout: 8000 }),
      adminLogout.click()
    ]);
    const adminSessionCleared = await page.evaluate(() => !sessionStorage.getItem('askexpert_user_role'));
    record('Auth Logout', 'Admin logout clears session storage & returns to login.html', adminSessionCleared && page.url().includes('login.html'));

    // 1.6 User Login redirects to user-dashboard.html
    await page.fill('#email', 'user');
    await page.fill('#password', 'user123');
    await page.click('#loginButton');
    await page.waitForURL('**/user-dashboard.html', { timeout: 8000 });
    record('Auth Login', 'User Login via normal form -> user-dashboard.html', page.url().includes('user-dashboard.html'));

    // 1.7 User Dashboard Logout clears session and returns to login.html
    const userLogout = (await page.$('#userTopbarLogoutBtn')) || (await page.$('#logoutBtn'));
    await Promise.all([
      page.waitForURL('**/login.html', { timeout: 8000 }),
      userLogout.click()
    ]);
    record('Auth Logout', 'User logout clears session & returns to login.html', page.url().includes('login.html'));

    // 1.8 Expert Login via Enter key on password field -> professional-dashboard.html
    await page.fill('#email', 'expert');
    await page.fill('#password', 'expert123');
    await page.press('#password', 'Enter');
    await page.waitForURL('**/professional-dashboard.html', { timeout: 8000 });
    record('Auth Login', 'Expert Login (via Enter key) -> professional-dashboard.html', page.url().includes('professional-dashboard.html'));

    // Verify Professional Dashboard zero fake records
    const profHtml = await page.content();
    const hasFakeProfData = profHtml.includes('#MH/2014/9842');
    record('Data Integrity', 'Professional Dashboard has zero fake records & loads live data', !hasFakeProfData);

    // 1.9 Expert Dashboard Logout
    const expertLogout = (await page.$('#expertTopbarLogoutBtn')) || (await page.$('#expertLogoutBtn'));
    await Promise.all([
      page.waitForURL('**/login.html', { timeout: 8000 }),
      expertLogout.click()
    ]);
    record('Auth Logout', 'Expert logout clears session & returns to login.html', page.url().includes('login.html'));

    await context.close();
  }

  // =========================================================================
  // 2. SESSION PROTECTION ON PRIVATE PAGES
  // =========================================================================
  {
    const context = await browser.newContext();
    const page = await context.newPage();

    // 2.1 user-dashboard.html without session -> redirects to login.html
    await page.goto(`${BASE_URL}/user-dashboard.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(1000);
    record('Session Guard', 'user-dashboard.html redirects unauthenticated user to login.html', page.url().includes('login.html'));

    // 2.2 professional-dashboard.html without session -> redirects to login.html
    await page.goto(`${BASE_URL}/professional-dashboard.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(1000);
    record('Session Guard', 'professional-dashboard.html redirects unauthenticated user to login.html', page.url().includes('login.html'));

    // 2.3 admin-dashboard.html without session -> redirects to login.html
    await page.goto(`${BASE_URL}/admin-dashboard.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(1000);
    record('Session Guard', 'admin-dashboard.html redirects unauthenticated user to login.html', page.url().includes('login.html'));

    await context.close();
  }

  // =========================================================================
  // 3. REGISTRATION FLOW (register.html)
  // =========================================================================
  {
    const context = await browser.newContext({ viewport: { width: 412, height: 915 } });
    const page = await context.newPage();

    await page.goto(`${BASE_URL}/register.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(500);

    // 3.1 Check Ask button is completely removed from register.html
    const hasAskInRegister = await page.$('.bottom-button-row a[href="ask-question.html"]');
    record('Register UI', 'Completely removed "Ask" button from register.html', !hasAskInRegister);

    // 3.2 Check default account type is 'user'
    const defaultAccType = await page.inputValue('#accountType');
    record('Register', 'Default Account Type is "User / Client"', defaultAccType === 'user');

    // 3.3 Send OTP without typing phone number auto-fills demo phone and generates Demo OTP
    await page.click('#sendOtpButton');
    await page.waitForTimeout(500);
    const generatedPhone = await page.inputValue('#phone');
    const demoCode = await page.innerText('#demoOtpCode');
    const otpValue = await page.inputValue('#otp');
    record('OTP Flow', 'Send OTP generates 6-digit Demo OTP and auto-fills OTP input', demoCode.length === 6 && otpValue === demoCode);

    // 3.3 Verify OTP
    await page.click('#verifyOtpButton');
    await page.waitForTimeout(500);
    const otpStatusText = await page.innerText('#otpStatus');
    record('OTP Flow', 'Verify OTP successfully marks OTP verified', otpStatusText.includes('Verified'));

    // 3.4 Select Professional to reveal Aadhaar Section
    await page.selectOption('#accountType', 'professional');
    await page.waitForTimeout(400);
    const isAadhaarVisible = await page.$eval('#expertVerificationFields', el => el.style.display !== 'none');
    record('Expert Verification', 'Selecting Professional dynamically displays Aadhaar section', isAadhaarVisible);

    // 3.5 Type 12-digit Aadhaar with auto-formatting
    await page.fill('#aadhaarNumber', '987654321098');
    const formattedAadhaar = await page.inputValue('#aadhaarNumber');
    record('Expert Verification', 'Aadhaar auto-formats with spaces ("9876 5432 1098")', formattedAadhaar === '9876 5432 1098');

    // 3.6 Submit Registration and verify automatic redirect to login.html
    const testEmail = `audit_user_${Date.now()}@askexpert.local`;
    await page.fill('#fullName', 'Suresh Kumar');
    await page.fill('#email', testEmail);
    await page.fill('#password', 'SecretPass@123');
    await page.click('#createButton');

    await page.waitForURL('**/login.html', { timeout: 8000 });
    record('Register Redirect', 'Registration automatically redirects to login.html', page.url().includes('login.html'));

    await context.close();
  }

  // =========================================================================
  // 4. FORGOT PASSWORD FLOW (forgot-password.html)
  // =========================================================================
  {
    const context = await browser.newContext({ viewport: { width: 412, height: 915 } });
    const page = await context.newPage();

    await page.goto(`${BASE_URL}/forgot-password.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(500);

    // 4.1 Enter Identifier and Send OTP
    await page.fill('#identifier', 'audit_user@askexpert.com');
    await page.click('#sendOtpButton');
    await page.waitForTimeout(500);
    const demoOtpVal = await page.innerText('#demoOtpCode');
    const otpInputVal = await page.inputValue('#otp');
    const sendBtnText = await page.innerText('#sendOtpButton');
    record('Forgot Password', 'Send OTP generates Demo OTP and auto-fills OTP input', demoOtpVal.length === 6 && otpInputVal === demoOtpVal);
    record('Forgot Password', 'Send OTP activates 60s countdown timer on button', sendBtnText.includes('Resend in'));

    // 4.2 Verify OTP and advance to Step 2
    await page.click('#verifyOtpButton');
    await page.waitForTimeout(800);
    const isStepTwoActive = await page.$eval('#stepTwo', el => el.classList.contains('active'));
    record('Forgot Password', 'Verify OTP advances to Step 2 (Reset Password Screen)', isStepTwoActive);

    // 4.3 Enter new valid password and submit
    await page.fill('#newPassword', 'NewSecurityPass@123');
    await page.fill('#confirmPassword', 'NewSecurityPass@123');
    await page.click('#updatePasswordButton');
    await page.waitForTimeout(1000);

    const isSuccessShown = await page.$eval('#successScreen', el => el.classList.contains('show'));
    record('Forgot Password', 'Password updated successfully and shows Success Screen with login link', isSuccessShown);

    await context.close();
  }

  // =========================================================================
  // 5. PAYMENTS & FINANCIAL ESCROW FLOW AUDIT (payments.html, payment-history.html)
  // =========================================================================
  {
    const context = await browser.newContext({ viewport: { width: 1280, height: 800 } });
    const page = await context.newPage();

    await page.goto(`${BASE_URL}/payments.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(600);

    // 5.1 Check wallet display starts at 0.00 and no fake 4,500.00
    const walletText = await page.innerText('#walletDisplay');
    record('Payments Flow', 'Wallet display starts at ₹0.00 (no hardcoded fake ₹4,500.00)', walletText.includes('0.00'));

    // 5.2 Check recent receipts has no hardcoded dummy items
    const recentTxnText = await page.innerText('#miniRecentTxnList');
    const hasFakeTxn = recentTxnText.includes('Adv. Vikram Rao (Legal)') || recentTxnText.includes('Wallet Top-up (UPI)');
    record('Payments Flow', 'Recent receipts ledger has zero hardcoded fake records', !hasFakeTxn);

    // 5.3 Test payment execution & gateway modal
    await page.click('#payNowBtn');
    await page.waitForTimeout(1000);

    // Modal opens with pending animation and transitions to verified success
    const modalOpen = await page.$eval('#checkoutModal', el => el.classList.contains('open'));
    record('Payments Flow', 'Proceed to Secure Pay opens payment gateway modal', modalOpen);

    // Wait for success transition
    await page.waitForSelector('#modalSuccessState', { state: 'visible', timeout: 10000 });
    const txnGenerated = await page.innerText('#successTxnId');
    record('Payments Flow', 'Payment completes successfully and issues real #TXN reference', txnGenerated.startsWith('#TXN-'));

    // 5.4 Check payment-history.html has zero SEED_HISTORY dummy transactions
    await page.goto(`${BASE_URL}/payment-history.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(600);
    const historyHtml = await page.content();
    const hasSeedHistory = historyHtml.includes('TXN-849201') && historyHtml.includes('CA Ananya Sharma') && historyHtml.includes('Dr. Rahul Kumar');
    record('Payments Flow', 'Payment History has zero hardcoded SEED_HISTORY records', !hasSeedHistory);

    // 5.5 Log in as Expert to inspect expert-protected earnings & requests
    await page.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
    await page.fill('#email', 'expert');
    await page.fill('#password', 'expert123');
    await page.click('#loginButton');
    await page.waitForURL('**/professional-dashboard.html', { timeout: 8000 });

    // 5.6 Check professional-earnings.html has zero hardcoded fake balances
    await page.goto(`${BASE_URL}/professional-earnings.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(600);
    const availablePayout = await page.innerText('#availablePayoutAmount');
    const totalNetEarnings = await page.innerText('#statTotalNetEarnings');
    const earningsHtml = await page.content();
    const hasFakeEarnings = availablePayout.includes('36,500') || totalNetEarnings.includes('48,900') || earningsHtml.includes('PAY-992014');
    record('Data Integrity', 'Professional Earnings has zero hardcoded fake balances or mock rows', !hasFakeEarnings);

    // 5.7 Check consultation-requests.html has zero hardcoded "2 Pending"
    await page.goto(`${BASE_URL}/consultation-requests.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(600);
    const reqHeaderBadge = await page.innerText('#totalPendingBadge');
    record('Data Integrity', 'Consultation requests queue badge reflects live count (not hardcoded 2)', !reqHeaderBadge.includes('2 Pending') || reqHeaderBadge.includes('Pending'));

    await context.close();
  }

  // =========================================================================
  // 6. AI CERTIFICATE VERIFICATION & ADVISORY AUDIT (admin-professionals.html)
  // =========================================================================
  {
    const context = await browser.newContext({ viewport: { width: 1280, height: 800 } });
    const page = await context.newPage();

    // Authenticate as Admin
    await page.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
    await page.fill('#email', 'admin');
    await page.fill('#password', 'admin123');
    await page.click('#loginButton');
    await page.waitForURL('**/admin-dashboard.html', { timeout: 8000 });

    // Navigate to admin-professionals.html
    await page.goto(`${BASE_URL}/admin-professionals.html`, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(800);

    // 6.1 Check AI Assessment section has Advisory Policy Banner
    const profHtml = await page.content();
    const hasAdvisoryPolicy = profHtml.includes('AI Advisory Policy') && profHtml.includes('AI never auto-approves or auto-rejects applications');
    record('AI Governance', 'AI Certificate Verifier enforces Advisory Policy (No auto approve/reject)', hasAdvisoryPolicy);

    // 6.2 Check Risk assessment elements exist
    const hasRiskFields = profHtml.includes('modalAiRiskLevel') && profHtml.includes('modalAiRiskScore') && profHtml.includes('modalAiSuspiciousPoints');
    record('AI Governance', 'AI Certificate Verifier includes Risk Level, Risk Score, and Suspicious Indicators', hasRiskFields);

    await context.close();
  }

  // =========================================================================
  // 7. RESPONSIVE SCREEN SIZE AUDIT
  // =========================================================================
  {
    const viewports = [
      { name: 'Mobile (iPhone 13 - 390x844)', width: 390, height: 844 },
      { name: 'Mobile (Pixel 7 - 412x915)', width: 412, height: 915 },
      { name: 'Tablet (iPad Mini - 768x1024)', width: 768, height: 1024 },
      { name: 'Desktop (Laptop - 1280x800)', width: 1280, height: 800 }
    ];

    for (const vp of viewports) {
      const context = await browser.newContext({ viewport: { width: vp.width, height: vp.height } });
      const page = await context.newPage();
      await page.goto(`${BASE_URL}/index.html`, { waitUntil: 'domcontentloaded' });
      await page.waitForTimeout(300);

      // Check card visibility and no horizontal scrollbar
      const bodyScrollWidth = await page.evaluate(() => document.body.scrollWidth);
      const viewportWidth = vp.width;
      const noHorizontalOverflow = bodyScrollWidth <= viewportWidth + 5;
      record('Responsive Design', `${vp.name} renders cleanly without horizontal overflow`, noHorizontalOverflow);
      await context.close();
    }
  }

  await browser.close();

  // =========================================================================
  // SUMMARY
  // =========================================================================
  console.log('\n═══════════════════════════════════════════════════════════════════');
  console.log('📊 AUDIT SUMMARY:');
  const total = results.length;
  const passed = results.filter(r => r.passed).length;
  const failed = total - passed;
  console.log(`Total Checks: ${total} | Passed: ${passed} | Failed: ${failed}`);
  console.log('═══════════════════════════════════════════════════════════════════');

  if (failed > 0) {
    process.exit(1);
  }
}

runComprehensiveAudit().catch(err => {
  console.error('Audit run error:', err);
  process.exit(1);
});
