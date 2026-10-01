# College Safety Dynamic Security Test Report

## Status
STATUS: FAILED

## 1. Test Counts
- **Total**: 25
- **Passed**: 8
- **Failed**: 4
- **Skipped**: 13
- **Blocked**: 0

## 2. Failed Tests

### 1. Phase 1 — Student Flow › Normal complaint creation & Evidence Upload
- **Exact Error**: 
  ```text
  Error: expect(locator).toHaveText(expected) failed
  Locator:  locator('#notice')
  Expected: "Submitted successfully. Your college safety team has been notified."
  Received: "Failed: Could not find the 'duplicate_of_id' column of 'safety_incidents' in the schema cache"
  Timeout:  10000ms
  ```
- **Browser**: Chromium
- **API/Supabase Error**: `Could not find the 'duplicate_of_id' column of 'safety_incidents' in the schema cache`
- **Root Cause Category**: Schema / PostgREST Cache. The PostgREST schema cache needs to be reloaded so that the API recognizes the latest database schema (possibly an outdated cache missing columns like `duplicate_of_id`).

### 2. Phase 1 — Student Flow › SOS creation
- **Exact Error**:
  ```text
  Error: expect(locator).toContainText(expected) failed
  Locator: locator('#incidentId')
  Expected substring: "medical_emergency"
  Received string:    "Incident: 09215BF8 | Type: harassment | Severity: HIGH"
  Timeout: 5000ms
  ```
- **Browser**: Chromium
- **Root Cause Category**: Cascading Failure / Test State. Because the previous test (Normal Complaint) failed with a schema cache error during the `insert`, the database may have actually inserted the `harassment` incident but the client threw an error. This SOS test is inadvertently picking up the leftover incident from the previous test rather than a newly created SOS.

### 3. Phase 2 — Authority Flow › Authorized staff access and visibility
- **Exact Error**:
  ```text
  Error: expect(locator).toBeVisible() failed
  Locator: locator('.incident').first()
  Expected: visible
  Timeout: 5000ms
  Error: element(s) not found
  ```
- **Browser**: Chromium
- **Root Cause Category**: Cascading Failure / Database. Staff is trying to view incidents, but due to previous tests failing to properly create and complete an incident flow, there are no incidents visible on the dashboard.

### 4. Phase 2 — Authority Flow › Acknowledge and Assign
- **Exact Error**:
  ```text
  Test timeout of 30000ms exceeded.
  Error: locator.click: Test timeout of 30000ms exceeded.
  Call log:
    - waiting for locator('.incident').first().locator('button:has-text("Acknowledge & Assign to Me")')
  ```
- **Browser**: Chromium
- **Root Cause Category**: Cascading Failure. Staff cannot find any incidents to interact with.

## 3. Security/RLS Findings
Most of the deep Security/RLS tests (Phase 5) were skipped because they depend on a working Student (Phase 1) and Authority (Phase 2) flow. We must resolve the schema cache issue blocking `safety_incidents` creation before we can evaluate the security rules.

## 4. Storage Findings
The storage tests (Phase 5 — Storage Rules Enforcement) were skipped.

## 5. Auth Findings
The auth flow works flawlessly. The synthetic test accounts successfully authenticated during `verify_test_fixture.mjs` and Playwright was able to run tests that required authentication.

## 6. Synthetic Data Cleanup
- The cleanup script `tests/college-safety/setup/TEST_DATA_TEARDOWN.sql` was executed successfully.
- All synthetic test incidents, profiles, staff records, locations, evidence, messages, notifications, and test Auth users have been properly removed from the linked database.

## 7. Final Status
- **FAILED**. The suite is currently blocked by a PostgREST schema cache error involving `duplicate_of_id`. We need to reload the Supabase schema cache before rerunning the tests.
