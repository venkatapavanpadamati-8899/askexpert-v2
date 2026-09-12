import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://girexuzrkeiylkbqglks.supabase.co';
const anonKey = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(supabaseUrl, anonKey);

async function updateUserMeta() {
  const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
    email: 'venkatapavanpadamati1@gmail.com',
    password: 'Pavan@123'
  });

  if (authError || !authData.user) {
    console.error('Sign in failed:', authError);
    return;
  }

  const { data: updateData, error: updateErr } = await supabase.auth.updateUser({
    data: {
      role: 'admin',
      full_name: 'VenkataPavan Padamati (Admin)'
    }
  });

  console.log('Update user metadata result:', updateData?.user?.user_metadata, updateErr);
}

updateUserMeta();
