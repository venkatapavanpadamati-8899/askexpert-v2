# B.Tech Project Report: AskExpert

**Project Title:** AskExpert - A Comprehensive Platform for Expert Consultation and Campus Safety
**Institution:** S.R.K.R. Engineering College (SRKR EC)
**Degree:** Bachelor of Technology (B.Tech)

## 1. Abstract
AskExpert is an integrated, dual-purpose web application designed to bridge the gap between students seeking professional guidance and experts across various fields. Furthermore, it incorporates a critical Campus Safety Module dedicated to providing a secure environment for college students, specifically focusing on women's safety and emergency response mechanisms. Built on a modern tech stack utilizing HTML, CSS, JavaScript, and Supabase (PostgreSQL), the platform ensures high performance, real-time communication, and rigorous data security through Row Level Security (RLS). 

## 2. Introduction
### 2.1 Problem Statement
1. **Lack of Accessible Mentorship:** Students often lack a verified, streamlined platform to connect with industry experts for career guidance, project help, or interview preparation.
2. **Campus Safety Concerns:** Existing college safety systems are often fragmented, lacking real-time SOS features, cross-college data isolation, and secure evidence management.

### 2.2 Objectives
- Develop a robust platform for real-time chat and consultation.
- Implement a secure payment and wallet system for consultation fees.
- Create a rigorous KYC (Know Your Customer) and admin approval flow for onboarding authentic experts.
- Build a dedicated College Safety module with instant SOS, cross-college data isolation, and secure evidence storage.

## 3. System Architecture
The application follows a client-server architecture with a serverless backend.
- **Frontend:** HTML, CSS, Vanilla JavaScript. Chosen for lightweight delivery and fast execution without framework overhead.
- **Backend & Database:** Supabase (PostgreSQL). Provides authentication, real-time database capabilities, and edge functions.
- **Security Layer:** Supabase Row Level Security (RLS) ensures that data is only accessible to authorized users (e.g., cross-college isolation, private chat visibility).
- **Hosting:** Vercel for scalable, global edge delivery.

## 4. Key Modules & Implementation
### 4.1 Authentication & Authorization
- **OTP-based Login:** Secure and passwordless authentication.
- **Role-Based Access Control (RBAC):** Distinct roles for Students, Experts, Authorities, and System Admins. RLS prevents role escalation.

### 4.2 Expert Consultation & Chat
- **KYC Verification:** Experts must submit credentials which are securely stored and manually verified by Admins before profile activation.
- **Real-time Chat:** Powered by Supabase Realtime, enabling instant messaging between students and approved experts. RLS ensures strict privacy (User A cannot see User B's chats).

### 4.3 Payment System
- **Wallet Infrastructure:** Users can load funds and pay experts.
- **Replay Protection:** Cryptographic checks and state management prevent payment replays and unauthorized wallet manipulation.

### 4.4 College Safety & SOS Module
- **Incident Reporting:** Students can report safety concerns, including anonymous submissions.
- **Emergency SOS:** One-tap SOS triggers immediate alerts to designated college authorities with precise location data (GPS).
- **Cross-College Isolation:** A strict RLS architecture ensures that authorities in College A cannot view, access, or modify incidents from College B.
- **Evidence Management:** Uploaded evidence (images/videos) is securely stored in a designated bucket, accessible only to the assigned authorities.

## 5. Testing & Quality Assurance
The project underwent rigorous automated testing using **Playwright**. The production regression suite consists of 41 comprehensive tests covering:
- E2E smoke tests
- Security boundary testing (RLS enforcement)
- Edge cases (network interruptions, duplicate SOS spam)
- State machine transitions (Pending -> Acknowledged -> Resolved)
- Real-time data synchronization
**Result:** 41/41 tests passed in the production environment (`askexpert-v2.vercel.app`), ensuring maximum reliability.

## 6. Product Status & Conclusion
Based on the final production verification report (Commit `cfe03c6`), AskExpert is verified and production-ready. All core flows—including payments, chat, KYC, and emergency response—have been validated. The project successfully demonstrates the integration of a commercial consultation service with a critical social safety utility, establishing a scalable blueprint for modern web applications.
