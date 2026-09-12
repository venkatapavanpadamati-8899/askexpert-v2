import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://girexuzrkeiylkbqglks.supabase.co';
const anonKey = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(supabaseUrl, anonKey);

async function checkAuthSchema() {
  const { data, error } = await supabase.rpc('get_auth_tables_test');
  console.log('rpc result:', data, error);
}

checkAuthSchema();
