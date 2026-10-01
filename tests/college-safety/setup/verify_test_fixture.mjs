import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.join(__dirname, '../.env') });

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error("Missing environment variables.");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

const accounts = [
  { email: process.env.TEST_STUDENT_A_EMAIL, password: process.env.TEST_STUDENT_A_PASSWORD, name: "Student A" },
  { email: process.env.TEST_STUDENT_B_EMAIL, password: process.env.TEST_STUDENT_B_PASSWORD, name: "Student B" },
  { email: process.env.TEST_STAFF_A_EMAIL, password: process.env.TEST_STAFF_A_PASSWORD, name: "Staff A" },
  { email: process.env.TEST_STAFF_B_EMAIL, password: process.env.TEST_STAFF_B_PASSWORD, name: "Staff B" },
  { email: process.env.TEST_UNAUTHORIZED_EMAIL, password: process.env.TEST_UNAUTHORIZED_PASSWORD, name: "Unauthorized" }
];

async function run() {
  console.log("=========================================");
  console.log("PHASE 4: DATABASE READ-ONLY DIAGNOSTICS");
  console.log("=========================================\n");

  for (const account of accounts) {
    console.log(`--- Checking ${account.name} (${account.email}) ---`);
    const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
      email: account.email,
      password: account.password,
    });

    if (authError || !authData.user) {
      console.log(`❌ Auth Failed:`, JSON.stringify(authError, null, 2));
      continue;
    }
    const user = authData.user;
    console.log(`✅ Auth Success. user_id: ${user.id}`);

    const { data: profile, error: profileError } = await supabase.from('profiles').select('*').eq('id', user.id).single();
    if (profileError) {
      console.log(`⚠️ Profile Error: ${profileError.message} (Code: ${profileError.code})`);
      console.log(`   Could be RLS or missing profile.`);
    } else {
      console.log(`✅ Profile Exists.`);
      console.log(`   - profile_role: ${profile.role}`);
      console.log(`   - college_id: ${profile.college_id ? profile.college_id : 'null'}`);
      console.log(`   - college_id_present: ${!!profile.college_id}`);
      console.log(`   - department: ${profile.department}`);
    }

    const { data: safetyStaff, error: staffError } = await supabase.from('safety_staff').select('*').eq('profile_id', user.id);
    if (staffError) {
      console.log(`⚠️ Safety Staff Error: ${staffError.message}`);
    } else if (safetyStaff && safetyStaff.length > 0) {
      const staff = safetyStaff[0];
      console.log(`✅ Safety Staff Exists.`);
      console.log(`   - safety_staff_college_match: ${profile && staff.college_id === profile.college_id}`);
      console.log(`   - safety_staff_active: ${staff.is_active}`);
      console.log(`   - safety_staff_role: ${staff.staff_role}`);
    } else {
      console.log(`ℹ️ No safety_staff record.`);
    }

    await supabase.auth.signOut();
    console.log("");
  }

  console.log("--- Checking Colleges ---");
  const { data: colleges, error: colError } = await supabase.from('colleges').select('id, code, name').in('code', ['TCOL_A', 'TCOL_B']);
  if (colError) console.log(`Colleges Error: ${colError.message}`);
  else {
    for (const c of colleges) {
      console.log(`College: ${c.code} -> ${c.id}`);
    }
  }

  console.log("\n--- Checking Incidents ---");
  const { data: incidents, error: incError } = await supabase.from('safety_incidents').select('id, incident_type').like('message', 'TEST_FIXTURE:%');
  if (incError) console.log(`Incidents Error: ${incError.message}`);
  else {
    console.log(`Found ${incidents.length} TEST_FIXTURE incidents.`);
  }

  console.log("=========================================\n");
}

run();
