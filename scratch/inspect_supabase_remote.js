import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://girexuzrkeiylkbqglks.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P";

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

(async () => {
  console.log("===================================================================");
  console.log("🔍 SUPABASE REMOTE DATABASE & AUTH DIAGNOSTIC AUDIT");
  console.log("===================================================================");

  const testEmail = `audit_check_${Date.now()}@example.com`;
  const testPassword = "AuditTestPassword@2026";

  console.log(`\n[DIAGNOSTIC 1] Testing direct supabase.auth.signUp() with email: ${testEmail}...`);
  const signUpRes = await supabase.auth.signUp({
    email: testEmail,
    password: testPassword,
    options: {
      data: {
        full_name: "Audit Diagnostic User",
        username: `audit_user_${Date.now()}`,
        phone: "9876543210",
        role: "user"
      }
    }
  });

  console.log("  - SignUp Data User ID:", signUpRes.data?.user?.id || "NONE");
  console.log("  - SignUp Data Session:", signUpRes.data?.session ? "SESSION CREATED" : "NO SESSION (Requires Email Confirmation / Unconfirmed)");
  console.log("  - SignUp Error:", signUpRes.error ? signUpRes.error.message : "NONE");

  if (signUpRes.data?.user) {
    const userId = signUpRes.data.user.id;

    console.log(`\n[DIAGNOSTIC 2] Querying public.profiles by ID (${userId})...`);
    const profileById = await supabase.from("profiles").select("*").eq("id", userId);
    console.log("  - Profile by ID Result:", JSON.stringify(profileById));

    console.log(`\n[DIAGNOSTIC 3] Querying public.profiles by Email (${testEmail})...`);
    const profileByEmail = await supabase.from("profiles").select("*").eq("email", testEmail);
    console.log("  - Profile by Email Result:", JSON.stringify(profileByEmail));

    console.log("\n[DIAGNOSTIC 4] Attempting direct client-side INSERT/UPSERT to public.profiles...");
    const upsertRes = await supabase.from("profiles").upsert({
      id: userId,
      full_name: "Audit Diagnostic User",
      username: `audit_user_${Date.now()}`,
      email: testEmail,
      phone: "9876543210",
      role: "user"
    });
    console.log("  - Upsert Result Error:", upsertRes.error ? upsertRes.error.message : "SUCCESS (No RLS Block on Insert)");
  }

  console.log("\n===================================================================");
  console.log("🎯 DIAGNOSTIC ANALYSIS COMPLETE");
  console.log("===================================================================");
})();
