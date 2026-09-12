import { runExpertVerificationAgent } from '../assets/js/ai/expertVerificationAgent.js';

async function testAgent() {
  console.log('=== TESTING CENTRALIZED EXPERT VERIFICATION AGENT ===');

  const testPayload = {
    profile: {
      full_name: 'Adv. Suresh Reddy',
      category: 'Legal',
      specialization: 'Corporate and Taxation Law',
      experience_years: 8,
      bio: 'Experienced High Court advocate specializing in corporate disputes.'
    },
    verification: {
      applicant_name: 'Adv. Suresh Reddy',
      id_holder_name: 'Suresh Reddy',
      id_document_path: 'experts/id_proof.pdf',
      degree_qualification: 'LL.B',
      university: 'National Law School',
      degree_document_path: 'experts/degree.pdf',
      council_registration_no: 'MAH/1234/2016',
      license_document_path: 'experts/license.pdf',
      license_issue_date: '2016-06-15',
      license_expiry_date: '2030-12-31'
    },
    documents: {
      idDocument: { fileName: 'id_proof.pdf', fileSize: 1024 * 1024, fileType: 'application/pdf' },
      degreeDocument: { fileName: 'degree.pdf', fileSize: 1.5 * 1024 * 1024, fileType: 'application/pdf' },
      licenseDocument: { fileName: 'license.pdf', fileSize: 1.2 * 1024 * 1024, fileType: 'application/pdf' }
    },
    answers: [
      { id: '101', body: 'Under Section 73 of the CGST Act, 2017, the proper officer may serve a notice requiring you to show cause within thirty days.' }
    ]
  };

  const report = runExpertVerificationAgent(testPayload);
  console.log('Report generated successfully:');
  console.log('- Overall Score:', report.overallScore);
  console.log('- Risk Level:', report.riskLevel);
  console.log('- Recommendation:', report.recommendation);
  console.log('- Advisory Note:', report.advisoryNote);
  console.log('- Identity Consistency:', JSON.stringify(report.identityConsistency));
  console.log('- Document Quality:', JSON.stringify(report.documentQuality));
  console.log('- Qualification Consistency:', JSON.stringify(report.qualificationConsistency));
  console.log('- License Consistency:', JSON.stringify(report.licenseConsistency));
  console.log('- Profile Consistency:', JSON.stringify(report.profileConsistency));
  console.log('- Expertise Consistency:', JSON.stringify(report.expertiseConsistency));
  console.log('- Q&A Quality Analysis:', JSON.stringify(report.qaQualityAnalysis));
  console.log('- Official Verification Status:', report.officialExternalVerification.status);
  console.log('- Official Verification Notice:', report.officialExternalVerification.notice);
  console.log('- Admin Decision Gate:', JSON.stringify(report.adminDecisionGate));

  const rawJson = JSON.stringify(report);
  const hasOverclaims = rawJson.includes('100% genuine') || rawJson.includes('100% authentic') || rawJson.includes('Government verified');
  console.log('- Overclaim check:', hasOverclaims ? 'FAIL: Forbidden claim present' : 'PASS: Zero overclaims');
}

testAgent().catch(console.error);
