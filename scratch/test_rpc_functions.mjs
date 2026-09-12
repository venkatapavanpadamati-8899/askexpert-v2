import { createClient } from '@supabase/supabase-js';

const supabase = createClient('https://girexuzrkeiylkbqglks.supabase.co', 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P');

async function testRpcFunctions() {
  console.log('=== VERIFYING RPC FUNCTIONS ON SUPABASE ===');

  const rpcs = [
    { name: 'admin_review_professional_verification', params: { p_expert_id: '00000000-0000-0000-0000-000000000000', p_decision: 'APPROVED' } },
    { name: 'settle_consultation_session', params: { p_session_id: '00000000-0000-0000-0000-000000000000' } },
    { name: 'request_payout', params: { p_amount: 100 } },
    { name: 'admin_reject_payout', params: { p_payout_id: '00000000-0000-0000-0000-000000000000', p_reason: 'test' } },
    { name: 'is_admin', params: {} }
  ];

  for (const r of rpcs) {
    const { data, error } = await supabase.rpc(r.name, r.params);
    if (!error) {
      console.log(`[EXISTS & EXECUTED] ${r.name.padEnd(45)} -> res:`, data);
    } else {
      const isMissing = error.message.includes('Could not find the function') || error.message.includes('schema cache');
      if (isMissing) {
        console.log(`[MISSING]          ${r.name.padEnd(45)} -> ${error.message}`);
      } else {
        console.log(`[EXISTS & GATED]   ${r.name.padEnd(45)} -> ${error.message}`);
      }
    }
  }
}

testRpcFunctions();
