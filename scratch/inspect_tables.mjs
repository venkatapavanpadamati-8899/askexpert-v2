import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function inspectSchema() {
  const { data, error } = await supabase.from('questions').select('*').limit(1);
  console.log('Select * from questions result:', { data, error });

  const { data: aData, error: aError } = await supabase.from('answers').select('*').limit(1);
  console.log('Select * from answers result:', { aData, aError });

  const { data: pvData, error: pvError } = await supabase.from('professional_verifications').select('*').limit(1);
  console.log('Select * from professional_verifications result:', { pvData, pvError });

  const { data: repData, error: repError } = await supabase.from('reports').select('*').limit(1);
  console.log('Select * from reports result:', { repData, repError });

  const { data: payData, error: payError } = await supabase.from('payments').select('*').limit(1);
  console.log('Select * from payments result:', { payData, payError });
}

inspectSchema();
