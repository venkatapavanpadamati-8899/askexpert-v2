# AskExpert - Supabase Security & Integration Test Checklist

This document details the step-by-step validation protocol to test Row Level Security (RLS), Role-Based Access Control (RBAC), private storage policies, and end-to-end user workflows.

---

## 1. Supabase Database Hardening Execution

1. Open your **Supabase Dashboard**: `https://supabase.com/dashboard/project/girexuzrkeiylkbqglks`
2. Navigate to **SQL Editor** -> Click **New Query**.
3. Open [`supabase-security.sql`](file:///d:/ASKEXPERT/supabase-security.sql) from your workspace root.
4. Paste the entire SQL script into the editor and click **Run**.
5. Verify that all 11 tables have RLS enabled:
   ```sql
   SELECT tablename, rowsecurity
   FROM pg_tables
   WHERE schemaname = 'public';
   ```
   *Expected output: `rowsecurity = true` for all 11 public tables.*

---

## 2. Security Test Matrix

### Test 1: User Data & Chat Isolation
- [ ] **Action**: Create two distinct user accounts (User A and User B) via [`register.html`](file:///d:/ASKEXPERT/register.html).
- [ ] **Action**: Start a consultation with an expert using User A.
- [ ] **Test**: Query `public.messages` using User B's auth session.
- [ ] **Expected Result**: User B receives **0 rows** for User A's private consultation.

### Test 2: Professional Verification & Private Storage
- [ ] **Action**: Professional uploads Aadhaar / Govt ID and degree certificate on [`professional-verification.html`](file:///d:/ASKEXPERT/professional-verification.html).
- [ ] **Test**: Attempt to load the raw file URL using a public unauthenticated browser window.
- [ ] **Expected Result**: Supabase Storage returns `403 Forbidden` / `400 Invalid JWT`.
- [ ] **Test**: Admin logs into [`admin-login.html`](file:///d:/ASKEXPERT/admin-login.html) and inspects the application on [`admin-professionals.html`](file:///d:/ASKEXPERT/admin-professionals.html).
- [ ] **Expected Result**: Admin generates authenticated preview token and inspects document cleanly.

### Test 3: Role Escalation Prevention
- [ ] **Action**: Log into a regular `user` account.
- [ ] **Test**: Send an update query to change `role` to `admin` or modify `account_status`.
  ```javascript
  await supabase.from('profiles').update({ role: 'admin' }).eq('id', myUserId);
  ```
- [ ] **Expected Result**: Rejected by RLS policy. Only `is_admin()` can update roles.

### Test 4: Financial Ledger Integrity
- [ ] **Action**: Record a consultation payment via [`payments.html`](file:///d:/ASKEXPERT/payments.html).
- [ ] **Test**: Query `public.payments` as an unrelated user.
- [ ] **Expected Result**: Unrelated user only sees their own transactions (`user_id = auth.uid()` or `expert_id = auth.uid()`).

---

## 3. End-to-End Persona Verification Steps

### Flow 1: Client Question -> Expert Answer -> Consultation
1. [`register.html`](file:///d:/ASKEXPERT/register.html) -> Register as Client.
2. [`user-dashboard.html`](file:///d:/ASKEXPERT/user-dashboard.html) -> Click **Ask Question**.
3. [`ask-question.html`](file:///d:/ASKEXPERT/ask-question.html) -> Submit question with category tags.
4. [`questions.html`](file:///d:/ASKEXPERT/questions.html) -> View new question in feed.
5. [`question-details.html`](file:///d:/ASKEXPERT/question-details.html) -> Post reply as verified expert.
6. [`payments.html`](file:///d:/ASKEXPERT/payments.html) -> Unlock direct 1-on-1 consultation.
7. [`chat.html`](file:///d:/ASKEXPERT/chat.html) -> Exchange text, voice note, and media attachment.

### Flow 2: Professional Onboarding -> Approval -> Earnings
1. [`register.html`](file:///d:/ASKEXPERT/register.html) -> Register as Professional.
2. [`professional-verification.html`](file:///d:/ASKEXPERT/professional-verification.html) -> Complete 5-step wizard and upload council registration.
3. [`admin-login.html`](file:///d:/ASKEXPERT/admin-login.html) -> Admin logs in.
4. [`admin-professionals.html`](file:///d:/ASKEXPERT/admin-professionals.html) -> Admin approves application.
5. [`professional-dashboard.html`](file:///d:/ASKEXPERT/professional-dashboard.html) -> Expert workspace unlocks.
6. [`consultation-requests.html`](file:///d:/ASKEXPERT/consultation-requests.html) -> Expert accepts client inquiry.
7. [`professional-earnings.html`](file:///d:/ASKEXPERT/professional-earnings.html) -> View verified commission earnings and submit bank payout request.

### Flow 3: Admin Governance & Incident Resolution
1. [`admin-dashboard.html`](file:///d:/ASKEXPERT/admin-dashboard.html) -> Check platform GMV and pending KYC banner.
2. [`admin-users.html`](file:///d:/ASKEXPERT/admin-users.html) -> Inspect account directory.
3. [`admin-questions.html`](file:///d:/ASKEXPERT/admin-questions.html) -> Review flagged inquiries.
4. [`admin-payments.html`](file:///d:/ASKEXPERT/admin-payments.html) -> Approve pending payout disbursement.
5. [`admin-reports.html`](file:///d:/ASKEXPERT/admin-reports.html) -> Investigate dispute case and record resolution notes.
