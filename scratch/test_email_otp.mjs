import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://girexuzrkeiylkbqglks.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P";

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function testEmailOtp() {
  console.log("Testing email signInWithOtp with shouldCreateUser: true...");
  const res1 = await supabase.auth.signInWithOtp({
    email: "test_verification@askexpert.com",
    options: { shouldCreateUser: true }
  });
  console.log("Email Result 1:", JSON.stringify(res1));

  console.log("Testing email signInWithOtp with shouldCreateUser: false...");
  const res2 = await supabase.auth.signInWithOtp({
    email: "test_verification@askexpert.com",
    options: { shouldCreateUser: false }
  });
  console.log("Email Result 2:", JSON.stringify(res2));
}

testEmailOtp();
