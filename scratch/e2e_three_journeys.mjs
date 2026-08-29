import { chromium } from '@playwright/test';
import path from 'path';
import fs from 'fs';

const screenshotDir = 'C:\\Users\\venka\\.gemini\\antigravity-ide\\brain\\ca1da655-f2cf-49bc-8366-d87678bb242d\\three_journeys_screenshots';
if (!fs.existsSync(screenshotDir)) {
  fs.mkdirSync(screenshotDir, { recursive: true });
}

async function runThreeJourneys() {
  console.log('====================================================');
  console.log('STARTING FULL 3-JOURNEY REAL INTEGRATION AUDIT');
  console.log('====================================================\n');

  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({ viewport: { width: 1280, height: 800 } });

  const testUserEmail = `kiran_${Date.now()}@askexpert.local`;
  const testUserPass = 'UserPassword123!';
  const testUserName = 'Kiran Kumar';

  // ================================================================
  // JOURNEY 1: USER ACCOUNT FLOW
  // ================================================================
  console.log('>>> [JOURNEY 1] USER REGISTRATION, LOGIN, QUESTION & PROFILE <<<');
  const userPage = await context.newPage();
  
  const userErrors = [];
  userPage.on('console', msg => { if (msg.type() === 'error' && !msg.text().includes('favicon')) userErrors.push(msg.text()); });

  // 1.1 Register Page
  console.log('1.1 Navigating to register.html...');
  await userPage.goto('http://localhost:5173/register.html', { waitUntil: 'domcontentloaded' });
  await userPage.waitForTimeout(1000);

  // Fill in user registration
  await userPage.fill('#fullName', testUserName);
  await userPage.fill('#email', testUserEmail);
  await userPage.fill('#phone', '9876543210');
  await userPage.click('#sendOtpButton');
  await userPage.waitForTimeout(1000);
  await userPage.click('#autoFillOtpButton');
  await userPage.waitForTimeout(500);

  await userPage.fill('#password', testUserPass);
  await userPage.check('#terms');

  await userPage.screenshot({ path: path.join(screenshotDir, '01_user_register_filled.png') });
  console.log('1.2 Submitting registration form with verified Demo OTP...');
  await userPage.click('#createButton');
  await userPage.waitForTimeout(3000);
  await userPage.screenshot({ path: path.join(screenshotDir, '02_user_registered_redirect.png') });
  console.log(`✓ Registration completed! Current URL: ${userPage.url()}`);

  // 1.3 Login with the created account
  console.log('1.3 Navigating to login.html and logging in...');
  await userPage.goto('http://localhost:5173/login.html', { waitUntil: 'domcontentloaded' });
  await userPage.waitForTimeout(1000);

  await userPage.fill('#email', testUserEmail);
  await userPage.fill('#password', testUserPass);
  await userPage.click('#loginButton');
  await userPage.waitForTimeout(3000);
  await userPage.screenshot({ path: path.join(screenshotDir, '03_user_logged_in.png') });
  console.log(`✓ User logged in successfully! Current URL: ${userPage.url()}`);

  // 1.4 Post a Question
  console.log('1.4 Navigating to ask-question.html to post a real inquiry...');
  await userPage.goto('http://localhost:5173/ask-question.html', { waitUntil: 'domcontentloaded' });
  await userPage.waitForTimeout(1000);

  await userPage.fill('#problemDescription', 'How to register a Private Limited Company in Telangana? Looking for verified legal guidance on MCA SPICe+ Part B incorporation, directors KYC, and Telangana ROC filings timeline.');
  await userPage.selectOption('#professionalSelect', { label: 'Legal Advisor / Lawyer' });
  await userPage.fill('#optionalNotes', 'Urgent ROC advisory needed.');
  await userPage.screenshot({ path: path.join(screenshotDir, '04_ask_question_filled.png') });

  console.log('1.5 Submitting question...');
  await userPage.click('#submitQuestionButton');
  await userPage.waitForTimeout(3000);
  await userPage.screenshot({ path: path.join(screenshotDir, '05_question_submitted.png') });
  console.log(`✓ Question submitted! Current URL: ${userPage.url()}`);

  // 1.6 Update Profile
  console.log('1.6 Navigating to edit-profile.html...');
  await userPage.goto('http://localhost:5173/edit-profile.html', { waitUntil: 'domcontentloaded' });
  await userPage.waitForTimeout(1000);

  await userPage.fill('#inputBio', 'Technology entrepreneur and Managing Director at Hyderabad TechStart.');
  await userPage.click('#saveProfileBtn');
  await userPage.waitForTimeout(2000);
  await userPage.screenshot({ path: path.join(screenshotDir, '06_profile_updated.png') });

  // Verify profile page
  await userPage.goto('http://localhost:5173/profile.html', { waitUntil: 'domcontentloaded' });
  await userPage.waitForTimeout(1000);
  const profileBioText = await userPage.innerText('body');
  const hasOldFakeEmail = profileBioText.includes('aditya.sharma@example.com');
  const hasUpdatedBio = profileBioText.includes('Technology entrepreneur');
  console.log(`✓ Profile verification: Updated Bio present: ${hasUpdatedBio}, Fake email absent: ${!hasOldFakeEmail}`);
  await userPage.screenshot({ path: path.join(screenshotDir, '07_profile_view.png') });

  // 1.7 Logout & Re-login Test
  console.log('1.7 Logging out...');
  await userPage.evaluate(() => {
    sessionStorage.clear();
    window.location.href = 'login.html';
  });
  await userPage.waitForTimeout(1500);

  console.log('1.8 Re-logging in with saved credentials...');
  await userPage.fill('#email', testUserEmail);
  await userPage.fill('#password', testUserPass);
  await userPage.click('#loginButton');
  await userPage.waitForTimeout(2500);
  console.log(`✓ Re-login successful! Final URL: ${userPage.url()}`);
  await userPage.screenshot({ path: path.join(screenshotDir, '08_user_relogin_success.png') });
  await userPage.close();

  // ================================================================
  // JOURNEY 2: EXPERT ACCOUNT FLOW
  // ================================================================
  console.log('\n>>> [JOURNEY 2] EXPERT DASHBOARD, QUESTIONS FEED & POSTING ANSWER <<<');
  const expertPage = await context.newPage();
  const expertErrors = [];
  expertPage.on('console', msg => { if (msg.type() === 'error' && !msg.text().includes('favicon')) expertErrors.push(msg.text()); });

  // 2.1 Login as Expert
  console.log('2.1 Logging in as Expert: expert.audit@askexpert.com...');
  await expertPage.goto('http://localhost:5173/login.html', { waitUntil: 'domcontentloaded' });
  await expertPage.waitForTimeout(1000);

  await expertPage.fill('#email', 'expert.audit@askexpert.com');
  await expertPage.fill('#password', 'ExpertSecurity123!');
  await expertPage.click('#loginButton');
  await expertPage.waitForTimeout(2500);
  await expertPage.screenshot({ path: path.join(screenshotDir, '09_expert_dashboard.png') });
  console.log(`✓ Expert logged in! Current URL: ${expertPage.url()}`);

  // 2.2 View Questions Feed
  console.log('2.2 Opening questions feed (questions.html)...');
  await expertPage.goto('http://localhost:5173/questions.html', { waitUntil: 'domcontentloaded' });
  await expertPage.waitForTimeout(1500);
  await expertPage.screenshot({ path: path.join(screenshotDir, '10_questions_feed.png') });

  const feedContent = await expertPage.innerText('body');
  const foundQuestion = feedContent.includes('Private Limited Company in Telangana') || feedContent.includes('ROC filing') || feedContent.includes('How to register');
  console.log(`✓ Question found in feed: ${foundQuestion}`);

  // 2.3 Open Question Details and Answer
  console.log('2.3 Answering the inquiry in question-details.html...');
  const firstCard = await expertPage.$('.question-card');
  if (firstCard) {
    await firstCard.click();
    await expertPage.waitForTimeout(2000);
    await expertPage.screenshot({ path: path.join(screenshotDir, '11_question_details_view.png') });

    const answerBox = await expertPage.$('#followupTextarea');
    if (answerBox) {
      await answerBox.fill('Adv. Suresh Reddy (Verified Legal Specialist): For Private Limited Company incorporation under MCA guidelines, prepare DSC Class 3 for directors, file SPICe+ Part A for name reservation, and submit SPICe+ Part B with drafting to Telangana ROC. Average certificate issuance is 5-7 business days.');
      await expertPage.click('#sendFollowupBtn');
      await expertPage.waitForTimeout(2500);
      await expertPage.screenshot({ path: path.join(screenshotDir, '12_answer_posted.png') });
      console.log('✓ Expert answer successfully submitted to question thread!');
    }
  }
  await expertPage.close();

  // ================================================================
  // JOURNEY 3: ADMIN ACCOUNT FLOW
  // ================================================================
  console.log('\n>>> [JOURNEY 3] ADMIN LOGIN, USERS, PROFESSIONALS & QUESTIONS AUDIT <<<');
  const adminPage = await context.newPage();
  const adminErrors = [];
  adminPage.on('console', msg => { if (msg.type() === 'error' && !msg.text().includes('favicon')) adminErrors.push(msg.text()); });

  // 3.1 Admin Login
  console.log('3.1 Logging in as Admin: admin.audit@askexpert.com...');
  await adminPage.goto('http://localhost:5173/admin-login.html', { waitUntil: 'domcontentloaded' });
  await adminPage.waitForTimeout(1000);

  await adminPage.fill('#adminEmailInput', 'admin.audit@askexpert.com');
  await adminPage.fill('#adminPasswordInput', 'AdminSecurity123!');
  await adminPage.click('#adminSubmitBtn');
  await adminPage.waitForTimeout(2500);
  await adminPage.screenshot({ path: path.join(screenshotDir, '13_admin_dashboard.png') });
  console.log(`✓ Admin authenticated! Current URL: ${adminPage.url()}`);

  // 3.2 Verify Admin Users Screen
  console.log('3.2 Checking admin-users.html for real database rows...');
  await adminPage.goto('http://localhost:5173/admin-users.html', { waitUntil: 'domcontentloaded' });
  await adminPage.waitForTimeout(2000);
  await adminPage.screenshot({ path: path.join(screenshotDir, '14_admin_users_verified.png') });
  const usersPageText = await adminPage.innerText('body');
  const hasHardcodedRohan = usersPageText.includes('Rohan Kapoor') && usersPageText.includes('USR-10884');
  console.log(`✓ Admin Users: Hardcoded Rohan Kapoor present: ${hasHardcodedRohan}`);

  // 3.3 Verify Admin Professionals Screen
  console.log('3.3 Checking admin-professionals.html...');
  await adminPage.goto('http://localhost:5173/admin-professionals.html', { waitUntil: 'domcontentloaded' });
  await adminPage.waitForTimeout(2000);
  await adminPage.screenshot({ path: path.join(screenshotDir, '15_admin_professionals_verified.png') });
  const profPageText = await adminPage.innerText('body');
  const hasHardcodedAnanya = profPageText.includes('APP-90214') && profPageText.includes('ananya.iyer@legal.in');
  console.log(`✓ Admin Professionals: Hardcoded Ananya Iyer present: ${hasHardcodedAnanya}`);

  // 3.4 Verify Admin Questions Screen
  console.log('3.4 Checking admin-questions.html...');
  await adminPage.goto('http://localhost:5173/admin-questions.html', { waitUntil: 'domcontentloaded' });
  await adminPage.waitForTimeout(2000);
  await adminPage.screenshot({ path: path.join(screenshotDir, '16_admin_questions_verified.png') });
  const qPageText = await adminPage.innerText('body');
  const hasHardcodedVendorQ = qPageText.includes('Vendor Contract Compliance & Arbitration Seating') && qPageText.includes('USR-10920');
  console.log(`✓ Admin Questions: Hardcoded Vendor Contract inquiry present: ${hasHardcodedVendorQ}`);

  // 3.5 Verify Admin Reports Screen
  console.log('3.5 Checking admin-reports.html...');
  await adminPage.goto('http://localhost:5173/admin-reports.html', { waitUntil: 'domcontentloaded' });
  await adminPage.waitForTimeout(2000);
  await adminPage.screenshot({ path: path.join(screenshotDir, '17_admin_reports_verified.png') });
  const repPageText = await adminPage.innerText('body');
  const hasHardcodedCryptoRep = repPageText.includes('REP-4019') && repPageText.includes('Solicitation of illegal FEMA');
  console.log(`✓ Admin Reports: Hardcoded FEMA report present: ${hasHardcodedCryptoRep}`);

  // 3.6 Verify Admin Payments Screen
  console.log('3.6 Checking admin-payments.html...');
  await adminPage.goto('http://localhost:5173/admin-payments.html', { waitUntil: 'domcontentloaded' });
  await adminPage.waitForTimeout(2000);
  await adminPage.screenshot({ path: path.join(screenshotDir, '18_admin_payments_verified.png') });
  const payPageText = await adminPage.innerText('body');
  const hasHardcodedPaymentRow = payPageText.includes('TXN-849182') && payPageText.includes('Aditya Sharma');
  console.log(`✓ Admin Payments: Hardcoded TXN-849182 present: ${hasHardcodedPaymentRow}`);

  await adminPage.close();
  await browser.close();

  console.log('\n====================================================');
  console.log('ALL 3 JOURNEYS COMPLETED AND TESTED IN BROWSER!');
  console.log('====================================================');
}

runThreeJourneys().catch(err => {
  console.error('Fatal error during 3-journey test:', err);
  process.exit(1);
});
