import { createClient } from '@supabase/supabase-js';

const sb = createClient('https://girexuzrkeiylkbqglks.supabase.co', 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P');

async function checkKycColumns() {
  const testCols = [
    'identity_document_type',
    'masked_identity_number',
    'last_four_consistency',
    'address_street',
    'ai_advisory_report'
  ];

  console.log('=== CHECKING FREE KYC COLUMNS IN LIVE DATABASE ===');
  for (const col of testCols) {
    const { data, error } = await sb.from('professional_verifications').select(col).limit(1);
    if (error) {
      console.log(`[MISSING] ${col.padEnd(25)} -> ${error.message}`);
    } else {
      console.log(`[EXISTS]  ${col.padEnd(25)} -> OK`);
    }
  }
}

checkKycColumns();
