import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://girexuzrkeiylkbqglks.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P";

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function testOtp() {
  console.log("1. Testing phone signInWithOtp with shouldCreateUser: true...");
  const res1 = await supabase.auth.signInWithOtp({
    phone: "+919876543210",
    options: { channel: "sms", shouldCreateUser: true }
  });
  console.log("Result 1:", JSON.stringify(res1));

  console.log("\n2. Testing phone signInWithOtp with shouldCreateUser: false...");
  const res2 = await supabase.auth.signInWithOtp({
    phone: "+919876543210",
    options: { channel: "sms", shouldCreateUser: false }
  });
  console.log("Result 2:", JSON.stringify(res2));

  console.log("\n3. Testing phone signInWithOtp default (no shouldCreateUser)...");
  const res3 = await supabase.auth.signInWithOtp({
    phone: "+919876543210"
  });
  console.log("Result 3:", JSON.stringify(res3));
}

testOtp();
