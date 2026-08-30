/**
 * AskExpert Professional Module
 * Helper functions for experts, verification states, and consultations
 */
import { supabase } from '../common/supabaseClient.js';

/**
 * Fetch professional profile and verification status
 * @param {string} expertId
 * @returns {Promise<object|null>}
 */
export async function getProfessionalProfile(expertId) {
  const { data, error } = await supabase
    .from('profiles')
    .select('*, professional_verifications(*)')
    .eq('id', expertId)
    .eq('role', 'professional')
    .single();

  if (error) {
    console.error('Error fetching professional profile:', error);
    return null;
  }
  return data;
}

/**
 * Fetch consultation requests for an expert
 * @param {string} expertId
 * @returns {Promise<Array>}
 */
export async function getConsultations(expertId) {
  const { data, error } = await supabase
    .from('consultation_requests')
    .select('*')
    .eq('professional_id', expertId)
    .order('created_at', { ascending: false });

  if (error) {
    console.error('Error fetching consultations:', error);
    return [];
  }
  return data || [];
}
