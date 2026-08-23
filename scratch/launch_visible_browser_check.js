import { chromium } from 'playwright';

(async () => {
  console.log("==================================================");
  console.log("🖥️ LAUNCHING DIRECT VISIBLE DESKTOP BROWSER");
  console.log("==================================================");

  const browser = await chromium.launch({
    headless: false,
    slowMo: 1000
  });

  const nodePid = process.pid;
  console.log(`✓ Browser Launched Successfully! (Parent Process PID: ${nodePid})`);

  const page = await browser.newPage();
  console.log("✓ Opening http://localhost:5173/index.html on Desktop Screen...");
  await page.goto("http://localhost:5173/index.html");

  const title = await page.title();
  console.log(`✓ Loaded Page Title: "${title}"`);
  console.log(`✓ Browser window is OPEN and VISIBLE on your Windows Desktop (Node PID: ${nodePid})!`);
  console.log("✓ Keeping window open for 10 seconds so you can visually confirm on screen...");

  await page.waitForTimeout(10000);
  await browser.close();
  console.log("✓ Browser window closed cleanly.");
})();
