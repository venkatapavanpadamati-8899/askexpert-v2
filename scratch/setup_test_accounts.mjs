import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function setupAccounts() {
  console.log('=== SETTING UP AND VERIFYING ACCOUNTS FOR 3 JOURNEYS ===');

  // 1. Admin Account
  const adminEmail = 'admin.audit@askexpert.com';
  const adminPass = 'AdminSecurity123!';

  console.log(`Setting up Admin account: ${adminEmail}...`);
  const { data: aData, error: aErr } = await supabase.auth.signUp({
    email: adminEmail,
    password: adminPass,
    options: {
      data: { full_name: 'Super Admin', role: 'admin' }
    }
  });

  let adminId = aData?.user?.id;
  if (!adminId) {
    // Already exists, sign in to get ID
    const { data: loginData } = await supabase.auth.signInWithPassword({
      email: adminEmail,
      password: adminPass
    });
    adminId = loginData?.user?.id;
  }

  if (adminId) {
    await supabase.from('profiles').upsert({
      id: adminId,
      full_name: 'Super Admin',
      email: adminEmail,
      role: 'admin',
      is_verified: true
    });
    console.log('✓ Admin account verified and ready with role=admin:', adminId);
  }

  // 2. Expert Account
  const expertEmail = 'expert.audit@askexpert.com';
  const expertPass = 'ExpertSecurity123!';

  console.log(`Setting up Expert account: ${expertEmail}...`);
  const { data: expData } = await supabase.auth.signUp({
    email: expertEmail,
    password: expertPass,
    options: {
      data: { full_name: 'Adv. Suresh Reddy', role: 'expert' }
    }
  });

  let expertId = expData?.user?.id;
  if (!expertId) {
    const { data: expLogin } = await supabase.auth.signInWithPassword({
      email: expertEmail,
      password: expertPass
    });
    expertId = expLogin?.user?.id;
  }

  if (expertId) {
    await supabase.from('profiles').upsert({
      id: expertId,
      full_name: 'Adv. Suresh Reddy',
      email: expertEmail,
      role: 'expert',
      specialization: 'Legal Advisor',
      headline: 'Corporate & ROC Compliance Counsel',
      experience_years: 12,
      rating: 4.95,
      is_verified: true
    });

    await supabase.from('professional_verifications').upsert({
      expert_id: expertId,
      council_registration_number: 'TS/BAR/2014/8912',
      verification_status: 'approved',
      submitted_at: new Date().toISOString()
    });
    console.log('✓ Expert account verified and ready with role=expert:', expertId);
  }
}

setupAccounts().catch(console.error);
