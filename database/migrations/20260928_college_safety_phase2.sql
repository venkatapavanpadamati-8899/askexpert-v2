-- Phase 2 College Safety Advanced Engine
-- Adds AI, Investigation, Assignment History, and Break-Glass tables

-- 1. Role Expansion
ALTER TABLE public.safety_staff DROP CONSTRAINT IF EXISTS safety_staff_staff_role_check;
ALTER TABLE public.safety_staff ADD CONSTRAINT safety_staff_staff_role_check 
  CHECK (staff_role IN ('manager', 'security', 'responder', 'hod', 'women_safety_cell', 'principal'));

-- 2. Incidents Expansion (AI & Privacy)
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS is_anonymous boolean DEFAULT false;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS ai_category_suggestion text;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS ai_priority_suggestion text;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS ai_risk_explanation text;
ALTER TABLE public.safety_incidents ADD COLUMN IF NOT EXISTS duplicate_hash text;

-- 3. Investigation Management (Internal Staff Only)
CREATE TABLE IF NOT EXISTS public.safety_investigations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id uuid NOT NULL REFERENCES public.safety_incidents(id) ON DELETE CASCADE UNIQUE,
  investigator_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  started_at timestamptz DEFAULT now(),
  follow_up_at timestamptz,
  internal_notes text,
  resolution_reason text,
  closure_approval_by uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE public.safety_investigations ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authorized staff read investigations" ON public.safety_investigations FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);
CREATE POLICY "Authorized staff update investigations" ON public.safety_investigations FOR ALL TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);

-- 4. Case Assignment History
CREATE TABLE IF NOT EXISTS public.safety_assignment_history (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id uuid NOT NULL REFERENCES public.safety_incidents(id) ON DELETE CASCADE,
  previous_assignee_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  new_assignee_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  assigned_by uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
  reason text,
  status text DEFAULT 'PENDING' CHECK (status IN ('PENDING','ACCEPTED','REJECTED','TRANSFERRED')),
  created_at timestamptz DEFAULT now()
);

ALTER TABLE public.safety_assignment_history ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Staff read assignment history" ON public.safety_assignment_history FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);
CREATE POLICY "Staff create assignments" ON public.safety_assignment_history FOR INSERT TO authenticated WITH CHECK (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);

-- 5. Break-Glass Access
CREATE TABLE IF NOT EXISTS public.safety_break_glass_requests (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  incident_id uuid NOT NULL REFERENCES public.safety_incidents(id) ON DELETE CASCADE,
  requested_by uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  reason text NOT NULL,
  expires_at timestamptz NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE public.safety_break_glass_requests ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Staff read break glass" ON public.safety_break_glass_requests FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.safety_incidents i WHERE i.id = incident_id AND public.is_safety_staff_for(i.college_id))
);
CREATE POLICY "High level roles can insert break glass" ON public.safety_break_glass_requests FOR INSERT TO authenticated WITH CHECK (
  EXISTS (
    SELECT 1 FROM public.safety_staff s 
    JOIN public.safety_incidents i ON s.college_id = i.college_id
    WHERE i.id = incident_id AND s.profile_id = auth.uid() 
    AND s.staff_role IN ('principal', 'hod', 'manager')
  )
);

-- RLS Policy allowing Break-Glass on Incidents
CREATE POLICY "Break-glass temporary access to incidents" ON public.safety_incidents FOR SELECT TO authenticated USING (
  EXISTS (
    SELECT 1 FROM public.safety_break_glass_requests bg
    WHERE bg.incident_id = id AND bg.requested_by = auth.uid() AND bg.expires_at > now()
  )
);

-- Note: In a fully fleshed out system, break glass would also apply to locations and evidence policies.

-- 6. Notification Tracking extensions
ALTER TABLE public.notifications ADD COLUMN IF NOT EXISTS is_read boolean DEFAULT false;
ALTER TABLE public.notifications ADD COLUMN IF NOT EXISTS read_at timestamptz;
ALTER TABLE public.notifications ADD COLUMN IF NOT EXISTS delivery_status text DEFAULT 'PENDING';
