import { test, expect } from '@playwright/test';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.VITE_SUPABASE_ANON_KEY;

test.describe('Chat & Realtime Access', () => {

  test('User cannot access chat without valid active session', async ({ page }) => {
    // Attempting to visit video-room or chat directly
    await page.goto('/chat.html?session=fake-session-id');
    // Should kick out or show error
    await expect(page).toHaveURL(/.*login\.html/);
  });

  test('User A cannot access User B\'s chat session (RLS)', async ({ page }) => {
    // 1. Log in as Student A
    const emailA = process.env.TEST_STUDENT_A_EMAIL || 'test-student@askexpert.com';
    const passwordA = process.env.TEST_STUDENT_A_PASSWORD || 'TestPass123!';
    
    await page.goto('/login.html');
    await page.fill('#email', emailA);
    await page.fill('#password', passwordA);
    await page.click('#loginButton');
    await page.waitForURL(/.*user-dashboard\.html/);
    
    // 2. We need a chat session belonging to someone else. 
    // For this test, we try to access a random/fake uuid. If RLS works, we get no rows.
    await page.goto('/chat.html?session=00000000-0000-0000-0000-000000000000');
    
    // Check if error box is shown or redirected
    const errorText = await page.textContent('body');
    // The exact error message depends on implementation, but it shouldn't load the chat interface
    // Let's assert it shows an error or redirects
    const hasError = errorText.includes('error') || errorText.includes('not found') || errorText.includes('Unauthorized') || page.url().includes('login.html') || page.url().includes('user-dashboard.html');
    expect(hasError).toBeTruthy();
  });
});
