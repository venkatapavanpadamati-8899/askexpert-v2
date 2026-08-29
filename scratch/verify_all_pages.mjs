import { chromium } from '@playwright/test';
import path from 'path';
import fs from 'fs';

const screenshotDir = 'C:\\Users\\venka\\.gemini\\antigravity-ide\\brain\\ca1da655-f2cf-49bc-8366-d87678bb242d\\verification_screenshots';
if (!fs.existsSync(screenshotDir)) {
  fs.mkdirSync(screenshotDir, { recursive: true });
}

const pagesToTest = [
  { name: 'Home Landing', url: 'http://localhost:5173/index.html' },
  { name: 'Login Page', url: 'http://localhost:5173/login.html' },
  { name: 'Register Page', url: 'http://localhost:5173/register.html' },
  { name: 'OTP & Password Recovery', url: 'http://localhost:5173/forgot-password.html' },
  { name: 'Questions Feed', url: 'http://localhost:5173/questions.html' },
  { name: 'Experts Directory', url: 'http://localhost:5173/experts.html' },
  { name: 'Profile Page', url: 'http://localhost:5173/profile.html' },
  { name: 'Chat Screen', url: 'http://localhost:5173/chat.html' },
  { name: 'User Dashboard (Guard)', url: 'http://localhost:5173/user-dashboard.html' },
  { name: 'Professional Dashboard (Guard)', url: 'http://localhost:5173/professional-dashboard.html' },
  { name: 'Admin Login', url: 'http://localhost:5173/admin-login.html' },
  { name: 'Admin Dashboard (Guard)', url: 'http://localhost:5173/admin-dashboard.html' },
  { name: 'Admin Payments (Guard)', url: 'http://localhost:5173/admin-payments.html' },
  { name: 'Admin Questions (Guard)', url: 'http://localhost:5173/admin-questions.html' },
  { name: 'Admin Reports (Guard)', url: 'http://localhost:5173/admin-reports.html' },
  { name: 'Admin Professionals (Guard)', url: 'http://localhost:5173/admin-professionals.html' }
];

async function runVerification() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({ viewport: { width: 1280, height: 800 } });

  console.log('=== RUNNING FULL AUDIT ACROSS ALL SCREENS ===\n');

  const results = [];

  for (let i = 0; i < pagesToTest.length; i++) {
    const item = pagesToTest[i];
    const page = await context.newPage();
    const consoleErrors = [];
    const networkFails = [];

    page.on('console', msg => {
      if (msg.type() === 'error') {
        const text = msg.text();
        if (!text.includes('favicon.ico')) {
          consoleErrors.push(text);
        }
      }
    });

    page.on('requestfailed', req => {
      const url = req.url();
      if (!url.includes('favicon.ico')) {
        networkFails.push(`${req.method()} ${url} - ${req.failure()?.errorText || 'failed'}`);
      }
    });

    try {
      const resp = await page.goto(item.url, { waitUntil: 'domcontentloaded', timeout: 15000 });
      await page.waitForTimeout(1500);

      const finalUrl = page.url();
      const filename = `${String(i + 1).padStart(2, '0')}_${item.name.replace(/[^a-zA-Z0-9]/g, '_')}.png`;
      await page.screenshot({ path: path.join(screenshotDir, filename), fullPage: false });

      // Check for known fake/demo data artifacts
      const pageText = await page.innerText('body');
      const hasFakeEmail = pageText.includes('aditya.sharma@example.com');
      const hasDemoRows = pageText.includes('Solicitation of illegal FEMA outward remittance') && !finalUrl.includes('admin-login.html');

      results.push({
        name: item.name,
        initialUrl: item.url,
        finalUrl: finalUrl,
        httpStatus: resp ? resp.status() : 'none',
        consoleErrors: consoleErrors,
        networkFails: networkFails,
        hasFakeEmail: hasFakeEmail,
        hasDemoRows: hasDemoRows,
        screenshot: filename
      });
      console.log(`[PASS] ${item.name} -> Final URL: ${finalUrl} (Errors: ${consoleErrors.length}, Network Fails: ${networkFails.length})`);
    } catch (err) {
      console.error(`[FAIL] ${item.name}:`, err.message);
      results.push({
        name: item.name,
        initialUrl: item.url,
        finalUrl: page.url(),
        httpStatus: 'ERROR',
        consoleErrors: [...consoleErrors, err.message],
        networkFails: networkFails,
        hasFakeEmail: false,
        hasDemoRows: false,
        screenshot: null
      });
    } finally {
      await page.close();
    }
  }

  await browser.close();

  console.log('\n=== AUDIT RESULTS SUMMARY ===');
  console.log(JSON.stringify(results, null, 2));

  fs.writeFileSync('d:\\ASKEXPERT\\scratch\\audit_results.json', JSON.stringify(results, null, 2));
}

runVerification().catch(err => {
  console.error('Fatal in test:', err);
  process.exit(1);
});
