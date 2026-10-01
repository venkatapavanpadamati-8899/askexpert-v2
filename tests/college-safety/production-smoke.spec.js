import { test, expect } from '@playwright/test';

// Configuration
const BASE_URL = process.env.PLAYWRIGHT_BASE_URL || 'https://askexpert-v2.vercel.app';
const USERS = {
  studentA: { email: process.env.TEST_STUDENT_A_EMAIL, password: process.env.TEST_STUDENT_A_PASSWORD },
  staffA: { email: process.env.TEST_STAFF_A_EMAIL, password: process.env.TEST_STAFF_A_PASSWORD },
  staffB: { email: process.env.TEST_STAFF_B_EMAIL, password: process.env.TEST_STAFF_B_PASSWORD }
};

let incidentId = null;

// Helper: Login
async function login(page, user, targetRegex) {
  await page.goto(`${BASE_URL}/login.html`);
  await page.fill('#email', user.email);
  await page.fill('#password', user.password);
  await page.click('#loginButton');
  await expect(page).toHaveURL(targetRegex, { timeout: 15000 });
}

async function adminLogin(page, user) {
  await page.goto(`${BASE_URL}/admin-login.html`);
  await page.fill('#email', user.email);
  await page.fill('#password', user.password);
  await page.click('#loginBtn');
  await expect(page).toHaveURL(/.*admin-dashboard(\.html)?/, { timeout: 15000 });
}

test.describe.serial('Production Smoke Test', () => {

  test.beforeEach(async ({ page }) => {
    // Intercept fonts to prevent timeout
    await page.route('**/*', (route) => {
      const url = route.request().url();
      if (url.includes('fonts.googleapis.com') || url.includes('fonts.gstatic.com')) {
        route.abort();
      } else {
        route.continue();
      }
    });
  });

  test('1. Student submits non-emergency complaint', async ({ page, request }) => {
    await login(page, USERS.studentA, /.*user-dashboard(\.html)?/);

    // Open Women Safety
    await page.goto(`${BASE_URL}/women-safety.html`);
    await expect(page.locator('#safetyForm')).toBeVisible();

    // Submit non-emergency test complaint
    await page.fill('#incidentType', 'Harassment');
    await page.fill('#incidentLocation', 'Test Location - Smoke Test');
    await page.fill('#incidentDescription', 'This is a controlled smoke test complaint. Please ignore.');
    await page.click('#shareLocation');
    await page.click('#shareIdentity'); // Share identity for testing

    // Evidence upload
    const buffer = Buffer.from('test image content');
    await page.setInputFiles('#evidenceUpload', {
      name: 'smoketest.png',
      mimeType: 'image/png',
      buffer
    });

    await page.click('#submitComplaint');
    await expect(page.locator('#successModal')).toBeVisible({ timeout: 10000 });
    
    // Check local storage for pending incident to find the ID, or fetch it
    // Wait for the modal to be visible
    await page.click('#closeSuccessModal');
    
    // Find incident via API to save ID for authority test
    const getRes = await request.get(`${process.env.VITE_SUPABASE_URL}/rest/v1/safety_incidents?select=id,status,college_id&order=created_at.desc&limit=1`, {
      headers: {
        'apikey': process.env.VITE_SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${process.env.VITE_SUPABASE_ANON_KEY}`
      }
    });
    const incidents = await getRes.json();
    expect(incidents.length).toBeGreaterThan(0);
    incidentId = incidents[0].id;
    console.log('Created test incident:', incidentId);
    expect(incidents[0].status).toBe('PENDING');
  });

  test('2. Authority Flow', async ({ page }) => {
    expect(incidentId).toBeTruthy(); // Ensure student test ran

    await adminLogin(page, USERS.staffA);
    await page.goto(`${BASE_URL}/college-safety-management.html`);

    // Verify incident appears
    const row = page.locator(`tr[data-id="${incidentId}"]`);
    await expect(row).toBeVisible();

    // View details
    await row.locator('.view-btn').click();
    await expect(page.locator('#modalIncidentId')).toContainText(incidentId.substring(0, 8));

    // Acknowledge
    await page.click('#acknowledgeBtn');
    await expect(row.locator('.status-badge')).toHaveText(/ACKNOWLEDGED/i);

    // Assign
    await page.fill('#assigneeName', 'Test Officer');
    await page.click('#assignBtn');
    await expect(row.locator('td:nth-child(5)')).toContainText('Test Officer');

    // Status transition to RESOLVED
    await page.selectOption('#updateStatus', 'RESOLVED');
    await page.click('#updateStatusBtn');
    await expect(row.locator('.status-badge')).toHaveText(/RESOLVED/i);

    // Case messages
    await page.fill('#newMessage', 'Smoke test resolution note.');
    await page.click('#sendMessageBtn');
    await expect(page.locator('#messagesList')).toContainText('Smoke test resolution note.');

    // Audit activity check
    await expect(page.locator('#auditLog')).toContainText('Status updated to RESOLVED');
  });

  test('3. Cross-college check', async ({ page }) => {
    expect(incidentId).toBeTruthy();

    await adminLogin(page, USERS.staffB);
    await page.goto(`${BASE_URL}/college-safety-management.html`);

    // Wait for table to load
    await page.waitForSelector('#incidentsTableBody tr');

    // Verify College A incident is NOT visible to College B staff
    const row = page.locator(`tr[data-id="${incidentId}"]`);
    await expect(row).toHaveCount(0);
  });

  test('4. Cleanup test data', async ({ request }) => {
    expect(incidentId).toBeTruthy();
    
    // Delete the test incident via API
    const deleteRes = await request.delete(`${process.env.VITE_SUPABASE_URL}/rest/v1/safety_incidents?id=eq.${incidentId}`, {
      headers: {
        'apikey': process.env.VITE_SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${process.env.VITE_SUPABASE_ANON_KEY}`
      }
    });
    expect(deleteRes.ok()).toBeTruthy();
    console.log('Cleaned up test incident:', incidentId);
  });
});
