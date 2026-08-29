import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function findAnswerCols() {
  const potential = [
    'id', 'question_id', 'user_id', 'expert_id', 'author_id', 'content', 'body', 'text', 'answer',
    'helpful_count', 'upvotes', 'votes', 'created_at', 'updated_at'
  ];

  for (const c of potential) {
    const { error } = await supabase.from('answers').select(c).limit(1);
    if (!error) {
      console.log(`FOUND COLUMN in answers: "${c}"`);
    }
  }
}

findAnswerCols();
