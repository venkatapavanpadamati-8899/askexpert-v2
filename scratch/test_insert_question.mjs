import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function testInsert() {
  const payload = {
    user_id: '0ee7fcaa-3ce5-4206-8982-703fdd2aff65',
    title: 'How to register a Private Limited Company in Telangana?',
    body: 'Looking for verified legal advisory on MCA ROC filing and GST registration timeline.',
    status: 'open',
    tags: ['Legal Advisor']
  };

  const { data, error } = await supabase.from('questions').insert(payload).select().single();
  console.log('Insert result:', { data, error });
}

testInsert();
