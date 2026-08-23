import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://girexuzrkeiylkbqglks.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P";
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

(async () => {
  console.log("===================================================================");
  console.log("🔍 SUPABASE REMOTE TRIGGER ERROR DIAGNOSTIC");
  console.log("===================================================================");

  // Test 1: Minimal metadata
  const email1 = `debug_minimal_${Date.now()}@example.com`;
  console.log(`\n[TEST 1] signUp with NO user_metadata (email: ${email1})...`);
  const res1 = await supabase.auth.signUp({
    email: email1,
    password: "Password@12345"
  });
  console.log("  - Res 1 Error:", res1.error ? `${res1.error.status} ${res1.error.message} (${JSON.stringify(res1.error)})` : "SUCCESS");

  // Test 2: Unique guaranteed username
  const email2 = `debug_unique_${Date.now()}@example.com`;
  const uniqueUsername = `u_${Date.now()}_${Math.floor(Math.random()*1000)}`;
  console.log(`\n[TEST 2] signUp with UNIQUE username '${uniqueUsername}' (email: ${email2})...`);
  const res2 = await supabase.auth.signUp({
    email: email2,
    password: "Password@12345",
    options: {
      data: {
        full_name: "Debug Unique User",
        username: uniqueUsername,
        phone: "+919876543210",
        role: "user"
      }
    }
  });
  console.log("  - Res 2 Error:", res2.error ? `${res2.error.status} ${res2.error.message} (${JSON.stringify(res2.error)})` : "SUCCESS");

  // Test 3: Existing User Sign-in check
  console.log(`\n[TEST 3] Testing sign-in with any existing account...`);
  const signInRes = await supabase.auth.signInWithPassword({
    email: "test_existing@example.com",
    password: "Password@12345"
  });
  console.log("  - Sign-in Error:", signInRes.error ? signInRes.error.message : "SUCCESS");
})();
