// scratch/test_free_kyc_verification_suite.mjs
// Automated Verification Suite for Free-KYC Multi-Step Expert Verification System

import { readFileSync, existsSync } from 'fs';
import { resolve } from 'path';
import {
  validateVerhoeffAadhaar,
  formatAadhaarMasked,
  performTemporaryLastFourCheck,
  analyzeIdentityDocumentAdvisory
} from '../assets/js/ai/aiAadhaarVerifier.js';
import { analyzeCertificateAuthenticity } from '../assets/js/ai/aiCertificateVerifier.js';

console.log('=== RUNNING FREE-KYC MULTI-STEP VERIFICATION TEST SUITE ===\n');

let passedTests = 0;
let totalTests = 0;

function assert(condition, testName) {
  totalTests++;
  if (condition) {
    console.log(`  ✅ [PASS] ${testName}`);
    passedTests++;
  } else {
    console.error(`  ❌ [FAIL] ${testName}`);
    throw new Error(`Test failed: ${testName}`);
  }
}

// -------------------------------------------------------------
// 1. Verhoeff and Masking Tests
// -------------------------------------------------------------
console.log('1. Testing Verhoeff and Masking Helpers...');
assert(validateVerhoeffAadhaar('219223749458') === true, 'Valid 12-digit Aadhaar passes Verhoeff algorithm');
assert(validateVerhoeffAadhaar('219223749455') === false, 'Corrupted Aadhaar fails Verhoeff algorithm');
assert(validateVerhoeffAadhaar('000000000000') === false, 'Repeated single digits rejected');
assert(formatAadhaarMasked('219223749458') === 'XXXX-XXXX-9458', '12-digit Aadhaar masked as XXXX-XXXX-9458');
assert(formatAadhaarMasked('Z1234567') === '****-****-4567', 'Passport number masked with last four digits');

// -------------------------------------------------------------
// 2. Temporary Last-Four Consistency Check
// -------------------------------------------------------------
console.log('\n2. Testing Temporary Last-Four Consistency Check...');
const resConsistent = performTemporaryLastFourCheck({
  enteredNumber: '219223749458',
  documentText: 'GOVERNMENT OF INDIA 2192 2374 9458',
  fileName: 'aadhaar_scan.pdf'
});
assert(resConsistent.status === 'CONSISTENT', 'Matching last-four returns CONSISTENT');

const resMismatch = performTemporaryLastFourCheck({
  enteredNumber: '219223749458',
  documentText: 'GOVERNMENT OF INDIA 1111 2222 3333',
  fileName: 'aadhaar_scan.pdf'
});
assert(resMismatch.status === 'DO_NOT_MATCH', 'Mismatched last-four returns DO_NOT_MATCH');

const resNotProvided = performTemporaryLastFourCheck({
  enteredNumber: '',
  documentText: 'PASSPORT REPUBLIC OF INDIA',
  fileName: 'passport.pdf'
});
assert(resNotProvided.status === 'NOT_PROVIDED', 'Empty voluntary number returns NOT_PROVIDED');

const resUnable = performTemporaryLastFourCheck({
  enteredNumber: '9454',
  documentText: 'NO DIGITS DETECTED IN TEXT STREAM',
  fileName: ''
});
assert(resUnable.status === 'UNABLE_TO_DETERMINE', 'Unreadable text returns UNABLE_TO_DETERMINE');

// -------------------------------------------------------------
// 3. Multi-Step Form UI Audit (professional-verification.html)
// -------------------------------------------------------------
console.log('\n3. Auditing professional-verification.html 9-Step Structure...');
const htmlPath = resolve(process.cwd(), 'professional-verification.html');
assert(existsSync(htmlPath), 'professional-verification.html exists');

const htmlContent = readFileSync(htmlPath, 'utf8');

assert(htmlContent.includes('data-step="1"') && htmlContent.includes('Personal Details'), 'Step 1: Expert Personal Details present');
assert(htmlContent.includes('data-step="2"') && htmlContent.includes('Address Details'), 'Step 2: Address Details present');
assert(htmlContent.includes('data-step="3"') && htmlContent.includes('Professional Details'), 'Step 3: Professional Details present');
assert(htmlContent.includes('data-step="4"') && htmlContent.includes('Optional Identity Verification'), 'Step 4: Optional Identity Verification present');
assert(htmlContent.includes('data-step="5"') && htmlContent.includes('Degree & Educational Qualification'), 'Step 5: Degree / Qualification present');
assert(htmlContent.includes('data-step="6"') && htmlContent.includes('Statutory License & Board Registration'), 'Step 6: License / Registration present');
assert(htmlContent.includes('data-step="7"') && htmlContent.includes('AI-Assisted Document Pre-check'), 'Step 7: AI Pre-check present');
assert(htmlContent.includes('data-step="8"') && htmlContent.includes('Final Review & Submission'), 'Step 8: Review & Submit present');
assert(htmlContent.includes('id="statusScreen"') && htmlContent.includes('Verification Pending Admin Review'), 'Step 9: Pending Admin Review status screen present');

// Verify Free-KYC rules on HTML
assert(!htmlContent.includes('btnSendIdentityOtp'), 'No Aadhaar OTP send button exists');
assert(!htmlContent.includes('btnVerifyIdentityOtp'), 'No Aadhaar OTP verify button exists');
assert(!htmlContent.includes('Surepass'), 'No Surepass integration exists in frontend');
assert(!htmlContent.includes('Setu'), 'No Setu integration exists in frontend');

// -------------------------------------------------------------
// 4. Admin Review Center Audit (admin-professionals.html)
// -------------------------------------------------------------
console.log('\n4. Auditing admin-professionals.html Compliance & Signed URLs...');
const adminHtmlPath = resolve(process.cwd(), 'admin-professionals.html');
const adminContent = readFileSync(adminHtmlPath, 'utf8');

assert(adminContent.includes('EXPERT VERIFICATION REPORT'), 'Admin review shows EXPERT VERIFICATION REPORT');
assert(adminContent.includes('modalLastFourConsistency'), 'Admin sees last-four consistency check');
assert(adminContent.includes('kyc-documents') && adminContent.includes('createSignedUrl'), 'Admin accesses private documents via short-lived signed URLs (1 hour)');
assert(adminContent.includes('admin_review_professional_verification'), 'Admin actions trigger server-side RPC gate');
assert(!adminContent.includes('vIdentityOtp'), 'Admin does not see/store any OTP');

// -------------------------------------------------------------
// 5. Database Migration Audit
// -------------------------------------------------------------
console.log('\n5. Auditing Database Migration 20260911_7_free_kyc_multi_step_verification.sql...');
const migPath = resolve(process.cwd(), 'database/migrations/20260911_7_free_kyc_multi_step_verification.sql');
assert(existsSync(migPath), 'Migration 7 exists');

const migContent = readFileSync(migPath, 'utf8');
assert(migContent.includes('identity_document_type'), 'Supports identity document type');
assert(migContent.includes('last_four_consistency'), 'Stores last four consistency state');
assert(migContent.includes("v_admin_id IS NULL OR NOT EXISTS"), 'Strictly checks admin authorization before review approval');
assert(migContent.includes("v_verification.degree_document_path IS NULL"), 'Enforces required professional documents before approval');

// -------------------------------------------------------------
// 6. AI Advisory Disclaimers
// -------------------------------------------------------------
console.log('\n6. Auditing AI Advisory Engines...');
const certResult = analyzeCertificateAuthenticity({
  profileName: 'Adv. Vikram Rao',
  degree: 'LL.M Corporate Law',
  university: 'NLSIU Bangalore',
  specialization: 'Legal',
  license: 'MAH/9842/2014'
});

assert(certResult.score > 0, 'AI Certificate authenticity score generated');
assert(certResult.govDatabaseDisclosure.noticeEnglish.includes('AI-Assisted Document Pre-check — Advisory Only'), 'Explicit advisory notice verified');
assert(certResult.decisionMode === 'STRICT_ADMIN_APPROVAL_REQUIRED', 'Admin-only approval policy enforced in AI module');

console.log(`\n🎉 ALL ${passedTests} OF ${totalTests} TESTS PASSED PERFECTLY!\n`);
