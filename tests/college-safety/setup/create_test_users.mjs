/**
 * ASKEXPERT — College Safety Test Fixture Creator
 * ------------------------------------------------
 * Creates the 5 test users via Supabase Admin API (signUp flow),
 * then seeds profiles, safety_staff, contacts, and one test incident per college.
 *
 * Usage:
 *   node tests/college-safety/setup/create_test_users.mjs
 *
 * Requires: SUPABASE_SERVICE_ROLE_KEY in tests/college-safety/.env
 * (add it temporarily; NEVER commit it to git)
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname  = path.dirname(__filename);
dotenv.config({ path: path.join(__dirname, '../.env') });

const SUPABASE_URL         = process.env.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY    = process.env.VITE_SUPABASE_ANON_KEY;
const SERVICE_ROLE_KEY     = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.error('Missing VITE_SUPABASE_URL or VITE_SUPABASE_ANON_KEY in .env');
  process.exit(1);
}

const anonClient = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

let adminClient = null;
if (SERVICE_ROLE_KEY) {
  adminClient = createClient(SUPABASE_URL, SERVICE_ROLE_KEY, {
    auth: { autoRefreshToken: false, persistSession: false }
  });
} else {
  console.warn('SUPABASE_SERVICE_ROLE_KEY not set. Will use signUp() (email confirmation required).\n');
}

const TEST_ACCOUNTS = [
  {
    key:      'studentA',
    email:    process.env.TEST_STUDENT_A_EMAIL,
    password: process.env.TEST_STUDENT_A_PASSWORD,
    fullName: 'TEST Student A',
    role:     'user',
    college:  'TCOL_A',
    dept:     'CSE',
    isStaff:  false,
  },
  {
    key:      'studentB',
    email:    process.env.TEST_STUDENT_B_EMAIL,
    password: process.env.TEST_STUDENT_B_PASSWORD,
    fullName: 'TEST Student B',
    role:     'user',
    college:  'TCOL_B',
    dept:     'ECE',
    isStaff:  false,
  },
  {
    key:      'staffA',
    email:    process.env.TEST_STAFF_A_EMAIL,
    password: process.env.TEST_STAFF_A_PASSWORD,
    fullName: 'TEST Safety Officer A',
    role:     'admin',
    college:  'TCOL_A',
    dept:     'Administration',
    isStaff:  true,
    staffRole:'manager',
  },
  {
    key:      'staffB',
    email:    process.env.TEST_STAFF_B_EMAIL,
    password: process.env.TEST_STAFF_B_PASSWORD,
    fullName: 'TEST Safety Officer B',
    role:     'admin',
    college:  'TCOL_B',
    dept:     'Administration',
    isStaff:  true,
    staffRole:'manager',
  },
  {
    key:      'unauthorized',
    email:    process.env.TEST_UNAUTHORIZED_EMAIL,
    password: process.env.TEST_UNAUTHORIZED_PASSWORD,
    fullName: 'Unauthorized User',
    role:     'user',
    college:  'TCOL_B',
    dept:     'ME',
    isStaff:  false,
  },
];

function ok(msg)  { console.log('OK  ' + msg); }
function fail(msg){ console.log('ERR ' + msg); }
function info(msg){ console.log('... ' + msg); }

async function ensureCollege(code, name) {
  const client = adminClient || anonClient;
  const { data: existing } = await client.from('colleges').select('id').eq('code', code).maybeSingle();
  if (existing) { ok(`College ${code} exists: ${existing.id}`); return existing.id; }
  const { data, error } = await client.from('colleges').insert({ name, code }).select('id').single();
  if (error) { fail(`College ${code} insert: ${error.message}`); return null; }
  ok(`College ${code} created: ${data.id}`);
  return data.id;
}

async function createUser(account) {
  console.log(`\n--- ${account.key} (${account.email}) ---`);
  if (adminClient) {
    const { data, error } = await adminClient.auth.admin.createUser({
      email:         account.email,
      password:      account.password,
      email_confirm: true,
      user_metadata: { full_name: account.fullName },
    });
    if (error) {
      if (error.message?.includes('already registered') || error.message?.includes('already been registered')) {
        info('User already exists — fetching ID');
        const { data: list } = await adminClient.auth.admin.listUsers();
        const existing = list?.users?.find(u => u.email === account.email);
        return existing?.id || null;
      }
      fail(`Admin createUser: ${error.message}`);
      return null;
    }
    ok(`Auth user created: ${data.user.id}`);
    return data.user.id;
  }
  const { data, error } = await anonClient.auth.signUp({
    email:    account.email,
    password: account.password,
    options:  { data: { full_name: account.fullName } },
  });
  if (error) { fail(`signUp: ${error.message}`); return null; }
  info(`signUp sent — confirm email for ${account.email}`);
  return data.user?.id || null;
}

async function upsertProfile(userId, account, collegeId) {
  const client = adminClient || anonClient;
  const { error } = await client.from('profiles').upsert({
    id: userId, full_name: account.fullName, role: account.role,
    email: account.email, college_id: collegeId, department: account.dept,
  }, { onConflict: 'id' });
  if (error) { fail(`Profile upsert (${account.key}): ${error.message}`); return false; }
  ok('Profile upserted');
  return true;
}

async function upsertSafetyStaff(userId, collegeId, staffRole) {
  const client = adminClient || anonClient;
  const { error } = await client.from('safety_staff').upsert({
    profile_id: userId, college_id: collegeId, staff_role: staffRole, is_active: true,
  }, { onConflict: 'college_id, profile_id' });
  if (error) { fail(`safety_staff upsert: ${error.message}`); return false; }
  ok(`safety_staff upserted (role: ${staffRole})`);
  return true;
}

async function seedContacts(collegeAId, collegeBId) {
  const client = adminClient || anonClient;
  const contacts = [
    { college_id: collegeAId, name: 'TEST Safety Cell',  contact_role: 'Women Safety Cell', phone: '+91-9999900001', email: 'safety@testcollegea.edu',  is_active: true },
    { college_id: collegeAId, name: 'TEST Security',      contact_role: 'Security Officer',  phone: '+91-9999900002', email: 'security@testcollegea.edu', is_active: true },
    { college_id: collegeBId, name: 'TEST Safety Cell B', contact_role: 'Women Safety Cell', phone: '+91-9999900003', email: 'safety@testcollegeb.edu',  is_active: true },
  ];
  const { error } = await client.from('safety_contacts').upsert(contacts, { onConflict: 'college_id, email' });
  if (error) { fail(`Contacts seed: ${error.message}`); } else { ok('Safety contacts seeded'); }
}

async function seedIncident(collegeId, studentId, incidentType, severity, message) {
  const client = adminClient || anonClient;
  const { data: existing } = await client.from('safety_incidents')
    .select('id').eq('student_id', studentId).eq('message', message).maybeSingle();
  if (existing) { info(`Fixture incident already exists: ${existing.id}`); return; }
  const { error } = await client.from('safety_incidents').insert({
    college_id: collegeId, student_id: studentId, incident_type: incidentType,
    severity, status: 'ACTIVE', message,
  });
  if (error) { fail(`Incident seed: ${error.message}`); } else { ok('Test incident seeded'); }
}

async function main() {
  console.log('\n=========================================');
  console.log('ASKEXPERT - Test Fixture Creator');
  console.log('=========================================\n');

  console.log('=== STEP 1: Colleges ===');
  const collegeAId = await ensureCollege('TCOL_A', 'TEST_COLLEGE_A');
  const collegeBId = await ensureCollege('TCOL_B', 'TEST_COLLEGE_B');
  if (!collegeAId || !collegeBId) { fail('Cannot proceed without college IDs'); process.exit(1); }
  const collegeMap = { 'TCOL_A': collegeAId, 'TCOL_B': collegeBId };

  console.log('\n=== STEP 2: Users + Profiles + Staff ===');
  const userIds = {};
  for (const account of TEST_ACCOUNTS) {
    const collegeId = collegeMap[account.college];
    const userId = await createUser(account);
    if (!userId) { console.log(`   Skipping profile for ${account.key}`); continue; }
    userIds[account.key] = userId;
    await upsertProfile(userId, account, collegeId);
    if (account.isStaff) await upsertSafetyStaff(userId, collegeId, account.staffRole);
  }

  console.log('\n=== STEP 3: Safety Contacts ===');
  await seedContacts(collegeAId, collegeBId);

  console.log('\n=== STEP 4: Seed Incidents ===');
  if (userIds.studentA) await seedIncident(collegeAId, userIds.studentA, 'harassment', 'HIGH', 'TEST_FIXTURE: Student A complaint for isolated testing');
  if (userIds.studentB) await seedIncident(collegeBId, userIds.studentB, 'bullying', 'MEDIUM', 'TEST_FIXTURE: Student B complaint about bullying');

  console.log('\n=== STEP 5: Login Verification ===');
  for (const account of TEST_ACCOUNTS) {
    const { data, error } = await anonClient.auth.signInWithPassword({ email: account.email, password: account.password });
    if (error) { fail(`Login verify (${account.key}): ${error.message}`); }
    else { ok(`Login verify (${account.key}) user_id=${data.user.id}`); await anonClient.auth.signOut(); }
  }

  const client = adminClient || anonClient;
  const { data: incidents } = await client.from('safety_incidents').select('id').like('message', 'TEST_FIXTURE:%');
  info(`TEST_FIXTURE incidents in DB: ${incidents?.length ?? 0}`);

  console.log('\n=========================================');
  console.log('FIXTURE SETUP COMPLETE');
  console.log('Now run: npx playwright test tests/college-safety');
  console.log('=========================================\n');
}

main().catch(err => { console.error(err); process.exit(1); });
