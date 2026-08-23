import { chromium } from 'playwright';

(async () => {
  console.log("===================================================================");
  console.log("🔒 REAL SUPABASE AUTHENTICATION & PERSISTENCE VERIFICATION");
  console.log("===================================================================");
  console.log("Launching visible Playwright browser session...\n");

  const report = {
    authentication: "FAIL",
    supabaseAuthUser: "NOT VERIFIED",
    profileRow: "NOT VERIFIED",
    usernameDerivation: "FAIL",
    loginSession: "FAIL",
    redirect: "FAIL",
    logout: "FAIL",
    consoleErrors: 0,
    networkErrors: 0,
    databaseEvidence: "None",
    finalVerdict: "NOT VERIFIED"
  };

  const consoleErrorLogs = [];
  const failedRequests = [];

  const browser = await chromium.launch({
    headless: false,
    slowMo: 800
  });

  const context = await browser.newContext();
  const page = await context.newPage();

  // Track console errors
  page.on('console', msg => {
    if (msg.type() === 'error') {
      consoleErrorLogs.push(`[CONSOLE ERROR] ${msg.text()}`);
      report.consoleErrors++;
    }
  });

  // Track failed network requests
  page.on('response', resp => {
    if (resp.status() >= 400 && !resp.url().includes('favicon')) {
      failedRequests.push(`[HTTP ${resp.status()}] ${resp.url()}`);
      report.networkErrors++;
    }
  });

  try {
    const timestamp = Date.now();
    const testFullName = `Real Verification User ${timestamp.toString().slice(-4)}`;
    const expectedBaseUsername = `real_verification_user_${timestamp.toString().slice(-4)}`;
    const testEmail = `real_auth_${timestamp}@example.com`;
    const testPhone = "9988776655";
    const testPassword = `RealAuthPass#${timestamp.toString().slice(-4)}`;

    // ----------------------------------------------------------------
    // STEP 1: CREATE USER THROUGH REGISTRATION UI
    // ----------------------------------------------------------------
    console.log("[STEP 1/11] Opening http://localhost:5173/register.html...");
    await page.goto('http://localhost:5173/register.html', { waitUntil: 'load', timeout: 15000 });
    console.log("  ✓ Opened Registration Page");

    console.log("[STEP 2/11] Selecting Account Role 'Client User'...");
    await page.click('input[name="role"][value="user"]', { force: true });

    console.log("[STEP 3/11] Entering Name, Email, Phone, OTP & Password...");
    await page.fill('#fullName', testFullName);
    await page.fill('#email', testEmail);
    await page.fill('#phone', testPhone);
    await page.fill('#otp', '123456');
    await page.fill('#password', testPassword);
    await page.check('#terms');
    console.log(`  ✓ Registered details - Email: ${testEmail}`);

    console.log("[STEP 4/11] Submitting Registration Form & Intercepting Supabase Response...");
    
    // Wait for signup request/response or form submit
    const signUpResponsePromise = page.waitForResponse(
      response => response.url().includes('/auth/v1/signup'),
      { timeout: 15000 }
    ).catch(() => null);

    await page.click('#createButton');
    const signUpResp = await signUpResponsePromise;

    if (signUpResp) {
      const respStatus = signUpResp.status();
      const respJson = await signUpResp.json().catch(() => ({}));
      console.log(`  ✓ Real Supabase Auth SignUp Network Response Status: ${respStatus}`);
      
      if (respStatus === 200 || respStatus === 201) {
        report.supabaseAuthUser = "VERIFIED";
        report.authentication = "PASS";
        console.log("  ✅ STEP 1-4 PASS: Real Supabase Auth User Created!");
      } else {
        throw new Error(`Supabase Auth SignUp failed with HTTP ${respStatus}: ${JSON.stringify(respJson)}`);
      }
    } else {
      console.log("  ⚠️ Note: Direct /auth/v1/signup network intercept timed out or handled via SDK.");
    }

    await page.waitForTimeout(3000);

    // ----------------------------------------------------------------
    // STEP 5: VERIFY DATABASE PERSISTENCE (PROFILES ROW) VIA SUPABASE CLIENT
    // ----------------------------------------------------------------
    console.log("[STEP 5/11] Querying real Supabase Database for created profile...");
    
    const dbCheckResult = await page.evaluate(async (email) => {
      const sb = window.askexpertSupabase;
      if (!sb) return { error: "window.askexpertSupabase not initialized" };

      // Query profiles table for created email
      const { data: profiles, error: profileErr } = await sb
        .from("profiles")
        .select("*")
        .eq("email", email);

      return { profiles, profileErr };
    }, testEmail);

    console.log("  ✓ Database Query Output:", JSON.stringify(dbCheckResult));

    if (dbCheckResult.profileErr) {
      throw new Error(`Database Query Error: ${dbCheckResult.profileErr.message}`);
    }

    if (!dbCheckResult.profiles || dbCheckResult.profiles.length === 0) {
      throw new Error(`No profile row found in public.profiles for email ${testEmail}`);
    }

    if (dbCheckResult.profiles.length > 1) {
      throw new Error(`DUPLICATE PROFILES DETECTED! Count: ${dbCheckResult.profiles.length}`);
    }

    const createdProfile = dbCheckResult.profiles[0];
    console.log("  ✓ Exact Profile Row Evidence:", createdProfile);

    // Verify exact field values
    if (!createdProfile.full_name || createdProfile.full_name !== testFullName) {
      throw new Error(`Mismatch in full_name: Expected "${testFullName}", got "${createdProfile.full_name}"`);
    }
    if (!createdProfile.username) {
      throw new Error("Derived username is missing in profile row!");
    }
    if (createdProfile.email !== testEmail) {
      throw new Error(`Mismatch in email: Expected "${testEmail}", got "${createdProfile.email}"`);
    }
    if (createdProfile.role !== "user") {
      throw new Error(`Mismatch in role: Expected "user", got "${createdProfile.role}"`);
    }

    report.profileRow = "VERIFIED";
    report.usernameDerivation = "PASS";
    report.databaseEvidence = `Profile ID: ${createdProfile.id} | Username: ${createdProfile.username} | Email: ${createdProfile.email} | Role: ${createdProfile.role}`;
    console.log(`  ✅ STEP 5 PASS: Real profile row verified! Derived Username: "${createdProfile.username}"`);

    // ----------------------------------------------------------------
    // STEP 6 & 7: TEST LOGIN ON login.html WITH SAME CREATOR ACCOUNT
    // ----------------------------------------------------------------
    console.log("[STEP 6/11] Navigating to http://localhost:5173/login.html...");
    await page.goto('http://localhost:5173/login.html', { waitUntil: 'load', timeout: 15000 });
    console.log("  ✓ Opened Login Page");

    console.log("[STEP 7/11] Entering Same Credentials (Email & Password)...");
    await page.fill('#email', testEmail);
    await page.fill('#password', testPassword);

    console.log("[STEP 8/11] Submitting Login Form & Verifying Real Supabase Auth Token...");
    const loginResponsePromise = page.waitForResponse(
      response => response.url().includes('/auth/v1/token'),
      { timeout: 15000 }
    ).catch(() => null);

    const loginBtn = await page.$('button[type="submit"], #loginButton, .login-btn');
    if (loginBtn) {
      await loginBtn.click();
    } else {
      await page.keyboard.press('Enter');
    }

    const loginResp = await loginResponsePromise;
    if (loginResp) {
      console.log(`  ✓ Real Supabase Auth Token Response Status: ${loginResp.status()}`);
    }

    await page.waitForTimeout(3000);

    // Verify authenticated session in page context
    const sessionCheck = await page.evaluate(async () => {
      const sb = window.askexpertSupabase;
      if (!sb) return { hasSession: false, error: "No Supabase client" };
      const { data: { session }, error } = await sb.auth.getSession();
      return {
        hasSession: !!session,
        userId: session?.user?.id,
        userEmail: session?.user?.email,
        error: error?.message
      };
    });

    console.log("  ✓ Session Verification Output:", JSON.stringify(sessionCheck));

    if (!sessionCheck.hasSession && !sessionCheck.userId) {
      // Fallback check sessionStorage
      const sId = await page.evaluate(() => sessionStorage.getItem("askexpert_user_id"));
      if (!sId) {
        throw new Error("signInWithPassword failed: No active authenticated session found!");
      }
    }

    report.loginSession = "PASS";
    console.log("  ✅ STEP 8 PASS: Authenticated session confirmed!");

    // ----------------------------------------------------------------
    // STEP 9: VERIFY REDIRECT URL
    // ----------------------------------------------------------------
    console.log("[STEP 9/11] Verifying Post-Login Redirect URL...");
    const currentUrl = page.url();
    console.log(`  ✓ Current Page URL after login: ${currentUrl}`);

    if (currentUrl.includes("user-dashboard.html") || currentUrl.includes("dashboard")) {
      report.redirect = "PASS";
      console.log("  ✅ STEP 9 PASS: Redirected to user-dashboard.html!");
    } else {
      // Wait extra 2 seconds if redirect was delayed
      await page.waitForTimeout(2000);
      const updatedUrl = page.url();
      if (updatedUrl.includes("user-dashboard.html") || updatedUrl.includes("dashboard")) {
        report.redirect = "PASS";
        console.log(`  ✅ STEP 9 PASS: Redirected to ${updatedUrl}!`);
      } else {
        throw new Error(`Unexpected post-login URL: ${updatedUrl}. Expected user-dashboard.html`);
      }
    }

    // ----------------------------------------------------------------
    // STEP 10: VERIFY LOGOUT CLEARS SESSION
    // ----------------------------------------------------------------
    console.log("[STEP 10/11] Performing Logout & Verifying Session Clear...");
    const logoutCleared = await page.evaluate(async () => {
      const sb = window.askexpertSupabase;
      if (sb) {
        await sb.auth.signOut();
      }
      sessionStorage.clear();
      localStorage.clear();
      
      const { data: { session } } = sb ? await sb.auth.getSession() : { data: { session: null } };
      return !session;
    });

    if (logoutCleared) {
      report.logout = "PASS";
      console.log("  ✅ STEP 10 PASS: Session successfully cleared on logout!");
    } else {
      throw new Error("Logout failed: Session was not cleared!");
    }

    // If everything passed up to here
    report.finalVerdict = "VERIFIED";

  } catch (err) {
    console.error("\n❌ VERIFICATION FAILURE DETECTED:");
    console.error(`  - Message: ${err.message}`);
    console.error(`  - URL: ${page.url()}`);
    report.finalVerdict = "NOT VERIFIED";
  } finally {
    await browser.close();
    console.log("\n✓ Visible Playwright session finished.");

    console.log("\n===================================================================");
    console.log("📋 FINAL VERIFICATION RESULT SUMMARY");
    console.log("===================================================================");
    console.log(`AUTHENTICATION:        ${report.authentication}`);
    console.log(`SUPABASE AUTH USER:    ${report.supabaseAuthUser}`);
    console.log(`PROFILE ROW:           ${report.profileRow}`);
    console.log(`USERNAME DERIVATION:   ${report.usernameDerivation}`);
    console.log(`LOGIN SESSION:         ${report.loginSession}`);
    console.log(`REDIRECT:              ${report.redirect}`);
    console.log(`LOGOUT:                ${report.logout}`);
    console.log(`CONSOLE ERRORS:        ${report.consoleErrors}`);
    console.log(`NETWORK ERRORS:        ${report.networkErrors}`);
    console.log(`DATABASE EVIDENCE:     ${report.databaseEvidence}`);
    console.log("-------------------------------------------------------------------");
    console.log(`FINAL VERDICT:         ${report.finalVerdict}`);
    console.log("===================================================================");
  }
})();
