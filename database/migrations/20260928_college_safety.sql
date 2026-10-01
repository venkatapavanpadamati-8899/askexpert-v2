-- AskExpert College Safety & Emergency Support module
-- Apply in the Supabase SQL editor after the existing schema migrations.
-- No service-role key is needed by the browser client.

CREATE TABLE IF NOT EXISTS public.colleges (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  code text UNIQUE,
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS college_id uuid REFERENCES public.colleges(id) ON DELETE SET NULL;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS department text;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS academic_year smallint CHECK (academic_year BETWEEN 1 AND 8);
CREATE INDEX IF NOT EXISTS idx_profiles_college_id ON public.profiles(college_id);

-- The legacy application exposed every profile row. Keep the expert directory available while
-- preventing ordinary users from querying student contact/profile data through the Data API.
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Profiles are viewable by everyone" ON public.profiles;
DROP POLICY IF EXISTS "Safety: own profile" ON public.profiles;
DROP POLICY IF EXISTS "Safety: public expert directory" ON public.profiles;
DROP POLICY IF EXISTS "Safety: authorized responders read college profiles" ON public.profiles;
DROP POLICY IF EXISTS "Safety: students read assigned responder" ON public.profiles;
CREATE POLICY "Safety: own profile" ON public.profiles FOR SELECT TO authenticated USING (id = auth.uid());
CREATE POLICY "Safety: public expert directory" ON public.profiles FOR SELECT TO authenticated USING (role = 'expert');

CREATE TABLE IF NOT EXISTS public.safety_staff (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  college_id uuid NOT NULL REFERENCES public.colleges(id) ON DELETE CASCADE,
  profile_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  staff_role text NOT NULL DEFAULT 'responder' CHECK (staff_role IN ('manager', 'security', 'responder')),
  is_active boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (college_id, profile_id)
);

-- Security-definer helpers avoid RLS recursion. They do not expose any data.
CREATE OR REPLACE FUNCTION public.is_safety_staff_for(target_college_id uuid)
RETURNS boolean LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT public.is_admin() OR EXISTS (
    SELECT 1 FROM public.safety_staff s
    WHERE s.profile_id = auth.uid() AND s.college_id = target_college_id AND s.is_active
  );
$$;
REVOKE ALL ON FUNCTION public.is_safety_staff_for(uuid) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.is_safety_staff_for(uuid) TO authenticated;

CREATE POLICY "Safety: authorized responders read college profiles" ON public.profiles FOR SELECT TO authenticated
  USING (public.is_admin() OR public.is_safety_staff_for(college_id));
CREATE POLICY "Safety: students read assigned responder" ON public.profiles FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.student_id = auth.uid() AND i.assigned_responder_id = profiles.id)
);

-- College/department membership controls RLS scope and must never be self-editable.
CREATE OR REPLACE FUNCTION public.safety_guard_profile_scope()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  IF TG_OP = 'UPDATE' AND NOT (public.is_admin() OR auth.role() = 'service_role')
     AND (NEW.college_id IS DISTINCT FROM OLD.college_id
       OR NEW.department IS DISTINCT FROM OLD.department
       OR NEW.academic_year IS DISTINCT FROM OLD.academic_year) THEN
    RAISE EXCEPTION 'Only an authorized administrator may change college safety membership';
  END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS safety_guard_profile_scope ON public.profiles;
CREATE TRIGGER safety_guard_profile_scope BEFORE UPDATE ON public.profiles
FOR EACH ROW EXECUTE FUNCTION public.safety_guard_profile_scope();

CREATE TABLE IF NOT EXISTS public.safety_incidents (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  college_id uuid NOT NULL REFERENCES public.colleges(id) ON DELETE RESTRICT,
  student_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
  incident_type text NOT NULL CHECK (incident_type IN ('medical_emergency','harassment','bullying','ragging','road_transport_safety','hostel_problem','unsafe_situation','academic_issue','lost_item','faculty_complaint','infrastructure_problem','cyber_social_media_issue','other')),
  severity text NOT NULL DEFAULT 'HIGH' CHECK (severity IN ('LOW','MEDIUM','HIGH','CRITICAL')),
  message text NOT NULL CHECK (char_length(message) BETWEEN 1 AND 1000),
  status text NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE','ACKNOWLEDGED','RESPONDING','RESOLVED','CANCELLED')),
  location_sharing_enabled boolean NOT NULL DEFAULT false,
  location_sharing_expires_at timestamptz,
  acknowledged_at timestamptz,
  closed_at timestamptz,
  assigned_responder_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  response_due_at timestamptz NOT NULL DEFAULT (now() + interval '15 minutes'),
  escalation_level smallint NOT NULL DEFAULT 0 CHECK (escalation_level BETWEEN 0 AND 3),
  escalated_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS severity text NOT NULL DEFAULT 'HIGH';
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS response_due_at timestamptz NOT NULL DEFAULT (now() + interval '15 minutes');
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS escalation_level smallint NOT NULL DEFAULT 0;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS escalated_at timestamptz;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS ai_risk_explanation text;
ALTER TABLE public.safety_incidents DROP CONSTRAINT IF EXISTS safety_incidents_incident_type_check;
ALTER TABLE public.safety_incidents ADD CONSTRAINT safety_incidents_incident_type_check CHECK (incident_type IN ('medical_emergency','harassment','bullying','ragging','road_transport_safety','hostel_problem','unsafe_situation','academic_issue','lost_item','faculty_complaint','infrastructure_problem','cyber_social_media_issue','other'));
ALTER TABLE public.safety_incidents DROP CONSTRAINT IF EXISTS safety_incidents_severity_check;
ALTER TABLE public.safety_incidents ADD CONSTRAINT safety_incidents_severity_check CHECK (severity IN ('LOW','MEDIUM','HIGH','CRITICAL'));
ALTER TABLE public.safety_incidents DROP CONSTRAINT IF EXISTS safety_incidents_escalation_level_check;
ALTER TABLE public.safety_incidents ADD CONSTRAINT safety_incidents_escalation_level_check CHECK (escalation_level BETWEEN 0 AND 3);
CREATE INDEX IF NOT EXISTS idx_safety_incidents_college_status ON public.safety_incidents(college_id, status, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_safety_incidents_student ON public.safety_incidents(student_id, created_at DESC);

CREATE TABLE IF NOT EXISTS public.safety_locations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id uuid NOT NULL REFERENCES public.safety_incidents(id) ON DELETE CASCADE,
  latitude numeric(9,6) NOT NULL CHECK (latitude BETWEEN -90 AND 90),
  longitude numeric(9,6) NOT NULL CHECK (longitude BETWEEN -180 AND 180),
  accuracy numeric(10,2) CHECK (accuracy >= 0),
  recorded_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_safety_locations_incident_time ON public.safety_locations(incident_id, recorded_at DESC);

CREATE TABLE IF NOT EXISTS public.safety_contacts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  college_id uuid NOT NULL REFERENCES public.colleges(id) ON DELETE CASCADE,
  name text NOT NULL,
  contact_role text NOT NULL,
  phone text,
  email text,
  is_active boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.safety_audit_logs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id uuid NOT NULL REFERENCES public.safety_incidents(id) ON DELETE CASCADE,
  actor_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  action text NOT NULL CHECK (char_length(action) <= 100),
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.safety_escalations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id uuid NOT NULL REFERENCES public.safety_incidents(id) ON DELETE CASCADE,
  triggered_by uuid NOT NULL REFERENCES public.profiles(id) ON DELETE RESTRICT,
  escalation_level smallint NOT NULL CHECK (escalation_level BETWEEN 1 AND 3),
  note text CHECK (char_length(note) <= 500),
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE OR REPLACE FUNCTION public.safety_apply_incident_defaults()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  NEW.response_due_at := now() + CASE NEW.severity
    WHEN 'CRITICAL' THEN interval '5 minutes' WHEN 'HIGH' THEN interval '15 minutes'
    WHEN 'MEDIUM' THEN interval '30 minutes' ELSE interval '60 minutes' END;
  NEW.escalation_level := 0;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS safety_incident_defaults ON public.safety_incidents;
CREATE TRIGGER safety_incident_defaults BEFORE INSERT ON public.safety_incidents
FOR EACH ROW EXECUTE FUNCTION public.safety_apply_incident_defaults();

-- Defense in depth: an SOS begins without location sharing, assignments, acknowledgements,
-- or closure. The browser cannot forge any of those server-managed values at INSERT time.
CREATE OR REPLACE FUNCTION public.safety_validate_incident_creation()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  IF NEW.student_id <> auth.uid() OR NEW.status <> 'ACTIVE' OR NEW.location_sharing_enabled
     OR NEW.location_sharing_expires_at IS NOT NULL OR NEW.acknowledged_at IS NOT NULL
     OR NEW.closed_at IS NOT NULL OR NEW.assigned_responder_id IS NOT NULL OR NEW.escalated_at IS NOT NULL THEN
    RAISE EXCEPTION 'Invalid safety incident creation';
  END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS safety_validate_incident_creation ON public.safety_incidents;
CREATE TRIGGER safety_validate_incident_creation BEFORE INSERT ON public.safety_incidents
FOR EACH ROW EXECUTE FUNCTION public.safety_validate_incident_creation();

-- In-app alerts are deliberately metadata-only: no coordinates or full profile data are copied
-- into notifications. External channels are an operational integration, not browser JavaScript.
CREATE OR REPLACE FUNCTION public.safety_notify_incident_change()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO public.notifications(user_id, type, title, message, link)
      SELECT s.profile_id, 'safety_sos', 'Emergency safety alert',
        'A student has created an emergency request. Open the College Safety dashboard to respond.', NEW.id::text
      FROM public.safety_staff s WHERE s.college_id = NEW.college_id AND s.is_active;
    INSERT INTO public.safety_audit_logs(incident_id, actor_id, action) VALUES (NEW.id, NEW.student_id, 'incident_created');
  ELSIF NEW.status IS DISTINCT FROM OLD.status THEN
    INSERT INTO public.notifications(user_id, type, title, message, link) VALUES
      (NEW.student_id, 'safety_status', 'Emergency status updated', 'Your safety request status is now ' || NEW.status || '.', NEW.id::text);
    INSERT INTO public.safety_audit_logs(incident_id, actor_id, action) VALUES (NEW.id, auth.uid(), 'status_' || lower(NEW.status));
    IF NEW.status IN ('RESOLVED', 'CLOSED', 'CANCELLED') THEN
      DELETE FROM public.safety_locations WHERE incident_id = NEW.id;
      INSERT INTO public.safety_audit_logs(incident_id, actor_id, action) VALUES (NEW.id, auth.uid(), 'location_history_purged');
    END IF;
  ELSIF NEW.location_sharing_enabled IS DISTINCT FROM OLD.location_sharing_enabled AND NEW.location_sharing_enabled THEN
    INSERT INTO public.safety_audit_logs(incident_id, actor_id, action) VALUES (NEW.id, auth.uid(), 'location_sharing_started');
  END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS safety_incident_notifications ON public.safety_incidents;
CREATE TRIGGER safety_incident_notifications AFTER INSERT OR UPDATE ON public.safety_incidents
FOR EACH ROW EXECUTE FUNCTION public.safety_notify_incident_change();

CREATE OR REPLACE FUNCTION public.safety_touch_and_guard_incident()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  NEW.updated_at = now();
  IF NOT public.is_safety_staff_for(OLD.college_id) THEN
    -- Students can cancel, or explicitly enable a short-lived location share, on their own active incident.
    IF OLD.student_id <> auth.uid() OR OLD.status <> 'ACTIVE'
       OR NEW.college_id IS DISTINCT FROM OLD.college_id OR NEW.student_id IS DISTINCT FROM OLD.student_id
       OR NEW.incident_type IS DISTINCT FROM OLD.incident_type OR NEW.message IS DISTINCT FROM OLD.message
       OR NEW.severity IS DISTINCT FROM OLD.severity OR NEW.response_due_at IS DISTINCT FROM OLD.response_due_at
       OR NEW.escalation_level IS DISTINCT FROM OLD.escalation_level OR NEW.escalated_at IS DISTINCT FROM OLD.escalated_at
       OR NEW.assigned_responder_id IS DISTINCT FROM OLD.assigned_responder_id THEN
      RAISE EXCEPTION 'Unsafe student incident update';
    END IF;
    IF NEW.status = 'CANCELLED' AND NEW.location_sharing_enabled = OLD.location_sharing_enabled
       AND NEW.location_sharing_expires_at IS NOT DISTINCT FROM OLD.location_sharing_expires_at THEN
      NEW.closed_at = now();
    ELSIF NEW.status = 'ACTIVE' AND OLD.location_sharing_enabled = false AND NEW.location_sharing_enabled = true
      AND NEW.location_sharing_expires_at > now() AND NEW.location_sharing_expires_at <= now() + interval '30 minutes' THEN
      NULL; -- explicit, bounded location-sharing opt-in
    ELSIF NEW.status = 'ACTIVE' AND OLD.location_sharing_enabled = true AND NEW.location_sharing_enabled = false
       AND NEW.location_sharing_expires_at IS NULL THEN
      NULL; -- students may withdraw location consent at any time
    ELSE
      RAISE EXCEPTION 'Students may only cancel or change their short-lived location consent';
    END IF;
  ELSE
    IF OLD.status IN ('CLOSED','CANCELLED') AND NEW IS DISTINCT FROM OLD THEN
      RAISE EXCEPTION 'Closed safety incidents are immutable';
    END IF;
    IF NEW.college_id IS DISTINCT FROM OLD.college_id OR NEW.student_id IS DISTINCT FROM OLD.student_id
       OR NEW.incident_type IS DISTINCT FROM OLD.incident_type OR NEW.message IS DISTINCT FROM OLD.message
       OR NEW.severity IS DISTINCT FROM OLD.severity OR NEW.response_due_at IS DISTINCT FROM OLD.response_due_at
       OR NEW.location_sharing_enabled IS DISTINCT FROM OLD.location_sharing_enabled
       OR NEW.location_sharing_expires_at IS DISTINCT FROM OLD.location_sharing_expires_at THEN
      RAISE EXCEPTION 'Safety staff may not alter student report or location-consent fields';
    END IF;
    IF NEW.escalation_level IS DISTINCT FROM OLD.escalation_level OR NEW.escalated_at IS DISTINCT FROM OLD.escalated_at THEN
      IF current_setting('app.safety_escalation', true) IS DISTINCT FROM 'true' THEN
        RAISE EXCEPTION 'Use the authorized escalation workflow';
      END IF;
    END IF;
    IF NEW.status = OLD.status THEN
      NULL;
    ELSIF OLD.status = 'ACTIVE' AND NEW.status IN ('ACKNOWLEDGED','RESPONDING','CANCELLED') THEN
      NULL;
    ELSIF OLD.status = 'ACKNOWLEDGED' AND NEW.status IN ('RESPONDING','INVESTIGATION','RESOLVED','CANCELLED') THEN
      NULL;
    ELSIF OLD.status = 'RESPONDING' AND NEW.status IN ('INVESTIGATION','RESOLVED','CANCELLED') THEN
      NULL;
    ELSIF OLD.status = 'INVESTIGATION' AND NEW.status IN ('WAITING_FOR_INFORMATION','RESOLUTION_PROPOSED','RESOLVED','CANCELLED') THEN
      NULL;
    ELSIF OLD.status = 'WAITING_FOR_INFORMATION' AND NEW.status IN ('INVESTIGATION','RESOLUTION_PROPOSED','RESOLVED','CANCELLED') THEN
      NULL;
    ELSIF OLD.status = 'RESOLUTION_PROPOSED' AND NEW.status IN ('INVESTIGATION','RESOLVED','CANCELLED') THEN
      NULL;
    ELSIF OLD.status = 'RESOLVED' AND NEW.status = 'CLOSED' THEN
      NULL;
    ELSE
      RAISE EXCEPTION 'Invalid safety incident status transition';
    END IF;
    IF NEW.status IN ('RESOLVED','CLOSED','CANCELLED') AND OLD.status NOT IN ('RESOLVED','CLOSED','CANCELLED') THEN
      NEW.location_sharing_enabled = false;
    END IF;
    IF NEW.status IN ('CLOSED','CANCELLED') AND OLD.status NOT IN ('CLOSED','CANCELLED') THEN
      NEW.closed_at = now();
    ELSIF NEW.status = 'ACKNOWLEDGED' AND OLD.status = 'ACTIVE' THEN
      NEW.acknowledged_at = now();
    END IF;
  END IF;
  IF NEW.assigned_responder_id IS NOT NULL AND NEW.assigned_responder_id IS DISTINCT FROM OLD.assigned_responder_id
    AND NOT EXISTS (SELECT 1 FROM public.safety_staff s WHERE s.college_id = OLD.college_id AND s.profile_id = NEW.assigned_responder_id AND s.is_active) THEN
    RAISE EXCEPTION 'Assigned responder is not authorized for this college';
  END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS safety_guard_incident_updates ON public.safety_incidents;
CREATE TRIGGER safety_guard_incident_updates BEFORE UPDATE ON public.safety_incidents
FOR EACH ROW EXECUTE FUNCTION public.safety_touch_and_guard_incident();

ALTER TABLE public.colleges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.safety_staff ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.safety_incidents ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.safety_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.safety_contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.safety_audit_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.safety_escalations ENABLE ROW LEVEL SECURITY;

-- Policies are explicitly replaced, so a SQL-editor retry after a connection interruption is safe.
DROP POLICY IF EXISTS "Safety staff can read own college" ON public.colleges;
DROP POLICY IF EXISTS "Admins manage colleges" ON public.colleges;
DROP POLICY IF EXISTS "Admins manage safety staff" ON public.safety_staff;
DROP POLICY IF EXISTS "Staff see own safety assignment" ON public.safety_staff;
DROP POLICY IF EXISTS "Authorized staff see college responder roster" ON public.safety_staff;
DROP POLICY IF EXISTS "Students create own college incident" ON public.safety_incidents;
DROP POLICY IF EXISTS "Students read own incidents" ON public.safety_incidents;
DROP POLICY IF EXISTS "Students cancel own active incident" ON public.safety_incidents;
DROP POLICY IF EXISTS "Authorized staff read incidents" ON public.safety_incidents;
DROP POLICY IF EXISTS "Authorized staff update incidents" ON public.safety_incidents;
DROP POLICY IF EXISTS "Student submits active own location" ON public.safety_locations;
DROP POLICY IF EXISTS "Student reads own incident locations" ON public.safety_locations;
DROP POLICY IF EXISTS "Staff reads authorized locations" ON public.safety_locations;
DROP POLICY IF EXISTS "Staff manage college contacts" ON public.safety_contacts;
DROP POLICY IF EXISTS "Students see their college emergency contacts" ON public.safety_contacts;
DROP POLICY IF EXISTS "Incident participants see audit log" ON public.safety_audit_logs;
DROP POLICY IF EXISTS "Authorized staff reads escalations" ON public.safety_escalations;
DROP POLICY IF EXISTS "Authorized staff creates escalation" ON public.safety_escalations;

CREATE POLICY "Safety staff can read own college" ON public.colleges FOR SELECT TO authenticated
  USING (public.is_safety_staff_for(id) OR id = (SELECT college_id FROM public.profiles WHERE id = auth.uid()));
CREATE POLICY "Admins manage colleges" ON public.colleges FOR ALL TO authenticated USING (public.is_admin()) WITH CHECK (public.is_admin());
CREATE POLICY "Admins manage safety staff" ON public.safety_staff FOR ALL TO authenticated USING (public.is_admin()) WITH CHECK (public.is_admin());
CREATE POLICY "Staff see own safety assignment" ON public.safety_staff FOR SELECT TO authenticated USING (profile_id = auth.uid());
CREATE POLICY "Authorized staff see college responder roster" ON public.safety_staff FOR SELECT TO authenticated USING (public.is_safety_staff_for(college_id));

CREATE POLICY "Students create own college incident" ON public.safety_incidents FOR INSERT TO authenticated WITH CHECK (
  student_id = auth.uid() AND status = 'ACTIVE' AND college_id = (SELECT college_id FROM public.profiles WHERE id = auth.uid())
  AND location_sharing_enabled = false AND location_sharing_expires_at IS NULL AND acknowledged_at IS NULL
  AND closed_at IS NULL AND assigned_responder_id IS NULL AND escalated_at IS NULL
);
CREATE POLICY "Students read own incidents" ON public.safety_incidents FOR SELECT TO authenticated USING (student_id = auth.uid());
CREATE POLICY "Students cancel own active incident" ON public.safety_incidents FOR UPDATE TO authenticated USING (student_id = auth.uid() AND status = 'ACTIVE') WITH CHECK (student_id = auth.uid());
CREATE POLICY "Authorized staff read incidents" ON public.safety_incidents FOR SELECT TO authenticated USING (public.is_safety_staff_for(college_id));
CREATE POLICY "Authorized staff update incidents" ON public.safety_incidents FOR UPDATE TO authenticated USING (public.is_safety_staff_for(college_id)) WITH CHECK (public.is_safety_staff_for(college_id));

CREATE POLICY "Student submits active own location" ON public.safety_locations FOR INSERT TO authenticated WITH CHECK (EXISTS (
  SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND i.student_id = auth.uid()
    AND i.status IN ('ACTIVE','ACKNOWLEDGED','RESPONDING') AND i.location_sharing_enabled
    AND (i.location_sharing_expires_at IS NULL OR i.location_sharing_expires_at > now())
));
CREATE POLICY "Student reads own incident locations" ON public.safety_locations FOR SELECT TO authenticated USING (EXISTS (
  SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND i.student_id = auth.uid()
));
CREATE POLICY "Staff reads authorized locations" ON public.safety_locations FOR SELECT TO authenticated USING (EXISTS (
  SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id)
));

CREATE POLICY "Staff manage college contacts" ON public.safety_contacts FOR ALL TO authenticated USING (public.is_safety_staff_for(college_id)) WITH CHECK (public.is_safety_staff_for(college_id));
CREATE POLICY "Students see their college emergency contacts" ON public.safety_contacts FOR SELECT TO authenticated USING (college_id = (SELECT college_id FROM public.profiles WHERE id = auth.uid()) AND is_active);
CREATE POLICY "Incident participants see audit log" ON public.safety_audit_logs FOR SELECT TO authenticated USING (EXISTS (
  SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND (i.student_id = auth.uid() OR public.is_safety_staff_for(i.college_id))
));
CREATE POLICY "Authorized staff reads escalations" ON public.safety_escalations FOR SELECT TO authenticated USING (EXISTS (
  SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id)
));
CREATE POLICY "Authorized staff creates escalation" ON public.safety_escalations FOR INSERT TO authenticated WITH CHECK (
  triggered_by = auth.uid() AND EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);

CREATE OR REPLACE FUNCTION public.safety_log_action(target_incident_id uuid, event_action text)
RETURNS void LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE incident_college uuid;
BEGIN
  SELECT college_id INTO incident_college FROM public.safety_incidents WHERE id = target_incident_id;
  IF incident_college IS NULL OR NOT (EXISTS (SELECT 1 FROM public.safety_incidents WHERE id = target_incident_id AND student_id = auth.uid()) OR public.is_safety_staff_for(incident_college)) THEN
    RAISE EXCEPTION 'Not authorized to log safety action';
  END IF;
  INSERT INTO public.safety_audit_logs(incident_id, actor_id, action) VALUES (target_incident_id, auth.uid(), left(event_action, 100));
END;
$$;
REVOKE ALL ON FUNCTION public.safety_log_action(uuid, text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.safety_log_action(uuid, text) TO authenticated;

-- Atomic, responder-only escalation. Level 3 signals the college's configured emergency protocol;
-- it does not automatically contact public emergency services.
CREATE OR REPLACE FUNCTION public.safety_escalate_incident(target_incident_id uuid, escalation_note text DEFAULT NULL)
RETURNS smallint LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
DECLARE current_incident public.safety_incidents%ROWTYPE; next_level smallint;
BEGIN
  SELECT * INTO current_incident FROM public.safety_incidents WHERE id = target_incident_id FOR UPDATE;
  IF NOT FOUND OR NOT public.is_safety_staff_for(current_incident.college_id) OR current_incident.status IN ('RESOLVED','CANCELLED') THEN
    RAISE EXCEPTION 'Not authorized to escalate this incident';
  END IF;
  next_level := LEAST(current_incident.escalation_level + 1, 3);
  IF next_level = current_incident.escalation_level THEN RETURN next_level; END IF;
  PERFORM set_config('app.safety_escalation', 'true', true);
  UPDATE public.safety_incidents SET escalation_level = next_level, escalated_at = now() WHERE id = target_incident_id;
  INSERT INTO public.safety_escalations(incident_id, triggered_by, escalation_level, note)
    VALUES (target_incident_id, auth.uid(), next_level, left(escalation_note, 500));
  INSERT INTO public.safety_audit_logs(incident_id, actor_id, action)
    VALUES (target_incident_id, auth.uid(), 'escalated_level_' || next_level);
  RETURN next_level;
END;
$$;
REVOKE ALL ON FUNCTION public.safety_escalate_incident(uuid, text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.safety_escalate_incident(uuid, text) TO authenticated;

-- Realtime must remain table-specific; do not publish profiles or audit logs.
DO $$ BEGIN
  ALTER PUBLICATION supabase_realtime ADD TABLE public.safety_incidents;
EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN
  ALTER PUBLICATION supabase_realtime ADD TABLE public.safety_locations;
EXCEPTION WHEN duplicate_object THEN NULL; END $$;
