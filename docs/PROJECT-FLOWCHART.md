# AskExpert — Complete System Flow Chart & Architecture

This document contains the complete end-to-end architectural, user, expert, admin, and subsystem flow charts for the **AskExpert** platform.

---

## 1. Overall System Navigation & Role-Based Routing

```mermaid
flowchart TD
    Home["Landing Page (index.html)<br/>• Search Experts & Questions<br/>• Domain Categories<br/>• Top-rated Specialists"]

    %% Authentication Pathways
    Home -->|Sign Up| Register["register.html<br/>• Phone Demo OTP Verification<br/>• Role Selection: User or Expert<br/>• Supabase Auth Account Creation"]
    Home -->|Sign In| Login["login.html<br/>• Email & Password Auth<br/>• Session Storage Initialization"]
    Login -->|Forgot Password| Forgot["forgot-password.html<br/>• 3-Step Wizard: Account Recovery<br/>• OTP Verification & Password Reset"]
    Login -->|Email Magic Link| Reset["reset-password.html<br/>• Recovery Session Handler"]

    %% Dynamic Role Dispatcher
    Login -->|Authentication Success| RoleRouter["dashboard.html<br/>(Dynamic Role Router)"]

    RoleRouter -->|role = 'user'| UserDash["user-dashboard.html<br/>• Recent Questions<br/>• Active Consultations<br/>• Notifications & Stats"]
    RoleRouter -->|role = 'expert'| ExpertDash["professional-dashboard.html<br/>• Inquiries Feed<br/>• Consultation Requests<br/>• Revenue & Payouts"]
    RoleRouter -->|role = 'admin'| AdminDash["admin-dashboard.html<br/>• Platform Metrics<br/>• User & Expert Moderation<br/>• AI Fix Center"]

    %% Direct Admin Gateway
    Home -->|Admin Gateway| AdminLogin["admin-login.html"] -->|Admin Credentials| AdminDash
```

---

## 2. Client / User Workflow

```mermaid
flowchart TD
    subgraph UserFlow ["User Journey: Questioning, Consulting & Payments"]
        U_Start["User registers or logs in"] --> U_Dash["User Dashboard (user-dashboard.html)"]
        
        %% Question Path
        U_Dash -->|Click 'Ask Question'| U_Ask["ask-question.html<br/>• Choose Domain & Specialty<br/>• Enter Title, Details & Budget"]
        U_Ask -->|Publish Question| DB_Q["Insert to 'questions' Table"]
        DB_Q --> Q_Feed["Questions Feed (questions.html)"]
        Q_Feed --> Q_Detail["Question Details (question-details.html)<br/>• View question thread<br/>• Read verified expert answers"]

        %% Expert Consultation Path
        U_Dash -->|Browse Specialists| U_Dir["Experts Directory (experts.html)<br/>• Filter by Category, Rating, Experience"]
        U_Dir --> U_Profile["Expert Profile (expert-profile.html)<br/>• View bio, credentials, hourly rate"]
        U_Profile -->|Book Appointment| U_Req["Consultation Requests (consultation-requests.html)<br/>• Select date, time & scope"]
        U_Req -->|Proceed to Checkout| U_Pay["Payments & Escrow (payments.html)<br/>• Secure Escrow Holding"]
        U_Pay -->|Payment Verified| U_Chat["Direct Consultation Chat (chat.html)<br/>• Realtime WebSocket Messaging<br/>• File/document sharing"]
        U_Chat -->|Consultation Finished| U_Review["Review Expert (review.html)<br/>• 5-star rating & written review"]

        %% Profile & Privacy Controls
        U_Dash -->|Manage Settings| U_Edit["Edit Profile (edit-profile.html)<br/>• Update Bio & Contact<br/>• Configure Privacy (Public/Private)<br/>• Set 'Who can message me'"]
        U_Dash -->|System Alerts| U_Notif["Notifications (notifications.html)<br/>• New answers, bookings, messages"]
    end
```

---

## 3. Professional / Expert Workflow

```mermaid
flowchart TD
    subgraph ExpertFlow ["Expert Journey: Verification, Answering & Earnings"]
        E_Start["Register as Expert (register.html)"] --> E_Login["Login (login.html)"]
        E_Login --> E_KYC["Professional Verification (professional-verification.html)<br/>• License/Bar Council number<br/>• Upload Credentials/Certificate"]
        
        E_KYC --> E_AI["AI Certificate Verifier (aiCertificateVerifier.js)<br/>• Validates certificate authenticity<br/>• Detects tampering/suspicious files"]
        E_AI -->|Passed Check| E_Pending["Status: 'pending_admin'<br/>Awaiting Admin Confirmation"]
        
        E_Pending -->|Admin Approves KYC| E_Dash["Professional Dashboard (professional-dashboard.html)"]

        %% Answering Inquiries
        E_Dash -->|Browse Feed| E_Feed["Questions Feed (questions.html)"]
        E_Feed --> E_Ans["Question Details (question-details.html)<br/>• Write & submit expert solution"]
        E_Ans -->|Insert Solution| DB_Ans["Insert to 'answers' Table"]

        %% Consultations & Income
        E_Dash -->|Manage Inbound Consultations| E_Req["Consultation Requests (consultation-requests.html)<br/>• Accept or Decline booking"]
        E_Req -->|Accepted| E_Chat["Consultation Room (chat.html)<br/>• Deliver 1-on-1 consultation"]
        E_Chat --> E_Earn["Professional Earnings (professional-earnings.html)<br/>• Completed consultations ledger<br/>• Escrow release & payout status"]
        E_Dash --> E_PubProfile["Professional Profile (professional-profile.html)<br/>• Public badges & verification seal"]
    end
```

---

## 4. Admin Governance & Platform Moderation

```mermaid
flowchart TD
    subgraph AdminFlow ["Admin Control Center & Moderation Modules"]
        A_Login["Admin Login (admin-login.html)<br/>(Strict Role Authentication Gate)"] --> A_Dash["Admin Dashboard (admin-dashboard.html)"]
        
        %% Moderation Panels
        A_Dash --> A_Users["Admin Users (admin-users.html)<br/>• View all registered accounts<br/>• Block / unblock abusive users"]
        A_Dash --> A_Pros["Admin Professionals (admin-professionals.html)<br/>• Review uploaded KYC documents<br/>• Approve verified badge or reject"]
        A_Dash --> A_Ques["Admin Questions (admin-questions.html)<br/>• Flag spam/inappropriate inquiries<br/>• Moderate or remove questions"]
        A_Dash --> A_Reps["Admin Reports (admin-reports.html)<br/>• Investigate dispute claims<br/>• Review flagged behavior"]
        A_Dash --> A_Pays["Admin Payments (admin-payments.html)<br/>• Financial transaction monitor<br/>• Escrow hold & refund release"]
        A_Dash --> A_Health["Admin Health (admin-health.html)<br/>• Database latency monitoring<br/>• API uptime & error tracking"]
        A_Dash --> A_AIFix["Admin AI Fix Center (admin-ai-fix-center.html)<br/>• AI issue diagnosis & proposal review"]
    end
```

---

## 5. AI Fix Center & Safety Pipeline

```mermaid
flowchart TD
    subgraph AIFixPipeline ["AI Automated Diagnosis & Admin-Gated Execution"]
        Step1["User, Expert, or Admin encounters an issue or requests a feature"]
        Step1 --> Step2["Opens Report Issue Modal (reportIssueModal.js)<br/>• Selects Category (Bug, Feature, Security)<br/>• Provides Title, Context & Severity"]
        Step2 -->|Insert Record| Table_Reports["Supabase Table: issue_reports<br/>(status: 'pending_ai')"]

        Table_Reports --> Step3["AI Issue Analyzer (aiIssueAnalyzer.js)<br/>• Root-cause technical analysis<br/>• Unified diff patch generation<br/>• Confidence score & risk estimation"]
        Step3 -->|Insert Proposal| Table_Proposals["Supabase Table: ai_fix_proposals<br/>(status: 'pending_review')"]

        Table_Proposals --> Step4["Admin AI Fix Center (admin-ai-fix-center.html)<br/>• Admin views pending proposals<br/>• Inspects Unified Diff & impacted files"]

        Step4 --> Step5{"Admin Review Decision"}

        Step5 -->|REJECT| Step6["Proposal Marked: REJECTED<br/>• Issue closed with admin reason<br/>• Zero code changes made"]
        Step5 -->|APPROVE| Step7["Admin Enters Signature Notes & Approves"]

        Step7 --> Table_Approvals["Supabase Table: admin_approvals<br/>(Authorized execution token)"]
        Table_Approvals --> Table_Audit["Supabase Table: audit_logs<br/>(Cryptographic audit trail)"]
        Table_Audit --> Step8["Automated Notification to Reporter<br/>• Realtime update on issue resolution"]
    end
```

---

## 6. Multi-Tier Chat Privacy Gating Flow

```mermaid
flowchart TD
    subgraph ChatEngine ["Universal Chat Access Control & Privacy Gating"]
        Chat_Init["Sender navigates to chat.html?recipient=Recipient_ID"]
        Chat_Init --> Fetch_Priv["Query privacy_settings Table for Recipient"]

        Fetch_Priv --> Check_Who{"Who Can Message Recipient?"}

        Check_Who -->|'nobody'| Block_Nobody["BLOCK INCOMING MESSAGE<br/>'This user has disabled incoming direct messages.'"]
        Check_Who -->|'verified_experts_only'| Check_Role{"Is Sender a Verified Expert?"}
        
        Check_Role -->|No| Block_Role["BLOCK INCOMING MESSAGE<br/>'Only verified specialists can message this user.'"]
        Check_Role -->|Yes| Allow_Msg["ALLOW CONVERSATION"]
        Check_Who -->|'everyone'| Allow_Msg

        Allow_Msg --> Rate_Limit{"Rate Limit Check<br/>(Max 10 messages per 10s)"}
        Rate_Limit -->|Threshold Exceeded| Throttle["Show Rate Limit Warning (429)"]
        Rate_Limit -->|Within Normal Limits| Send_Realtime["Dispatch message via Supabase Realtime<br/>(Stored in 'messages' table)"]
    end
```

---

## 7. Database Entity Relationship Overview

```mermaid
erDiagram
    PROFILES ||--o{ QUESTIONS : writes
    PROFILES ||--o{ ANSWERS : author
    PROFILES ||--o{ CONSULTATION_REQUESTS : requests
    PROFILES ||--o{ CONSULTATION_REQUESTS : receives
    PROFILES ||--o{ PAYMENTS : pays
    PROFILES ||--o{ REVIEWS : writes
    PROFILES ||--o{ REVIEWS : receives
    PROFILES ||--o{ NOTIFICATIONS : receives
    PROFILES ||--o| PRIVACY_SETTINGS : configures
    PROFILES ||--o| PROFESSIONAL_VERIFICATIONS : submits

    QUESTIONS ||--o{ ANSWERS : contains
    
    CONVERSATIONS ||--o{ CONVERSATION_PARTICIPANTS : includes
    CONVERSATIONS ||--o{ MESSAGES : contains
    PROFILES ||--o{ CONVERSATION_PARTICIPANTS : member
    PROFILES ||--o{ MESSAGES : sends

    PROFILES ||--o{ ISSUE_REPORTS : reports
    ISSUE_REPORTS ||--o{ AI_FIX_PROPOSALS : analyzed_into
    AI_FIX_PROPOSALS ||--o{ ADMIN_APPROVALS : decided_by
    PROFILES ||--o{ ADMIN_APPROVALS : admin
    PROFILES ||--o{ AUDIT_LOGS : actor
```
