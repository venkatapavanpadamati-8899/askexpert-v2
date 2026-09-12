import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://girexuzrkeiylkbqglks.supabase.co';
const anonKey = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(supabaseUrl, anonKey);

async function inspectProfiles() {
  const { data, error } = await supabase
    .from('profiles')
    .select('id, email, full_name, role, is_verified, account_status')
    .order('id', { ascending: false })
    .limit(20);

  console.log('Total recent profiles:', data?.length, error);
  console.log('Profiles:', data);
}

inspectProfiles();
