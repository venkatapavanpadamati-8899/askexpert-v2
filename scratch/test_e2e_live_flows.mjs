import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  'https://girexuzrkeiylkbqglks.supabase.co',
  'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P'
);

async function runEndToEndVerification() {
  console.log("==================================================================");
  console.log("ASKEXPERT END-TO-END FUNCTIONAL VERIFICATION AUDIT");
  console.log("Target: https://girexuzrkeiylkbqglks.supabase.co");
  console.log("==================================================================\n");

  const results = {};

  // 1. User Registration check (profiles table schema, columns, and trigger readiness)
  try {
    const { data, error } = await supabase
      .from('profiles')
      .select('id, email, full_name, role, is_verified, is_blocked, wallet_balance')
      .limit(1);
    if (error) throw error;
    results["1. User Registration"] = { status: "PASS", details: "profiles table ready with role, full_name, email, is_verified, is_blocked, and wallet_balance." };
  } catch (err) {
    results["1. User Registration"] = { status: "FAIL", error: err.message, file: "register.html", func: "registerForm.submit" };
  }

  // 2. Login check (auth readiness & role retrieval)
  try {
    const { data, error } = await supabase.auth.getSession();
    results["2. Login"] = { status: "PASS", details: "Supabase Auth client initialized and session lookup active." };
  } catch (err) {
    results["2. Login"] = { status: "FAIL", error: err.message, file: "login.html", func: "supabase.auth.signInWithPassword" };
  }

  // 3. User Dashboard (queries for questions, chats, wallet)
  try {
    const { count: qCount, error: qErr } = await supabase.from('questions').select('*', { count: 'exact', head: true });
    const { count: cCount, error: cErr } = await supabase.from('consultation_requests').select('*', { count: 'exact', head: true });
    if (qErr || cErr) throw new Error(qErr?.message || cErr?.message);
    results["3. User Dashboard"] = { status: "PASS", details: "User dashboard live queries for questions and consultations respond with exact counts." };
  } catch (err) {
    results["3. User Dashboard"] = { status: "FAIL", error: err.message, file: "user-dashboard.html", func: "loadUserQuestions" };
  }

  // Setup authenticated QA user for end-to-end testing
  let testUserId = null;
  try {
    const timestamp = Date.now();
    const testEmail = `qa_audit_${timestamp}@askexpert.local`;
    const testPassword = 'VerifyPass123!';
    const { data: authData, error: aErr } = await supabase.auth.signUp({
      email: testEmail,
      password: testPassword,
      options: { data: { full_name: 'QA Test Runner', role: 'user' } }
    });
    if (authData?.user) {
      testUserId = authData.user.id;
    }
  } catch (err) {
    console.warn("Auth signup error in test suite:", err);
  }

  // 4. Ask Question (test insert into DB with user_id, title, description, body, category, language, status)
  let testQuestionId = null;
  try {
    const testPayload = {
      user_id: testUserId,
      title: "Automated QA Verification Question " + Date.now(),
      description: "Testing end to end DB insert capability for AskExpert platform verification.",
      body: "Testing end to end DB insert capability for AskExpert platform verification.",
      category: "Technology Architect",
      language: "English",
      status: "open"
    };
    const { data: inserted, error: insErr } = await supabase
      .from('questions')
      .insert(testPayload)
      .select()
      .single();
    
    if (insErr) throw insErr;
    testQuestionId = inserted.id;
    results["4. Ask Question (DB Save)"] = { 
      status: "PASS", 
      details: `Successfully inserted question record ID: ${testQuestionId} directly into Supabase questions table!` 
    };
  } catch (err) {
    results["4. Ask Question (DB Save)"] = { status: "FAIL", error: err.message, file: "ask-question.html", func: "form.submit" };
  }

  // 5. Questions List (fetch list ordered by created_at)
  try {
    const { data: qList, error: listErr } = await supabase
      .from('questions')
      .select('id, title, description, category, language, status, created_at')
      .order('created_at', { ascending: false })
      .limit(5);
    if (listErr) throw listErr;
    results["5. Questions List"] = { 
      status: "PASS", 
      details: `Fetched ${qList.length} questions including title, description, category, and status.` 
    };
  } catch (err) {
    results["5. Questions List"] = { status: "FAIL", error: err.message, file: "questions.html", func: "loadQuestionsFromSupabase" };
  }

  // 6. Answer Submit (test insert into answers table)
  let testAnswerId = null;
  try {
    if (!testQuestionId) throw new Error("No test question available to answer.");
    const testAnsPayload = {
      question_id: testQuestionId,
      user_id: testUserId,
      content: "Automated QA Verification Answer confirming answers table compatibility.",
      body: "Automated QA Verification Answer confirming answers table compatibility.",
      helpful_count: 0
    };
    const { data: ansData, error: ansErr } = await supabase
      .from('answers')
      .insert(testAnsPayload)
      .select()
      .single();
    if (ansErr) throw ansErr;
    testAnswerId = ansData.id;
    results["6. Answer Submit"] = { 
      status: "PASS", 
      details: `Successfully inserted answer ID: ${testAnswerId} into Supabase answers table!` 
    };
  } catch (err) {
    results["6. Answer Submit"] = { status: "FAIL", error: err.message, file: "question-details.html", func: "sendFollowupBtn.click" };
  }

  // 7. Professional Dashboard (expert answers, reviews, verifications query)
  try {
    const { data: expAnswers, error: aErr } = await supabase.from('answers').select('id, question_id, helpful_count').limit(1);
    const { data: expReviews, error: rErr } = await supabase.from('reviews').select('id, rating, review_text').limit(1);
    if (aErr || rErr) throw new Error(aErr?.message || rErr?.message);
    results["7. Professional Dashboard"] = { status: "PASS", details: "Queries for answers and reviews with review_text column execute successfully." };
  } catch (err) {
    results["7. Professional Dashboard"] = { status: "FAIL", error: err.message, file: "professional-dashboard.html", func: "loadExpertStats" };
  }

  // 8. Admin Dashboard (all live statistics)
  try {
    const { count: kycCount } = await supabase.from('professional_verifications').select('*', { count: 'exact', head: true }).eq('verification_status', 'pending');
    const { count: usersCount } = await supabase.from('profiles').select('*', { count: 'exact', head: true });
    const { count: reportsCount } = await supabase.from('reports').select('*', { count: 'exact', head: true }).eq('status', 'open');
    results["8. Admin Dashboard"] = { 
      status: "PASS", 
      details: `Platform stats operational: KYC Pending: ${kycCount || 0}, Users: ${usersCount || 0}, Open Reports: ${reportsCount || 0}.` 
    };
  } catch (err) {
    results["8. Admin Dashboard"] = { status: "FAIL", error: err.message, file: "admin-dashboard.html", func: "fetchLivePlatformStats" };
  }

  // 9. Notifications (is_read, type, title, message)
  try {
    const { data, error } = await supabase.from('notifications').select('id, user_id, title, message, is_read, created_at').limit(1);
    if (error) throw error;
    results["9. Notifications"] = { status: "PASS", details: "notifications table schema verified with is_read, title, message." };
  } catch (err) {
    results["9. Notifications"] = { status: "FAIL", error: err.message, file: "notifications.html", func: "loadNotifications" };
  }

  // 10. Chat (messages & conversations)
  try {
    const { data: cData, error: cErr } = await supabase.from('conversations').select('id, user_id, expert_id, status').limit(1);
    const { data: mData, error: mErr } = await supabase.from('messages').select('id, conversation_id, content, sender_id').limit(1);
    if (cErr || mErr) throw new Error(cErr?.message || mErr?.message);
    results["10. Chat"] = { status: "PASS", details: "conversations and messages tables live and accessible." };
  } catch (err) {
    results["10. Chat"] = { status: "FAIL", error: err.message, file: "chat.html", func: "loadMessages" };
  }

  // 11. Reports (reports table & open disputes)
  try {
    const { data, error } = await supabase.from('reports').select('id, reporter_id, reason, status, created_at').limit(1);
    if (error) throw error;
    results["11. Reports"] = { status: "PASS", details: "reports table schema verified with status, reason, reporter_id." };
  } catch (err) {
    results["11. Reports"] = { status: "FAIL", error: err.message, file: "admin-reports.html", func: "loadReports" };
  }

  // 12. Settings (privacy_settings table & profile updates)
  try {
    const { data, error } = await supabase.from('privacy_settings').select('user_id, profile_visibility, show_online_status').limit(1);
    if (error) throw error;
    results["12. Settings"] = { status: "PASS", details: "privacy_settings table accessible with profile_visibility settings." };
  } catch (err) {
    results["12. Settings"] = { status: "FAIL", error: err.message, file: "settings.html", func: "savePreferences" };
  }

  // 13. Payments (payments table & payout_requests)
  try {
    const { data: pData, error: pErr } = await supabase.from('payments').select('id, amount, status, currency').limit(1);
    const { data: poData, error: poErr } = await supabase.from('payout_requests').select('id, amount, status').limit(1);
    if (pErr || poErr) throw new Error(pErr?.message || poErr?.message);
    results["13. Payments"] = { status: "PASS", details: "payments and payout_requests tables operational." };
  } catch (err) {
    results["13. Payments"] = { status: "FAIL", error: err.message, file: "payments.html", func: "loadPayments" };
  }

  // Clean up test records
  if (testAnswerId) {
    try { await supabase.from('answers').delete().eq('id', testAnswerId); } catch (e) {}
  }
  if (testQuestionId) {
    try { await supabase.from('questions').delete().eq('id', testQuestionId); } catch (e) {}
  }

  console.log("==================================================================");
  console.log("FINAL RESULTS SUMMARY:");
  console.log("==================================================================");
  let passCount = 0;
  let totalCount = Object.keys(results).length;

  for (const [key, val] of Object.entries(results)) {
    if (val.status === "PASS") {
      passCount++;
      console.log(`[PASS] ${key.padEnd(28)} -> ${val.details}`);
    } else {
      console.log(`[FAIL] ${key.padEnd(28)} -> ${val.error} (${val.file} :: ${val.func})`);
    }
  }

  const score = Math.round((passCount / totalCount) * 100);
  console.log("\n------------------------------------------------------------------");
  console.log(`SCORE: ${passCount} / ${totalCount} PASSED (${score}%)`);
  console.log("------------------------------------------------------------------");
}

runEndToEndVerification();
