import { chromium } from 'playwright';
import { createServer } from 'vite';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function testExpertRegistration() {
  console.log('Testing Expert Registration flow...');
  const server = await createServer({ server: { port: 5174 } });
  await server.listen();
  const baseUrl = 'http://localhost:5174';

  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();

  try {
    await page.goto(`${baseUrl}/register.html`, { waitUntil: 'networkidle' });

    // Select Professional / Expert
    await page.locator('#accountType').selectOption('professional');
    const isExpertFieldsVisible = await page.locator('#expertVerificationFields').isVisible();
    console.log('Expert verification fields visible:', isExpertFieldsVisible);

    const expertEmail = `expert_test_${Date.now()}@askexpert.local`;
    await page.locator('#fullName').fill('Dr. Expert Tester');
    await page.locator('#email').fill(expertEmail);
    await page.locator('#password').fill('ExpertPassword123!');
    await page.locator('#phone').fill('9811122233');
    await page.locator('#aadhaarNumber').fill('123456789012');

    // Send and verify OTP
    await page.locator('#sendOtpButton').click();
    await page.waitForTimeout(300);
    await page.locator('#autoFillOtpButton').click();
    await page.waitForTimeout(300);

    // Register
    await page.locator('#createButton').click();
    await page.locator('#formStatus.show').waitFor({ state: 'visible', timeout: 15000 });

    const statusMsg = await page.locator('#formStatus').textContent();
    console.log('Expert Registration Status:', statusMsg);

    // Verify profile role in database
    const { data: profile } = await supabase.from('profiles').select('*').eq('email', expertEmail).single();
    console.log('Created Expert Profile:', { id: profile?.id, role: profile?.role, specialization: profile?.specialization });

    // Verify KYC verification table
    const { data: kyc } = await supabase.from('professional_verifications').select('*').eq('expert_id', profile.id).single();
    console.log('Created KYC Record:', { status: kyc?.verification_status, reg_no: kyc?.council_registration_no });

    if (profile?.role === 'expert' && kyc?.verification_status === 'pending') {
      console.log('🎉 Expert registration runtime test PASSED!');
    } else {
      throw new Error('Expert role or KYC status mismatch');
    }
  } finally {
    await browser.close();
    await server.close();
  }
}

testExpertRegistration().catch(err => {
  console.error('Expert test failed:', err);
  process.exit(1);
});
