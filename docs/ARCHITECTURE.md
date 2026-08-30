# AskExpert Project Architecture

This document describes the organized production directory structure for the AskExpert platform.

```
ASKEXPERT/
├── assets/
│   ├── css/
│   │   └── styles.css              # Main application styling
│   ├── js/
│   │   ├── common/                 # Shared foundation modules
│   │   │   ├── supabaseClient.js   # Supabase client initializer
│   │   │   ├── errorTracker.js     # Production client error tracking
│   │   │   ├── reportIssueModal.js # Issue reporting widget
│   │   │   └── utils.js            # Common utility functions (escapeHTML, formatters)
│   │   ├── auth/                   # Authentication & session guards
│   │   │   └── auth.js             # Session checking & sign-out helpers
│   │   ├── user/                   # User dashboard & client logic
│   │   │   └── user.js             # User data access and stats
│   │   ├── professional/           # Expert & consultant logic
│   │   │   └── professional.js     # Verification & earnings helpers
│   │   ├── admin/                  # Administrative tools
│   │   │   ├── adminErrorAgent.js  # Automated error diagnosis agent
│   │   │   └── admin.js            # Admin authentication guard & stats
│   │   └── ai/                     # AI features & micro-agents
│   │       ├── aiCertificateVerifier.js # OCR & verification analyzer
│   │       └── aiIssueAnalyzer.js       # AI issue classification & severity
│   ├── images/                     # Static images
│   ├── icons/                      # SVG and UI icons
│   └── videos/                     # Media & demo videos
├── database/
│   ├── schema/                     # Core table schemas and patches
│   ├── migrations/                 # Incremental schema migration scripts
│   ├── seed/                       # Seed dataset SQL scripts
│   └── security/                   # Supabase RLS security policies & hardening
├── docs/                           # Project guides, reports & documentation
├── [*.html]                        # All HTML application pages in root
├── package.json                    # Project metadata & dependencies
├── vite.config.js                  # Vite bundler configuration
└── .env                            # Environment variables (Vite & Supabase)
```
