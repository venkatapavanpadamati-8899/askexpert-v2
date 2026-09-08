// assets/js/supabaseClient.js
import { createClient } from '@supabase/supabase-js';

// Resolve environment variables with safe fallbacks
const SUPABASE_URL = (typeof import.meta !== 'undefined' && import.meta.env && import.meta.env.VITE_SUPABASE_URL)
  || (typeof window !== 'undefined' && window.VITE_SUPABASE_URL)
  || 'https://girexuzrkeiylkbqglks.supabase.co';

const SUPABASE_ANON_KEY = (typeof import.meta !== 'undefined' && import.meta.env && import.meta.env.VITE_SUPABASE_ANON_KEY)
  || (typeof window !== 'undefined' && window.VITE_SUPABASE_ANON_KEY)
  || 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

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

// Also attach to window for legacy inline scripts and global client access
if (typeof window !== 'undefined') {
  window.askexpertSupabase = supabase;
  window.askExpertSupabase = supabase;
  window.supabase = supabase;
}

export default supabase;
