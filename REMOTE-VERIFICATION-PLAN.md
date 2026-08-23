# AskExpert - Remote Supabase Verification & Sandbox Testing Runbook

**Target Project**: `https://girexuzrkeiylkbqglks.supabase.co`  
**Anon Key**: `sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P`  
**Environment**: Sandbox / Staging Pre-Flight  

---

## 1. Edge Functions Status Check

Verify that all 8 Edge Functions return `HTTP 200` (or `401 Unauthorized` on unauthenticated requests) instead of `404 Not Found`:

| Edge Function | Endpoint URI | Health / Auth Check Command | Expected Status |
|---|---|---|:---:|
| `payment-create` | `/functions/v1/payment-create` | `curl -i -X POST https://girexuzrkeiylkbqglks.supabase.co/functions/v1/payment-create` | `401 Unauthorized` / `200` (w/ JWT) |
| `payment-verify` | `/functions/v1/payment-verify` | `curl -i -X POST https://girexuzrkeiylkbqglks.supabase.co/functions/v1/payment-verify` | `401 Unauthorized` / `200` (w/ JWT) |
| `payment-webhook` | `/functions/v1/payment-webhook` | `curl -i -X POST https://girexuzrkeiylkbqglks.supabase.co/functions/v1/payment-webhook` | `400 Bad Request` (Missing Sig) |
| `session-start` | `/functions/v1/session-start` | `curl -i -X POST https://girexuzrkeiylkbqglks.supabase.co/functions/v1/session-start` | `401 Unauthorized` / `200` (w/ JWT) |
| `session-end` | `/functions/v1/session-end` | `curl -i -X POST https://girexuzrkeiylkbqglks.supabase.co/functions/v1/session-end` | `401 Unauthorized` / `200` (w/ JWT) |
| `session-dispute` | `/functions/v1/session-dispute` | `curl -i -X POST https://girexuzrkeiylkbqglks.supabase.co/functions/v1/session-dispute` | `401 Unauthorized` / `200` (w/ JWT) |
| `resolve-dispute` | `/functions/v1/resolve-dispute` | `curl -i -X POST https://girexuzrkeiylkbqglks.supabase.co/functions/v1/resolve-dispute` | `401 Unauthorized` (Admin Only) |
| `process-refund` | `/functions/v1/process-refund` | `curl -i -X POST https://girexuzrkeiylkbqglks.supabase.co/functions/v1/process-refund` | `401 Unauthorized` (Admin Only) |

---

## 2. Database Schema & RLS Policy Verification

Execute in [Supabase SQL Editor](https://supabase.com/dashboard/project/girexuzrkeiylkbqglks/sql) to verify that all 14 tables exist with Row Level Security active:

```sql
SELECT 
    schemaname, 
    tablename, 
    rowsecurity AS rls_enabled 
FROM pg_tables 
WHERE schemaname = 'public' 
ORDER BY tablename ASC;
```

### Required 14 Tables & RLS Status:
1. `answers` ──► `rls_enabled = true`
2. `consultation_requests` ──► `rls_enabled = true`
3. `consultation_sessions` ──► `rls_enabled = true`
4. `conversations` ──► `rls_enabled = true`
5. `messages` ──► `rls_enabled = true`
6. `notifications` ──► `rls_enabled = true`
7. `payments` ──► `rls_enabled = true`
8. `payout_requests` ──► `rls_enabled = true`
9. `professional_verifications` ──► `rls_enabled = true`
10. `profiles` ──► `rls_enabled = true`
11. `questions` ──► `rls_enabled = true`
12. `reports` ──► `rls_enabled = true`
13. `reviews` ──► `rls_enabled = true`
14. `session_events` ──► `rls_enabled = true`

---

## 3. Storage Privacy Penetration Test

### Test 1: Public Read for Chat Attachments
- **URL**: `https://girexuzrkeiylkbqglks.supabase.co/storage/v1/object/public/chat-media/test-sample.png`
- **Expected**: HTTP 200 (if file exists) or HTTP 404 (Not Found). Never HTTP 403.

### Test 2: Unauthenticated Access to Private KYC Documents
- **URL**: `https://girexuzrkeiylkbqglks.supabase.co/storage/v1/object/public/private-verifications/aadhaar_card.pdf`
- **Expected**: **`HTTP 400 Invalid JWT`** or **`HTTP 403 Unauthorized`** (Protected).

---

## 4. Realtime Publications Verification

Verify published tables in Supabase:

```sql
SELECT 
    schemaname, 
    tablename 
FROM pg_publication_tables 
WHERE pubname = 'supabase_realtime' 
ORDER BY tablename ASC;
```

**Required Publications**:
- `messages` (Live chat streaming)
- `notifications` (Instant user & expert alerts)
- `consultation_requests` (Expert request notifications)
- `questions` (Public question stream updates)
- `answers` (Live answer feed updates)
- `payments` (Real-time payment status updates)

---

## 5. Sandbox Payment & Lifecycle Test Suite

### Scenario A: Happy Path (End-to-End Consultation)
1. **Order Creation**: Client opens [`payments.html?expert=11111111-1111-1111-1111-111111111111&fee=1200`](file:///d:/ASKEXPERT/payments.html).  
   `payment-create` generates order `order_test_xxxx` with ₹1,200 fee + ₹99 platform fee + ₹233.82 GST.
2. **Gateway Sandbox Payment**: Client completes mock payment using Razorpay/Cashfree test card / UPI.
3. **Cryptographic Verification**: `payment-verify` validates signature, unlocks conversation room, sets `status = 'successful'`.
4. **Session Start**: Client enters [`chat.html`](file:///d:/ASKEXPERT/chat.html) $\rightarrow$ `session-start` records 30-min timer.
5. **Chat Interaction**: Client and expert exchange text, images, and voice audio notes.
6. **Session End**: User clicks **End Consultation** $\rightarrow$ `session-end` calculates net earnings (`₹1,200 - 10% = ₹1,080`) and closes conversation.
7. **Verified Review**: Client submits 5-star rating on [`review.html`](file:///d:/ASKEXPERT/review.html) $\rightarrow$ updates `profiles.rating`.

---

### Scenario B: Negative & Edge Case Tests

| Test Case | Simulation | Expected Result |
|---|---|---|
| **Invalid Signature** | Client sends fake signature to `payment-verify`. | **Rejected**: HTTP 400 `Invalid payment signature`. |
| **Double Verification / Anti-Replay** | Client resubmits already verified `payment_id`. | **Rejected**: HTTP 400 `Payment already processed`. |
| **Failed Gateway Payment** | User cancels or simulates bank failure. | Payment marked `failed` in DB; room remains locked. |
| **Webhook Idempotency** | Gateway fires duplicate webhook event. | `payment-webhook` detects duplicate `provider_payment_id` and ignores redundant event. |
| **Dispute & Refund** | Client clicks **Report Issue / Dispute** in chat. | `session-dispute` freezes earnings $\rightarrow$ Admin approves refund in [`admin-reports.html`](file:///d:/ASKEXPERT/admin-reports.html) $\rightarrow$ `resolve-dispute` marks payment `refunded`. |

---

## 6. Final Production Launch Gate

```
[✓] Step 1: Execute SQL hardening script in Supabase
[✓] Step 2: Deploy 8 Edge Functions via `npx supabase functions deploy`
[✓] Step 3: Run Storage penetration test (Private bucket returns 403)
[✓] Step 4: Complete Sandbox payment transaction
[✓] Step 5: Test failed payment & duplicate verification defense
[✓] Step 6: Test session-end earnings calculation & review submission
[✓] Step 7: Test dispute adjudication in admin-reports.html
        ↓
Switch to Live Gateway Credentials (`rzp_live_*`)
        ↓
Point Production Webhook (`/functions/v1/payment-webhook`)
        ↓
Deploy `dist/` to Production Hosting
        ↓
🚀 ASKEXPERT IS LIVE!
```
