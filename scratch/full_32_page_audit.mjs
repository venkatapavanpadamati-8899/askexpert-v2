import { chromium } from '@playwright/test';
import fs from 'fs';
import path from 'path';

const BASE_URL = 'http://localhost:5173';
const screenshotDir = 'C:\\Users\\venka\\.gemini\\antigravity-ide\\brain\\ca1da655-f2cf-49bc-8366-d87678bb242d\\full_32_page_screenshots';

if (!fs.existsSync(screenshotDir)) {
  fs.mkdirSync(screenshotDir, { recursive: true });
}

const all32Pages = [
  { name: 'Home Landing', file: 'index.html' },
  { name: 'Login', file: 'login.html' },
  { name: 'Register', file: 'register.html' },
  { name: 'Forgot Password', file: 'forgot-password.html' },
  { name: 'Reset Password', file: 'reset-password.html' },
  { name: 'User Dashboard', file: 'user-dashboard.html' },
  { name: 'Experts Directory', file: 'experts.html' },
  { name: 'Expert Profile', file: 'expert-profile.html' },
  { name: 'Ask Question', file: 'ask-question.html' },
  { name: 'Questions Feed', file: 'questions.html' },
  { name: 'Question Details', file: 'question-details.html' },
  { name: 'Chat Screen', file: 'chat.html' },
  { name: 'Payments', file: 'payments.html' },
  { name: 'Payment History', file: 'payment-history.html' },
  { name: 'User Profile', file: 'profile.html' },
  { name: 'Edit Profile', file: 'edit-profile.html' },
  { name: 'Notifications', file: 'notifications.html' },
  { name: 'Review Expert', file: 'review.html' },
  { name: 'Professional Dashboard', file: 'professional-dashboard.html' },
  { name: 'Professional Verification', file: 'professional-verification.html' },
  { name: 'Professional Earnings', file: 'professional-earnings.html' },
  { name: 'Professional Profile', file: 'professional-profile.html' },
  { name: 'Consultation Requests', file: 'consultation-requests.html' },
  { name: 'Admin Login', file: 'admin-login.html' },
  { name: 'Admin Dashboard', file: 'admin-dashboard.html' },
  { name: 'Admin Users', file: 'admin-users.html' },
  { name: 'Admin Professionals', file: 'admin-professionals.html' },
  { name: 'Admin Questions', file: 'admin-questions.html' },
  { name: 'Admin Payments', file: 'admin-payments.html' },
  { name: 'Admin Reports', file: 'admin-reports.html' },
  { name: 'Admin Health', file: 'admin-health.html' },
  { name: 'Admin AI Fix Center', file: 'admin-ai-fix-center.html' }
];

async function runFullAudit() {
  console.log(`🚀 Starting Full 32-Page Audit on ${BASE_URL}...`);
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({ viewport: { width: 1280, height: 800 } });

  const auditReport = [];
  let totalConsoleErrors = 0;
  let totalNetworkFailures = 0;

  for (let i = 0; i < all32Pages.length; i++) {
    const item = all32Pages[i];
    const page = await context.newPage();
    const consoleErrors = [];
    const networkFailures = [];

    page.on('console', msg => {
      if (msg.type() === 'error') {
        const txt = msg.text();
        if (!txt.includes('favicon.ico')) consoleErrors.push(txt);
      }
    });

    page.on('requestfailed', req => {
      const u = req.url();
      if (!u.includes('favicon.ico')) {
        networkFailures.push(`${req.method()} ${u} (${req.failure()?.errorText || 'failed'})`);
      }
    });

    const targetUrl = `${BASE_URL}/${item.file}`;

    try {
      const response = await page.goto(targetUrl, { waitUntil: 'domcontentloaded', timeout: 15000 });
      await page.waitForTimeout(1200);

      const currentUrl = page.url();
      const status = response ? response.status() : 'OK';
      const filename = `${String(i + 1).padStart(2, '0')}_${item.file.replace('.html', '')}.png`;
      const screenshotPath = path.join(screenshotDir, filename);
      await page.screenshot({ path: screenshotPath, fullPage: false });

      totalConsoleErrors += consoleErrors.length;
      totalNetworkFailures += networkFailures.length;

      const record = {
        index: i + 1,
        name: item.name,
        file: item.file,
        httpStatus: status,
        finalUrl: currentUrl,
        consoleErrorsCount: consoleErrors.length,
        consoleErrors: consoleErrors,
        networkFailuresCount: networkFailures.length,
        networkFailures: networkFailures,
        screenshot: filename,
        result: (consoleErrors.length === 0 && networkFailures.length === 0) ? 'PASS' : 'WARN'
      };

      auditReport.push(record);
      console.log(`[${record.result}] #${i + 1} ${item.name} (${item.file}) -> HTTP ${status}, Console Errs: ${consoleErrors.length}, Net Fails: ${networkFailures.length}`);
    } catch (err) {
      console.error(`[ERROR] #${i + 1} ${item.name} (${item.file}) ->`, err.message);
      auditReport.push({
        index: i + 1,
        name: item.name,
        file: item.file,
        httpStatus: 'ERR',
        finalUrl: page.url(),
        consoleErrorsCount: consoleErrors.length + 1,
        consoleErrors: [...consoleErrors, err.message],
        networkFailuresCount: networkFailures.length,
        networkFailures: networkFailures,
        screenshot: null,
        result: 'FAIL'
      });
      totalConsoleErrors += consoleErrors.length + 1;
    } finally {
      await page.close();
    }
  }

  await browser.close();

  fs.writeFileSync('scratch/full_32_page_audit_report.json', JSON.stringify(auditReport, null, 2));

  console.log('\n=============================================');
  console.log(`TOTAL PAGES AUDITED: ${all32Pages.length}`);
  console.log(`TOTAL CONSOLE ERRORS: ${totalConsoleErrors}`);
  console.log(`TOTAL NETWORK FAILURES: ${totalNetworkFailures}`);
  console.log('=============================================\n');
}

runFullAudit().catch(err => {
  console.error('Audit execution error:', err);
  process.exit(1);
});
