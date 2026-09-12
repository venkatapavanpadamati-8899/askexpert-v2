import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://girexuzrkeiylkbqglks.supabase.co';
const anonKey = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(supabaseUrl, anonKey);

async function testProfileInsert() {
  const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
    email: 'venkatapavanpadamati1@gmail.com',
    password: 'Pavan@123'
  });

  if (authError || !authData.user) {
    console.error('Sign in failed:', authError);
    return;
  }

  const userId = authData.user.id;
  console.log('Authenticated as:', userId);

  // Check if profile exists
  const { data: existingProf, error: fetchErr } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userId)
    .maybeSingle();

  console.log('Existing profile:', existingProf, fetchErr);

  // Try to upsert profile
  const { data: upsertData, error: upsertErr } = await supabase
    .from('profiles')
    .upsert({
      id: userId,
      email: 'venkatapavanpadamati1@gmail.com',
      full_name: 'VenkataPavan Padamati (Admin)',
      role: 'admin',
      is_verified: true,
      account_status: 'active',
      is_blocked: false
    })
    .select();

  console.log('Upsert result:', upsertData, upsertErr);
}

testProfileInsert();
