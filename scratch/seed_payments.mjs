import { createClient } from '@supabase/supabase-js';

const supabase = createClient('https://girexuzrkeiylkbqglks.supabase.co', 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P');

async function run() {
  const { data: signInData, error: signInErr } = await supabase.auth.signInWithPassword({
    email: 'user.audit@askexpert.com',
    password: 'UserSecurity123!'
  });

  if (signInErr) {
    console.log('Login failed:', signInErr.message);
    return;
  }
  
  console.log('Logged in as user.audit@askexpert.com');

  const { data: experts } = await supabase.from('profiles').select('id').eq('role', 'expert').limit(1);

  if (experts?.length) {
    const userId = signInData.user.id;
    const { error } = await supabase.from('payments').insert([
      { user_id: userId, expert_id: experts[0].id, amount: 2500, status: 'successful', description: 'Consultation with Verified Expert', payment_method: 'Card', provider_payment_id: 'TXN-12345' },
      { user_id: userId, expert_id: experts[0].id, amount: 1500, status: 'successful', description: 'Emergency Call', payment_method: 'UPI', provider_payment_id: 'TXN-54321' },
      { user_id: userId, expert_id: experts[0].id, amount: 1000, status: 'pending', description: 'Scheduled standard check', payment_method: 'Wallet', provider_payment_id: 'TXN-98765' },
      { user_id: userId, expert_id: experts[0].id, amount: 1200, status: 'refunded', description: 'Cancelled by expert', payment_method: 'NetBanking', provider_payment_id: 'TXN-11223' }
    ]);
    console.log(error ? 'Error seeding payments: ' + error.message : 'Success seeding payments!');
    
    const { error: payoutError } = await supabase.from('payout_requests').insert([
      { expert_id: experts[0].id, amount: 900, status: 'pending', notes: 'Monthly withdrawal' }
    ]);
    console.log(payoutError ? 'Error seeding payout: ' + payoutError.message : 'Success seeding payout!');
  } else {
    console.log('No experts found to seed payments');
  }
}
run();
