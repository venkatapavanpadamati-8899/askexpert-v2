import { test, expect } from '@playwright/test';

test.describe('Expert UI and Demo Data check', () => {
  
  test('Expert cards should not contain Demo badges', async ({ page }) => {
    await page.goto('/experts.html');
    
    // Wait for the grid to load
    await page.waitForSelector('.experts-grid', { timeout: 10000 });
    
    // Ensure no element has the badge-demo class
    const demoBadges = page.locator('.badge-demo');
    await expect(demoBadges).toHaveCount(0);
    
    const textContent = await page.textContent('body');
    expect(textContent).not.toContain('DEMO');
  });

});
