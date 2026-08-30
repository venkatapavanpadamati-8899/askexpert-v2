/**
 * AskExpert Admin Module
 * Helper functions for admin access guards and administrative actions
 */
import { supabase } from '../common/supabaseClient.js';

/**
 * Guard admin page - ensure logged in user has admin privileges
 * @param {string} fallbackUrl
 * @returns {Promise<object>} Admin session user
 */
export async function requireAdmin(fallbackUrl = 'admin-login.html') {
  const { data: { session }, error } = await supabase.auth.getSession();
  if (error || !session) {
    window.location.replace(fallbackUrl);
    throw new Error('Admin unauthenticated');
  }

  const { data: profile, error: pError } = await supabase
    .from('profiles')
    .select('role')
    .eq('id', session.user.id)
    .single();

  if (pError || !profile || profile.role !== 'admin') {
    window.location.replace('index.html');
    throw new Error('Unauthorized admin access');
  }

  return session.user;
}

/**
 * Fetch platform system statistics
 * @returns {Promise<object>} Stats summary
 */
export async function getSystemStats() {
  try {
    const [usersRes, expertsRes, questionsRes] = await Promise.all([
      supabase.from('profiles').select('id', { count: 'exact', head: true }).eq('role', 'user'),
      supabase.from('profiles').select('id', { count: 'exact', head: true }).eq('role', 'professional'),
      supabase.from('questions').select('id', { count: 'exact', head: true })
    ]);

    return {
      usersCount: usersRes.count || 0,
      expertsCount: expertsRes.count || 0,
      questionsCount: questionsRes.count || 0
    };
  } catch (err) {
    console.error('Failed to fetch system stats:', err);
    return { usersCount: 0, expertsCount: 0, questionsCount: 0 };
  }
}
