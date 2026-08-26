import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = "https://girexuzrkeiylkbqglks.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P";

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

async function checkLiveDb() {
  console.log("=== CHECKING LIVE SUPABASE DATABASE STATUS ===");

  // 1. Query total profiles count
  const { data: allProfiles, count: totalCount, error: countErr } = await supabase
    .from("profiles")
    .select("*", { count: "exact" });

  if (countErr) {
    console.error("❌ Error querying profiles:", countErr.message);
  } else {
    console.log(`📊 Total profiles in public.profiles: ${totalCount}`);
  }

  // 2. Query total experts count
  const { data: experts, count: expertCount, error: expErr } = await supabase
    .from("profiles")
    .select("*", { count: "exact" })
    .eq("role", "expert");

  if (expErr) {
    console.error("❌ Error querying experts:", expErr.message);
  } else {
    console.log(`👨‍⚕️ Total experts (role='expert') in public.profiles: ${expertCount}`);
  }

  // 3. Query demo experts count
  const { data: demoExperts, count: demoCount, error: demoErr } = await supabase
    .from("profiles")
    .select("*", { count: "exact" })
    .eq("role", "expert")
    .eq("is_demo", true);

  if (demoErr) {
    console.log("⚠️ is_demo column query failed or does not exist yet:", demoErr.message);
  } else {
    console.log(`🏷️ Total demo experts (is_demo=true): ${demoCount}`);
  }
}

checkLiveDb();
