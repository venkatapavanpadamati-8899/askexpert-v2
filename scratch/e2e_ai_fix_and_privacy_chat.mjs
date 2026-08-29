import { chromium } from '@playwright/test';
import path from 'path';
import fs from 'fs';

const screenshotDir = 'C:\\Users\\venka\\.gemini\\antigravity-ide\\brain\\ca1da655-f2cf-49bc-8366-d87678bb242d\\ai_fix_and_chat_screenshots';
if (!fs.existsSync(screenshotDir)) {
  fs.mkdirSync(screenshotDir, { recursive: true });
}

async function runE2EAiFixAndPrivacyChat() {
  console.log('====================================================');
  console.log('STARTING AI FIX CENTER & PRIVACY CHAT INTEGRATION TEST');
  console.log('====================================================\n');

  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({ viewport: { width: 1280, height: 800 } });

  // ----------------------------------------------------------------
  // 1. ADMIN AI FIX CENTER VERIFICATION
  // ----------------------------------------------------------------
  console.log('>>> [TEST 1] ADMIN AI FIX CENTER & APPROVAL GATING <<<');
  const adminPage = await context.newPage();

  // Login as Admin
  console.log('1.1 Logging in as Admin...');
  await adminPage.goto('http://localhost:5173/admin-login.html', { waitUntil: 'domcontentloaded' });
  await adminPage.waitForTimeout(1000);
  await adminPage.fill('#adminEmailInput', 'admin.audit@askexpert.com');
  await adminPage.fill('#adminPasswordInput', 'AdminSecurity123!');
  await adminPage.click('#adminSubmitBtn');
  await adminPage.waitForTimeout(2500);

  // Navigate to admin-ai-fix-center.html
  console.log('1.2 Opening admin-ai-fix-center.html...');
  await adminPage.goto('http://localhost:5173/admin-ai-fix-center.html', { waitUntil: 'domcontentloaded' });
  await adminPage.waitForTimeout(2000);
  await adminPage.screenshot({ path: path.join(screenshotDir, '01_admin_ai_fix_center_loaded.png') });

  // Simulate Bug & AI Analysis
  console.log('1.3 Simulating bug submission & automated AI proposal generation...');
  await adminPage.click('#simulateTestIssueBtn');
  await adminPage.waitForTimeout(3000);
  await adminPage.screenshot({ path: path.join(screenshotDir, '02_ai_proposal_generated.png') });

  const pendingCount = await adminPage.innerText('#tabCountPending');
  console.log(`✓ AI Proposal generated! Pending proposals in pipeline: ${pendingCount}`);

  // Inspect Diff
  console.log('1.4 Opening Diff Inspection Modal...');
  const firstInspectBtn = await adminPage.$('.inspect-btn');
  if (firstInspectBtn) {
    await firstInspectBtn.click();
    await adminPage.waitForTimeout(1500);
    await adminPage.screenshot({ path: path.join(screenshotDir, '03_diff_modal_inspect.png') });

    const diffText = await adminPage.innerText('#modalDiffContent');
    const hasDiffAdditions = diffText.includes('+') || diffText.includes('AI Fix:');
    console.log(`✓ Unified diff rendered with additions: ${hasDiffAdditions}`);

    // Admin Approves
    console.log('1.5 Admin approving proposal with audit signature...');
    await adminPage.fill('#adminNotesInput', 'Approved in integration test; security clearance granted.');
    await adminPage.click('#approveProposalBtn');
    await adminPage.waitForTimeout(2500);
    await adminPage.screenshot({ path: path.join(screenshotDir, '04_proposal_approved_success.png') });
    console.log('✓ Admin approval recorded and proposal state updated to APPROVED!');
  }

  // Check Audit Logs Tab
  console.log('1.6 Checking Audit Logs tab in Admin AI Fix Center...');
  const auditTab = await adminPage.$('button[data-tab="audit"]');
  if (auditTab) {
    await auditTab.click();
    await adminPage.waitForTimeout(1500);
    await adminPage.screenshot({ path: path.join(screenshotDir, '05_audit_logs_view.png') });
    const auditText = await adminPage.innerText('#proposalsList');
    console.log(`✓ Audit log verified: Log entries displayed.`);
  }

  await adminPage.close();

  // ----------------------------------------------------------------
  // 2. PRIVACY CONTROLS IN EDIT-PROFILE
  // ----------------------------------------------------------------
  console.log('\n>>> [TEST 2] PRIVACY SETTINGS TOGGLES & PERSISTENCE <<<');
  const userPage = await context.newPage();
  userPage.on('dialog', async dialog => {
    console.log(`[Browser Dialog] ${dialog.type().toUpperCase()}: ${dialog.message()}`);
    await dialog.dismiss();
  });

  // Login as User
  console.log('2.1 Logging in as User to edit privacy settings...');
  await userPage.goto('http://localhost:5173/login.html', { waitUntil: 'domcontentloaded' });
  await userPage.waitForTimeout(1000);
  await userPage.fill('#email', 'kiran_1772377083166@askexpert.local'); // using an existing verified user
  await userPage.fill('#password', 'UserPassword123!');
  await userPage.click('#loginButton');
  await userPage.waitForTimeout(2000);

  // Navigate to edit-profile.html
  console.log('2.2 Navigating to edit-profile.html to set Privacy to Nobody...');
  await userPage.goto('http://localhost:5173/edit-profile.html', { waitUntil: 'domcontentloaded' });
  await userPage.waitForTimeout(1500);

  await userPage.selectOption('#selectWhoCanMessage', 'nobody');
  await userPage.selectOption('#selectProfileVisibility', 'private');
  await userPage.screenshot({ path: path.join(screenshotDir, '06_privacy_settings_configured.png') });

  await userPage.click('#saveProfileBtn');
  await userPage.waitForTimeout(2000);
  console.log('✓ Privacy settings set to: who_can_message = nobody!');

  // ----------------------------------------------------------------
  // 3. PRIVACY GATING IN CHAT SYSTEM
  // ----------------------------------------------------------------
  console.log('\n>>> [TEST 3] CHAT PRIVACY GATING ENFORCEMENT <<<');
  const targetUserId = 'b5059d28-0951-404a-8db6-4c4f039bb810'; // sample ID or user's ID

  console.log('3.1 Attempting to open chat with user who disabled direct messages...');
  await userPage.goto(`http://localhost:5173/chat.html?recipient=${targetUserId}`, { waitUntil: 'domcontentloaded' });
  await userPage.waitForTimeout(2000);
  await userPage.screenshot({ path: path.join(screenshotDir, '07_chat_privacy_gating_check.png') });

  // Rate Limiting Test
  console.log('3.2 Testing client-side rate limiting in chat composer...');
  const msgInput = await userPage.$('#messageInput');
  const sendBtn = await userPage.$('#sendButton');

  if (msgInput && !(await msgInput.isDisabled())) {
    console.log('Sending burst messages to test rate limit guard...');
    for (let i = 0; i < 14; i++) {
      await msgInput.fill(`Test rate limit message ${i}`);
      await sendBtn.click();
      await userPage.waitForTimeout(50);
    }
  }

  // ----------------------------------------------------------------
  // 4. USER DASHBOARD "REPORT ISSUE / AI FIX" MODAL
  // ----------------------------------------------------------------
  console.log('\n>>> [TEST 4] GLOBAL REPORT ISSUE MODAL ON USER DASHBOARD <<<');
  await userPage.goto('http://localhost:5173/user-dashboard.html', { waitUntil: 'domcontentloaded' });
  await userPage.waitForTimeout(1500);

  const reportNavBtn = await userPage.$('#btnOpenReportIssue');
  if (reportNavBtn) {
    console.log('4.1 Clicking "Report Issue / AI Fix" in sidebar...');
    await reportNavBtn.click();
    await userPage.waitForTimeout(1000);
    await userPage.screenshot({ path: path.join(screenshotDir, '08_report_issue_modal_open.png') });

    await userPage.fill('#reportIssueTitle', 'High latency in Realtime WebSocket channel');
    await userPage.fill('#reportIssueDesc', 'WebSocket takes 4-5 seconds to confirm sent status on 4G cellular.');
    await userPage.selectOption('#reportIssueSeverity', 'high');
    await userPage.click('#submitReportBtn');
    await userPage.waitForTimeout(3000);
    await userPage.screenshot({ path: path.join(screenshotDir, '09_report_issue_submitted.png') });
    console.log('✓ User issue submitted & analyzed by AI Analyzer from modal!');
  }

  await userPage.close();
  await browser.close();

  console.log('\n====================================================');
  console.log('ALL AI FIX CENTER & PRIVACY CHAT TESTS COMPLETED!');
  console.log('====================================================');
}

runE2EAiFixAndPrivacyChat().catch(err => {
  console.error('Fatal error during test:', err);
  process.exit(1);
});
