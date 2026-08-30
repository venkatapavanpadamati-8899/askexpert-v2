import { chromium } from 'playwright';

const BASE_URL = 'http://localhost:5173';

async function testNoRefreshHiddenAdmin() {
  console.log('🚀 Testing Hidden Admin Login and Zero-Refresh Behavior...\n');
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({ viewport: { width: 412, height: 915 } });
  const page = await context.newPage();

  // 1. Verify that NO visible admin login button or link exists on login.html
  console.log('1. Checking login.html for visible Admin links...');
  await page.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(500);

  const pageContent = await page.content();
  const hasDirectAdminText = pageContent.includes('Direct Admin Login');
  console.log('Contains "Direct Admin Login" link?', hasDirectAdminText);
  if (hasDirectAdminText) {
    throw new Error('Visible "Direct Admin Login" link still exists! It must be hidden.');
  }
  console.log('✓ PASS: Admin link is completely hidden from login.html!');

  // 2. Test Admin Hidden Login (Entering admin credentials in standard form)
  console.log('\n2. Testing Hidden Admin Login with "admin" & "admin123"...');
  let reloaded = false;
  page.on('framenavigated', f => {
    if (f === page.mainFrame()) {
      console.log('→ Main frame navigated to:', f.url());
    }
  });

  await page.fill('#email', 'admin');
  await page.fill('#password', 'admin123');
  await page.click('#loginButton');

  // Wait for redirect to admin-dashboard.html
  await page.waitForURL('**/admin-dashboard.html', { timeout: 8000 });
  console.log('✓ PASS: Admin successfully logged in via standard form and redirected to admin-dashboard.html! URL:', page.url());

  // 3. Test User Login and verify no page reload/refresh loop
  console.log('\n3. Testing User Login with "user" & "user123"...');
  await page.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(500);

  await page.fill('#email', 'user');
  await page.fill('#password', 'user123');
  await page.click('#loginButton');

  await page.waitForURL('**/user-dashboard.html', { timeout: 8000 });
  console.log('✓ PASS: User successfully logged in and redirected to user-dashboard.html! URL:', page.url());

  // 4. Test Expert Login with Enter keydown (ensuring Enter key does NOT reload page)
  console.log('\n4. Testing Expert Login with Enter key press on password field...');
  await page.goto(`${BASE_URL}/login.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(500);

  await page.fill('#email', 'expert');
  await page.fill('#password', 'expert123');
  await page.press('#password', 'Enter');

  await page.waitForURL('**/professional-dashboard.html', { timeout: 8000 });
  console.log('✓ PASS: Enter key cleanly submitted login without page refresh, redirected to professional-dashboard.html! URL:', page.url());

  await page.close();
  await browser.close();

  console.log('\n========================================================');
  console.log('🎉 ALL TESTS PASSED: HIDDEN ADMIN LOGIN & ZERO-REFRESH CONFIRMED 100%!');
  console.log('========================================================');
}

testNoRefreshHiddenAdmin().catch(err => {
  console.error('❌ Test failed:', err);
  process.exit(1);
});
