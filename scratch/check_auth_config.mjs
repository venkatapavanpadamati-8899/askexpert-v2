import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://girexuzrkeiylkbqglks.supabase.co';
const anonKey = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(supabaseUrl, anonKey);

// Check if we can view any auth or config info
try {
  const { data, error } = await supabase.from('profiles').select('count', { count: 'exact', head: true });
  console.log('Database connected:', !error);
} catch (e) {
  console.error(e);
}
