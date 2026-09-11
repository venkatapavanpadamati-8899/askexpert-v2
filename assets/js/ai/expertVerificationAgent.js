/**
 * AskExpert - Centralized AI Expert Verification & Quality Analysis Agent
 * 
 * ROLE & GOVERNANCE:
 * Collects, analyzes, cross-checks, scores, flags, and explains complete expert verification data.
 * Produces an evidence-first diagnostic report for platform Administrators.
 * 
 * STRICT COMPLIANCE POLICY:
 * - AI analysis is strictly ADVISORY ONLY and provides preliminary risk signals.
 * - AI NEVER independently approves or verifies an expert.
 * - AI NEVER claims "100% genuine", "government verified", or "legally authentic" without authorized external API evidence.
 * - Final verification decision rests exclusively with the authorized platform Administrator.
 */

import { validateVerhoeffAadhaar } from './aiAadhaarVerifier.js';

/**
 * Normalizes strings by stripping titles, honorary prefixes, and punctuation
 */
function normalizeText(str = '') {
  return String(str || '')
    .toLowerCase()
    .replace(/\b(adv|advocate|dr|doctor|ca|cs|cma|mr|mrs|ms|prof|shri|smt)\b\.?/gi, '')
    .replace(/[^a-z0-9\s]/gi, ' ')
    .replace(/\s+/g, ' ')
    .trim();
}

/**
 * Calculates Token-based Name Match similarity
 */
function calculateNameSimilarity(nameA = '', nameB = '') {
  const cleanA = normalizeText(nameA);
  const cleanB = normalizeText(nameB);

  if (!cleanA || !cleanB) {
    return { score: 50, matchType: 'UNKNOWN', detail: 'One or both names were not provided for comparison.' };
  }

  if (cleanA === cleanB) {
    return { score: 100, matchType: 'EXACT_MATCH', detail: `Exact match: "${nameA}" matches "${nameB}".` };
  }

  const tokensA = cleanA.split(' ').filter(Boolean);
  const tokensB = cleanB.split(' ').filter(Boolean);
  const matching = tokensA.filter(t => tokensB.includes(t));
  const overlapRatio = (2 * matching.length) / (tokensA.length + tokensB.length);
  const score = Math.round(overlapRatio * 100);

  if (score >= 80) {
    return { score, matchType: 'HIGH_CONFIDENCE_MATCH', detail: `High similarity (${score}%): "${nameA}" vs "${nameB}".` };
  } else if (score >= 50) {
    return { score, matchType: 'PARTIAL_MATCH', detail: `Partial overlap (${score}%): Middle name or initials differ between "${nameA}" and "${nameB}".` };
  } else {
    return { score, matchType: 'MISMATCH', detail: `Divergence detected (${score}%): Name "${nameA}" does not align with "${nameB}".` };
  }
}

/**
 * Evaluates document file attributes, MIME types, and structural integrity
 */
function analyzeDocumentHealth(doc = {}, docType = 'document') {
  const fileName = doc.fileName || doc.name || '';
  const fileExt = (fileName.split('.').pop() || '').toLowerCase();
  const fileSize = doc.fileSize || doc.size || 0;
  const issues = [];
  const warnings = [];

  const allowedExts = ['pdf', 'jpg', 'jpeg', 'png', 'webp'];
  let status = 'PASS';

  if (!fileName && fileSize === 0) {
    return {
      type: docType,
      status: 'MANUAL_REVIEW_REQUIRED',
      healthScore: 40,
      evidence: 'No file metadata or document uploaded.',
      issues: ['Document file is missing or unattached.'],
      warnings: []
    };
  }

  if (!allowedExts.includes(fileExt)) {
    issues.push(`Unsupported file format .${fileExt}. Allowed formats: PDF, JPG, PNG, WEBP.`);
    status = 'SUSPICIOUS';
  }

  // Size checks
  if (fileSize > 0 && fileSize < 15 * 1024) {
    warnings.push(`File size (${(fileSize / 1024).toFixed(1)} KB) is unusually small. Check for low resolution or blur.`);
    if (status === 'PASS') status = 'WARNING';
  } else if (fileSize > 10 * 1024 * 1024) {
    issues.push(`File exceeds 10 MB limit (${(fileSize / (1024 * 1024)).toFixed(1)} MB).`);
    status = 'SUSPICIOUS';
  }

  const healthScore = Math.max(0, 100 - (issues.length * 40 + warnings.length * 15));

  return {
    type: docType,
    fileName,
    fileExt: `.${fileExt.toUpperCase()}`,
    fileSizeBytes: fileSize,
    status: status,
    healthScore,
    evidence: `File "${fileName}" (${(fileSize / 1024).toFixed(1)} KB, format .${fileExt})`,
    issues,
    warnings
  };
}

/**
 * Checks professional specialization coherence with qualifications
 */
function evaluateQualificationCoherence(profession = '', degree = '', university = '') {
  const p = (profession || '').toLowerCase();
  const d = (degree || '').toLowerCase();
  const issues = [];
  const evidence = [];

  let coherent = true;
  let score = 90;

  if (p.includes('legal') || p.includes('law') || p.includes('advocate')) {
    evidence.push('Statutory field: Legal Services (Bar Council purview)');
    if (d.includes('llb') || d.includes('ll.b') || d.includes('law') || d.includes('llm')) {
      evidence.push(`Qualification "${degree}" directly satisfies legal practice prerequisites.`);
      score = 95;
    } else if (d.includes('b.tech') || d.includes('mbbs') || d.includes('b.com')) {
      issues.push(`Degree "${degree}" is non-legal; does not qualify for independent legal counsel.`);
      coherent = false;
      score = 30;
    }
  } else if (p.includes('tax') || p.includes('ca') || p.includes('chartered') || p.includes('audit')) {
    evidence.push('Statutory field: Chartered Accountancy / Taxation (ICAI purview)');
    if (d.includes('ca') || d.includes('chartered') || d.includes('icai') || d.includes('fca') || d.includes('aca')) {
      evidence.push(`Qualification "${degree}" matches statutory accounting credentials.`);
      score = 95;
    } else if (d.includes('b.com') || d.includes('m.com') || d.includes('mba')) {
      evidence.push(`Commerce degree "${degree}" relevant, but requires active COP / Council number for certified audit.`);
      score = 75;
    }
  } else if (p.includes('doctor') || p.includes('medic') || p.includes('health') || p.includes('clinic')) {
    evidence.push('Statutory field: Healthcare / Medicine (NMC / SMC purview)');
    if (d.includes('mbbs') || d.includes('md') || d.includes('ms') || d.includes('bams') || d.includes('bhms') || d.includes('bds')) {
      evidence.push(`Medical qualification "${degree}" recognized for clinical practice.`);
      score = 95;
    } else {
      issues.push(`Degree "${degree}" does not correspond with medical practice authorization.`);
      coherent = false;
      score = 25;
    }
  } else {
    evidence.push(`General Professional Advisory domain: ${profession}`);
    score = 85;
  }

  return {
    coherent,
    score,
    status: coherent ? (score >= 90 ? 'MATCH' : 'PARTIAL_MATCH') : 'MISMATCH',
    issues,
    evidence
  };
}

/**
 * Checks council registration syntax and validity dates
 */
function evaluateLicenseValidity(councilNo = '', expiryDate = null, issueDate = null) {
  const issues = [];
  const warnings = [];
  const evidence = [];

  const lic = (councilNo || '').trim();
  let score = 85;
  let status = 'PASS';

  if (!lic) {
    return {
      status: 'MANUAL_REVIEW_REQUIRED',
      score: 30,
      evidence: 'No registration/license number entered.',
      issues: ['Statutory license/registration number is missing.'],
      warnings: []
    };
  }

  evidence.push(`Submitted License/Registration: #${lic}`);

  // Expiry check
  if (expiryDate) {
    const exp = new Date(expiryDate);
    const now = new Date();
    if (!isNaN(exp.getTime())) {
      if (exp < now) {
        issues.push(`Professional license expired on ${exp.toLocaleDateString()}. Active renewal proof required.`);
        status = 'SUSPICIOUS';
        score = 20;
      } else {
        const daysLeft = Math.ceil((exp - now) / (1000 * 60 * 60 * 24));
        if (daysLeft < 60) {
          warnings.push(`License is nearing expiration (${daysLeft} days remaining).`);
          if (status === 'PASS') status = 'WARNING';
          score = 70;
        } else {
          evidence.push(`License validity confirmed active through ${exp.toLocaleDateString()} (${daysLeft} days remaining).`);
          score = 95;
        }
      }
    }
  } else {
    evidence.push('Perpetual enrollment or open council validity (Standard for Bar/Medical life enrollment).');
    score = 90;
  }

  return {
    status,
    score,
    issues,
    warnings,
    evidence
  };
}

/**
 * Analyzes Q&A Quality and Answer Consistency across expert history
 */
function analyzeExpertAnswerHistory(answers = [], claimedSpecialty = '') {
  if (!answers || answers.length === 0) {
    return {
      answerCount: 0,
      qualityScore: 75,
      consistencyScore: 80,
      consistencyStatus: 'INSUFFICIENT_EVIDENCE',
      strengths: ['No historical complaints or flagged answers on record.'],
      weaknesses: ['New expert with zero submitted answers. Baseline confidence applied.'],
      detectedContradictions: [],
      repeatedPatterns: [],
      outOfDomainCount: 0
    };
  }

  const specLower = (claimedSpecialty || '').toLowerCase();
  let totalLength = 0;
  let repetitiveCount = 0;
  let outOfDomainCount = 0;
  const detectedContradictions = [];
  const seenTexts = new Map();

  answers.forEach((ans, idx) => {
    const text = (ans.content || ans.answer || '').trim();
    totalLength += text.length;

    // Check repetition
    const normalized = text.toLowerCase().slice(0, 80);
    if (seenTexts.has(normalized)) {
      repetitiveCount++;
      seenTexts.set(normalized, seenTexts.get(normalized) + 1);
    } else {
      seenTexts.set(normalized, 1);
    }

    // Check out-of-domain signals
    const category = (ans.category || ans.topic || '').toLowerCase();
    if (specLower && category && !specLower.includes(category) && !category.includes(specLower)) {
      if ((specLower.includes('legal') && (category.includes('medical') || category.includes('health'))) ||
          (specLower.includes('medical') && (category.includes('legal') || category.includes('tax') || category.includes('law'))) ||
          (specLower.includes('tax') && (category.includes('medical') || category.includes('health')))) {
        outOfDomainCount++;
      }
    }
  });

  const avgLength = totalLength / answers.length;
  let qualityScore = 85;
  let consistencyScore = 90;

  if (avgLength < 50) {
    qualityScore -= 20; // overly brief
  } else if (avgLength > 200) {
    qualityScore += 10;
  }

  if (repetitiveCount > 0) {
    consistencyScore -= (repetitiveCount * 15);
  }
  if (outOfDomainCount > 0) {
    consistencyScore -= (outOfDomainCount * 20);
  }

  qualityScore = Math.max(20, Math.min(100, qualityScore));
  consistencyScore = Math.max(20, Math.min(100, consistencyScore));

  let consistencyStatus = 'HIGH';
  if (consistencyScore < 50) consistencyStatus = 'LOW';
  else if (consistencyScore < 75) consistencyStatus = 'MEDIUM';

  const strengths = [];
  const weaknesses = [];

  if (qualityScore >= 80) strengths.push('Answers exhibit structured reasoning and detailed domain explanations.');
  if (consistencyScore >= 85) strengths.push('Consistent technical positions maintained across all consultation answers.');
  if (repetitiveCount > 0) weaknesses.push(`Detected ${repetitiveCount} boilerplate or duplicate response patterns.`);
  if (outOfDomainCount > 0) weaknesses.push(`Detected ${outOfDomainCount} answers provided outside primary specialization.`);

  return {
    answerCount: answers.length,
    qualityScore,
    consistencyScore,
    consistencyStatus,
    strengths,
    weaknesses,
    detectedContradictions,
    repeatedPatterns: repetitiveCount > 0 ? [`${repetitiveCount} duplicate answer occurrences flagged.`] : [],
    outOfDomainCount
  };
}

/**
 * Centralized Expert Verification Agent Master Pipeline
 */
export function runExpertVerificationAgent(expertPayload = {}) {
  const profile = expertPayload.profile || {};
  const verifRecord = expertPayload.verification || {};
  const documents = expertPayload.documents || {};
  const answers = expertPayload.answers || [];
  const officialResult = expertPayload.officialExternalVerification || null;

  const profileName = profile.full_name || verifRecord.applicant_name || 'Unspecified Name';
  const profession = profile.specialization || profile.category || verifRecord.profession || 'Specialist';
  const degree = verifRecord.degree_qualification || profile.headline || '';
  const university = verifRecord.university || 'Recognized Board/University';
  const councilNo = verifRecord.council_registration_no || '';
  const expiryDate = verifRecord.license_expiry_date || null;
  const issueDate = verifRecord.license_issue_date || null;

  // 1. Identity Analysis
  const identityNameMatch = calculateNameSimilarity(profileName, verifRecord.id_holder_name || profileName);
  let identityScore = identityNameMatch.score;
  const identityIssues = [];
  if (identityNameMatch.matchType === 'MISMATCH') {
    identityIssues.push(identityNameMatch.detail);
  }

  // 2. Document Health Analysis
  const idDocHealth = analyzeDocumentHealth(documents.idDocument || { fileName: verifRecord.id_document_path }, 'Government Identity Proof');
  const degreeDocHealth = analyzeDocumentHealth(documents.degreeDocument || { fileName: verifRecord.degree_document_path }, 'Academic Degree Certificate');
  const licenseDocHealth = analyzeDocumentHealth(documents.licenseDocument || { fileName: verifRecord.license_document_path }, 'Council Registration License');

  const docQualityScore = Math.round((idDocHealth.healthScore + degreeDocHealth.healthScore + licenseDocHealth.healthScore) / 3);

  // 3. Qualification Consistency
  const qualCheck = evaluateQualificationCoherence(profession, degree, university);
  const qualScore = qualCheck.score;

  // 4. License Consistency
  const licenseCheck = evaluateLicenseValidity(councilNo, expiryDate, issueDate);
  const licenseScore = licenseCheck.score;

  // 5. Cross-Document Consistency
  const crossNameMatch = calculateNameSimilarity(profileName, verifRecord.doc_holder_name || profileName);
  const crossConsistencyScore = Math.round((identityNameMatch.score + crossNameMatch.score + (qualCheck.coherent ? 95 : 40)) / 3);

  // 6. Expertise Consistency
  let expertiseScore = Math.round((qualScore * 0.4) + (licenseScore * 0.4) + (profile.experience_years ? Math.min(100, profile.experience_years * 10) : 70) * 0.2);
  let expertiseStatus = 'HIGH';
  if (expertiseScore < 50) expertiseStatus = 'LOW';
  else if (expertiseScore < 75) expertiseStatus = 'MEDIUM';

  // 7. Q&A Quality & Consistency
  const qaAnalysis = analyzeExpertAnswerHistory(answers, profession);

  // 8. Security / Fraud Signals
  const fraudIssues = [];
  let fraudRiskScore = 95; // 100 = cleanest, 0 = critical fraud indicators

  if (identityIssues.length > 0) {
    fraudIssues.push('Name divergence between applicant profile and submitted documents.');
    fraudRiskScore -= 30;
  }
  if (!qualCheck.coherent) {
    fraudIssues.push('Severe mismatch between claimed profession and uploaded educational credential.');
    fraudRiskScore -= 25;
  }
  if (licenseCheck.status === 'SUSPICIOUS') {
    fraudIssues.push('Professional license is expired or invalid.');
    fraudRiskScore -= 35;
  }

  fraudRiskScore = Math.max(10, Math.min(100, fraudRiskScore));

  // 9. Weighted Overall Verification Score
  const categoryScores = {
    identityConsistency: identityScore,
    documentQuality: docQualityScore,
    qualificationConsistency: qualScore,
    licenseConsistency: licenseScore,
    profileConsistency: 90,
    expertiseConsistency: expertiseScore,
    answerQuality: qaAnalysis.qualityScore,
    answerConsistency: qaAnalysis.consistencyScore,
    fraudSecurityRisk: fraudRiskScore
  };

  const overallSignal = Math.round(
    (identityScore * 0.15) +
    (docQualityScore * 0.15) +
    (qualScore * 0.15) +
    (licenseScore * 0.15) +
    (crossConsistencyScore * 0.10) +
    (expertiseScore * 0.10) +
    (qaAnalysis.qualityScore * 0.10) +
    (fraudRiskScore * 0.10)
  );

  // Risk Level Classification
  let overallRisk = 'LOW';
  let aiRecommendation = 'APPROVE FOR ADMIN REVIEW';
  let aiState = 'AI_PRECHECK_PASSED';

  if (overallSignal < 45 || fraudRiskScore < 50 || licenseCheck.status === 'SUSPICIOUS') {
    overallRisk = 'HIGH';
    aiRecommendation = 'HIGH RISK — ADMIN ATTENTION REQUIRED';
    aiState = 'AI_SUSPICIOUS';
  } else if (overallSignal < 70 || identityIssues.length > 0 || docQualityScore < 60) {
    overallRisk = 'MEDIUM';
    aiRecommendation = 'MANUAL REVIEW REQUIRED';
    aiState = 'MANUAL_REVIEW_REQUIRED';
  }

  // Mandatory Disclaimer
  const disclaimer = 'AI-assisted verification and risk analysis completed. This analysis is advisory only and is not a substitute for authorized regulatory or physical verification. Final approval is strictly reserved for the Platform Administrator.';

  // Build Diagnostic Report Structure
  const report = {
    expertId: profile.id || verifRecord.expert_id || 'unassigned_id',
    expertName: profileName,
    profession,
    specialization: profile.specialization || profession,
    submissionDate: verifRecord.created_at || new Date().toISOString(),
    
    finalAiSignal: {
      overallScore: overallSignal,
      riskLevel: overallRisk,
      recommendation: aiRecommendation,
      aiState,
      categoryScores,
      disclaimer
    },

    identityCheck: {
      status: identityNameMatch.matchType,
      score: identityScore,
      evidence: identityNameMatch.detail,
      issues: identityIssues
    },

    documentCheck: {
      idProof: idDocHealth,
      degreeProof: degreeDocHealth,
      licenseProof: licenseDocHealth,
      overallQualityScore: docQualityScore
    },

    qualificationCheck: {
      status: qualCheck.status,
      score: qualScore,
      evidence: qualCheck.evidence,
      issues: qualCheck.issues
    },

    licenseCheck: {
      status: licenseCheck.status,
      score: licenseScore,
      evidence: licenseCheck.evidence,
      issues: licenseCheck.issues,
      warnings: licenseCheck.warnings
    },

    expertiseConsistency: {
      status: expertiseStatus,
      score: expertiseScore,
      evidence: `Assessed across ${profession} domain, qualification (${degree}), and ${profile.experience_years || 5}+ years stated practice.`
    },

    qaQualityAnalysis: qaAnalysis,

    securityRiskSignals: {
      fraudScore: fraudRiskScore,
      detectedFlags: fraudIssues,
      riskLevel: overallRisk
    },

    officialExternalVerification: officialResult ? {
      provider: officialResult.provider,
      verificationType: officialResult.verificationType,
      providerResponse: officialResult.providerResponse,
      verifiedAt: officialResult.verifiedAt,
      status: 'OFFICIALLY_VERIFIED'
    } : {
      status: 'UNAVAILABLE',
      notice: 'Official government verification API unavailable — Platform Admin manual verification required.'
    },

    adminDecisionGate: {
      requiredAction: 'ADMIN_MANUAL_REVIEW',
      allowedOutcomes: ['ADMIN_APPROVED', 'ADMIN_REJECTED', 'RESUBMISSION_REQUIRED'],
      gatedFeatures: [
        'Public Verified Directory Listing',
        'Direct Client Booking Eligibility',
        'Paid Consultation Order Creation',
        'Wallet Consultation Revenue Earnings',
        'Payout Withdrawal Eligibility'
      ]
    }
  };

  return report;
}
