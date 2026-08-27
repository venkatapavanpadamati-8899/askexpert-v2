import { chromium } from '@playwright/test';
import fs from 'fs';
import path from 'path';

const outDir = 'C:\\Users\\venka\\.gemini\\antigravity-ide\\brain\\e540050c-18a5-4bba-94d1-62bd802dda4c\\screenshots';
if (!fs.existsSync(outDir)) {
  fs.mkdirSync(outDir, { recursive: true });
}

const pages = [
  { name: 'register', url: 'http://localhost:5173/register.html' },
  { name: 'login', url: 'http://localhost:5173/login.html' },
  { name: 'forgot-password', url: 'http://localhost:5173/forgot-password.html' },
  { name: 'question-details-not-found', url: 'http://localhost:5173/question-details.html?id=nonexistent-id-999' },
  { name: 'expert-profile-not-found', url: 'http://localhost:5173/expert-profile.html?expert=nonexistent-id-999' },
  { name: 'consultation-requests', url: 'http://localhost:5173/consultation-requests.html' },
  { name: 'notifications', url: 'http://localhost:5173/notifications.html' },
  { name: 'chat', url: 'http://localhost:5173/chat.html' },
  { name: 'admin-professionals', url: 'http://localhost:5173/admin-professionals.html' }
];

async function run() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({ viewport: { width: 1280, height: 800 } });
  
  const results = [];

  for (const p of pages) {
    const page = await context.newPage();
    const consoleLogs = [];
    const consoleErrors = [];
    
    page.on('console', msg => {
      if (msg.type() === 'error') consoleErrors.push(msg.text());
      else consoleLogs.push(msg.text());
    });

    page.on('pageerror', err => {
      consoleErrors.push(err.message);
    });

    try {
      await page.goto(p.url, { waitUntil: 'networkidle', timeout: 10000 }).catch(async () => {
        await page.goto(p.url, { waitUntil: 'domcontentloaded', timeout: 5000 });
      });

      await page.waitForTimeout(1000);

      const filePath = path.join(outDir, `${p.name}.png`);
      await page.screenshot({ path: filePath, fullPage: false });

      results.push({
        page: p.name,
        url: p.url,
        status: 'SUCCESS',
        screenshot: filePath,
        consoleErrors: consoleErrors.filter(e => !e.includes('net::ERR_') && !e.includes('favicon'))
      });
      console.log(`[PASS] ${p.name} -> ${filePath}`);
    } catch (e) {
      results.push({
        page: p.name,
        url: p.url,
        status: 'FAILED',
        error: e.message
      });
      console.error(`[FAIL] ${p.name}: ${e.message}`);
    } finally {
      await page.close();
    }
  }

  await browser.close();
  console.log('\n--- VERIFICATION SUMMARY ---');
  console.log(JSON.stringify(results, null, 2));
}

run().catch(console.error);
