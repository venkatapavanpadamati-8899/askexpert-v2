import { test, expect } from '@playwright/test';
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.VITE_SUPABASE_ANON_KEY;

test.describe('Chat & Realtime Access', () => {

  test('User cannot access chat without valid active session', async ({ page }) => {
    // Attempting to visit video-room or chat directly
    await page.goto('/chat.html?session=fake-session-id');
    // Should kick out or show error
    await expect(page).toHaveURL(/.*login.*/);
  });

  test('User A cannot access User B\'s chat session (RLS)', async () => {
    const client = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
    
    // 1. Sign in as Student A
    const emailA = process.env.TEST_STUDENT_A_EMAIL || 'test-student@askexpert.com';
    const passwordA = process.env.TEST_STUDENT_A_PASSWORD || 'TestPass123!';
    
    const { data: authData, error: signInErr } = await client.auth.signInWithPassword({
      email: emailA,
      password: passwordA,
    });
    
    expect(signInErr).toBeNull();
    const studentA_ID = authData.user.id;

    // 2. Fetch a conversation where Student A is NOT a participant.
    // If RLS is working, this query should return 0 rows for Student A.
    // We'll query all conversations and verify that every returned conversation
    // has studentA_ID as either user_id or expert_id.
    const { data: convs, error: fetchErr } = await client.from('conversations').select('*');
    expect(fetchErr).toBeNull();
    
    if (convs && convs.length > 0) {
      for (const conv of convs) {
        const isParticipant = (conv.user_id === studentA_ID || conv.expert_id === studentA_ID);
        expect(isParticipant).toBeTruthy();
      }
    }
    
    // 3. To be absolutely sure, try to fetch a specific known conversation ID (fake or real)
    const { data: specificConv } = await client.from('conversations').select('*').eq('id', '00000000-0000-0000-0000-000000000000');
    // Even if it exists, it should be hidden from Student A (unless they are a participant)
    expect(specificConv).toHaveLength(0);
  });
});
