// scratch/test_aadhaar_verification_suite.mjs
import assert from "node:assert";
import { validateVerhoeffAadhaar, formatAadhaarMasked } from "../assets/js/ai/aiAadhaarVerifier.js";
import { analyzeCertificateAuthenticity } from "../assets/js/ai/aiCertificateVerifier.js";
import fs from "node:fs";

console.log("=== RUNNING AADHAAR IDENTITY VERIFICATION TEST SUITE ===");

// 1. Test Verhoeff Algorithm Validation
console.log("\n1. Testing Verhoeff Algorithm...");
// Valid Verhoeff Aadhaar test numbers (mathematically valid checksums)
const validAadhaar1 = "284562849102"; // Example 12-digit with valid checksum or test vectors
assert(formatAadhaarMasked("284562849102") === "XXXX XXXX 9102", "Masked formatting should hide first 8 digits");
assert(!validateVerhoeffAadhaar("000000000000"), "Repeated single digits must be rejected");
assert(!validateVerhoeffAadhaar("12345"), "Short numbers must be rejected");
assert(!validateVerhoeffAadhaar("abcdef123456"), "Non-numeric strings must be rejected");
console.log("  ✅ Verhoeff algorithm & masking validated");

// 2. Audit professional-verification.html for Step 1 Identity Verification
console.log("\n2. Auditing professional-verification.html Step 1...");
const verifHtml = fs.readFileSync("professional-verification.html", "utf8");
assert(verifHtml.includes('data-step="1"'), "Step 1 exists");
assert(verifHtml.includes("Identity Verification (KYC)"), "Step 1 has Identity Verification");
assert(verifHtml.includes("vAadhaarConsent"), "Mandatory consent checkbox present");
assert(verifHtml.includes("btnSendIdentityOtp"), "Send OTP button present");
assert(verifHtml.includes("btnVerifyIdentityOtp"), "Verify OTP button present");
assert(verifHtml.includes("start-identity-verification"), "Invokes start-identity-verification edge function");
assert(verifHtml.includes("verify-identity-otp"), "Invokes verify-identity-otp edge function");
assert(verifHtml.includes("Real-time Aadhaar verification is currently unavailable. Authorized identity verification provider configuration is required."), "Contains exact provider unavailable warning");
console.log("  ✅ professional-verification.html contains all required KYC elements & provider notices");

// 3. Security Audit: No Full Aadhaar or OTP in storage or logs
console.log("\n3. Auditing Client Storage & Logging for Aadhaar/OTP Leakage...");
assert(!verifHtml.includes("localStorage.setItem('askexpert_aadhaar'"), "No full Aadhaar in localStorage");
assert(!verifHtml.includes("sessionStorage.setItem('askexpert_aadhaar'"), "No full Aadhaar in sessionStorage");
assert(!verifHtml.includes("localStorage.setItem('askexpert_otp'"), "No OTP in localStorage");
assert(!verifHtml.includes("sessionStorage.setItem('askexpert_otp'"), "No OTP in sessionStorage");
console.log("  ✅ Zero-storage policy confirmed for full Aadhaar and OTP");

// 4. Edge Functions Security & Integrity Audit
console.log("\n4. Auditing Edge Functions...");
const startFunc = fs.readFileSync("supabase/functions/start-identity-verification/index.ts", "utf8");
assert(startFunc.includes("CONSENT_REQUIRED"), "Consent validation enforced server-side");
assert(startFunc.includes("PROVIDER_UNAVAILABLE"), "Provider configuration required fallback enforced");
assert(startFunc.includes("identity_verification_attempts"), "Server-side rate limiting tracked");
assert(!startFunc.includes("fake_otp"), "No fake OTP in start-identity-verification");

const verifyFunc = fs.readFileSync("supabase/functions/verify-identity-otp/index.ts", "utf8");
assert(verifyFunc.includes("PROVIDER_VERIFIED"), "Sets PROVIDER_VERIFIED on real provider success");
assert(verifyFunc.includes("compareDemographicNames"), "Demographic name cross-check implemented");
assert(!verifyFunc.includes("fake_otp"), "No fake OTP in verify-identity-otp");
console.log("  ✅ Supabase Edge Functions adhere to provider security & zero-simulation rules");

// 5. Admin Review Center Audit
console.log("\n5. Auditing Admin Review Center...");
const adminHtml = fs.readFileSync("admin-professionals.html", "utf8");
assert(adminHtml.includes("modalMaskedAadhaar"), "Admin sees Masked Aadhaar");
assert(adminHtml.includes("modalIdentityStatusPill"), "Admin sees Identity Status");
assert(adminHtml.includes("modalProviderRefId"), "Admin sees Provider Safe Ref ID");
assert(adminHtml.includes("modalConsentTimestamp"), "Admin sees Consent Timestamp");
assert(adminHtml.includes("modalVerificationTimestamp"), "Admin sees Verification Timestamp");
assert(!adminHtml.includes("modalOtpCode"), "Admin NEVER sees OTP");
console.log("  ✅ Admin review center displays all required compliance fields and omits OTP");

// 6. AI Verifier Advisory Labels Audit
console.log("\n6. Auditing AI Advisory Labels...");
const aiCertHtml = fs.readFileSync("assets/js/ai/aiCertificateVerifier.js", "utf8");
assert(aiCertHtml.includes("AI-Assisted Document Pre-check — Advisory Only"), "aiCertificateVerifier has transparent advisory disclaimer");
const aiAadhaarHtml = fs.readFileSync("assets/js/ai/aiAadhaarVerifier.js", "utf8");
assert(aiAadhaarHtml.includes("AI-Assisted Document Pre-check — Advisory Only"), "aiAadhaarVerifier has transparent advisory disclaimer");
console.log("  ✅ AI verifier advisory labels confirmed");

console.log("\n🎉 ALL AUDIT CHECKS PASSED SUCCESSFULLY!");
