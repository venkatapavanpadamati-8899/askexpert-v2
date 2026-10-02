// Assign Student B to College B via smoke.staff (admin) account
// Run: node tests/college-safety/setup/assign_student_b.mjs
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import path from 'path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.resolve(__dirname, '../.env') });

const SUPABASE_URL = process.env.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.VITE_SUPABASE_ANON_KEY;

const COLLEGE_B_ID = 'babdedea-38d6-4976-bf51-8a3c517a6618';
const STUDENT_B_ID = '133343de-337b-439f-9d42-f2838e3d659a';

const client = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Sign in as smoke.staff (admin)
const { error: signInErr } = await client.auth.signInWithPassword({
  email: process.env.TEST_STAFF_A_EMAIL,
  password: process.env.TEST_STAFF_A_PASSWORD,
});
if (signInErr) { console.error('Sign-in failed:', signInErr.message); process.exit(1); }

const { data: { user } } = await client.auth.getUser();
console.log('Signed in as:', user?.email, '(admin check)');

// Check if current user is admin
const { data: profile } = await client.from('profiles').select('role').eq('id', user.id).single();
console.log('Staff role:', profile?.role);

// Update Student B's college_id as admin
const { error: updateErr } = await client
  .from('profiles')
  .update({ college_id: COLLEGE_B_ID })
  .eq('id', STUDENT_B_ID);

if (updateErr) {
  console.error('Update failed:', updateErr.message);
} else {
  console.log('✅ Student B assigned to College B:', COLLEGE_B_ID);
}

// Verify
const { data: verify } = await client
  .from('profiles')
  .select('email, college_id, role')
  .eq('id', STUDENT_B_ID)
  .single();
console.log('Verification:', verify);

await client.auth.signOut();
