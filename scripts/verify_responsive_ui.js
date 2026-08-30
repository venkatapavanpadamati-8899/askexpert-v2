import { chromium } from '@playwright/test';
import path from 'path';
import fs from 'fs';

const VIEWPORTS = [
  { width: 360, height: 800, name: 'mobile_360x800' },
  { width: 390, height: 844, name: 'mobile_390x844' },
  { width: 412, height: 915, name: 'mobile_412x915' },
  { width: 430, height: 932, name: 'mobile_430x932' },
  { width: 768, height: 1024, name: 'tablet_768x1024' },
  { width: 1366, height: 768, name: 'desktop_1366x768' },
];

const PAGES = [
  { url: 'http://localhost:5173/index.html', title: 'Home' },
  { url: 'http://localhost:5173/register.html', title: 'Register' },
  { url: 'http://localhost:5173/login.html', title: 'Login' },
  { url: 'http://localhost:5173/ask-question.html', title: 'Ask Question' },
  { url: 'http://localhost:5173/experts.html', title: 'Experts' },
  { url: 'http://localhost:5173/questions.html', title: 'Questions' },
  { url: 'http://localhost:5173/question-details.html', title: 'Question Details' },
  { url: 'http://localhost:5173/expert-profile.html', title: 'Expert Profile' },
  { url: 'http://localhost:5173/chat.html', title: 'Chat' },
  { url: 'http://localhost:5173/payments.html', title: 'Payments' },
  { url: 'http://localhost:5173/payment-history.html', title: 'Payment History' },
  { url: 'http://localhost:5173/profile.html', title: 'Profile' },
  { url: 'http://localhost:5173/edit-profile.html', title: 'Edit Profile' },
  { url: 'http://localhost:5173/notifications.html', title: 'Notifications' },
  { url: 'http://localhost:5173/review.html', title: 'Review' },
  { url: 'http://localhost:5173/user-dashboard.html?preview=true', title: 'User Dashboard' },
  { url: 'http://localhost:5173/professional-dashboard.html?preview=true', title: 'Professional Dashboard' },
  { url: 'http://localhost:5173/consultation-requests.html?preview=true', title: 'Consultation Requests' },
  { url: 'http://localhost:5173/professional-verification.html', title: 'Professional Verification' },
  { url: 'http://localhost:5173/professional-earnings.html?preview=true', title: 'Professional Earnings' },
  { url: 'http://localhost:5173/professional-profile.html?preview=true', title: 'Professional Profile' },
  { url: 'http://localhost:5173/admin-login.html', title: 'Admin Login' },
  { url: 'http://localhost:5173/admin-dashboard.html?preview=true', title: 'Admin Dashboard' },
  { url: 'http://localhost:5173/admin-users.html?preview=true', title: 'Admin Users' },
  { url: 'http://localhost:5173/admin-professionals.html?preview=true', title: 'Admin Professionals' },
  { url: 'http://localhost:5173/admin-questions.html?preview=true', title: 'Admin Questions' },
  { url: 'http://localhost:5173/admin-payments.html?preview=true', title: 'Admin Payments' },
  { url: 'http://localhost:5173/admin-reports.html?preview=true', title: 'Admin Reports' },
  { url: 'http://localhost:5173/admin-health.html?preview=true', title: 'Admin Health' },
  { url: 'http://localhost:5173/admin-ai-fix-center.html?preview=true', title: 'Admin AI Fix Center' }
];

const artifactDir = 'C:\\Users\\venka\\.gemini\\antigravity-ide\\brain\\f5a9a7b4-8d7c-4f58-818b-8b30dd3e6070';

async function run() {
  const browser = await chromium.launch({ headless: true });
  console.log('--- STARTING RESPONSIVE AUDIT ---');
  let auditSummary = {
    viewportsTested: VIEWPORTS.length,
    pagesTested: PAGES.length,
    horizontalScrollViolations: 0,
    consoleErrors: 0,
    failures: []
  };

  for (const vp of VIEWPORTS) {
    console.log(`\nTesting Viewport: ${vp.name} (${vp.width}x${vp.height})`);
    const context = await browser.newContext({
      viewport: { width: vp.width, height: vp.height }
    });

    for (const p of PAGES) {
      const page = await context.newPage();
      let pageConsoleErrors = [];
      page.on('console', msg => {
        if (msg.type() === 'error') pageConsoleErrors.push(msg.text());
      });

      try {
        await page.goto(p.url, { waitUntil: 'domcontentloaded', timeout: 10000 });
        await page.waitForTimeout(1000);

        // Check horizontal scroll
        const scrollWidth = await page.evaluate(() => document.documentElement.scrollWidth);
        const innerWidth = await page.evaluate(() => window.innerWidth);
        const hasHorizontalScroll = scrollWidth > innerWidth;

        if (hasHorizontalScroll) {
          console.error(`  [FAIL] ${p.title} has horizontal scroll! (${scrollWidth}px > ${innerWidth}px)`);
          auditSummary.horizontalScrollViolations++;
          auditSummary.failures.push({ viewport: vp.name, page: p.title, issue: 'Horizontal Scroll' });
        } else {
          console.log(`  [PASS] ${p.title}: 0 horizontal scroll (width: ${innerWidth}px)`);
        }

        // Capture a representative mobile sample for Register & Login
        if (vp.name === 'mobile_390x844' && (p.title === 'Register' || p.title === 'Ask Question' || p.title === 'Payments')) {
          const shotName = `responsive_${p.title.toLowerCase().replace(/\s+/g, '_')}_${vp.name}.png`;
          await page.screenshot({ path: path.join(artifactDir, shotName), fullPage: false });
          console.log(`  [SAVED SCREENSHOT] ${shotName}`);
        }

      } catch (err) {
        console.error(`  [ERROR] Loading ${p.url}: ${err.message}`);
        auditSummary.failures.push({ viewport: vp.name, page: p.title, issue: err.message });
      } finally {
        await page.close();
      }
    }
    await context.close();
  }

  await browser.close();
  console.log('\n--- AUDIT SUMMARY ---');
  console.log(JSON.stringify(auditSummary, null, 2));
}

run();
