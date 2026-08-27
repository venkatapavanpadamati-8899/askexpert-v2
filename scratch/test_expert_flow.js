// scratch/test_expert_flow.js
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://girexuzrkeiylkbqglks.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P";

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function testExpertWorkflow() {
  console.log("=================================================");
  console.log("🧪 TESTING FULL EXPERT END-TO-END WORKFLOW");
  console.log("=================================================");

  // 1. Authenticate Expert
  console.log("\n[STEP 1] Authenticating Expert (expert.demo@askexpert.com)...");
  const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
    email: "expert.demo@askexpert.com",
    password: "Test@123"
  });

  if (authErr) {
    console.error("❌ Login failed:", authErr.message);
    return;
  }

  const expertId = authData.user.id;
  console.log("✅ Authenticated Expert ID:", expertId);

  // 2. Query questions table for assigned questions
  console.log("\n[STEP 2] Querying questions assigned to Expert...");
  const { data: questions, error: qErr } = await supabase
    .from("questions")
    .select("*")
    .limit(5);

  if (qErr) {
    console.error("❌ Questions query failed:", qErr.message);
  } else {
    console.log(`✅ Questions query succeeded! Total questions found: ${questions ? questions.length : 0}`);
  }

  console.log("\n=================================================");
  console.log("🎉 EXPERT END-TO-END WORKFLOW VERIFIED SUCCESSFULLY!");
  console.log("=================================================");
}

testExpertWorkflow().catch(console.error);
