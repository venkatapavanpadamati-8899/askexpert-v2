import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function findCols() {
  const potential = [
    'content', 'body', 'details', 'question', 'text', 'notes',
    'specialization', 'category_id', 'department', 'field', 'tag', 'tags',
    'updated_at', 'moderation_status', 'moderation_reason', 'author_id',
    'is_answered', 'answer_count', 'views', 'view_count'
  ];

  for (const c of potential) {
    const { error } = await supabase.from('questions').select(c).limit(1);
    if (!error) {
      console.log(`FOUND COLUMN in questions: "${c}"`);
    }
  }
}

findCols();
