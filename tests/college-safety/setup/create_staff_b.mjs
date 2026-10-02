// Create smoke.staff.b@askexpert.app for College B cross-college smoke test
// Run: node tests/college-safety/setup/create_staff_b.mjs
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import path from 'path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.resolve(__dirname, '../.env') });

const SUPABASE_URL = process.env.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.VITE_SUPABASE_ANON_KEY;

const COLLEGE_B_ID = 'babdedea-38d6-4976-bf51-8a3c517a6618';
const STAFF_B_EMAIL = 'smoke.staff.b@askexpert.app';
const STAFF_B_PASSWORD = 'SmokeStaffB2026!';

const client = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// ─── Step 1: Sign up Staff B ─────────────────────────────────────────────────
console.log(`\n▶ Creating: Staff B (College B) (${STAFF_B_EMAIL})`);
let staffBId;

const { data: signUpData, error: signUpErr } = await client.auth.signUp({
  email: STAFF_B_EMAIL,
  password: STAFF_B_PASSWORD,
  options: { data: { full_name: 'Smoke Staff B' } }
});

if (signUpErr && signUpErr.message.includes('already registered')) {
  console.log('  ℹ️  Already registered — signing in to get ID');
  const { data: signInData, error: signInErr } = await client.auth.signInWithPassword({
    email: STAFF_B_EMAIL, password: STAFF_B_PASSWORD
  });
  if (signInErr) { console.error('  ❌ Sign-in failed:', signInErr.message); process.exit(1); }
  staffBId = signInData.user.id;
  console.log('  ✅ Confirmed existing account, ID:', staffBId);
} else if (signUpErr) {
  console.error('  ❌ Sign-up failed:', signUpErr.message); process.exit(1);
} else {
  staffBId = signUpData.user.id;
  console.log('  ✅ Signed up, ID:', staffBId);
}

await client.auth.signOut();

// ─── Step 2: Sign in as Staff A (admin) to assign college_id & role ──────────
console.log('\n▶ Signing in as Staff A (admin) to assign college_id to Staff B...');
const { error: adminSignInErr } = await client.auth.signInWithPassword({
  email: process.env.TEST_STAFF_A_EMAIL,
  password: process.env.TEST_STAFF_A_PASSWORD
});
if (adminSignInErr) { console.error('❌ Admin sign-in failed:', adminSignInErr.message); process.exit(1); }

// Upsert profile for Staff B
const { error: profileErr } = await client.from('profiles').upsert({
  id: staffBId,
  email: STAFF_B_EMAIL,
  role: 'admin',
  college_id: COLLEGE_B_ID,
  full_name: 'Smoke Staff B'
}, { onConflict: 'id' });

if (profileErr) {
  console.error('  ❌ Profile upsert failed:', profileErr.message);
} else {
  console.log('  ✅ Profile set: role=admin, college_id=' + COLLEGE_B_ID);
}

// ─── Step 3: Insert safety_staff mapping ─────────────────────────────────────
const { error: ssErr } = await client.from('safety_staff').upsert({
  profile_id: staffBId,
  college_id: COLLEGE_B_ID,
  is_active: true
}, { onConflict: 'profile_id,college_id' });

if (ssErr) {
  console.error('  ❌ safety_staff upsert failed:', ssErr.message);
} else {
  console.log('  ✅ safety_staff mapping created');
}

await client.auth.signOut();

// ─── Step 4: Verify ───────────────────────────────────────────────────────────
console.log('\n▶ Verifying Staff B...');
const { error: verifySignInErr } = await client.auth.signInWithPassword({
  email: STAFF_B_EMAIL, password: STAFF_B_PASSWORD
});
if (verifySignInErr) {
  console.error('  ❌ Verify sign-in failed:', verifySignInErr.message);
} else {
  const { data: profile } = await client.from('profiles').select('email, role, college_id').eq('id', staffBId).single();
  const { data: ss } = await client.from('safety_staff').select('profile_id, college_id, is_active').eq('profile_id', staffBId).single();
  console.log('  Profile:', profile);
  console.log('  safety_staff:', ss);
  console.log('\n✅ Staff B ready. Add to .env:');
  console.log(`TEST_STAFF_B_EMAIL=${STAFF_B_EMAIL}`);
  console.log(`TEST_STAFF_B_PASSWORD=${STAFF_B_PASSWORD}`);
}

await client.auth.signOut();
