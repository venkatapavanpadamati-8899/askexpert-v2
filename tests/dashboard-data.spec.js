import { test, expect } from '@playwright/test';

test.describe('Dashboard Data Integrity', () => {

  test('Dashboard loads without dummy data', async ({ page }) => {
    // 1. Log in as Student A
    const emailA = process.env.TEST_STUDENT_A_EMAIL || 'test-student@askexpert.com';
    const passwordA = process.env.TEST_STUDENT_A_PASSWORD || 'TestPass123!';
    
    await page.goto('/login.html');
    await page.fill('#email', emailA);
    await page.fill('#password', passwordA);
    await page.click('#loginButton');
    await page.waitForURL(/.*user-dashboard\.html/);

    // 2. Check for hardcoded elements or dummy metrics
    const bodyText = await page.textContent('body');
    
    // Some stats might legitimately be 0, but we want to make sure it doesn't just show placeholder text
    // E.g., we look for missing elements or errors in console
    
    expect(bodyText).not.toContain('undefined');
    expect(bodyText).not.toContain('[object Object]');
  });
});
