import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://girexuzrkeiylkbqglks.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P";

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function testTriggerEndToEnd() {
  console.log("=== TASK 1: REAL REGISTRATION + TRIGGER TEST ===");

  const testEmail = `test_trigger_${Date.now()}@askexpert.com`;
  const testPassword = "TestPassword123!";
  const testFullName = "Automated Trigger Test User";

  console.log(`1. Attempting signUp for: ${testEmail}...`);
  const { data, error } = await supabase.auth.signUp({
    email: testEmail,
    password: testPassword,
    options: {
      data: {
        full_name: testFullName,
        role: "user",
        username: `trig_${Date.now()}`
      }
    }
  });

  if (error) {
    console.error("❌ Registration error:", error.message);
    return false;
  }

  const userId = data.user?.id;
  console.log(`✅ Registration successful! Created auth.users ID: ${userId}`);

  // 2. Query public.profiles to verify if handle_new_user() trigger automatically generated the profile!
  console.log("2. Verifying public.profiles automatic row creation via handle_new_user() trigger...");
  
  // Wait 1 sec for trigger to finish execution
  await new Promise(r => setTimeout(r, 1500));

  const { data: profile, error: profErr } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", userId)
    .single();

  if (profErr || !profile) {
    console.error("❌ Trigger failed: Profile row not found in public.profiles! Error:", profErr?.message);
    return false;
  }

  console.log("🎉 TRIGGER TEST SUCCESSFUL!");
  console.log("   Profile Record Created by Trigger:", {
    id: profile.id,
    full_name: profile.full_name,
    email: profile.email,
    role: profile.role,
    username: profile.username,
    created_at: profile.created_at
  });

  return true;
}

testTriggerEndToEnd();
