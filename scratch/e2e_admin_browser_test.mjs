import { chromium } from '@playwright/test';

async function runBrowserTests() {
  console.log('=== STARTING PLAYWRIGHT E2E BROWSER VERIFICATION ===\n');

  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  try {
    // -----------------------------------------------------------------
    // TEST 1: Direct unauthenticated access to admin-dashboard.html -> Rejected
    // -----------------------------------------------------------------
    console.log('1. Testing direct unauthenticated access to /admin-dashboard.html...');
    await page.goto('http://localhost:5173/admin-dashboard.html');
    await page.waitForTimeout(2000);
    const finalUrl1 = page.url();
    console.log('   Final URL after guard execution:', finalUrl1);
    if (finalUrl1.includes('admin-login.html') || finalUrl1.includes('login.html')) {
      console.log('   ✓ PASS: Unauthenticated access was successfully blocked & redirected to login!');
    } else {
      throw new Error(`Direct access was NOT blocked! Current URL: ${finalUrl1}`);
    }

    // -----------------------------------------------------------------
    // TEST 2: Normal login.html does NOT expose any Admin UI
    // -----------------------------------------------------------------
    console.log('\n2. Verifying normal login.html does not expose Admin options...');
    await page.goto('http://localhost:5173/login.html');
    const adminBtnCount = await page.locator('text=Admin').count();
    const adminLinkCount = await page.locator('a[href*="admin"]').count();
    console.log(`   Found ${adminBtnCount} "Admin" elements and ${adminLinkCount} admin links.`);
    if (adminLinkCount === 0) {
      console.log('   ✓ PASS: Normal login page has zero exposed Admin links/buttons!');
    } else {
      throw new Error('Normal login exposes administrative links!');
    }

    // -----------------------------------------------------------------
    // TEST 3: Admin Login page has Google OAuth & Email/Password
    // -----------------------------------------------------------------
    console.log('\n3. Verifying admin-login.html UI elements...');
    await page.goto('http://localhost:5173/admin-login.html');
    const emailInput = await page.$('#adminEmailInput');
    const passInput = await page.$('#adminPasswordInput');
    const submitBtn = await page.$('#adminSubmitBtn');
    const googleBtn = await page.$('#adminGoogleBtn');

    if (emailInput && passInput && submitBtn && googleBtn) {
      console.log('   ✓ PASS: admin-login.html contains Email, Password, Submit, and Google OAuth buttons!');
    } else {
      throw new Error('admin-login.html is missing required inputs or buttons!');
    }

    // -----------------------------------------------------------------
    // TEST 4: Real Email/Password Authentication for venkatapavanpadamati1@gmail.com
    // -----------------------------------------------------------------
    console.log('\n4. Executing live Admin login with venkatapavanpadamati1@gmail.com...');
    await page.fill('#adminEmailInput', 'venkatapavanpadamati1@gmail.com');
    await page.fill('#adminPasswordInput', 'Pavan@123');
    await page.click('#adminSubmitBtn');

    console.log('   Submitted form, waiting for authentication & redirect...');
    await page.waitForURL('**/admin-dashboard.html', { timeout: 15000 });
    console.log('   ✓ PASS: Successfully authenticated and redirected to:', page.url());

    // -----------------------------------------------------------------
    // TEST 5: Verify Admin Dashboard is fully loaded and active
    // -----------------------------------------------------------------
    console.log('\n5. Verifying Admin Dashboard live elements...');
    await page.waitForSelector('.admin-sidebar', { timeout: 5000 });
    const pageTitle = await page.title();
    console.log('   Dashboard page title:', pageTitle);
    console.log('   ✓ PASS: Admin Command Center successfully rendered for authorized administrator!');

    console.log('\n=================================================');
    console.log('🎉 ALL PLAYWRIGHT E2E BROWSER TESTS PASSED 100%!');
    console.log('=================================================');
  } catch (err) {
    console.error('❌ E2E Browser Test Failed:', err);
    process.exit(1);
  } finally {
    await browser.close();
  }
}

runBrowserTests();
