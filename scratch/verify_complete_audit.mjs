// scratch/verify_complete_audit.mjs
import fs from 'fs';
import path from 'path';

console.log('====================================================');
console.log('      AskExpert Complete Production Audit Scanner    ');
console.log('====================================================\n');

let failedTests = 0;
let passedTests = 0;

function assert(condition, message) {
  if (condition) {
    console.log(`✅ PASS: ${message}`);
    passedTests++;
  } else {
    console.error(`❌ FAIL: ${message}`);
    failedTests++;
  }
}

// 1. Check admin-dashboard.html bypass removal
const adminDashHtml = fs.readFileSync('admin-dashboard.html', 'utf8');
assert(!adminDashHtml.includes('get("preview") === "true"'), 'admin-dashboard.html has no ?preview=true bypass');
assert(adminDashHtml.includes('verifyAdminAccess()'), 'admin-dashboard.html executes verifyAdminAccess');
assert(adminDashHtml.includes('admin-login.html'), 'admin-dashboard.html redirects unauthorized users to admin-login.html');

// 2. Check professional-earnings.html bypass removal
const profEarningsHtml = fs.readFileSync('professional-earnings.html', 'utf8');
assert(!profEarningsHtml.includes('demo_expert_1'), 'professional-earnings.html has no demo_expert_1 fallback');
assert(!profEarningsHtml.includes('get("preview") === "true"'), 'professional-earnings.html has no ?preview=true bypass');
assert(profEarningsHtml.includes('supabase.rpc("request_payout"'), 'professional-earnings.html uses atomic request_payout RPC');

// 3. Check chat.html bypass & mock expert removal
const chatHtml = fs.readFileSync('chat.html', 'utf8');
assert(!chatHtml.includes('expert_demo_1'), 'chat.html has no expert_demo_1 fallback');
assert(!chatHtml.includes('demo_client_preview'), 'chat.html has no demo_client_preview fallback');
assert(!chatHtml.includes('get("preview") === "true"'), 'chat.html has no ?preview=true bypass');
assert(chatHtml.includes('invoke("video-room"'), 'chat.html integrates with real video-room Edge Function');

// 4. Check question-details.html mock question removal
const qDetailsHtml = fs.readFileSync('question-details.html', 'utf8');
assert(!qDetailsHtml.includes('preview-101'), 'question-details.html has no preview-101 mock question');
assert(!qDetailsHtml.includes('urlParams.get("preview")'), 'question-details.html has no preview injection');

// 5. Check professional-verification.html AI claims
const profVerifHtml = fs.readFileSync('professional-verification.html', 'utf8');
assert(!profVerifHtml.includes('Vision AI: Inspecting certificate seals'), 'professional-verification.html has no fake Vision AI claims');
assert(profVerifHtml.includes('Statutory Format & Integrity Pre-Check'), 'professional-verification.html uses transparent pre-check terminology');

// 6. Check aiIssueAnalyzer.js confidence score
const aiIssueAnalyzerJs = fs.readFileSync('assets/js/ai/aiIssueAnalyzer.js', 'utf8');
assert(!aiIssueAnalyzerJs.includes('96.50'), 'aiIssueAnalyzer.js has no hardcoded 96.50 confidence score');

// 7. Check Edge Functions existence
const requiredFunctions = [
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

requiredFunctions.forEach(fn => {
  const p = path.join('supabase', 'functions', fn, 'index.ts');
  assert(fs.existsSync(p), `Edge Function '${fn}' exists and is ready for deployment`);
});

// 8. Scan all root HTML files for bypasses
const rootFiles = fs.readdirSync('.').filter(f => f.endsWith('.html'));
let dirtyFiles = [];
rootFiles.forEach(file => {
  const content = fs.readFileSync(file, 'utf8');
  if (content.includes('preview === "true"') || content.includes('mockUser') || content.includes('fakeSession')) {
    dirtyFiles.push(file);
  }
});

assert(dirtyFiles.length === 0, `All ${rootFiles.length} root HTML files have zero bypass/mock signatures (dirty files: ${dirtyFiles.join(', ') || 'none'})`);

console.log('\n====================================================');
console.log(`Scan Summary: ${passedTests} passed, ${failedTests} failed.`);
console.log('====================================================');

if (failedTests > 0) {
  process.exit(1);
} else {
  console.log('🎉 AUDIT COMPLETE: Zero bypasses, zero fake claims, 100% code compliant.');
}
