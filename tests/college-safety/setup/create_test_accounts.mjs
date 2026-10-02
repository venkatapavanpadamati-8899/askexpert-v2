// STEP 2: Create synthetic test accounts for missing test credentials
// Run: node tests/college-safety/setup/create_test_accounts.mjs
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import path from 'path';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: path.resolve(__dirname, '../.env') });

const SUPABASE_URL = process.env.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.VITE_SUPABASE_ANON_KEY;

// College B UUID (freshly created)
const COLLEGE_B_ID = 'babdedea-38d6-4976-bf51-8a3c517a6618';

const accounts = [
  {
    email: 'smoke.student.b@askexpert.app',
    password: 'SmokeStudentB2026!',
    full_name: 'Smoke Student B',
    role: 'user',
    college_id: COLLEGE_B_ID,
    label: 'Student B (College B)'
  },
  {
    email: 'smoke.unauthorized@askexpert.app',
    password: 'SmokeUnauth2026!',
    full_name: 'Smoke Unauthorized',
    role: 'user',
    college_id: null, // no college assignment — truly unauthorized
    label: 'Unauthorized User'
  }
];

const client = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

for (const account of accounts) {
  console.log(`\n▶ Creating: ${account.label} (${account.email})`);

  // Try sign-up
  const { data: signupData, error: signupErr } = await client.auth.signUp({
    email: account.email,
    password: account.password,
    options: { data: { full_name: account.full_name } }
  });

  if (signupErr) {
    if (signupErr.message.includes('already registered')) {
      console.log(`  ℹ️  Already registered — trying sign-in to confirm`);
      const { error: signinErr } = await client.auth.signInWithPassword({
        email: account.email,
        password: account.password
      });
      if (signinErr) {
        console.error(`  ❌ Sign-in also failed:`, signinErr.message);
        continue;
      }
      console.log(`  ✅ Confirmed existing account`);
    } else {
      console.error(`  ❌ Sign-up failed:`, signupErr.message);
      continue;
    }
  } else {
    console.log(`  ✅ Sign-up succeeded: ${signupData?.user?.id}`);
    // Small delay for profile trigger to fire
    await new Promise(r => setTimeout(r, 1500));
  }

  // Get session to know the user id
  const { data: { session } } = await client.auth.getSession();
  if (!session) {
    // Must sign in
    await client.auth.signInWithPassword({ email: account.email, password: account.password });
  }
  const { data: { user } } = await client.auth.getUser();
  if (!user) { console.error('  ❌ Cannot get user'); continue; }

  // Update profile
  const { error: profileErr } = await client
    .from('profiles')
    .upsert({
      id: user.id,
      email: account.email,
      full_name: account.full_name,
      role: account.role,
      college_id: account.college_id
    }, { onConflict: 'id' });

  if (profileErr) {
    console.error(`  ❌ Profile upsert failed:`, profileErr.message);
  } else {
    console.log(`  ✅ Profile set: role=${account.role}, college_id=${account.college_id}`);
  }

  await client.auth.signOut();
}

console.log('\n✅ Done. Verify accounts in Supabase Dashboard.');
