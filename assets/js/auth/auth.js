/**
 * AskExpert Auth Module
 * Centralized helpers for authentication state & route protection
 */
import { supabase } from '../common/supabaseClient.js';

/**
 * Get current active session
 * @returns {Promise<object|null>}
 */
export async function getSession() {
  const { data: { session }, error } = await supabase.auth.getSession();
  if (error || !session) return null;
  return session;
}

/**
 * Check and guard authenticated routes
 * @param {string} redirectTo - Fallback page if unauthenticated
 * @returns {Promise<object>} Authenticated session
 */
export async function requireAuth(redirectTo = 'login.html') {
  const session = await getSession();
  if (!session) {
    window.location.replace(redirectTo);
    throw new Error('Unauthenticated');
  }
  return session;
}

/**
 * Sign out current user and clear local session state
 * @param {string} redirectAfter - Page to navigate after logout
 */
export async function signOut(redirectAfter = 'login.html') {
  try {
    await supabase.auth.signOut();
  } catch (err) {
    console.error('Sign out error:', err);
  } finally {
    window.location.replace(redirectAfter);
  }
}
