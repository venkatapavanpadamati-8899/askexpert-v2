import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  'https://girexuzrkeiylkbqglks.supabase.co',
  'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P'
);

async function checkDatabaseHealth() {
  console.log("=== COMPREHENSIVE LIVE SUPABASE DB HEALTH CHECK ===\n");
  let errorCount = 0;
  let successCount = 0;

  // 1. Check profiles table & columns
  console.log("1. Checking 'profiles' table...");
  const { data: profData, error: profErr } = await supabase.from('profiles').select('id, email, full_name, role, is_verified, is_blocked').limit(1);
  if (profErr) {
    console.log("  ❌ Error in profiles:", profErr.message);
    errorCount++;
  } else {
    console.log("  ✅ profiles OK (is_verified, is_blocked accessible)");
    successCount++;
  }

  // 2. Check professional_verifications
  console.log("2. Checking 'professional_verifications' table...");
  const { data: verifData, error: verifErr } = await supabase.from('professional_verifications').select('id, expert_id, council_registration_no, verification_status').limit(1);
  if (verifErr) {
    console.log("  ❌ Error in professional_verifications:", verifErr.message);
    errorCount++;
  } else {
    console.log("  ✅ professional_verifications OK");
    successCount++;
  }

  // 3. Check questions table: body vs description
  console.log("3. Checking 'questions' table columns...");
  const { data: qBodyData, error: qBodyErr } = await supabase.from('questions').select('id, user_id, title, body, status').limit(1);
  if (qBodyErr) {
    console.log("  ❌ Error selecting body from questions:", qBodyErr.message);
    errorCount++;
  } else {
    console.log("  ✅ questions(body, title, status) OK");
    successCount++;
  }

  const { data: qDescData, error: qDescErr } = await supabase.from('questions').select('description, category').limit(1);
  if (qDescErr) {
    console.log("  ⚠️ questions(description, category) NOT in DB yet:", qDescErr.message);
    console.log("     -> SQL patch needs to be run if you want description/category columns directly in Supabase.");
  } else {
    console.log("  ✅ questions(description, category) OK (Patch applied!)");
    successCount++;
  }

  // 4. Check answers table: expert_id vs user_id
  console.log("4. Checking 'answers' table columns...");
  const { data: aExpData, error: aExpErr } = await supabase.from('answers').select('id, question_id, expert_id, body').limit(1);
  if (aExpErr) {
    console.log("  ❌ Error selecting expert_id from answers:", aExpErr.message);
    errorCount++;
  } else {
    console.log("  ✅ answers(expert_id, body) OK");
    successCount++;
  }

  const { data: aUserData, error: aUserErr } = await supabase.from('answers').select('user_id').limit(1);
  if (aUserErr) {
    console.log("  ⚠️ answers(user_id) NOT in DB yet:", aUserErr.message);
  } else {
    console.log("  ✅ answers(user_id) OK (Patch applied!)");
    successCount++;
  }

  // 5. Check reviews
  console.log("5. Checking 'reviews' table...");
  const { data: revData, error: revErr } = await supabase.from('reviews').select('id, expert_id, user_id, rating, comment').limit(1);
  if (revErr) {
    console.log("  ❌ Error in reviews:", revErr.message);
    errorCount++;
  } else {
    console.log("  ✅ reviews OK");
    successCount++;
  }

  // 6. Check consultation_requests
  console.log("6. Checking 'consultation_requests' table...");
  const { data: crData, error: crErr } = await supabase.from('consultation_requests').select('id, user_id, expert_id, status').limit(1);
  if (crErr) {
    console.log("  ❌ Error in consultation_requests:", crErr.message);
    errorCount++;
  } else {
    console.log("  ✅ consultation_requests OK");
    successCount++;
  }

  // 7. Check payments
  console.log("7. Checking 'payments' table...");
  const { data: payData, error: payErr } = await supabase.from('payments').select('id, user_id, amount, status').limit(1);
  if (payErr) {
    console.log("  ❌ Error in payments:", payErr.message);
    errorCount++;
  } else {
    console.log("  ✅ payments OK");
    successCount++;
  }

  // 8. Check reports
  console.log("8. Checking 'reports' table...");
  const { data: repData, error: repErr } = await supabase.from('reports').select('id, reporter_id, reason, status').limit(1);
  if (repErr) {
    console.log("  ❌ Error in reports:", repErr.message);
    errorCount++;
  } else {
    console.log("  ✅ reports OK");
    successCount++;
  }

  // 9. Check system_errors table
  console.log("9. Checking 'system_errors' table...");
  const { data: seData, error: seErr } = await supabase.from('system_errors').select('id, error_message, status').limit(1);
  if (seErr) {
    console.log("  ⚠️ system_errors table NOT in DB yet:", seErr.message);
    console.log("     -> Run production_fix.sql in Supabase to create system_errors.");
  } else {
    console.log("  ✅ system_errors table OK (Patch applied!)");
    successCount++;
  }

  // 10. Check messages & conversations
  console.log("10. Checking 'messages' and 'conversations' tables...");
  const { data: msgData, error: msgErr } = await supabase.from('messages').select('id, conversation_id, content').limit(1);
  const { data: convData, error: convErr } = await supabase.from('conversations').select('id, user_id, expert_id').limit(1);
  if (msgErr || convErr) {
    console.log("  ❌ Error in chat tables:", msgErr?.message || convErr?.message);
    errorCount++;
  } else {
    console.log("  ✅ messages & conversations OK");
    successCount++;
  }

  console.log("\n==========================================");
  console.log(`SUMMARY: ${successCount} verified OK, ${errorCount} hard errors.`);
  console.log("==========================================");
}

checkDatabaseHealth();
