/**
 * INSPECTION ONLY — NO WRITES, NO SCHEMA CHANGES.
 *
 * Targets:
 *  1. public.profiles columns and data types  (information_schema via REST)
 *  2. All constraints + indexes on public.profiles  (information_schema)
 *  3. public.handle_new_user() function body  (pg_catalog via anon REST)
 *  4. on_auth_user_created trigger definition  (information_schema.triggers)
 *  5. Exact 500 error when signing up (raw signup call, capture full body)
 *  6. Whether a username collision is the sole cause
 */

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdicmV4dXpya2VpeWxrYnFnbGtzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA1NjgxMzIsImV4cCI6MjA1NjE0NDEzMn0.aWPMxmJB4u60GNbPRdBNBb4BQBJNvMFOt8JHCZXADnc';

const BASE_HEADERS = {
  'Content-Type': 'application/json',
  'apikey': ANON_KEY,
  'Authorization': `Bearer ${ANON_KEY}`,
  'Accept': 'application/json',
};

async function get(url, extraHeaders = {}) {
  const res = await fetch(url, { headers: { ...BASE_HEADERS, ...extraHeaders } });
  const body = await res.text();
  return { status: res.status, headers: Object.fromEntries(res.headers), body };
}

async function main() {
  console.log('='.repeat(72));
  console.log('🔍  REMOTE SUPABASE SCHEMA INSPECTION  (READ-ONLY)');
  console.log('='.repeat(72));

  // ── 1. COLUMNS ─────────────────────────────────────────────────────────────
  console.log('\n══ [1] public.profiles COLUMNS ══');
  const cols = await get(
    `${SUPABASE_URL}/rest/v1/profiles?limit=0`,
    // HEAD request gives columns in Content-Profile; GET with limit=0 is safer
  );
  console.log('Status:', cols.status);
  // Also try OPTIONS to get column meta
  const opts = await fetch(`${SUPABASE_URL}/rest/v1/profiles`, {
    method: 'OPTIONS',
    headers: BASE_HEADERS,
  });
  const optsBody = await opts.text();
  console.log('OPTIONS status:', opts.status);
  if (optsBody.length < 4000) console.log('OPTIONS body:', optsBody);

  // ── 2. information_schema.columns ─────────────────────────────────────────
  console.log('\n══ [2] information_schema.columns (profiles) ══');
  const icols = await get(
    `${SUPABASE_URL}/rest/v1/information_schema.columns?table_schema=eq.public&table_name=eq.profiles&select=column_name,data_type,character_maximum_length,is_nullable,column_default&order=ordinal_position`
  );
  console.log('Status:', icols.status);
  if (icols.status === 200) {
    try {
      const data = JSON.parse(icols.body);
      console.log(`Found ${data.length} columns:`);
      data.forEach(c => {
        console.log(`  ${c.column_name.padEnd(24)} ${(c.data_type + (c.character_maximum_length ? `(${c.character_maximum_length})` : '')).padEnd(28)} nullable=${c.is_nullable}  default=${c.column_default ?? 'null'}`);
      });
    } catch(e) { console.log('Parse error:', e.message, icols.body.substring(0, 500)); }
  } else {
    console.log('Body:', icols.body.substring(0, 600));
  }

  // ── 3. TABLE CONSTRAINTS ───────────────────────────────────────────────────
  console.log('\n══ [3] information_schema.table_constraints (profiles) ══');
  const tc = await get(
    `${SUPABASE_URL}/rest/v1/information_schema.table_constraints?table_schema=eq.public&table_name=eq.profiles&select=constraint_name,constraint_type`
  );
  console.log('Status:', tc.status);
  if (tc.status === 200) {
    try {
      const data = JSON.parse(tc.body);
      data.forEach(c => console.log(`  ${c.constraint_type.padEnd(15)} ${c.constraint_name}`));
    } catch(e) { console.log('Body:', tc.body.substring(0, 500)); }
  } else {
    console.log('Body:', tc.body.substring(0, 500));
  }

  // ── 3b. KEY_COLUMN_USAGE — what columns each constraint covers ─────────────
  console.log('\n══ [3b] key_column_usage (profiles constraints) ══');
  const kcu = await get(
    `${SUPABASE_URL}/rest/v1/information_schema.key_column_usage?table_schema=eq.public&table_name=eq.profiles&select=constraint_name,column_name,ordinal_position`
  );
  console.log('Status:', kcu.status);
  if (kcu.status === 200) {
    try {
      const data = JSON.parse(kcu.body);
      data.forEach(c => console.log(`  ${c.constraint_name.padEnd(40)} → ${c.column_name}`));
    } catch(e) { console.log('Body:', kcu.body.substring(0, 500)); }
  } else {
    console.log('Body:', kcu.body.substring(0, 500));
  }

  // ── 4. TRIGGERS ────────────────────────────────────────────────────────────
  console.log('\n══ [4] information_schema.triggers (on auth.users) ══');
  const trigs = await get(
    `${SUPABASE_URL}/rest/v1/information_schema.triggers?trigger_name=eq.on_auth_user_created&select=trigger_name,event_manipulation,event_object_schema,event_object_table,action_statement,action_timing`
  );
  console.log('Status:', trigs.status);
  if (trigs.status === 200) {
    try {
      const data = JSON.parse(trigs.body);
      data.forEach(t => {
        console.log('  trigger_name:', t.trigger_name);
        console.log('  event:', t.action_timing, t.event_manipulation, 'ON', t.event_object_schema + '.' + t.event_object_table);
        console.log('  action:', t.action_statement);
      });
    } catch(e) { console.log('Body:', trigs.body.substring(0, 500)); }
  } else {
    console.log('Body (triggers):', trigs.body.substring(0, 600));
  }

  // ── 5. FUNCTION BODY — via pg_proc through postgrest ──────────────────────
  console.log('\n══ [5] public.handle_new_user function body ══');
  const fn = await get(
    `${SUPABASE_URL}/rest/v1/pg_proc?proname=eq.handle_new_user&select=proname,prosrc,prokind`
  );
  console.log('Status:', fn.status);
  if (fn.status === 200) {
    try {
      const data = JSON.parse(fn.body);
      if (data.length > 0) {
        console.log('  Function kind:', data[0].prokind);
        console.log('  Function body:');
        console.log(data[0].prosrc);
      } else {
        console.log('  No rows returned (pg_proc not exposed to anon — expected)');
      }
    } catch(e) { console.log('Body:', fn.body.substring(0, 600)); }
  } else {
    console.log('Body (pg_proc):', fn.body.substring(0, 600));
  }

  // ── 6. RAW SIGNUP — capture exact error ───────────────────────────────────
  console.log('\n══ [6] Raw signup attempt — capture exact 500 error ══');
  const testEmail = `schema_inspect_${Date.now()}@test-domain.com`;
  const signupRes = await fetch(`${SUPABASE_URL}/auth/v1/signup`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'apikey': ANON_KEY },
    body: JSON.stringify({
      email: testEmail,
      password: 'InspectOnly999!',
      data: {
        full_name: 'Schema Inspector',
        username: 'schemainspector',
        role: 'user',
        phone: '9876543210',
      }
    }),
  });
  console.log('  Signup status:', signupRes.status);
  const signupBody = await signupRes.text();
  console.log('  Signup response:', signupBody);

  // ── 7. Try with a truly unique random username to isolate username collision
  console.log('\n══ [7] Signup with random unique username ══');
  const uniqueEmail = `unique_inspect_${Date.now()}@test-domain.com`;
  const uniqueUsername = `uq_${Date.now()}_${Math.floor(Math.random()*99999)}`;
  const res2 = await fetch(`${SUPABASE_URL}/auth/v1/signup`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'apikey': ANON_KEY },
    body: JSON.stringify({
      email: uniqueEmail,
      password: 'InspectOnly999!',
      data: {
        full_name: 'Unique Inspector',
        username: uniqueUsername,
        role: 'user',
        phone: '9876543210',
      }
    }),
  });
  console.log('  Signup status (unique username):', res2.status);
  const body2 = await res2.text();
  console.log('  Signup response (unique username):', body2);

  // ── 8. Try with NO username (no metadata) — test trigger fallback ──────────
  console.log('\n══ [8] Signup with NO user_metadata — pure email fallback ══');
  const minEmail = `nometadata_${Date.now()}@test-domain.com`;
  const res3 = await fetch(`${SUPABASE_URL}/auth/v1/signup`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'apikey': ANON_KEY },
    body: JSON.stringify({ email: minEmail, password: 'InspectOnly999!' }),
  });
  console.log('  Signup status (no metadata):', res3.status);
  const body3 = await res3.text();
  console.log('  Signup response (no metadata):', body3);

  // ── 9. Check whether username column has unique constraint directly ────────
  console.log('\n══ [9] Checking profiles.username uniqueness (existing values) ══');
  const usernameCheck = await get(
    `${SUPABASE_URL}/rest/v1/profiles?username=eq.schemainspector&select=id,username,email`
  );
  console.log('  Status:', usernameCheck.status);
  console.log('  Body:', usernameCheck.body.substring(0, 400));

  const splitPartCheck = await get(
    `${SUPABASE_URL}/rest/v1/profiles?username=eq.nometadata_check&select=id,username,email`
  );
  console.log('\n[9b] Profiles with email-prefix username:');
  console.log('  Status:', splitPartCheck.status);
  console.log('  Body:', splitPartCheck.body.substring(0, 400));

  // ── 10. Sample existing profiles (to see scale + real usernames) ───────────
  console.log('\n══ [10] Sample existing profiles (limit 10) ══');
  const sampleRes = await get(
    `${SUPABASE_URL}/rest/v1/profiles?select=id,username,email,role,created_at&limit=10&order=created_at.desc`
  );
  console.log('  Status:', sampleRes.status);
  if (sampleRes.status === 200) {
    try {
      const data = JSON.parse(sampleRes.body);
      console.log(`  Returned ${data.length} profiles:`);
      data.forEach(p => console.log(`    id=${p.id?.substring(0,8)}...  username=${p.username}  role=${p.role}  email=${p.email}`));
    } catch(e) { console.log('  Body:', sampleRes.body.substring(0, 500)); }
  } else {
    console.log('  Body:', sampleRes.body.substring(0, 500));
  }

  // ── 11. Total count ────────────────────────────────────────────────────────
  console.log('\n══ [11] Total profile count ══');
  const countRes = await fetch(`${SUPABASE_URL}/rest/v1/profiles?select=id`, {
    headers: { ...BASE_HEADERS, 'Prefer': 'count=exact', 'Range': '0-0' },
  });
  console.log('  HTTP status:', countRes.status);
  console.log('  Content-Range:', countRes.headers.get('content-range'));

  console.log('\n' + '='.repeat(72));
  console.log('✅  INSPECTION COMPLETE — ZERO WRITES MADE');
  console.log('='.repeat(72));
}

main().catch(err => { console.error('Script error:', err); process.exit(1); });
