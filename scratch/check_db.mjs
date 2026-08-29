import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function inspectDb() {
  console.log('Connecting to Supabase...');
  const { data: profiles, error } = await supabase.from('profiles').select('id, full_name, email, role, is_verified').limit(20);
  if (error) {
    console.error('Error fetching profiles:', error);
  } else {
    console.log('Profiles in DB:', profiles);
  }

  const { data: questions, error: qErr } = await supabase.from('questions').select('id, title, category, status').limit(5);
  if (qErr) {
    console.error('Error fetching questions:', qErr);
  } else {
    console.log('Questions in DB:', questions);
  }
}

inspectDb();
