import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function checkProfile() {
  const { data, error } = await supabase.from('profiles').select('*').eq('id', '595b0d26-f74d-4bf9-bf67-d989f1f433af').maybeSingle();
  console.log('Profile for user:', { data, error });
}

checkProfile();
