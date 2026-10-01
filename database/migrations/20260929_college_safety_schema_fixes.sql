-- Fix A: Add ai_risk_explanation column to safety_incidents
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS ai_risk_explanation text;

-- Fix B: Update safety_notify_incident_change to use notifications.link instead of related_id
CREATE OR REPLACE FUNCTION public.safety_notify_incident_change()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO public.notifications(user_id, type, title, message, link)
      SELECT s.profile_id, 'safety_sos', 'Emergency safety alert',
        'A student has created an emergency request. Open the College Safety dashboard to respond.', 'admin-dashboard.html'
      FROM public.safety_staff s WHERE s.college_id = NEW.college_id AND s.is_active;
    INSERT INTO public.safety_audit_logs(incident_id, actor_id, action) VALUES (NEW.id, NEW.student_id, 'incident_created');
  ELSIF NEW.status IS DISTINCT FROM OLD.status THEN
    INSERT INTO public.notifications(user_id, type, title, message, link) VALUES
      (NEW.student_id, 'safety_status', 'Emergency status updated', 'Your safety request status is now ' || NEW.status || '.', 'college-safety.html');
    INSERT INTO public.safety_audit_logs(incident_id, actor_id, action) VALUES (NEW.id, auth.uid(), 'status_' || lower(NEW.status));
    IF NEW.status IN ('RESOLVED', 'CANCELLED') THEN
      DELETE FROM public.safety_locations WHERE incident_id = NEW.id;
      INSERT INTO public.safety_audit_logs(incident_id, actor_id, action) VALUES (NEW.id, auth.uid(), 'location_history_purged');
    END IF;
  ELSIF NEW.location_sharing_enabled IS DISTINCT FROM OLD.location_sharing_enabled AND NEW.location_sharing_enabled THEN
    INSERT INTO public.safety_audit_logs(incident_id, actor_id, action) VALUES (NEW.id, auth.uid(), 'location_sharing_started');
  END IF;
  RETURN NEW;
END;
$function$;

-- Fix C: Update notifications_type_check to allow safety_sos and safety_status
ALTER TABLE public.notifications DROP CONSTRAINT IF EXISTS notifications_type_check;
ALTER TABLE public.notifications ADD CONSTRAINT notifications_type_check CHECK (type = ANY (ARRAY['new_question'::text, 'new_answer'::text, 'expert_approved'::text, 'expert_rejected'::text, 'answer_accepted'::text, 'safety_sos'::text, 'safety_status'::text, 'chat'::text, 'payment'::text, 'expert'::text]));
