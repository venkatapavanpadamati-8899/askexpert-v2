import { createClient } from '@supabase/supabase-js';

const supabase = createClient('https://girexuzrkeiylkbqglks.supabase.co', 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P');

const allTables = [
  'profiles',
  'professional_verifications',
  'questions',
  'answers',
  'conversations',
  'messages',
  'consultation_requests',
  'payments',
  'payout_requests',
  'notifications',
  'reports',
  'consultation_sessions',
  'reviews',
  'session_events',
  'system_health',
  'audit_logs',
  'system_errors',
  'error_fix_proposals',
  'ai_agent_audit_logs',
  'issue_reports',
  'ai_fix_proposals',
  'admin_approvals',
  'privacy_settings',
  'chat_session_keys',
  'chat_ephemeral_presence',
  'domains'
];

async function inspectLiveDatabase() {
  console.log("=== LIVE SUPABASE TABLE INSPECTION ===");
  const results = {};

  for (const table of allTables) {
    const { data, error } = await supabase.from(table).select('*').limit(1);
    if (error) {
      results[table] = { exists: false, error: error.message };
    } else {
      results[table] = {
        exists: true,
        sampleCols: data && data.length > 0 ? Object.keys(data[0]) : '(empty table)'
      };
    }
  }

  for (const [table, res] of Object.entries(results)) {
    if (res.exists) {
      console.log(`[EXISTS] ${table.padEnd(26)} -> cols: ${Array.isArray(res.sampleCols) ? res.sampleCols.join(', ') : res.sampleCols}`);
    } else {
      console.log(`[MISSING] ${table.padEnd(25)} -> ${res.error}`);
    }
  }
}

inspectLiveDatabase();
