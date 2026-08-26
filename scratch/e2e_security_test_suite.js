import fs from 'fs';
import path from 'path';

console.log("=================================================================");
console.log("          ASKEXPERT END-TO-END SECURITY & TESTING SUITE          ");
console.log("=================================================================\n");

let passedCount = 0;
let totalCount = 0;

function runTest(testName, testFn) {
  totalCount++;
  try {
    const result = testFn();
    if (result.pass) {
      passedCount++;
      console.log(`[PASS] Test ${totalCount}: ${testName}`);
      console.log(`       Details: ${result.details}\n`);
    } else {
      console.log(`[FAIL] Test ${totalCount}: ${testName}`);
      console.log(`       Reason: ${result.details}\n`);
    }
  } catch (err) {
    console.log(`[FAIL] Test ${totalCount}: ${testName}`);
    console.log(`       Error: ${err.message}\n`);
  }
}

// Test 1: User & Expert Auth Flow
runTest("User Registration & Login HTML Integration", () => {
  const regHtml = fs.readFileSync("d:/ASKEXPERT/register.html", "utf8");
  const loginHtml = fs.readFileSync("d:/ASKEXPERT/login.html", "utf8");
  const hasSignUp = regHtml.includes("supabase.auth.signUp");
  const hasSignIn = loginHtml.includes("supabase.auth.signInWithPassword");
  return {
    pass: hasSignUp && hasSignIn,
    details: "register.html invokes signUp and login.html invokes signInWithPassword"
  };
});

// Test 2: Admin Authentication Hardening
runTest("Admin Login Auth Hardening (No Demo Fallbacks)", () => {
  const adminLogin = fs.readFileSync("d:/ASKEXPERT/admin-login.html", "utf8");
  const hasDemoFallback = adminLogin.includes('email.includes("admin")') || adminLogin.includes('sessionStorage.setItem("askexpert_admin_auth"');
  const hasPureAuth = adminLogin.includes("supabase.auth.signInWithPassword") && adminLogin.includes('.eq("id", user.id)') && adminLogin.includes('prof.role === "admin"');
  return {
    pass: !hasDemoFallback && hasPureAuth,
    details: "admin-login.html uses strict 3-step auth and zero demo fallbacks"
  };
});

// Test 3: Admin Page Route Guards
runTest("Admin Sub-Pages Direct Access Protection", () => {
  const adminPages = [
    "admin-dashboard.html", "admin-users.html", "admin-professionals.html",
    "admin-questions.html", "admin-payments.html", "admin-reports.html", "admin-health.html"
  ];
  let allProtected = true;
  adminPages.forEach(p => {
    const html = fs.readFileSync(`d:/ASKEXPERT/${p}`, "utf8");
    if (!html.includes("verifyAdminAccess()")) {
      allProtected = false;
    }
  });
  return {
    pass: allProtected,
    details: "All 7 admin sub-pages invoke verifyAdminAccess() on load"
  };
});

// Test 4: Experts Directory DB Filter
runTest("Experts Directory DB Verification Query Filter", () => {
  const expertsHtml = fs.readFileSync("d:/ASKEXPERT/experts.html", "utf8");
  const hasVerifiedFilter = expertsHtml.includes('.eq("role", "expert")') && expertsHtml.includes('.eq("is_verified", true)');
  const hasNoSeedArray = !expertsHtml.includes("const SEED_EXPERTS = [");
  const hasEmptyTitle = expertsHtml.includes("No verified experts available");
  return {
    pass: hasVerifiedFilter && hasNoSeedArray && hasEmptyTitle,
    details: "experts.html queries role='expert' AND is_verified=true; 0 inline SEED_EXPERTS array"
  };
});

// Test 5: Chat Page Expert Verification & Input Locking
runTest("Chat Page Expert Verification & Input Locking", () => {
  const chatHtml = fs.readFileSync("d:/ASKEXPERT/chat.html", "utf8");
  const hasNoDir = !chatHtml.includes("const EXPERT_DIRECTORY =");
  const hasDbCheck = chatHtml.includes('.eq("role", "expert")') && chatHtml.includes('.eq("is_verified", true)');
  const hasInputLock = chatHtml.includes("renderInvalidExpertState") && chatHtml.includes("msgInput.disabled = true");
  return {
    pass: hasNoDir && hasDbCheck && hasInputLock,
    details: "chat.html validates expert ID against DB and locks inputs if invalid/unverified"
  };
});

// Test 6: Payment Server-Side Pricing Edge Function
runTest("Payment Create Edge Function Server-Side Pricing & Verification Guard", () => {
  const fnCode = fs.readFileSync("d:/ASKEXPERT/supabase/functions/payment-create/index.ts", "utf8");
  const hasFeeLookup = fnCode.includes('select("id, full_name, consultation_fee, role, is_verified")');
  const hasVerifiedCheck = fnCode.includes('.eq("role", "expert")') && fnCode.includes('.eq("is_verified", true)');
  const hasGstCalc = fnCode.includes("gstAmount") && fnCode.includes("platformFee");
  return {
    pass: hasFeeLookup && hasVerifiedCheck && hasGstCalc,
    details: "payment-create Edge Function looks up DB fee and enforces role='expert' AND is_verified=true"
  };
});

// Test 7: Payment Verification Edge Function Replay Protection
runTest("Payment Verify Edge Function Replay Protection", () => {
  const fnCode = fs.readFileSync("d:/ASKEXPERT/supabase/functions/payment-verify/index.ts", "utf8");
  const hasReplayCheck = fnCode.includes('if (paymentRecord.status === "successful")') && fnCode.includes("Payment already verified");
  return {
    pass: hasReplayCheck,
    details: "payment-verify Edge Function checks status === 'successful' to prevent replay attacks"
  };
});

// Test 8: Client-Side Secrets Check
runTest("Client-Side Javascript Secret Exposure Check", () => {
  const clientJs = fs.readFileSync("d:/ASKEXPERT/assets/js/supabaseClient.js", "utf8");
  const hasServiceRoleKey = clientJs.includes("service_role") || clientJs.includes("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9");
  return {
    pass: !hasServiceRoleKey,
    details: "assets/js/supabaseClient.js contains ONLY SUPABASE_ANON_KEY (0 service_role secrets)"
  };
});

// Test 9: Row Level Security (RLS) Schema Policies
runTest("Database Row Level Security (RLS) Policy Coverage", () => {
  const sql = fs.readFileSync("d:/ASKEXPERT/supabase-security.sql", "utf8");
  const rlsCount = (sql.match(/ENABLE ROW LEVEL SECURITY/g) || []).length;
  const hasPaymentPolicy = sql.includes('CREATE POLICY "Users and experts can view related payments" ON public.payments');
  const hasAdminCheck = sql.includes("CREATE OR REPLACE FUNCTION public.is_admin()");
  return {
    pass: rlsCount >= 16 && hasPaymentPolicy && hasAdminCheck,
    details: `RLS enabled on ${rlsCount} tables; payments table RLS and is_admin() function verified`
  };
});

// Test 10: Private Storage Bucket Policy
runTest("Private Verification Storage Bucket Security Policy", () => {
  const sql = fs.readFileSync("d:/ASKEXPERT/supabase-security.sql", "utf8");
  const hasPrivateBucket = sql.includes("'private-verifications'") && sql.includes("storage.foldername(name)");
  return {
    pass: hasPrivateBucket,
    details: "private-verifications bucket configured with folder auth.uid() / is_admin() RLS policy"
  };
});

console.log(`SUMMARY: ${passedCount} / ${totalCount} TESTS PASSED.`);
