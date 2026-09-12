// scratch/audit_supabase_deep.mjs
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function runDeepDbAudit() {
  console.log('=== SUPABASE DEEP DATABASE & STORAGE AUDIT ===');

  const tablesToCheck = [
    'profiles',
    'questions',
    'answers',
    'professional_verifications',
    'consultation_requests',
    'consultation_sessions',
    'payout_requests',
    'reports',
    'messages',
    'ratings',
    'payments',
    'wallets',
    'wallet_transactions',
    'audit_logs',
    'notifications',
    'system_errors'
  ];

  const results = {};

  for (const table of tablesToCheck) {
    try {
      const { data, error, count } = await supabase.from(table).select('*', { count: 'exact', head: true });
      if (error) {
        results[table] = { status: 'ERROR', error: error.message, code: error.code };
      } else {
        results[table] = { status: 'ACCESSIBLE', count };
      }
    } catch (e) {
      results[table] = { status: 'EXCEPTION', message: e.message };
    }
  }

  console.log('Tables check results:');
  console.log(JSON.stringify(results, null, 2));

  // Storage buckets check
  console.log('\n=== CHECKING STORAGE BUCKETS ===');
  try {
    const { data: buckets, error: bErr } = await supabase.storage.listBuckets();
    if (bErr) {
      console.log('Storage buckets list error:', bErr.message);
    } else {
      console.log('Buckets found:', buckets?.map(b => ({ name: b.name, public: b.public, id: b.id })));
    }
  } catch (e) {
    console.log('Storage exception:', e.message);
  }

  // Check specific kyc-documents bucket
  try {
    const { data: files, error: fErr } = await supabase.storage.from('kyc-documents').list('', { limit: 5 });
    if (fErr) {
      console.log('kyc-documents list (anon):', fErr.message);
    } else {
      console.log('kyc-documents files count (anon):', files?.length);
    }
  } catch (e) {
    console.log('kyc-documents check exception:', e.message);
  }
}

runDeepDbAudit();
