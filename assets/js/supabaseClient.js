// assets/js/supabaseClient.js
import { createClient } from '@supabase/supabase-js';

// Support Vercel / Vite environment variables with robust fallback defaults
const getEnvVar = (key, defaultValue) => {
  if (typeof import.meta !== 'undefined' && import.meta.env && import.meta.env[key]) {
    return import.meta.env[key];
  }
  if (typeof process !== 'undefined' && process.env && process.env[key]) {
    return process.env[key];
  }
  if (typeof window !== 'undefined' && window.env && window.env[key]) {
    return window.env[key];
  }
  return defaultValue;
};

export const SUPABASE_URL = getEnvVar("VITE_SUPABASE_URL", "https://girexuzrkeiylkbqglks.supabase.co");
export const SUPABASE_ANON_KEY = getEnvVar("VITE_SUPABASE_ANON_KEY", "sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P");

// Create and export singleton client instance
export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
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
});

// Also attach to window for easy access in scripts if needed
if (typeof window !== "undefined") {
  window.askexpertSupabase = supabase;
}

export default supabase;

