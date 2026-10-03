import { test, expect } from '@playwright/test';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.VITE_SUPABASE_ANON_KEY;

test.describe('Admin Security & Role Escalation', () => {

  test('Normal user cannot access admin dashboard', async ({ page }) => {
    // 1. Unauthenticated access should redirect
    await page.goto('/admin-dashboard.html');
    await expect(page).toHaveURL(/.*admin-login.*/, { timeout: 15000 });

    // 2. Normal user access should redirect
    // Use test student A as normal user
    const email = process.env.TEST_STUDENT_A_EMAIL || 'test-student@askexpert.com';
    const password = process.env.TEST_STUDENT_A_PASSWORD || 'TestPass123!';
    
    await page.goto('/login.html');
    await page.fill('#email', email);
    await page.fill('#password', password);
    await page.click('#loginButton');
    
    // Wait for login success
    await page.waitForURL(/.*user-dashboard.*/);
    
    // Attempt to access admin dashboard
    await page.goto('/admin-dashboard.html', { waitUntil: 'commit' });
    // Should be kicked out
    await expect(page).toHaveURL(/.*admin-login.*/);
  });

  test('Manipulating localStorage role to admin does not bypass security', async ({ page }) => {
    await page.goto('/admin-login.html');
    
    // Fake local storage
    await page.evaluate(() => {
      localStorage.setItem('askexpert_user_role', 'admin');
      localStorage.setItem('askexpert_user_id', 'fake-uuid');
    });
    
    await page.goto('/admin-dashboard.html');
    
    // DB check should fail and redirect
    await expect(page).toHaveURL(/.*admin-login.*/);
  });
});
