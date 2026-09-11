// scratch/test_live_readiness.mjs
import fs from 'fs';
import path from 'path';

console.log('====================================================');
console.log('     AskExpert Comprehensive Integrity Verification  ');
console.log('====================================================\n');

let totalChecks = 0;
let passedChecks = 0;
let failedChecks = 0;

function check(desc, condition) {
  totalChecks++;
  if (condition) {
    console.log(`✅ PASS: ${desc}`);
    passedChecks++;
  } else {
    console.error(`❌ FAIL: ${desc}`);
    failedChecks++;
  }
}

// 1. Root HTML files check
const htmlFiles = fs.readdirSync('.').filter(f => f.endsWith('.html'));
check(`Found ${htmlFiles.length} root HTML files`, htmlFiles.length >= 30);

// 2. Dist files check
const distHtmlFiles = fs.readdirSync('dist').filter(f => f.endsWith('.html'));
check(`Dist folder has compiled ${distHtmlFiles.length} HTML pages`, distHtmlFiles.length >= 30);

// 3. Verify core pages exist in both root and dist
const corePages = [
  'index.html',
  'login.html',
  'register.html',
  'forgot-password.html',
  'user-dashboard.html',
  'professional-dashboard.html',
  'professional-earnings.html',
  'professional-verification.html',
  'admin-dashboard.html',
  'admin-login.html',
  'admin-payments.html',
  'admin-professionals.html',
  'admin-questions.html',
  'admin-reports.html',
  'admin-health.html',
  'admin-ai-fix-center.html',
  'chat.html',
  'payments.html',
  'payment-history.html',
  'questions.html',
  'question-details.html',
  'experts.html',
  'expert-profile.html',
  'ask-question.html',
  'notifications.html',
  'settings.html',
  'profile.html',
  'edit-profile.html',
  'review.html',
  'flowchart.html',
  'consultation-requests.html',
  'auth-callback.html',
  'reset-password.html'
];

for (const p of corePages) {
  check(`Page '${p}' exists in root and dist`, fs.existsSync(p) && fs.existsSync(path.join('dist', p)));
}

// 4. Verify all 10 Edge Functions exist
const edgeFunctions = [
  'payment-create',
  'payment-verify',
  'payment-webhook',
  'process-refund',
  'process-payout',
  'session-start',
  'session-end',
  'session-dispute',
  'resolve-dispute',
  'video-room'
];

for (const fn of edgeFunctions) {
  const p = path.join('supabase', 'functions', fn, 'index.ts');
  check(`Edge function '${fn}' source exists`, fs.existsSync(p) && fs.statSync(p).size > 100);
}

// 5. Verify database migrations exist
const migrations = [
  '20260908_username_resolver.sql',
  '20260908_fix_verified_profiles_security_invoker.sql',
  '20260910_2_harden_role_and_account_security.sql',
  '20260910_3_storage_and_payment_hardening.sql',
  '20260910_4_atomic_wallet_settlement_and_payouts.sql'
];

for (const m of migrations) {
  const p = path.join('database', 'migrations', m);
  check(`Migration file '${m}' exists and valid`, fs.existsSync(p) && fs.statSync(p).size > 50);
}

// 6. Verify zero mock/preview bypasses in any HTML file
let dirtyFiles = [];
for (const file of htmlFiles) {
  const content = fs.readFileSync(file, 'utf8');
  if (content.includes('get("preview") === "true"') || content.includes('get(\'preview\') === \'true\'')) {
    dirtyFiles.push(file);
  }
}
check('Zero preview bypasses in all HTML files', dirtyFiles.length === 0);

console.log('\n====================================================');
console.log(`Integrity Verification Summary: ${passedChecks}/${totalChecks} PASSED (${failedChecks} FAILED)`);
console.log('====================================================\n');
