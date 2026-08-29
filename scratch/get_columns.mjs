import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function checkCols() {
  // Let's query an empty select and check keys if possible, or try common column names
  const testCols = ['id', 'user_id', 'title', 'description', 'category', 'profession', 'domain', 'topic', 'status', 'answers_count', 'created_at'];
  for (const c of testCols) {
    const { error } = await supabase.from('questions').select(c).limit(1);
    console.log(`Column "${c}":`, error ? `NOT FOUND (${error.message})` : 'EXISTS');
  }
}

checkCols();
