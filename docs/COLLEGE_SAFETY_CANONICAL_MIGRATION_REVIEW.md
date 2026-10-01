# COLLEGE SAFETY CANONICAL MIGRATION REVIEW

## 1. Dependency Map

### Migration 1: `20260928_college_safety.sql`
- **Tables Created**: `colleges`, `safety_staff`, `safety_incidents`, `safety_locations`, `safety_contacts`, `safety_audit_logs`, `safety_escalations`.
- **Columns Created**: 
  - On `profiles`: `college_id`, `department`, `academic_year`.
  - On `safety_incidents`: `severity`, `response_due_at`, `escalation_level`, `escalated_at`.
- **Enums/Types**: Uses `CHECK` constraints on `text` and `smallint` types instead of custom ENUMs (e.g., `staff_role`, `incident_type`, `severity`, `status`, `escalation_level`).
- **Functions**: `is_safety_staff_for`, `safety_guard_profile_scope`, `safety_apply_incident_defaults`, `safety_validate_incident_creation`, `safety_notify_incident_change`, `safety_touch_and_guard_incident`, `safety_log_action`, `safety_escalate_incident`.
- **Triggers**: `safety_guard_profile_scope` (on `profiles`), `safety_incident_defaults`, `safety_validate_incident_creation`, `safety_incident_notifications`, `safety_guard_incident_updates` (all on `safety_incidents`).
- **RLS**: Enabled on `profiles`, `colleges`, `safety_staff`, `safety_incidents`, `safety_locations`, `safety_contacts`, `safety_audit_logs`, `safety_escalations`.
- **Policies**: Created 18 distinct policies governing students, authorized safety staff, and admin access control across the above tables.
- **Indexes**: `idx_profiles_college_id`, `idx_safety_incidents_college_status`, `idx_safety_incidents_student`, `idx_safety_locations_incident_time`.
- **Storage Objects**: None.
- **Realtime Objects**: `supabase_realtime` publication for `safety_incidents` and `safety_locations`.

### Migration 2: `20260929_college_safety_finalize.sql`
- **ALTER TABLE**: 
  - `safety_staff`: Replaced `staff_role_check`, added `availability` and `department`.
  - `safety_incidents`: Replaced `status_check`, added `is_anonymous`, AI suggestions, duplicate tracking fields, and assignment/resolution timestamps.
  - `safety_audit_logs`: Added `college_id`, `resource`, `resource_id`, `metadata`.
- **New Tables**: `safety_messages`, `safety_evidence`.
- **New View**: `vw_safety_incidents_safe` (redacts anonymous `student_id` for unauthorized staff).
- **Functions**: `can_access_safety_incident`.
- **Triggers**: None created in this specific migration.
- **RLS Policies**: Replaced read/update incident, location, profile, and audit log policies with `can_access_safety_incident`. Added specific message and evidence tracking policies for students and staff.
- **Storage Policies**: Created `safety_evidence` bucket. Added `INSERT` and `SELECT` policies for students/authorized staff enforcing strict path and access rules.
- **Realtime Configuration**: Added `safety_messages` to `supabase_realtime`.
- **Indexes**: `idx_safety_evidence_incident`, `idx_safety_messages_incident`.

## 2. Structural & Security Checks
- **Duplicate table creation**: Handled via `IF NOT EXISTS`.
- **Duplicate policy names**: Handled via `DROP POLICY IF EXISTS`.
- **Duplicate functions / Conflicting triggers**: Used `CREATE OR REPLACE` and `DROP TRIGGER IF EXISTS`.
- **Missing references / FK dependency problems**: Dependencies flow correctly (`colleges` -> `profiles` -> `incidents` -> `locations`/`messages`/`evidence`). All constraints are robust.
- **Enum/type conflicts**: Averted by using `TEXT` with strict `CHECK` constraints.
- **RLS recursion**: Prevented using `SECURITY DEFINER` and `SET search_path = public` in all access-check functions (`is_safety_staff_for`, `can_access_safety_incident`), deliberately bypassing RLS within the function execution.
- **SECURITY DEFINER search_path problems**: All safely configured.
- **Storage policy conflicts**: Safely handled using conditional updates and correct path-matching enforcement.
- **Realtime authorization problems**: Realtime inherits RLS correctly.
- **Unsafe grants**: All public execution is explicitly revoked and only granted to `authenticated` users.
- **Cross-college access**: Safely guarded at RLS levels across all entities.
- **Student privilege escalation**: Stopped strictly via `safety_guard_profile_scope` and `safety_touch_and_guard_incident` triggers.
- **Forged fields / State manipulation**: Verified. Students cannot spoof SOS locations, assignments, or escalations. Status transitions are hardened and immutable when closed.
- **Anonymous identity exposure**: Fixed via `vw_safety_incidents_safe` providing dynamic redaction.
- **Cross-college audit-log exposure**: Protected by `can_access_safety_incident` scoping in the policy.

## 3. Workflow Verification
- **Student → Incident/SOS → Auth Routing → Resolution → Closed**: The state machine and corresponding RLS perfectly trace and enforce this flow. Staff cannot regress states unnaturally.
- **Evidence Path Format**: 
  - Validated constraint: `split_part(name, '/', 1) = i.id::text` AND `split_part(name, '/', 2) = auth.uid()::text`.
  - Exactly conforms to `incidentId/userId/file`.
- **Evidence Bucket Configuration**: Is `private` (`public = false`), capped at 10MB, strictly typed, and prohibits cross-user/cross-college/public access via robust `auth.uid()` / `can_access` RLS filtering.
- **Anonymous Complaint Behavior**: The `vw_safety_incidents_safe` VIEW leverages `auth.uid()` checks against the `safety_staff` table to dynamically conditionally redact the `student_id`.
- **State Machine**: Both SQL files correctly limit valid transitions and reject manipulation dynamically (via `safety_touch_and_guard_incident`).
- **Role Model**: Secure constraints present.

## 4. Execution Readiness
These two canonical migrations are completely free of recursive triggers or conflicting schemas, provided they are run sequentially in a clean/empty Supabase environment against the existing standard base schema.

---
## Summary

- Canonical migrations reviewed: YES
- Migration 1 reviewed: YES
- Migration 2 reviewed: YES
- Audit guide reviewed: YES
- Dependency conflicts: 0
- Security issues: 0
- Storage issues: 0
- RLS issues: 0
- Realtime issues: 0

**FINAL STATUS:**
READY_TO_APPLY
