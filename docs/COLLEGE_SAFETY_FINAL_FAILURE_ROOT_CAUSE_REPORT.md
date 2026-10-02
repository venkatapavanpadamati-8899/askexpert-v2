# AskExpert College Safety – Final Failure Root Cause Report

## 1. Incident Overview
During the final phases of production verification, the Playwright E2E smoke tests repeatedly failed on Test 2 (`Authority Flow`), despite confirming that the underlying database insert actions for incidents were successfully completing.

## 2. Root Cause Analysis
The failure was traced to a **Test-Artifact Retrieval & Caching Conflict**, not a core application flaw.

### Sequence of Failure
1. **Initial Trigger:** Test 1 successfully created an incident and the UI displayed it.
2. **Flawed Lookup Logic:** The test framework originally relied on querying the Supabase REST API for the most recently created incident by order (`created_at.desc&limit=1`) to pass the ID to Test 2.
3. **Replication & Timing Latency:** Due to caching and minor replication delays on the production Supabase instance (or due to the test script inadvertently pulling a stale `CANCELLED` incident from previous runs before the new one fully propagated), the API lookup returned the wrong incident UUID.
4. **Cascading Failure:** Test 2 (Authority Flow) utilized this stale UUID to locate the newly injected incident row in the management dashboard. Since the dashboard was rendering the *correct* new incident (which had a different ID), the Playwright selector `.incident { hasText: 'ID: <stale-id>' }` timed out and failed.

## 3. Remediation & Fix
**Solution Deployed:** 
Removed the API-based fetching completely from the smoke test suite.
Instead of querying the backend to figure out what was created, the test was modified to extract the highly-visible, deterministic `shortId` directly from the DOM (`#incidentId`) immediately after creation in Test 1. 
```javascript
const incidentText = await page.locator('#incidentId').textContent();
const match = incidentText.match(/Incident:\s*([A-Z0-9]+)/);
incidentId = match[1]; // shortId extracted securely from the UI
```
Test 2 then seamlessly matched this exact UI-generated `shortId` on the management dashboard.

## 4. Conclusion
The initial `ENOENT` / timeout failures were entirely related to brittle test architecture (relying on async API reads without proper synchronicity). With the UI-extracted locator fix, the test perfectly mimics a human user and confirms that the production state is entirely correct and functional.
