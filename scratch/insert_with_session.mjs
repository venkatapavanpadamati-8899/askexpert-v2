import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function insertWithSession() {
  const testEmail = 'testuser_1788014742434@askexpert.local';
  const testPassword = 'TestPassword123!';

  const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
    email: testEmail,
    password: testPassword
  });

  if (authErr) {
    console.error('Sign in failed:', authErr);
    return;
  }

  console.log('Logged in user:', authData.user.id);

  // Now insert a question
  const { data: qData, error: qErr } = await supabase.from('questions').insert({
    user_id: authData.user.id,
    title: 'How to register a Private Limited Company in Telangana?',
    body: 'Looking for verified legal advisory on MCA ROC filing and GST registration timeline.',
    status: 'open',
    tags: ['Legal Advisor']
  }).select().single();

  if (qErr) {
    console.error('Question insert error:', qErr);
  } else {
    console.log('✓ SUCCESS! Question inserted into Supabase:', qData);
  }
}

insertWithSession();
