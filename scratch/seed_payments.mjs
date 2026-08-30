import { createClient } from '@supabase/supabase-js';

const supabase = createClient('https://girexuzrkeiylkbqglks.supabase.co', 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P');

async function run() {
  const { data: signInData, error: signInErr } = await supabase.auth.signInWithPassword({
    email: 'venkatapavanpadamati@gmail.com',
    password: 'Admin@123'
  });

  if (signInErr) {
    const { error: signInErr2 } = await supabase.auth.signInWithPassword({
      email: 'venkatapavanpadamati@gmail.com',
      password: 'Test@123'
    });
    if (signInErr2) {
      console.log('Login failed:', signInErr.message, signInErr2.message);
      return;
    }
  }

  const { data: users } = await supabase.from('profiles').select('id').eq('role', 'user').limit(1);
  const { data: experts } = await supabase.from('profiles').select('id').eq('role', 'expert').limit(1);

  if (users?.length && experts?.length) {
    const { error } = await supabase.from('payments').insert([
      { user_id: users[0].id, expert_id: experts[0].id, amount: 2500, status: 'successful', description: 'Consultation with Verified Expert', payment_method: 'Card' },
      { user_id: users[0].id, expert_id: experts[0].id, amount: 1500, status: 'successful', description: 'Emergency Call', payment_method: 'UPI' },
      { user_id: users[0].id, expert_id: experts[0].id, amount: 1000, status: 'pending', description: 'Scheduled standard check', payment_method: 'Wallet' },
      { user_id: users[0].id, expert_id: experts[0].id, amount: 1200, status: 'refunded', description: 'Cancelled by expert', payment_method: 'NetBanking' }
    ]);
    console.log(error ? 'Error: ' + error.message : 'Success seeding payments!');
  } else {
    console.log('No users or experts found to seed payments');
  }
}
run();
