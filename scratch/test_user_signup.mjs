import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function testSignupAndInsert() {
  const timestamp = Date.now();
  const testEmail = `testuser_${timestamp}@askexpert.local`;
  const testPassword = 'TestPassword123!';

  console.log(`1. Signing up test user: ${testEmail}...`);
  const { data: authData, error: authErr } = await supabase.auth.signUp({
    email: testEmail,
    password: testPassword,
    options: {
      data: {
        full_name: 'Test Client User',
        role: 'user'
      }
    }
  });

  if (authErr) {
    console.error('Sign up error:', authErr);
    return;
  }

  const user = authData.user;
  console.log('User created:', user.id);

  // Upsert profile
  console.log('2. Upserting profile...');
  const { error: profErr } = await supabase.from('profiles').upsert({
    id: user.id,
    full_name: 'Test Client User',
    email: testEmail,
    role: 'user'
  });
  if (profErr) console.warn('Profile upsert warning:', profErr);

  // Now insert question with authenticated session!
  console.log('3. Inserting question with authenticated user session...');
  const { data: qData, error: qErr } = await supabase.from('questions').insert({
    user_id: user.id,
    title: 'How to register a Private Limited Company in Telangana?',
    body: 'Looking for verified legal advisory on MCA ROC filing and GST registration timeline.',
    status: 'open',
    tags: ['Legal Advisor']
  }).select().single();

  if (qErr) {
    console.error('Question insert error:', qErr);
  } else {
    console.log('✓ Question successfully inserted into Supabase questions table!', qData);
  }
}

testSignupAndInsert();
