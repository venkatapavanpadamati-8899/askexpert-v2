# AskExpert - Production Deployment & Operational Runbook

This guide contains step-by-step instructions for deploying AskExpert into live production on Supabase and connecting payment gateways.

---

## 1. Database & Security Initialization

1. Open the [Supabase Dashboard](https://supabase.com/dashboard) and select project: `girexuzrkeiylkbqglks`.
2. Go to **SQL Editor** $\rightarrow$ **New Query**.
3. Paste and run the entire [`supabase-security.sql`](file:///d:/ASKEXPERT/supabase-security.sql) script:
   - Provisions 14 core tables with constraints and foreign keys.
   - Creates `public.is_admin()` and `public.is_expert()` security definer functions.
   - Attaches `handle_new_user()` trigger to `auth.users`.
   - Enables **Row Level Security (RLS)** with fine-grained RBAC policies across all tables.
   - Configures storage bucket rules for `chat-media` (public) and `private-verifications` (private).
   - Enables Realtime publication on `messages`, `notifications`, and `consultation_requests`.

---

## 2. Supabase Storage Buckets Setup

Navigate to **Storage** in your Supabase dashboard and verify two buckets exist:

| Bucket Name | Public / Private | Purpose | Security Rule |
|---|---|---|---|
| `chat-media` | **Public** | Consultation photos, videos, PDFs, voice audio notes (`.webm`) | Upload restricted to authenticated session participants |
| `private-verifications` | **Strictly Private** | Professional Aadhaar/Govt IDs, degree certificates, bar council licenses | Direct URLs return `403`; inspection requires admin signed tokens |

---

## 3. Deploy Supabase Edge Functions

Run the following commands in terminal:

```bash
# 1. Login to Supabase CLI
npx supabase login

# 2. Link local project to your remote Supabase instance
npx supabase link --project-ref girexuzrkeiylkbqglks

# 3. Deploy all 8 authoritative Edge Functions
npx supabase functions deploy payment-create
npx supabase functions deploy payment-verify
npx supabase functions deploy payment-webhook
npx supabase functions deploy session-start
npx supabase functions deploy session-end
npx supabase functions deploy session-dispute
npx supabase functions deploy resolve-dispute
npx supabase functions deploy process-refund
```

---

## 4. Set Production Environment Secrets

Set your live payment gateway keys securely in Supabase (do NOT put secret keys in frontend HTML/JS):

```bash
npx supabase secrets set GATEWAY_KEY_ID="rzp_live_xxxxxxxxxxxxxx"
npx supabase secrets set GATEWAY_KEY_SECRET="your_live_secret_key"
npx supabase secrets set GATEWAY_WEBHOOK_SECRET="your_live_webhook_signing_secret"
```

---

## 5. Configure Gateway Webhook Endpoint

In your Payment Gateway dashboard (e.g., Razorpay / Cashfree / Stripe):

1. **Webhook URL**:
   ```
   https://girexuzrkeiylkbqglks.supabase.co/functions/v1/payment-webhook
   ```
2. **Subscribed Events**:
   - `payment.captured` / `payment.succeeded`
   - `payment.failed`
   - `refund.processed` / `refund.created`
3. **Secret**: Enter the exact secret configured in `GATEWAY_WEBHOOK_SECRET`.

---

## 6. Frontend Production Build & Hosting

1. Generate optimized production bundle:
   ```bash
   npm run build
   ```
2. Deploy the generated `dist/` directory to your static host (Cloudflare Pages, Vercel, Netlify, or AWS S3/CloudFront).

---

## 7. Live Production Smoke Test Sequence

| Stage | User Flow | Verification Point |
|:---:|---|---|
| **1** | Client signs up & logs in | Profile created in `public.profiles` with `role = 'user'` |
| **2** | Professional registers with degree | Documents upload to `private-verifications`; status = `pending` |
| **3** | Admin approves professional | Admin clicks Approve in `admin-professionals.html`; status = `verified` |
| **4** | Client asks question | Question visible in `questions.html` stream |
| **5** | Client books consultation | Order generated via `payment-create`; paid via gateway; verified via `payment-verify` |
| **6** | Active Consultation | Server countdown timer running; Realtime text, images, and voice notes sync |
| **7** | Session Completion | Client ends session $\rightarrow$ `session-end` calculates net earnings $\rightarrow$ redirects to `review.html` |
| **8** | Review Submission | 1–5★ rating posted $\rightarrow$ expert aggregate score recalculated |
| **9** | Dispute & Resolution | Client files issue $\rightarrow$ `session-dispute` freezes earnings $\rightarrow$ Admin adjudicates refund in `admin-reports.html` |
