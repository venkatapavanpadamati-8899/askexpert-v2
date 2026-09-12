import { createClient } from '@supabase/supabase-js';

const sb = createClient('https://girexuzrkeiylkbqglks.supabase.co', 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P');

async function testAuthRpc() {
  const testEmail = `probe_user_${Date.now()}@testdomain.com`;
  const testPass = `Pass${Date.now()}!Aa1`;
  
  console.log('Testing with authenticated session:', testEmail);
  const { data: signData, error: signErr } = await sb.auth.signUp({
    email: testEmail,
    password: testPass
  });

  if (signErr) {
    console.log('Sign up error:', signErr.message);
  } else {
    console.log('User signed up! Session present?', !!signData.session);
  }

  // If session created, test RPC
  const { data: rpcRes, error: rpcErr } = await sb.rpc('admin_review_professional_verification', {
    p_expert_id: '00000000-0000-0000-0000-000000000000',
    p_decision: 'APPROVED'
  });

  console.log('RPC result:', rpcRes);
  console.log('RPC error:', rpcErr ? rpcErr.message : 'none');
}

testAuthRpc();
