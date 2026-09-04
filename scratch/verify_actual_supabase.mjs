import { createClient } from '@supabase/supabase-js';

const supabase = createClient('https://girexuzrkeiylkbqglks.supabase.co', 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P');

async function testDb() {
  console.log("=== LIVE SUPABASE SCHEMA & TABLE VERIFICATION ===");

  // 1. Check profiles table & columns
  const { data: profiles, error: profErr } = await supabase.from('profiles').select('id, full_name, email, role, is_verified, is_blocked').limit(2);
  console.log("1. profiles query:", profErr ? `ERR: ${profErr.message}` : `OK, count: ${profiles.length}, sample: ${JSON.stringify(profiles[0])}`);

  // 2. Check professional_verifications table & columns
  const { data: pv, error: pvErr } = await supabase.from('professional_verifications').select('*').limit(1);
  console.log("2. professional_verifications query:", pvErr ? `ERR: ${pvErr.message}` : `OK, cols: ${Object.keys(pv[0] || {})}`);

  // Test council_registration_no vs council_registration_number
  const { data: pvNo, error: pvNoErr } = await supabase.from('professional_verifications').select('council_registration_no').limit(1);
  console.log("   council_registration_no query:", pvNoErr ? `ERR: ${pvNoErr.message}` : `OK`);

  const { data: pvNumber, error: pvNumberErr } = await supabase.from('professional_verifications').select('council_registration_number').limit(1);
  console.log("   council_registration_number query:", pvNumberErr ? `ERR: ${pvNumberErr.message}` : `OK`);

  // 3. Check questions table
  const { data: q, error: qErr } = await supabase.from('questions').select('id, title, status, moderation_status, answers_count').limit(1);
  console.log("3. questions query:", qErr ? `ERR: ${qErr.message}` : `OK, sample: ${JSON.stringify(q[0])}`);

  // 4. Check answers table columns
  const { data: ans, error: ansErr } = await supabase.from('answers').select('*').limit(1);
  console.log("4. answers query:", ansErr ? `ERR: ${ansErr.message}` : `OK, cols: ${Object.keys(ans[0] || {})}`);

  // 5. Check system_errors table
  const { data: sysErr, error: sysErrErr } = await supabase.from('system_errors').select('id').limit(1);
  console.log("5. system_errors query:", sysErrErr ? `ERR: ${sysErrErr.message}` : `OK, exists!`);

  // 6. Check error_fix_proposals table
  const { data: efp, error: efpErr } = await supabase.from('error_fix_proposals').select('id').limit(1);
  console.log("6. error_fix_proposals query:", efpErr ? `ERR: ${efpErr.message}` : `OK, exists!`);

  // 7. Check reports table
  const { data: rep, error: repErr } = await supabase.from('reports').select('id, status').limit(1);
  console.log("7. reports query:", repErr ? `ERR: ${repErr.message}` : `OK`);

  // 8. Check payments & payout_requests
  const { data: pay, error: payErr } = await supabase.from('payments').select('id, amount, status').limit(1);
  console.log("8. payments query:", payErr ? `ERR: ${payErr.message}` : `OK`);

  const { data: po, error: poErr } = await supabase.from('payout_requests').select('id, amount, status').limit(1);
  console.log("   payout_requests query:", poErr ? `ERR: ${poErr.message}` : `OK`);

  // 9. Check Auth sign in with audit users
  console.log("\n=== AUTH SIGN-IN CHECKS ===");
  const { data: userAuth, error: uErr } = await supabase.auth.signInWithPassword({
    email: 'user.audit@askexpert.com',
    password: 'UserSecurity123!'
  });
  console.log("User signIn:", uErr ? `ERR: ${uErr.message}` : `OK, user id: ${userAuth.user?.id}`);

  const { data: expAuth, error: eErr } = await supabase.auth.signInWithPassword({
    email: 'expert.audit@askexpert.com',
    password: 'ExpertSecurity123!'
  });
  console.log("Expert signIn:", eErr ? `ERR: ${eErr.message}` : `OK, expert id: ${expAuth.user?.id}`);

  const { data: admAuth, error: aErr } = await supabase.auth.signInWithPassword({
    email: 'admin.audit@askexpert.com',
    password: 'AdminSecurity123!'
  });
  console.log("Admin signIn:", aErr ? `ERR: ${aErr.message}` : `OK, admin id: ${admAuth.user?.id}`);

  await supabase.auth.signOut();
}

testDb();
