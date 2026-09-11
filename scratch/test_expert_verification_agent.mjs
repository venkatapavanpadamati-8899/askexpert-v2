// scratch/test_expert_verification_agent.mjs
import { runExpertVerificationAgent } from '../assets/js/ai/expertVerificationAgent.js';

console.log('====================================================');
console.log('  AskExpert - Verification Agent Test Suite         ');
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

// Case 1: Valid clean expert
console.log('--- Case 1: Valid Expert Profile ---');
const cleanReport = runExpertVerificationAgent({
  profile: {
    id: 'exp_001',
    full_name: 'Dr. Ramesh Chandra',
    specialization: 'Medical Consultation',
    experience_years: 12
  },
  verification: {
    degree_qualification: 'MBBS, MD',
    council_registration_no: 'MCI-123456',
    license_expiry_date: '2030-12-31'
  },
  documents: {
    idDocument: { fileName: 'aadhaar_front.jpg', fileSize: 350 * 1024 },
    degreeDocument: { fileName: 'md_degree_certificate.pdf', fileSize: 850 * 1024 },
    licenseDocument: { fileName: 'medical_council_license.pdf', fileSize: 600 * 1024 }
  },
  answers: [
    { content: 'For acute hypertension, immediate clinical evaluation and continuous arterial pressure monitoring are warranted.', topic: 'Medical Consultation' },
    { content: 'Post-operative wound care requires sterile dressings and prescribed antibiotic regimen adherence.', topic: 'Medical Consultation' }
  ]
});

assert(cleanReport.finalAiSignal.overallScore >= 80, 'Clean expert gets high verification score', `Score: ${cleanReport.finalAiSignal.overallScore}`);
assert(cleanReport.finalAiSignal.riskLevel === 'LOW', 'Clean expert classified as LOW risk');
assert(cleanReport.expertiseConsistency.status === 'HIGH', 'Expertise consistency rated HIGH');
assert(cleanReport.qaQualityAnalysis.qualityScore >= 80, 'Q&A Quality scored high');

// Case 2: Name Mismatch & Suspicious Identity
console.log('\n--- Case 2: Name Mismatch ---');
const mismatchReport = runExpertVerificationAgent({
  profile: {
    id: 'exp_002',
    full_name: 'Priya Sharma',
    specialization: 'Legal Advisory'
  },
  verification: {
    applicant_name: 'Priya Sharma',
    id_holder_name: 'Kavita Verma', // Name mismatch
    degree_qualification: 'LL.B.',
    council_registration_no: 'D/9988/2019'
  }
});

assert(mismatchReport.identityCheck.status === 'MISMATCH', 'Identifies name divergence');
assert(mismatchReport.finalAiSignal.riskLevel !== 'LOW', 'Elevates risk on identity mismatch');

// Case 3: Degree vs Profession Mismatch
console.log('\n--- Case 3: Qualification vs Profession Mismatch ---');
const qualMismatchReport = runExpertVerificationAgent({
  profile: {
    id: 'exp_003',
    full_name: 'Anil Kumar',
    specialization: 'Legal Advisory'
  },
  verification: {
    degree_qualification: 'B.Tech in Mechanical Engineering',
    council_registration_no: 'STATE-BAR-001'
  }
});

assert(qualMismatchReport.qualificationCheck.status === 'MISMATCH', 'Flags non-legal degree for legal counsel');
assert(qualMismatchReport.qualificationCheck.score < 50, 'Reduces qualification score for profession mismatch');

// Case 4: Expired Professional License
console.log('\n--- Case 4: Expired License ---');
const expiredLicenseReport = runExpertVerificationAgent({
  profile: {
    id: 'exp_004',
    full_name: 'Vikram Singh',
    specialization: 'Medical Consultation'
  },
  verification: {
    degree_qualification: 'MBBS',
    council_registration_no: 'SMC-887766',
    license_expiry_date: '2020-01-01' // Expired
  }
});

assert(expiredLicenseReport.licenseCheck.status === 'SUSPICIOUS', 'Flags expired license as SUSPICIOUS');
assert(expiredLicenseReport.finalAiSignal.riskLevel === 'HIGH', 'Elevates risk to HIGH on expired license');

// Case 5: Repetitive / Out-of-Domain Answers
console.log('\n--- Case 5: Answer Quality & Anomaly Detection ---');
const badAnswersReport = runExpertVerificationAgent({
  profile: {
    id: 'exp_005',
    full_name: 'Dr. Arvind Rao',
    specialization: 'Medical Consultation'
  },
  verification: {
    degree_qualification: 'MBBS',
    council_registration_no: 'MCI-554433'
  },
  answers: [
    { content: 'Contact my office for details.', topic: 'Medical Consultation' },
    { content: 'Contact my office for details.', topic: 'Medical Consultation' },
    { content: 'For legal advice on divorce filing, submit form 12.', topic: 'Legal Advisory' } // Out of domain
  ]
});

assert(badAnswersReport.qaQualityAnalysis.repeatedPatterns.length > 0, 'Detects repetitive boilerplate answers');
assert(badAnswersReport.qaQualityAnalysis.outOfDomainCount > 0, 'Flags answers outside medical specialization');

console.log('\n====================================================');
console.log(`Results: ${passedTests} passed out of ${totalTests} tests.`);
console.log('====================================================');
