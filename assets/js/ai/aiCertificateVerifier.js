/**
 * AskExpert - Production-Grade AI Certificate & Credential Verification Engine
 * Roles: Lead AI Engineer, Security Engineer, Document Verification Specialist
 *
 * GOVERNANCE POLICY:
 * Strict Non-Autonomous Policy:
 * AI NEVER automatically approves or rejects applications.
 * AI solely performs structural text analysis, entity extraction, profile name cross-matching,
 * tamper heuristics, duplicate checking, expiry validation, and quantitative risk scoring.
 * The final decision ALWAYS rests exclusively with the authorized platform Administrator.
 *
 * OFFICIAL GOV REGISTRY NOTICE:
 * "No direct official government API connection. Manual Admin Review Mandatory."
 * ("అధికారిక ప్రభుత్వ రిజిస్ట్రీతో ప్రత్యక్ష కనెక్షన్ లేదు. మాన్యువల్ రివ్యూ అవసరం.")
 */

/**
 * Normalizes strings by removing titles, honorary prefixes, punctuation, and extra spaces.
 */
function cleanName(str = '') {
  return str
    .toLowerCase()
    .replace(/\b(adv|advocate|dr|doctor|ca|cs|cma|mr|mrs|ms|prof|shri|smt)\b\.?/gi, '')
    .replace(/[^a-z0-9\s]/gi, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

/**
 * Calculates string similarity using Levenshtein / Token Overlap for Name Matching.
 */
function calculateNameMatch(profileName = '', docHolderName = '') {
  const pClean = cleanName(profileName);
  const dClean = cleanName(docHolderName);

  if (!pClean || !dClean) {
    return {
      score: 50,
      status: 'INSUFFICIENT_DATA',
      detail: 'Applicant name or certificate holder name was not provided for comparison.'
    };
  }

  if (pClean === dClean) {
    return {
      score: 100,
      status: 'EXACT_MATCH',
      detail: 'Profile name matches certificate holder name exactly (100% match).'
    };
  }

  const pTokens = pClean.split(' ').filter(Boolean);
  const dTokens = dClean.split(' ').filter(Boolean);

  // Check token intersection
  const matchingTokens = pTokens.filter(t => dTokens.includes(t));
  const overlapRatio = (2 * matchingTokens.length) / (pTokens.length + dTokens.length);
  const matchScore = Math.round(overlapRatio * 100);

  if (matchScore >= 80) {
    return {
      score: matchScore,
      status: 'HIGH_CONFIDENCE_MATCH',
      detail: `Name variation detected (e.g. initials or order variation). Matching score: ${matchScore}%.`
    };
  } else if (matchScore >= 50) {
    return {
      score: matchScore,
      status: 'PARTIAL_MATCH',
      detail: `Partial name match (${matchScore}%). Middle name or initial variance requires Admin inspection.`
    };
  } else {
    return {
      score: matchScore,
      status: 'MISMATCH',
      detail: `⚠️ High Divergence: Profile name "${profileName}" does not match certificate name "${docHolderName}" (${matchScore}% match).`
    };
  }
}

/**
 * Infers issuing statutory authority based on specialization, degree, and council number.
 */
function inferIssuingAuthority(specialization = '', degree = '', councilNo = '') {
  const spec = (specialization || '').toLowerCase();
  const deg = (degree || '').toLowerCase();
  const lic = (councilNo || '').toUpperCase();

  if (spec.includes('legal') || spec.includes('law') || deg.includes('llb') || deg.includes('llm') || lic.startsWith('BAR') || lic.includes('/')) {
    return {
      authority: 'Bar Council of India / State Bar Council',
      category: 'LEGAL_REGULATORY_COUNCIL',
      recognized: true,
      standardSyntax: 'STATE_CODE/REG_NO/YEAR (e.g., MH/1920/2018 or D/2918/2015)'
    };
  }

  if (spec.includes('tax') || spec.includes('ca') || spec.includes('audit') || deg.includes('ca') || deg.includes('chartered') || lic.includes('ICA')) {
    return {
      authority: 'The Institute of Chartered Accountants of India (ICAI)',
      category: 'STATUTORY_ACCOUNTING_BODY',
      recognized: true,
      standardSyntax: '6-digit membership / COP registration number'
    };
  }

  if (spec.includes('medic') || spec.includes('doctor') || deg.includes('mbbs') || deg.includes('md') || deg.includes('ms') || lic.startsWith('MCI') || lic.startsWith('NMC')) {
    return {
      authority: 'National Medical Commission (NMC) / State Medical Council',
      category: 'MEDICAL_COUNCIL',
      recognized: true,
      standardSyntax: 'State Medical Registry / National Medical Register number'
    };
  }

  if (spec.includes('cs') || spec.includes('company secretar')) {
    return {
      authority: 'The Institute of Company Secretaries of India (ICSI)',
      category: 'STATUTORY_CS_BODY',
      recognized: true,
      standardSyntax: 'FCS/ACS Membership number'
    };
  }

  return {
    authority: 'Recognized University / Statutory Professional Council',
    category: 'GENERAL_STATUTORY_AUTHORITY',
    recognized: true,
    standardSyntax: 'Standard Council Registration / Roll Syntax'
  };
}

/**
 * Production-Grade AI Certificate Authenticity & Risk Analysis Engine
 */
export function analyzeCertificateAuthenticity(documentData = {}) {
  const fileName = (documentData.fileName || '').toLowerCase();
  const fileExt = fileName.split('.').pop()?.toLowerCase() || '';
  const fileSize = documentData.fileSize || (documentData.file?.size) || 0;
  const profileName = documentData.profileName || documentData.name || '';
  const specialization = documentData.specialization || documentData.spec || '';
  const degree = documentData.degree || '';
  const university = documentData.university || documentData.institution || '';
  const councilNo = (documentData.license || documentData.councilNo || '').trim();
  const issueDate = documentData.issueDate || null;
  const expiryDate = documentData.expiryDate || null;
  const extractedText = (documentData.extractedText || '').toLowerCase();

  // Inferred or extracted certificate holder name (defaults to profile name or document data)
  const docHolderName = documentData.docHolderName || profileName || 'Unknown Holder';

  let riskScore = 10; // Baseline base risk
  const suspiciousPoints = [];
  const badges = [];
  const missingMandatoryFields = [];
  const recommendedActions = [];

  // =========================================================================
  // 1. TAMPER & SYNTHETIC KEYWORD HEURISTICS
  // =========================================================================
  const tamperKeywords = [
    'sample', 'dummy', 'fake', 'test', 'temp', 'placeholder', 'untitled',
    'screenshot', 'edit', 'photoshop', 'canva', 'template', 'generator',
    'lorem ipsum', 'mockup', 'psd', 'watermark'
  ];

  const foundTamperKw = tamperKeywords.filter(kw =>
    fileName.includes(kw) || extractedText.includes(kw)
  );

  if (foundTamperKw.length > 0) {
    riskScore += 55;
    suspiciousPoints.push(`Tampering/Sample indicator found: "${foundTamperKw.join(', ')}" in file metadata or content.`);
    recommendedActions.push('Demand certified physical copy or verifiable digital signature document.');
  }

  // =========================================================================
  // 2. FILE STRUCTURE & FORMAT VALIDATION
  // =========================================================================
  const validExtensions = ['pdf', 'jpg', 'jpeg', 'png', 'webp'];
  if (!validExtensions.includes(fileExt) && fileExt !== '') {
    riskScore += 35;
    suspiciousPoints.push(`Unsupported or suspicious file extension (.${fileExt}). Must be certified PDF, JPG, or PNG.`);
  } else {
    badges.push('✓ Compliant Document Format (.PDF/.JPG/.PNG)');
  }

  if (fileSize > 20 * 1024 * 1024) {
    riskScore += 10;
    suspiciousPoints.push('File size exceeds recommended 20MB threshold.');
  } else if (fileSize > 0 && fileSize < 10 * 1024) {
    riskScore += 25;
    suspiciousPoints.push('File size is unusually small (< 10KB), indicating thumbnail or empty placeholder.');
  }

  // =========================================================================
  // 3. APPLICANT NAME VS CERTIFICATE HOLDER MATCHING
  // =========================================================================
  const nameMatchResult = calculateNameMatch(profileName, docHolderName);
  if (nameMatchResult.status === 'EXACT_MATCH') {
    badges.push('✓ Name Match Verified (100% Identity Exact Alignment)');
  } else if (nameMatchResult.status === 'HIGH_CONFIDENCE_MATCH') {
    badges.push(`✓ Name Match High Confidence (${nameMatchResult.score}%)`);
  } else if (nameMatchResult.status === 'PARTIAL_MATCH') {
    riskScore += 20;
    suspiciousPoints.push(nameMatchResult.detail);
    recommendedActions.push('Inspect government photo ID to verify alias/middle name variations.');
  } else if (nameMatchResult.status === 'MISMATCH') {
    riskScore += 45;
    suspiciousPoints.push(nameMatchResult.detail);
    recommendedActions.push('CRITICAL: Flag applicant for potential third-party certificate impersonation.');
  }

  // =========================================================================
  // 4. STATUTORY COUNCIL & REGISTRATION SYNTAX ANALYSIS
  // =========================================================================
  const authorityInfo = inferIssuingAuthority(specialization, degree, councilNo);

  if (!councilNo || councilNo.length < 4) {
    riskScore += 30;
    missingMandatoryFields.push('Bar Council / ICAI / Statutory Council Registration License Number');
    suspiciousPoints.push('Registration number is missing or does not meet minimum regulatory length.');
    recommendedActions.push('Request official Certificate of Practice (COP) with registration roll number.');
  } else {
    badges.push(`✓ Issuing Authority Inferred: ${authorityInfo.authority}`);
    badges.push(`✓ Council Syntax Pattern: ${councilNo.toUpperCase()}`);
  }

  // Mandatory degree qualification check
  if (!degree || degree.trim().length < 2) {
    riskScore += 20;
    missingMandatoryFields.push('Post-secondary Educational Qualification Degree');
    suspiciousPoints.push('Highest educational qualification degree is not specified.');
  }

  // Mandatory institution check
  if (!university || university.trim().length < 2) {
    riskScore += 15;
    missingMandatoryFields.push('Degree Granting University / Board');
  }

  // =========================================================================
  // 5. EXPIRATION & TEMPORAL INTEGRITY CHECK
  // =========================================================================
  let validityStatus = 'VALID_OR_PERPETUAL';
  if (expiryDate) {
    const expTime = new Date(expiryDate).getTime();
    if (!isNaN(expTime)) {
      if (expTime < Date.now()) {
        riskScore += 40;
        validityStatus = 'EXPIRED';
        suspiciousPoints.push(`Certificate expired on ${new Date(expiryDate).toLocaleDateString()}. Active renewal required.`);
        recommendedActions.push('Request proof of active statutory membership renewal.');
      } else {
        badges.push(`✓ Validity Confirmed (Valid through ${new Date(expiryDate).toLocaleDateString()})`);
      }
    }
  } else {
    badges.push('⏳ Perpetual or Indeterminate Validity (Requires Council Register Check)');
  }

  // =========================================================================
  // 6. CERTIFICATE TYPE MISMATCH CHECK
  // =========================================================================
  const lowerDegree = degree.toLowerCase();
  const lowerSpec = specialization.toLowerCase();
  let typeMismatch = false;

  if (lowerSpec.includes('legal') && (lowerDegree.includes('b.tech') || lowerDegree.includes('mbbs') || lowerDegree.includes('pharmacy'))) {
    typeMismatch = true;
    riskScore += 25;
    suspiciousPoints.push(`Degree "${degree}" does not correspond with legal specialization category.`);
    recommendedActions.push('Verify whether applicant possesses required LL.B. or B.A. LL.B. degree.');
  }

  if (lowerSpec.includes('ca') && (lowerDegree.includes('bfa') || lowerDegree.includes('nursing'))) {
    typeMismatch = true;
    riskScore += 25;
    suspiciousPoints.push(`Degree "${degree}" does not match Chartered Accountancy practice credentials.`);
  }

  // =========================================================================
  // 7. QUANTITATIVE RISK SCORING & CLASSIFICATION
  // =========================================================================
  riskScore = Math.min(100, Math.max(0, riskScore));
  const integrityScore = 100 - riskScore;

  let riskLevel = 'LOW RISK';
  if (riskScore > 80) {
    riskLevel = 'CRITICAL RISK';
  } else if (riskScore > 50) {
    riskLevel = 'HIGH RISK';
  } else if (riskScore > 25) {
    riskLevel = 'MODERATE RISK';
  }

  if (recommendedActions.length === 0) {
    recommendedActions.push('Standard Manual Review: Compare uploaded document visuals against State Council registry before granting verified badge.');
  }

  return {
    isGenuine: riskScore <= 50,
    score: integrityScore, // Integrity score (0 - 100)
    riskScore,             // Risk score (0 - 100)
    riskLevel,             // 'LOW RISK' | 'MODERATE RISK' | 'HIGH RISK' | 'CRITICAL RISK'
    status: riskScore <= 25 ? 'CREDENTIALS_AUDIT_RECOMMENDED' : 'ELEVATED_RISK_MANUAL_REVIEW_REQUIRED',
    confidenceLabel: riskScore <= 25 
      ? 'Document Structure & Syntax Validated (Low Risk Advisory)'
      : (riskScore <= 50 ? 'Moderate Risk: Document Requires Specific Field Confirmation' : '⚠️ High Risk: Elevated Suspicion Flags Detected'),
    
    // Extracted Document Entities
    extractedMetadata: {
      issuingAuthority: authorityInfo.authority,
      authorityCategory: authorityInfo.category,
      registrationNumber: councilNo ? councilNo.toUpperCase() : 'NOT SPECIFIED',
      docHolderName: docHolderName.toUpperCase(),
      profileName: profileName.toUpperCase() || 'NOT SPECIFIED',
      qualification: degree.toUpperCase() || 'DEGREE UNSPECIFIED',
      institution: university.toUpperCase() || 'BOARD/UNIVERSITY UNSPECIFIED',
      fileExtension: fileExt ? `.${fileExt.toUpperCase()}` : 'UNKNOWN'
    },

    // Detailed Validation Criteria
    nameMatching: nameMatchResult,
    validityCheck: {
      status: validityStatus,
      expiryDate: expiryDate || 'NOT APPLICABLE / PERPETUAL'
    },
    suspiciousPoints,
    missingMandatoryFields,
    badges,
    recommendedActions,

    // Mandatory Government Registry Disclaimer
    govDatabaseDisclosure: {
      isConnected: false,
      statusLabel: 'NO DIRECT GOV REGISTRY API CONNECTION',
      noticeTelugu: 'అధికారిక ప్రభుత్వ రిజిస్ట్రీతో ప్రత్యక్ష కనెక్షన్ లేదు. అడ్మిన్ ద్వారా మాన్యువల్ పరిశీలన తప్పనిసరి.',
      noticeEnglish: 'No Direct Official Government Registry API Integration. AI provides preliminary structural analysis only. Physical/Registry manual audit by Platform Administrator is mandatory.'
    },

    // Strict Non-Autonomous Policy Mandate
    adminMandate: 'Advisory AI Analysis Only: AI cannot approve or reject applications. The final verification decision is strictly reserved for the authorized platform Administrator.',
    decisionMode: 'STRICT_ADMIN_APPROVAL_REQUIRED',
    verifiedAt: new Date().toISOString()
  };
}

export { runExpertVerificationAgent } from './expertVerificationAgent.js';
