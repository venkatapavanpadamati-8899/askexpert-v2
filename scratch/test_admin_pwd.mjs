import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://girexuzrkeiylkbqglks.supabase.co';
const anonKey = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(supabaseUrl, anonKey);

async function testSignIn() {
  const res = await supabase.auth.signInWithPassword({
    email: 'venkatapavanpadamati1@gmail.com',
    password: 'Pavan@123'
  });

  console.log('SignIn with password result:');
  console.log('User ID:', res.data?.user?.id);
  console.log('User Email:', res.data?.user?.email);
  console.log('User App Metadata:', res.data?.user?.app_metadata);
  console.log('User User Metadata:', res.data?.user?.user_metadata);
  console.log('Error:', res.error?.message, res.error?.status);
}

testSignIn();
