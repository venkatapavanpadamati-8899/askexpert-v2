// assets/js/supabaseClient.js
import { createClient } from '@supabase/supabase-js';

// Resolve environment variables — NO hardcoded fallbacks in production
const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.error(
    '[AskExpert] Supabase environment variables are missing. ' +
    'Set VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY in your .env file or Vercel project settings.'
  );
}

export { SUPABASE_URL, SUPABASE_ANON_KEY };

// Create and export singleton client instance
export const supabase = (SUPABASE_URL && SUPABASE_ANON_KEY)
  ? createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
      auth: {
        persistSession: true,
        autoRefreshToken: true,
        detectSessionInUrl: true
      },
      realtime: {
        params: {
          eventsPerSecond: 10
        }
      }
    })
  : null;

// Also attach to window for legacy inline scripts
if (typeof window !== 'undefined') {
  window.askexpertSupabase = supabase;
}

export default supabase;
