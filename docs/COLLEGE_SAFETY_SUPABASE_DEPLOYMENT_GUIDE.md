# College Safety Supabase Deployment Guide

## A. PRE-DEPLOYMENT CHECKS
1. Ensure you have the `20260928_college_safety.sql` migration file ready.
2. Ensure you have the `20260928_college_safety_review_fixes.sql` migration file ready.
3. Review current active connections in Supabase to ensure a safe window for schema changes.
4. Verify that you have the correct project selected in the Supabase Dashboard.

## B. BACKUP / SAFETY CHECKS
1. Go to the Database -> Backups section in your Supabase dashboard.
2. Ensure you have a recent automated backup or trigger a manual backup if available.
3. Keep the Supabase SQL editor open in a clean tab.

## C. EXACT SQL EXECUTION ORDER
1. Copy the contents of `20260928_college_safety.sql` and execute it in the Supabase SQL Editor.
2. Copy the contents of `20260928_college_safety_review_fixes.sql` and execute it in the Supabase SQL Editor immediately after.

## D. POST-MIGRATION VERIFICATION
1. Check the Table Editor in Supabase to ensure `colleges`, `safety_staff`, `safety_incidents`, `safety_locations`, `safety_contacts`, `safety_audit_logs`, and `safety_escalations` tables were created.
2. Verify that RLS is active on all new tables.
3. Verify that the Realtime toggle is enabled for `safety_incidents` and `safety_locations`.

## E. COLLEGE CREATION
1. Go to the `colleges` table in the Supabase Table Editor.
2. Insert a new row with the college name and code. 
3. Note the generated UUID for the new college.

## F. profiles.college_id assignment
1. Go to the `profiles` table.
2. Assign the previously noted `college_id` UUID to the target student profiles.
3. (Note: Only administrators can modify this field directly due to the new security trigger.)

## G. safety staff setup
1. Go to the `safety_staff` table.
2. Add records mapping the `college_id` to the `profile_id` of the authorized responder(s).
3. Set their `staff_role` appropriately (e.g., `responder`).

## H. safety contacts setup
1. Go to the `safety_contacts` table.
2. Insert the emergency contacts (phone, email) associated with the `college_id`.

## I. RLS testing
1. Open the Supabase SQL Editor.
2. Run the provided checklist script: `D:\ASKEXPERT\database\tests\college_safety_rls_checklist.sql`.
3. Manually impersonate users or use the provided statements to verify isolation and access control.

## J. Realtime testing
1. With an active client session for a responder, subscribe to `safety_incidents` channel.
2. Have a student trigger a new incident and verify the payload is received by the responder in real-time.

## K. Location testing
1. As a student with an active incident, trigger a location update.
2. Verify the `safety_locations` table receives the insert and the bounded expiration constraint functions as expected.

## L. SOS end-to-end testing
1. Create a test student and a test responder.
2. Create an SOS incident.
3. Check for the new record in `safety_incidents` and `safety_audit_logs`.
4. Acknowledge, escalate, and resolve the incident.
5. Check `safety_audit_logs` and `safety_escalations` to ensure all transitions were captured.

## M. Rollback considerations
If critical errors occur during deployment:
1. Revert using Point-in-Time Recovery (PITR) if enabled.
2. Otherwise, drop the new tables and triggers manually using the Supabase SQL editor:
   - DROP TABLE safety_escalations, safety_audit_logs, safety_contacts, safety_locations, safety_incidents, safety_staff, colleges CASCADE;
   - DROP FUNCTION public.is_safety_staff_for, public.safety_apply_incident_defaults, public.safety_notify_incident_change, public.safety_touch_and_guard_incident, public.safety_log_action, public.safety_escalate_incident, public.enforce_profile_college_security;
   - ALTER TABLE profiles DROP COLUMN college_id, department, academic_year;
