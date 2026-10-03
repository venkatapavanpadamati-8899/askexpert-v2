# B.Tech Project Viva Preparation Guide: AskExpert

This guide contains anticipated questions and optimal answers for your project viva voce.

## 1. Project Overview & Architecture

**Q: What is the main objective of your project?**
**A:** The primary objective is to create a dual-purpose platform called AskExpert. It connects students with verified industry experts for consultation while simultaneously providing a rigorous campus safety module for emergency reporting and incident management. 

**Q: Why did you choose Vanilla JavaScript over frameworks like React or Angular?**
**A:** We opted for HTML, CSS, and Vanilla JS to maintain a lightweight, fast-loading frontend without the overhead of heavy frameworks. This allowed us to focus deeply on mastering DOM manipulation, browser APIs, and strict backend security integration.

**Q: Can you explain your database and backend architecture?**
**A:** We use a serverless architecture powered by Supabase, which is built on PostgreSQL. We leverage Supabase for Authentication (OTP), Realtime subscriptions (for chat and SOS alerts), Storage (for evidence and KYC docs), and Row Level Security (RLS) to enforce strict access control at the database layer.

## 2. Security & Data Privacy

**Q: How do you ensure that a student in College A cannot see complaints from College B?**
**A:** We implemented **Row Level Security (RLS)** in PostgreSQL. Every safety incident is tagged with a `college_id`. The RLS policy explicitly checks the authenticated user's `college_id` against the row's `college_id`. If they don't match, the database completely hides the row, making cross-college data leakage impossible.

**Q: How is the payment system secured against manipulation?**
**A:** Our payment and wallet system uses server-side validation. We implemented **replay protection**, ensuring a transaction ID can only be processed once. Balances are calculated securely via database RPCs (Remote Procedure Calls) rather than trusting client-side math.

**Q: What prevents a regular user from accessing the admin dashboard?**
**A:** We enforce **Role-Based Access Control (RBAC)**. When a user attempts an admin action (like approving an expert's KYC), a Supabase RPC function invokes a secondary function `is_admin()` to verify the user's role before executing the logic. Furthermore, the frontend actively redirects unauthorized users away from admin routes.

## 3. Testing & Reliability

**Q: How did you test your application?**
**A:** We utilized **Playwright** for end-to-end (E2E) automated testing. We developed a robust 41-test regression suite that runs directly against our production environment. 

**Q: What kind of scenarios did your tests cover?**
**A:** Our tests cover UI functionality (e.g., submitting an SOS), edge cases (e.g., rapid duplicate SOS spam, offline behavior simulation), and most importantly, security hardening (e.g., attempting to access unauthorized chat sessions, testing payload manipulation to change a `college_id`).

**Q: We noticed an `ERR_ABORTED` in some network logs. What is that?**
**A:** That is a non-blocking browser cancellation, often caused by a race condition where the automated test verifies the UI and closes the browser context *before* a background analytics fetch request completes. It does not indicate a failure in the application logic or data integrity.

## 4. Specific Implementation Details

**Q: How does the SOS system work in real-time?**
**A:** When a student triggers an SOS, the client captures their GPS coordinates via the Geolocation API and inserts a high-priority incident into the database. The college authority's dashboard uses Supabase Realtime subscriptions to instantly receive the payload and display an alert without requiring a page refresh.

**Q: Explain the KYC process for Experts.**
**A:** An aspiring expert registers and submits proof of their credentials (documents uploaded securely to Supabase Storage). Their status is marked as `PENDING`. Only a System Admin can view these documents on the admin dashboard and trigger an RPC to update their status to `APPROVED`, at which point their profile becomes visible to students.
