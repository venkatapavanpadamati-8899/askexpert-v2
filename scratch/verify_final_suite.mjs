import fs from 'fs';

console.log("=== FINAL POST-FIX VERIFICATION AUDIT ===");

let passed = 0;
let total = 0;

function test(title, fn) {
  total++;
  try {
    const res = fn();
    if (res) {
      console.log(`[PASS] ${title}`);
      passed++;
    } else {
      console.log(`[FAIL] ${title}`);
    }
  } catch (err) {
    console.log(`[FAIL] ${title} — ${err.message}`);
  }
}

// 1. Check Demo OTP
test("Demo OTP in register.html untouched", () => {
  const c = fs.readFileSync('register.html', 'utf8');
  return c.includes('id="demoOtpBox"') && c.includes('id="autoFillOtpButton"') && c.includes('otpVerified = true');
});

test("Demo OTP in forgot-password.html untouched", () => {
  const c = fs.readFileSync('forgot-password.html', 'utf8');
  return c.includes('demo-otp-box') && c.includes('demo-otp-fill-btn');
});

// 2. Check Hidden Admin Login
test("Hidden Admin Login in login.html untouched", () => {
  const c = fs.readFileSync('login.html', 'utf8');
  return c.includes('targetEmail === "admin"') && c.includes('sessionStorage.setItem("askexpert_user_id", "admin-authorized")');
});

test("Real admin email not hijacked in login.html", () => {
  const c = fs.readFileSync('login.html', 'utf8');
  return !c.includes('venkatapavanpadamati1@gmail.com');
});

// 3. User Dashboard Clean Data
test("User Dashboard has NO localStorage fake fallback for stats", () => {
  const c = fs.readFileSync('user-dashboard.html', 'utf8');
  return !c.includes('localStorage.getItem("askexpert_questions")') && c.includes('.eq("user_id", currentUser.id)');
});

test("User Dashboard filters questions strictly by currentUser.id", () => {
  const c = fs.readFileSync('user-dashboard.html', 'utf8');
  return c.includes('.eq("user_id", currentUser.id)') && c.includes('answers_count || 0');
});

test("User Dashboard has real chat and wallet queries", () => {
  const c = fs.readFileSync('user-dashboard.html', 'utf8');
  return c.includes('statChats') && c.includes('statWallet') && c.includes('sideWalletBalance');
});

test("User Dashboard has NO fake preview bypass", () => {
  const c = fs.readFileSync('user-dashboard.html', 'utf8');
  return !c.includes('Aditya Sharma') && !c.includes('preview');
});

// 4. Ask Question payload
test("Ask Question payload uses description & category (not body/tags)", () => {
  const c = fs.readFileSync('ask-question.html', 'utf8');
  return c.includes('description: desc') && c.includes('category: profession') && !c.includes('body: desc');
});

// 5. Professional Dashboard Clean Data
test("Professional Dashboard has NO fake preview bypass", () => {
  const c = fs.readFileSync('professional-dashboard.html', 'utf8');
  return !c.includes('Adv. Vikram Rao') && !c.includes('preview');
});

test("Professional Dashboard queries answers by user_id", () => {
  const c = fs.readFileSync('professional-dashboard.html', 'utf8');
  return c.includes('.eq("user_id", currentExpertId)');
});

// 6. Admin Dashboard Fixes
test("Admin Dashboard queries council_registration_no", () => {
  const c = fs.readFileSync('admin-dashboard.html', 'utf8');
  return c.includes('council_registration_no');
});

test("Admin Dashboard disputes badge queries reports table", () => {
  const c = fs.readFileSync('admin-dashboard.html', 'utf8');
  return c.includes('badgeOpenDisputes') && c.includes('.from("reports")');
});

// 7. Flowchart link
test("Flowchart links to existing docs/PROJECT-FLOWCHART.md", () => {
  const c = fs.readFileSync('flowchart.html', 'utf8');
  return c.includes('docs/PROJECT-FLOWCHART.md');
});

console.log(`\nResults: ${passed} / ${total} tests passed.`);
