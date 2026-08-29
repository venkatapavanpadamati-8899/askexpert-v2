import { chromium } from 'playwright';

async function testFlowchart() {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  const errors = [];
  page.on('console', msg => { if (msg.type() === 'error') errors.push(msg.text()); });
  
  await page.goto('http://localhost:5173/flowchart.html', { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(2000);
  console.log('Flowchart page loaded! Errors count:', errors.length);

  // Click on each tab to test on-demand rendering
  const tabs = ['user', 'expert', 'admin', 'aifix', 'chat', 'erd'];
  for (const t of tabs) {
    await page.click(`button[data-tab="${t}"]`);
    await page.waitForTimeout(1200);
    console.log(`✓ Tab ${t} rendered.`);
  }

  console.log('Total Console Errors across all tabs:', errors.length);
  if (errors.length > 0) console.log('Errors:', errors);

  await page.screenshot({ path: 'scratch/flowchart_rendered.png' });
  await browser.close();
}

testFlowchart().catch(console.error);
