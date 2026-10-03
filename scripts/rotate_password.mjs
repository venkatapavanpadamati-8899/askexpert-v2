import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const client = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function rotatePassword() {
  const { data, error } = await client.auth.signInWithPassword({
    email: 'smoke.staff@askexpert.app',
    password: 'SmokeStaff2027Secure!'
  });
  if (error) {
    console.error('Sign in error:', error.message);
    process.exit(1);
  }
  
  const newPassword = 'SmokeStaff2028Ultimate!';
  const { error: updateError } = await client.auth.updateUser({
    password: newPassword
  });
  
  if (updateError) {
    console.error('Update error:', updateError.message);
    process.exit(1);
  }
  
  console.log('Password successfully rotated to', newPassword);
}

rotatePassword();
