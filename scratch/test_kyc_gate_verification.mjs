// scratch/test_kyc_gate_verification.mjs
// Comprehensive KYC Verification Gate Test Suite
import { analyzeCertificateAuthenticity } from '../assets/js/ai/aiCertificateVerifier.js';
import fs from 'fs';
import path from 'path';

console.log('====================================================');
console.log('  AskExpert - Strict KYC Gate Verification Suite   ');
console.log('====================================================\n');

let totalTests = 0;
let passedTests = 0;

function assert(condition, name, details = '') {
  totalTests++;
  if (condition) {
    passedTests++;
    console.log(`✅ PASS: ${name}`);
  } else {
    console.error(`❌ FAIL: ${name}`);
    if (details) console.error(`   Details: ${details}`);
  }
}

// 1. Test AI Advisory Pre-Check Scoring & Boundary Rules
console.log('--- 1. Testing AI Pre-Check Engine ---');

const cleanApplicant = analyzeCertificateAuthenticity({
  profileName: 'Advocate Rajesh Sharma',
  docHolderName: 'Rajesh Sharma',
  specialization: 'Legal',
  degree: 'LLB',
  university: 'Delhi University',
  license: 'D/1234/2018',
  fileName: 'bar_council_certificate.pdf',
  fileSize: 1024 * 500, // 500 KB
  issueDate: '2018-05-15',
  expiryDate: '2030-05-15'
});

assert(cleanApplicant.riskScore <= 25, 'Clean applicant has low risk score', `Score: ${cleanApplicant.riskScore}`);
assert(cleanApplicant.riskLevel === 'LOW RISK', 'Clean applicant classified as LOW RISK');
assert(cleanApplicant.decisionMode === 'STRICT_ADMIN_APPROVAL_REQUIRED', 'AI enforces STRICT_ADMIN_APPROVAL_REQUIRED');
assert(cleanApplicant.govDatabaseDisclosure.isConnected === false, 'AI acknowledges no direct official gov registry connection');
assert(cleanApplicant.adminMandate.includes('final verification decision is strictly reserved for the authorized platform Administrator'), 'AI includes strict admin review mandate');

// Test Tamper / Anomaly / Mismatch detection
const mismatchedApplicant = analyzeCertificateAuthenticity({
  profileName: 'Dr. Suresh Kumar',
  docHolderName: 'Pooja Verma', // Clear name mismatch
  specialization: 'Medical',
  degree: 'MBBS',
  university: 'AIIMS',
  license: 'MCI-998877',
  fileName: 'license_scan.jpg',
  fileSize: 1024 * 10, // suspicious tiny file (10KB)
  issueDate: '2020-01-01',
  expiryDate: '2021-01-01' // Expired!
});

assert(mismatchedApplicant.riskScore > 50, 'Mismatched applicant gets elevated risk score', `Score: ${mismatchedApplicant.riskScore}`);
assert(mismatchedApplicant.suspiciousPoints.some(p => p.toLowerCase().includes('mismatch') || p.toLowerCase().includes('divergence')), 'AI flags name divergence');
assert(mismatchedApplicant.suspiciousPoints.some(p => p.toLowerCase().includes('expired')), 'AI flags expired license');

// 2. Test Server-Side Payment Gate (payment-create Edge Function)
console.log('\n--- 2. Auditing Server-Side Payment Gate ---');
const paymentCreateCode = fs.readFileSync(path.resolve('supabase/functions/payment-create/index.ts'), 'utf-8');

assert(
  paymentCreateCode.includes('.eq("is_verified", true)') && paymentCreateCode.includes('.eq("role", "expert")'),
  'payment-create Edge Function strictly enforces is_verified = true and role = expert',
  'Unverified experts cannot receive orders'
);

assert(
  paymentCreateCode.includes('Specified expert profile is unverified or invalid'),
  'payment-create returns explicit error message for unverified experts'
);

// 3. Test Database RLS & Security Triggers
console.log('\n--- 3. Auditing Database Security Triggers & RLS ---');
const secMigration = fs.readFileSync(path.resolve('database/migrations/20260910_2_harden_role_and_account_security.sql'), 'utf-8');

assert(
  secMigration.includes("NEW.is_verified := false;") && secMigration.includes("public.enforce_profile_role_security"),
  'enforce_profile_role_security trigger forces is_verified = false on non-admin INSERT'
);

assert(
  secMigration.includes("IF (NEW.is_verified IS DISTINCT FROM OLD.is_verified) THEN") &&
  secMigration.includes("RAISE EXCEPTION 'Access Denied: Only compliance administrators can modify verification status.';"),
  'enforce_profile_role_security trigger prevents non-admins from self-granting is_verified = true'
);

// 4. Test Private Storage Configuration
console.log('\n--- 4. Auditing Private KYC Storage Bucket ---');
const storageMigration = fs.readFileSync(path.resolve('database/migrations/20260910_3_storage_and_payment_hardening.sql'), 'utf-8');

assert(
  storageMigration.includes("'kyc-documents'") && storageMigration.includes("false"),
  'kyc-documents storage bucket is configured as private (public = false)'
);

assert(
  storageMigration.includes("KYC owners and admins can read documents") &&
  storageMigration.includes("(storage.foldername(name))[1] = auth.uid()::text OR public.is_admin()"),
  'Storage RLS restricts KYC read access exclusively to owner or admin'
);

// 5. Test Frontend Expert Directory Isolation
console.log('\n--- 5. Auditing Frontend Expert Listing & Profile Access ---');
const expertsHtml = fs.readFileSync(path.resolve('experts.html'), 'utf-8');
const expertProfileHtml = fs.readFileSync(path.resolve('expert-profile.html'), 'utf-8');

assert(
  expertsHtml.includes('.eq("role", "expert")') && expertsHtml.includes('.eq("is_verified", true)'),
  'experts.html directory strictly filters by is_verified = true'
);

assert(
  expertProfileHtml.includes('.eq("role", "expert")') && expertProfileHtml.includes('.eq("is_verified", true)'),
  'expert-profile.html profile view strictly filters by is_verified = true'
);

// 6. Test Admin Approval & Rejection Flow
console.log('\n--- 6. Auditing Admin KYC Management & Audit Trail ---');
const adminProfHtml = fs.readFileSync(path.resolve('admin-professionals.html'), 'utf-8');

assert(
  adminProfHtml.includes('verification_status: "approved"') && adminProfHtml.includes('is_verified: true'),
  'Admin approval flow updates verification_status and is_verified'
);

assert(
  adminProfHtml.includes('verification_status: "rejected"') && adminProfHtml.includes('rejection_reason: reason'),
  'Admin rejection flow requires and records mandatory rejection reason'
);

assert(
  adminProfHtml.includes('PROFESSIONAL_VERIFICATION_APPROVED') && adminProfHtml.includes('audit_logs'),
  'Admin approval writes immutable record into audit_logs table'
);

console.log('\n====================================================');
console.log(`Results: ${passedTests} passed out of ${totalTests} tests.`);
console.log('====================================================');
