/**
 * AskExpert User Module
 * Helper functions for user accounts, questions, and dashboard stats
 */
import { supabase } from '../common/supabaseClient.js';

/**
 * Fetch profile details for a given user ID
 * @param {string} userId
 * @returns {Promise<object|null>}
 */
export async function getUserProfile(userId) {
  const { data, error } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userId)
    .single();

  if (error) {
    console.error('Error fetching user profile:', error);
    return null;
  }
  return data;
}

/**
 * Fetch questions asked by a specific user
 * @param {string} userId
 * @param {number} limit
 * @returns {Promise<Array>}
 */
export async function getUserQuestions(userId, limit = 20) {
  const { data, error } = await supabase
    .from('questions')
    .select('*')
    .eq('user_id', userId)
    .order('created_at', { ascending: false })
    .limit(limit);

  if (error) {
    console.error('Error fetching user questions:', error);
    return [];
  }
  return data || [];
}
