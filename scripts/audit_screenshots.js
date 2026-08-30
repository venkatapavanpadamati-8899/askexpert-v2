import { chromium } from '@playwright/test';
import path from 'path';

const outDir = 'C:\\Users\\venka\\.gemini\\antigravity-ide\\brain\\f5a9a7b4-8d7c-4f58-818b-8b30dd3e6070';

async function run() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    viewport: { width: 1440, height: 900 }
  });

  const pages = [
    { url: 'http://localhost:5173/professional-dashboard.html?preview=true', name: 'professional_dashboard_sapphire_3d.png' },
    { url: 'http://localhost:5173/payments.html', name: 'payments_escrow_gold_3d.png' },
    { url: 'http://localhost:5173/profile.html', name: 'profile_identity_orchid_3d.png' },
    { url: 'http://localhost:5173/question-details.html?preview=true', name: 'question_details_teal_3d.png' },
    { url: 'http://localhost:5173/admin-dashboard.html?preview=true', name: 'admin_command_crimson_3d.png' },
  ];

  for (const p of pages) {
    try {
      const page = await context.newPage();
      await page.goto(p.url, { waitUntil: 'networkidle', timeout: 15000 });
      await page.waitForTimeout(1500);
      const targetPath = path.join(outDir, p.name);
      await page.screenshot({ path: targetPath, fullPage: false });
      console.log(`[CAPTURED] ${p.name}`);
      await page.close();
    } catch (err) {
      console.error(`[ERROR] ${p.name}:`, err.message);
    }
  }

  await browser.close();
}

run();
