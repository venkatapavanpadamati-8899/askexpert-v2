-- Phase 3 Advanced College Safety Engine
-- Adds Case Communication, SLA tracking, and Extended Statuses

-- 1. Extend Status Constraint
ALTER TABLE public.safety_incidents DROP CONSTRAINT IF EXISTS safety_incidents_status_check;
ALTER TABLE public.safety_incidents ADD CONSTRAINT safety_incidents_status_check 
  CHECK (status IN ('ACTIVE','ACKNOWLEDGED','RESPONDING','INVESTIGATION','WAITING_FOR_INFORMATION','RESOLUTION_PROPOSED','RESOLVED','CLOSED','CANCELLED'));

-- 2. SLA / Overdue Engine tracking
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS is_overdue boolean DEFAULT false;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS sla_breach_at timestamptz;

-- 3. Secure Case Communication (Messages)
CREATE TABLE IF NOT EXISTS public.safety_messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id uuid NOT NULL REFERENCES public.safety_incidents(id) ON DELETE CASCADE,
  sender_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  message text NOT NULL CHECK (char_length(message) > 0),
  is_internal boolean DEFAULT false, -- If true, students cannot see it
  attachment_urls text[] DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

-- RLS for Messages
ALTER TABLE public.safety_messages ENABLE ROW LEVEL SECURITY;

-- Students can read non-internal messages of their own incidents
CREATE POLICY "Students read own non-internal messages" ON public.safety_messages FOR SELECT TO authenticated USING (
  is_internal = false AND EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND i.student_id = auth.uid())
);
-- Students can insert non-internal messages to their own incidents
CREATE POLICY "Students send messages" ON public.safety_messages FOR INSERT TO authenticated WITH CHECK (
  is_internal = false AND sender_id = auth.uid() AND EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND i.student_id = auth.uid())
);

-- Staff can read all messages (internal and external) for their college incidents
CREATE POLICY "Staff read messages" ON public.safety_messages FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);
-- Staff can send messages
CREATE POLICY "Staff send messages" ON public.safety_messages FOR INSERT TO authenticated WITH CHECK (
  sender_id = auth.uid() AND EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);

-- Realtime support for Messages
DO $$ BEGIN
  ALTER PUBLICATION supabase_realtime ADD TABLE public.safety_messages;
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- 4. Notification status extensions (if not in Phase 2)
ALTER TABLE public.notifications ADD COLUMN IF NOT EXISTS delivery_status text DEFAULT 'SENT';
