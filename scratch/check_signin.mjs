import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function checkSession() {
  // Let's test signing in with the user we just created
  const testEmail = 'testuser_1788014742434@askexpert.local';
  const testPassword = 'TestPassword123!';

  const { data, error } = await supabase.auth.signInWithPassword({
    email: testEmail,
    password: testPassword
  });

  console.log('SignIn result:', { session: !!data?.session, user: data?.user?.id, error });
}

checkSession();
