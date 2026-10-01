# AskExpert College Safety architecture and flow

```mermaid
flowchart TD
  S[Authenticated student] --> C{Confirms SOS}
  C --> I[Safety incident]
  C -->|Optional separate action| G[Browser geolocation permission]
  G -->|Granted| L[Bounded location updates]
  I --> DB[(Supabase: incidents, locations, audit)]
  L --> DB
  DB --> R[Realtime: authorized college responders]
  R --> M[Safety dashboard / map]
  M --> A[Acknowledge, assign, escalate, resolve]
  A --> DB
  DB --> N[Metadata-only in-app notifications]
```

```mermaid
flowchart TD
  A[Problem occurs] --> B[Student signs in]
  B --> C[Chooses category and urgency]
  C --> D[Confirms SOS]
  D --> E[Authorized responders alerted]
  E --> F{Student chooses location sharing?}
  F -->|Yes| G[GPS update, max 30 minutes]
  F -->|No / denied| H[Incident remains active without location]
  G --> I[Management responds]
  H --> I
  I --> J[Acknowledge / assign / escalate]
  J --> K[Resolve or student cancels]
  K --> L[Stop location sharing and preserve minimal audit record]
```

## Access boundary

| Actor | Can do | Cannot do |
|---|---|---|
| Student | Create/read own incident, opt into bounded location, cancel | Read another student's incident or location |
| Assigned college responder | See only its college's active incidents, latest opted-in location, manage status/assignment | Read another college's incidents |
| Platform admin | Manage college and responder configuration | Bypass audited safety actions silently |

The client never contains a service-role key. Row-level policies plus server-side PostgreSQL functions enforce ownership, college scope, responder assignment, status lifecycle, location expiry, and escalation.

## Operational configuration

1. Create a `colleges` record.
2. Set each student's `profiles.college_id`, plus optional `department` and `academic_year`.
3. Add approved personnel to `safety_staff` and college emergency numbers to `safety_contacts`.
4. Document exactly who receives escalation Levels 1–3 and test the response process.
5. Set a retention schedule for closed incidents and location records before production.
