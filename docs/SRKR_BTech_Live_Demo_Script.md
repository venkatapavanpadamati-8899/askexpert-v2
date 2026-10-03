# AskExpert Live Demo Script

**Environment:** Production (`https://askexpert-v2.vercel.app`)

## Preparation Before the Demo
1. Ensure you have three distinct email addresses/accounts ready:
   - **Student Account** (e.g., test-student@example.com)
   - **Expert Account** (e.g., test-expert@example.com)
   - **Admin/Authority Account** (e.g., admin@college.edu)
2. Have a sample image/PDF ready on your local machine to use for KYC/Evidence upload.

---

## Step 1: Landing Page & Authentication (2 mins)
**Narrative:** "Welcome to AskExpert. We'll start by showing our secure, passwordless authentication flow."
**Action:**
1. Navigate to the homepage.
2. Click **Login** and enter the Student Email.
3. Show the OTP prompt. (If using a test email, retrieve the OTP from the Supabase dashboard or your email).
4. Enter OTP and log in. 
5. Briefly show the Student Dashboard.

---

## Step 2: Expert KYC & Admin Approval (3 mins)
**Narrative:** "Security and trust are paramount. Let's see how an Expert is verified before they can offer consultations."
**Action:**
1. Open a new Incognito window and log in as the **Expert**.
2. Navigate to the KYC submission page.
3. Fill out the professional details and upload a dummy certificate. Click Submit.
4. Point out the status is now **PENDING**.
5. Switch to a third browser window logged in as the **System Admin**.
6. Open the Admin Dashboard -> Verification Requests.
7. Show the pending request, review the document, and click **Approve**.
8. Switch back to the Expert window, refresh, and show the status is now **APPROVED**.

---

## Step 3: Consultation & Real-time Chat (3 mins)
**Narrative:** "Now that the expert is approved, the student can connect with them."
**Action:**
1. On the Student window, find the newly approved Expert.
2. Initiate a chat. 
3. Send a message: *"Hi, I need help with my final year project."*
4. Instantly switch to the Expert window and show the message arriving in real-time.
5. Reply from the Expert: *"Sure, I can help you with that."*
6. Mention: *"This is powered by Supabase Realtime, and Row Level Security ensures no one else can read this conversation."*

---

## Step 4: Payments & Wallet (2 mins)
**Narrative:** "To book a session, the student needs to pay. Let's look at the wallet."
**Action:**
1. On the Student window, go to the Wallet section.
2. Show the current balance.
3. (If possible in the demo environment) Simulate adding funds.
4. Initiate a payment transfer to the Expert.
5. Emphasize: *"Our backend enforces strict replay protection so a transaction cannot be duplicated."*

---

## Step 5: Campus Safety & Emergency SOS (4 mins)
**Narrative:** "Beyond mentorship, we built a critical Campus Safety module. Let's trigger a real-time emergency."
**Action:**
1. Position the Student window on the left and the Admin/Authority window on the right (split screen).
2. On the Admin window, navigate to the **College Safety Dashboard**.
3. On the Student window, navigate to the **Women Safety / SOS** page.
4. Click the **RED SOS BUTTON**. Accept location permissions if prompted.
5. Watch the Admin Dashboard on the right instantly update with the new high-priority incident without refreshing the page.
6. On the Admin window, click **Acknowledge** on the incident.
7. (Optional) Show that logging in as an authority from a *different* college yields an empty dashboard, proving our Cross-College RLS Isolation works.

---

## Step 6: Conclusion (1 min)
**Narrative:** "That concludes the live demo. We have shown robust authentication, real-time secure chat, strict admin workflows, and instant emergency response—all running in a verified production environment."
*(Open the floor for questions).*
