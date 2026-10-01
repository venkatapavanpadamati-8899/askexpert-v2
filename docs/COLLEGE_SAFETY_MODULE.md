# College Safety & Emergency Support

## Deployment

1. Apply `database/migrations/20260928_college_safety.sql` in the Supabase SQL editor.
2. Insert each college, set `profiles.college_id` for its students, then add only vetted responders to `safety_staff`.
3. Link students to `safety.html` and responders to `admin-safety.html`. Existing admins may access every college; non-admin responders can access only their assigned college.
4. Configure notification delivery in a server-side Edge Function before enabling SMS, email, push, or WhatsApp. Browser code intentionally contains no provider credentials.

## Privacy flow

`Student action → confirmed SOS → optional location permission → scoped incident/location records → RLS-authorized responder → response → close/cancel → audit log`

SOS is created without requesting location. Location is a separate explicit action, limited to 30 minutes in the browser, and database insertion is rejected after cancellation, resolution, or expiry. The dashboard opens the map only when an authorized responder requests the latest location. It does not expose a complete profile or historic route.

When an incident is resolved or cancelled, the database stops sharing and purges its stored location points while keeping only the non-coordinate audit event. This is an intentionally privacy-first default; colleges needing a different legally approved retention period should change that policy only after a documented review.

## Notifications

The migration sends a metadata-only in-app notification to each active, authorized responder when SOS is created, and tells the student when status changes. Coordinates are never copied into notifications. Email, SMS, push, and WhatsApp should be implemented as a server-side worker/webhook that consumes approved safety events; store provider secrets only as Supabase Edge Function secrets and apply delivery/rate-limit rules there.

## Advanced response levels

Students choose `LOW`, `MEDIUM`, `HIGH`, or `CRITICAL`. The database—not the browser—sets the corresponding response target to 60, 30, 15, or 5 minutes. Authorized responders may atomically escalate an open incident from Level 1 through Level 3; every escalation is audited. Level 3 must be mapped by each college to its own documented emergency protocol. It is intentionally not an automatic call to public emergency services.

## Security and remaining operational work

RLS, authenticated ownership checks, college-scoped staff authorization, location lifecycle checks, parameterized Supabase queries, HTML escaping, and audit logging are included. Configure Supabase Realtime Authorization policies if that feature is enabled; database RLS remains the data boundary. Complete a legal/privacy review, appoint safety staff, establish retention and incident-response policies, and add a server-side notification provider before production use. A browser tab is not a reliable standalone emergency-dispatch mechanism.
