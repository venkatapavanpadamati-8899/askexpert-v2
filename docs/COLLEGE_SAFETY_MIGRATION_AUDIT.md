# College Safety migration audit — 2026-09-29

## Do not run the SQL yet

Static review found that the currently present safety SQL files are a **multi-phase, dependent set**, not one interchangeable script. Running only an arbitrary file, or pasting the safety fragment appended to `database/APPLY_IN_SUPABASE_SQL_EDITOR.sql`, is not safe for a staging or production project.

`database/APPLY_IN_SUPABASE_SQL_EDITOR.sql` is a legacy professional-KYC script. Its appended evidence fragment has weaker, duplicate Storage policies and must not be used as the College Safety deployment entry point.

## Canonical deployment order

1. Existing AskExpert schema and role-hardening migrations.
2. `20260928_college_safety.sql` — core tables, RLS, consent/location controls.
3. `20260929_college_safety_finalize.sql` — advanced roles, extended workflow, messages, evidence metadata, private Storage bucket/policies, and anonymous redaction.

`20260928_college_safety_enhancements.sql`, `20260928_college_safety_phase2.sql`, `20260928_college_safety_phase3.sql`, `20260928_college_safety_phase4.sql`, `20260928_college_safety_review_fixes.sql`, and `20260929_college_safety_security_hardening.sql` are superseded deployment inputs. Preserve them as history but do not run them against a new environment.

## Defects fixed in the reviewed files

- SOS insert rejects forged sharing, assignment, acknowledgement, closure, and escalation fields.
- Students can withdraw location consent before expiry.
- College/department/year cannot be self-edited to cross a college RLS boundary.
- Staff cannot directly alter student report/consent data, bypass escalation, use invalid status transitions, or reopen closed/cancelled incidents.
- Core and Phase 3 status workflows are aligned through `CLOSED`.
- Phase 4 audit policy no longer grants every college's staff access to rows with a null `college_id`.
- Base safety policies are safely replaceable on a SQL-editor retry.

## Still required before any remote run

1. Apply the two canonical migrations to an empty local Supabase instance and record results. Do not apply them ad hoc to the remote project.
2. Add a server-side cleanup job for an uploaded Storage object whose evidence metadata insert fails.
3. Verify Supabase Realtime Authorization policies (not just Postgres RLS) for incidents, locations, and messages.
4. Use the authenticated test matrix in `database/tests/college_safety_rls_checklist.sql` against a non-production project.
5. Confirm that current application queries still work after profiles RLS becomes privacy-preserving; expert directory access remains allowed, student-profile public reads do not.

Until these remote tests pass, the honest status is **LOCAL_STATIC_REVIEWED — NOT READY_FOR_STAGING**.
