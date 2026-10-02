import { test, expect } from '@playwright/test';

test.describe('Authentication and OTP Flow', () => {
  
  test('Demo OTP is completely removed from Register UI', async ({ page }) => {
    await page.goto('/register.html');
    
    // Check that Demo OTP box is not present
    const demoOtpBox = page.locator('#demoOtpBox');
    await expect(demoOtpBox).toHaveCount(0);
    
    // Attempt registration flow up to OTP sending
    await page.fill('#fullName', 'Test User');
    await page.fill('#email', 'test-real-flow@askexpert.com');
    await page.fill('#phone', '9999999999');
    await page.fill('#password', 'TestPass123!');
    await page.click('#createButton');
    
    // Expect the real OTP input to be shown, but no demo OTP text
    const textContent = await page.textContent('body');
    expect(textContent).not.toContain('Demo OTP:');
  });

  test('Demo OTP is completely removed from Forgot Password UI', async ({ page }) => {
    await page.goto('/forgot-password.html');
    
    const demoOtpBox = page.locator('#demoOtpBox');
    await expect(demoOtpBox).toHaveCount(0);
    
    await page.fill('#identifier', 'test-forgot@askexpert.com');
    await page.click('#sendOtpButton');
    
    // Expect the status to say OTP sent, but no demo OTP provided
    const status = page.locator('#otpStatus');
    await expect(status).toBeVisible({ timeout: 15000 });
    await expect(status).toContainText('OTP');
    
    const textContent = await page.textContent('body');
    expect(textContent).not.toContain('Demo OTP:');
  });
});
