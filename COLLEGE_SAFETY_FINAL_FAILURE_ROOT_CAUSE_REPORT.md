# College Safety System — Final Failure Root Cause Report

## Executive Summary
During the dynamic E2E testing phase, two specific tests failed intermittently (Timeout Errors) and were subsequently identified as being caused by **test state contamination** rather than an underlying security or application defect.

The system was fully re-tested with precise cleanup procedures, yielding a **25/25 PASS** result. This report details the root cause of the previous failures and verifies that the application's security posture was never compromised.

---

## Failure 1: Test 22 (Anonymous Complaint Privacy)
**Symptom:**
Test 22 timed out while waiting for the `#isAnonymous` checkbox to become visible during form submission.

**Root Cause:**
* **Shared test fixture / stale incident state.**
* An earlier test in the suite (Test 17 or 18) submitted an SOS and transitioned it to `ACTIVE`, leaving the student with an active incident. 
* The `women-safety.html` frontend is designed to block new complaint submissions if a student already has an active incident (showing the "Incident Tracking" panel instead of the SOS form).
* Because the student still had an active incident, the form never loaded, causing Playwright to timeout.

**Application Security Defect:** No
**Test Isolation Defect:** Yes
**Fix:** Per-test cleanup / resilient fixture setup (explicitly cancelling active incidents before the test starts).
**Retest:** PASS

---

## Failure 2: Test 25 (SOS creates incident without location if permission denied)
**Symptom:**
Test 25 timed out attempting to click `#btnSendSOS`.

**Root Cause:**
* **Shared test fixture / stale incident state.**
* Similar to Test 22, Test 25 logged in as `studentA`. Because Test 22 (which we just fixed) created an *anonymous* active incident for `studentA`, the UI once again loaded the "Incident Tracking" panel instead of the SOS form.
* The test attempted to interact with `#btnSendSOS` which was hidden from the DOM.

**Application Security Defect:** No
**Test Isolation Defect:** Yes
**Fix:** Per-test cleanup / resilient fixture setup (closing any active incidents before the test proceeds).
**Retest:** PASS

---

## `fakeHash` Evidence Integrity Audit

During the source audit, a hardcoded value `content_hash: fakeHash` was observed in `assets/js/safety/safety.js`.

* **Is it an actual production value?** No, it is a hardcoded string `sha256:pending`.
* **Is it a test-only value?** No, it is currently running in the application frontend code as a placeholder.
* **Is it a placeholder?** Yes. The source code explicitly states: `// Hash could be generated locally here in real implementation. We'll use a placeholder.`
* **Does it impact evidence integrity?** 
  It limits the ability to cryptographically prove *client-side* non-repudiation (i.e., proving the file wasn't altered in transit before reaching the server). However, it does **not** introduce a security vulnerability into the storage infrastructure. Supabase Storage handles actual file persistence securely, and access is rigorously guarded by Storage RLS policies (preventing unauthorized downloads/cross-college access). 
* **Recommendation:** For production, implement a client-side SHA-256 hash calculation using Web Crypto API (`crypto.subtle.digest`) before upload to achieve true end-to-end evidence integrity, replacing the placeholder.

---

## Direct API Security & State Machine Verification

### Payload Spoofing (Verified PASS)
Tests successfully verified that malicious students cannot manipulate the `college_id` via payload spoofing. The API strictly enforces that the user's `college_id` is derived securely.

### State Machine Integrity (Verified PASS)
Valid state transitions (`ACTIVE` → `ACKNOWLEDGED`) succeed. Invalid or unauthorized transitions (e.g., student attempting to modify status/assignments or bypassing valid flows) are strictly rejected by the backend policies.
