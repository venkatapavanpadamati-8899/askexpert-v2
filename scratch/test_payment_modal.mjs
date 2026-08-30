import { chromium } from 'playwright';

const BASE_URL = 'http://localhost:5173';

async function testPaymentModal() {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({ viewport: { width: 1280, height: 800 } });
  const page = await context.newPage();

  page.on('console', msg => console.log('PAGE LOG:', msg.type(), msg.text()));
  page.on('pageerror', err => console.log('PAGE ERROR:', err.message));

  await page.goto(`${BASE_URL}/payments.html`, { waitUntil: 'domcontentloaded' });
  await page.waitForTimeout(1000);

  console.log('Clicking payNowBtn...');
  await page.click('#payNowBtn');

  for (let i = 0; i < 15; i++) {
    await page.waitForTimeout(1000);
    const pendingDisp = await page.$eval('#modalPendingState', el => el.style.display);
    const successDisp = await page.$eval('#modalSuccessState', el => el.style.display);
    const failedDisp = await page.$eval('#modalFailedState', el => el.style.display);
    console.log(`Sec ${i+1}: pending=${pendingDisp}, success=${successDisp}, failed=${failedDisp}`);
    if (successDisp === 'block') {
      console.log('SUCCESS STATE REACHED!');
      break;
    }
  }

  await browser.close();
}

testPaymentModal();
