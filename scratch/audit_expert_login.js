// scratch/audit_expert_login.js
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://girexuzrkeiylkbqglks.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P";

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: { persistSession: false }
});

async function runAudit() {
  console.log("=================================================");
  console.log("🔒 EXPERT LOGIN & SUPABASE AUTH AUDIT");
  console.log("=================================================");

  const targetEmail = "expert.test@askexpert.com";
  const targetPassword = "Test@123";

  console.log(`[AUDIT 1] Testing signInWithPassword for ${targetEmail}...`);
  const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({
    email: targetEmail,
    password: targetPassword
  });

  if (signInError) {
    console.error("❌ signInWithPassword Failed:", signInError.message, signInError);
  } else {
    console.log("✅ signInWithPassword Succeeded!");
    console.log("  - User ID:", signInData.user?.id);
    console.log("  - Email:", signInData.user?.email);
    console.log("  - Email Confirmed At:", signInData.user?.email_confirmed_at);
  }

  console.log(`\n[AUDIT 2] Inspecting public.profiles for ${targetEmail}...`);
  const { data: profiles, error: profileError } = await supabase
    .from('profiles')
    .select('*')
    .eq('email', targetEmail);

  if (profileError) {
    console.error("❌ Profile Query Failed:", profileError.message);
  } else {
    console.log(` Found ${profiles ? profiles.length : 0} matching profile(s):`);
    console.log(JSON.stringify(profiles, null, 2));
  }

  console.log("\n=================================================");
}

runAudit().catch(err => console.error("Fatal audit error:", err));
