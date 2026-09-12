import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://girexuzrkeiylkbqglks.supabase.co';
const anonKey = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(supabaseUrl, anonKey);

async function checkEmails() {
  const { data, error } = await supabase
    .from('profiles')
    .select('*')
    .or('email.ilike.%venkatapavan%,email.ilike.%pavan%');

  console.log('Query result:', data, error);
}

checkEmails();
