# AskExpert College Safety – Final Project Report

## 1. Introduction
The AskExpert College Safety Module is a dedicated extension of the AskExpert platform engineered to enhance security, reporting, and emergency response capabilities within university and college environments. It aims to deliver a unified solution for managing incidents, harassment reporting, and direct SOS alerting.

## 2. Core Features Implemented
1. **Student Complaint & Incident Flow**
   - Supports anonymous and authenticated reporting.
   - Live evidence upload (images, audio, documentation) via restricted storage.
   - Comprehensive tracking UI for students.
2. **Emergency SOS & Location Tracking**
   - High-priority, zero-friction SOS trigger.
   - Geolocation streaming and temporary "break-glass" location access.
3. **Authority & Management Dashboard**
   - RLS-isolated dashboard for college authorities.
   - Live realtime synchronization of new incidents.
   - AI-driven risk evaluation indicators and sorting.
4. **Emergency Command Center**
   - Top-level overview combining statistics, live maps, and rapid dispatch tools for critical staff.
   
## 3. Technology Stack
* **Frontend:** Vanilla JavaScript, CSS, HTML5, Vite (Bundling).
* **Backend / Database:** Supabase (PostgreSQL).
* **Authentication:** Supabase Auth (JWT).
* **Realtime:** Supabase Realtime (WebSockets).
* **Hosting / CI/CD:** Vercel, GitHub Actions.

## 4. Security Highlights
The system incorporates strict security invariants at the database level:
* Identity non-repudiation for authenticated users.
* Evidence hashing (SHA-256) via Web Crypto API for tamper resistance.
* Complete physical schema isolation for tenant boundaries.

## 5. Roadmap & Future Expansion
* **Android Application:** Developing an Android/Play Store app to integrate native SOS hardware button triggers and background location services.
* **Local Authorities API:** Future-proofing for automated municipal police/ambulance dispatch via standard API bridges.
