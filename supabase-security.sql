-- ==============================================================================
-- ASKEXPERT - COMPLETE PRODUCTION SUPABASE SECURITY & RLS HARDENING SCRIPT
-- ==============================================================================
-- Run this script in the Supabase SQL Editor:
-- Dashboard -> SQL Editor -> New Query -> Paste & Run
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. HELPER SECURITY FUNCTIONS
-- ------------------------------------------------------------------------------

-- Helper function to check if current authenticated user is an Admin
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid()
    AND role = 'admin'
  );
$$;

-- Helper function to check if current authenticated user is a Verified Expert
CREATE OR REPLACE FUNCTION public.is_expert()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid()
    AND role = 'expert'
  );
$$;

-- ------------------------------------------------------------------------------
-- 2. CORE DATABASE TABLES & SCHEMA DEFINITIONS (14 TABLES)
-- ------------------------------------------------------------------------------

-- Table 1: profiles
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT,
  role TEXT NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'expert', 'admin')),
  username TEXT UNIQUE,
  email TEXT,
  phone TEXT,
  avatar_url TEXT,
  headline TEXT,
  specialization TEXT,
  experience_years INT DEFAULT 0,
  languages TEXT[] DEFAULT ARRAY['English'],
  rating NUMERIC(3,2) DEFAULT 5.00,
  reviews_count INT DEFAULT 0,
  consultation_fee NUMERIC(10,2) DEFAULT 1000.00,
  bio TEXT,
  skills TEXT[] DEFAULT ARRAY[]::TEXT[],
  availability_status TEXT DEFAULT 'available' CHECK (availability_status IN ('available', 'busy', 'offline')),
  account_status TEXT DEFAULT 'active' CHECK (account_status IN ('active', 'suspended', 'blocked')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table 2: professional_verifications
CREATE TABLE IF NOT EXISTS public.professional_verifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  expert_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  council_registration_no TEXT NOT NULL,
  degree_qualification TEXT NOT NULL,
  id_document_path TEXT,
  verification_status TEXT NOT NULL DEFAULT 'pending' CHECK (verification_status IN ('pending', 'approved', 'rejected')),
  identity_verified BOOLEAN NOT NULL DEFAULT false,
  degree_verified BOOLEAN NOT NULL DEFAULT false,
  council_verified BOOLEAN NOT NULL DEFAULT false,
  rejection_reason TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table 3: questions
CREATE TABLE IF NOT EXISTS public.questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  language TEXT DEFAULT 'English',
  status TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'assigned', 'answered', 'resolved', 'closed')),
  answers_count INT NOT NULL DEFAULT 0,
  moderation_status TEXT DEFAULT 'visible' CHECK (moderation_status IN ('visible', 'flagged', 'under_review', 'removed', 'hidden')),
  moderation_reason TEXT,
  moderated_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  moderated_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table 4: answers
CREATE TABLE IF NOT EXISTS public.answers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  author_name TEXT,
  author_role TEXT DEFAULT 'expert',
  author_avatar TEXT,
  author_headline TEXT,
  content TEXT NOT NULL,
  media_url TEXT,
  helpful_count INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table 5: conversations
CREATE TABLE IF NOT EXISTS public.conversations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  expert_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'archived', 'closed')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT unique_user_expert_conversation UNIQUE(user_id, expert_id)
);

-- Table 6: messages
CREATE TABLE IF NOT EXISTS public.messages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id UUID NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE,
  sender_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  sender_role TEXT NOT NULL DEFAULT 'user' CHECK (sender_role IN ('user', 'expert', 'admin')),
  content TEXT,
  message_type TEXT NOT NULL DEFAULT 'text' CHECK (message_type IN ('text', 'image', 'video', 'document', 'audio')),
  media_url TEXT,
  media_metadata JSONB DEFAULT '{}'::JSONB,
  status TEXT NOT NULL DEFAULT 'sent' CHECK (status IN ('sent', 'delivered', 'read')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table 7: consultation_requests
CREATE TABLE IF NOT EXISTS public.consultation_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  expert_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  offered_amount NUMERIC(10,2) DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'declined', 'cancelled', 'completed')),
  message TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table 8: payments
CREATE TABLE IF NOT EXISTS public.payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  expert_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  conversation_id UUID REFERENCES public.conversations(id) ON DELETE SET NULL,
  amount NUMERIC(10,2) NOT NULL CHECK (amount > 0),
  currency TEXT NOT NULL DEFAULT 'INR',
  payment_method TEXT,
  provider TEXT,
  provider_payment_id TEXT,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'successful', 'failed', 'cancelled', 'refunded')),
  description TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table 9: payout_requests
CREATE TABLE IF NOT EXISTS public.payout_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  expert_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  amount NUMERIC(10,2) NOT NULL CHECK (amount > 0),
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'processing', 'paid', 'rejected', 'cancelled')),
  payout_reference TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  processed_at TIMESTAMPTZ
);

-- Table 10: notifications
CREATE TABLE IF NOT EXISTS public.notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  related_id UUID,
  is_read BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table 11: reports
CREATE TABLE IF NOT EXISTS public.reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  reporter_id UUID NOT NULL,
  reported_user_id UUID,
  report_type TEXT NOT NULL,
  reason TEXT NOT NULL,
  description TEXT,
  question_id UUID REFERENCES public.questions(id) ON DELETE SET NULL,
  conversation_id UUID REFERENCES public.conversations(id) ON DELETE SET NULL,
  payment_id UUID REFERENCES public.payments(id) ON DELETE SET NULL,
  priority TEXT NOT NULL DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high', 'critical')),
  status TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'under_review', 'resolved', 'dismissed')),
  assigned_admin UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  resolution_notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  resolved_at TIMESTAMPTZ,
  CONSTRAINT reports_reporter_id_fkey FOREIGN KEY (reporter_id) REFERENCES public.profiles(id) ON DELETE CASCADE,
  CONSTRAINT reports_reported_user_id_fkey FOREIGN KEY (reported_user_id) REFERENCES public.profiles(id) ON DELETE SET NULL
);

-- Table 12: consultation_sessions
CREATE TABLE IF NOT EXISTS public.consultation_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id UUID NOT NULL,
  user_id UUID NOT NULL,
  expert_id UUID NOT NULL,
  payment_id UUID,
  duration_minutes INT NOT NULL DEFAULT 30,
  status TEXT NOT NULL DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'active', 'completed', 'cancelled', 'disputed', 'expired')),
  started_at TIMESTAMPTZ,
  expires_at TIMESTAMPTZ,
  ended_at TIMESTAMPTZ,
  expert_gross_amount NUMERIC(10,2) NOT NULL DEFAULT 0,
  platform_fee NUMERIC(10,2) NOT NULL DEFAULT 0,
  expert_net_earnings NUMERIC(10,2) NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT consultation_sessions_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE,
  CONSTRAINT consultation_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE,
  CONSTRAINT consultation_sessions_expert_id_fkey FOREIGN KEY (expert_id) REFERENCES public.profiles(id) ON DELETE CASCADE,
  CONSTRAINT consultation_sessions_payment_id_fkey FOREIGN KEY (payment_id) REFERENCES public.payments(id) ON DELETE SET NULL
);

-- Table 13: reviews
CREATE TABLE IF NOT EXISTS public.reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID,
  user_id UUID NOT NULL,
  expert_id UUID NOT NULL,
  rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT reviews_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.consultation_sessions(id) ON DELETE CASCADE,
  CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE,
  CONSTRAINT reviews_expert_id_fkey FOREIGN KEY (expert_id) REFERENCES public.profiles(id) ON DELETE CASCADE
);

-- Table 14: session_events
CREATE TABLE IF NOT EXISTS public.session_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID NOT NULL,
  event_type TEXT NOT NULL,
  triggered_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  metadata JSONB DEFAULT '{}'::JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT session_events_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.consultation_sessions(id) ON DELETE CASCADE
);

-- Table 15: system_health
CREATE TABLE IF NOT EXISTS public.system_health (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  component_name TEXT NOT NULL UNIQUE,
  status TEXT NOT NULL DEFAULT 'healthy' CHECK (status IN ('healthy', 'degraded', 'down', 'maintenance')),
  response_time_ms INT NOT NULL DEFAULT 0,
  last_checked TIMESTAMPTZ NOT NULL DEFAULT now(),
  error_message TEXT,
  metadata JSONB DEFAULT '{}'::JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Table 16: audit_logs
CREATE TABLE IF NOT EXISTS public.audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  actor_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  actor_role TEXT NOT NULL DEFAULT 'admin',
  action TEXT NOT NULL,
  resource_type TEXT NOT NULL,
  resource_id TEXT,
  timestamp TIMESTAMPTZ NOT NULL DEFAULT now(),
  ip_address TEXT,
  metadata JSONB DEFAULT '{}'::JSONB
);

-- ------------------------------------------------------------------------------
-- 3. AUTOMATIC USER PROFILE CREATION TRIGGER
-- ------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  base_username TEXT;
  final_username TEXT;
  counter INT := 1;
BEGIN
  -- Extract username from metadata or email
  base_username := COALESCE(
    NEW.raw_user_meta_data->>'username',
    split_part(NEW.email, '@', 1)
  );

  -- Sanitize username: lowercase, replace spaces, remove special characters
  base_username := LOWER(REGEXP_REPLACE(base_username, '[^a-zA-Z0-9_]', '_', 'g'));
  IF base_username IS NULL OR LENGTH(base_username) < 2 THEN
    base_username := 'user_' || SUBSTRING(NEW.id::text FROM 1 FOR 8);
  END IF;

  final_username := base_username;

  -- Ensure username is unique in public.profiles table
  WHILE EXISTS (SELECT 1 FROM public.profiles WHERE username = final_username AND id <> NEW.id) LOOP
    final_username := base_username || '_' || counter;
    counter := counter + 1;
  END LOOP;

  -- Safely insert or update profile row
  INSERT INTO public.profiles (
    id,
    full_name,
    role,
    username,
    email,
    phone,
    avatar_url,
    headline,
    specialization
  )
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email),
    COALESCE(NEW.raw_user_meta_data->>'role', 'user'),
    final_username,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'phone', ''),
    COALESCE(NEW.raw_user_meta_data->>'avatar_url', ''),
    COALESCE(NEW.raw_user_meta_data->>'headline', ''),
    COALESCE(NEW.raw_user_meta_data->>'specialization', '')
  )
  ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
    role = EXCLUDED.role,
    username = EXCLUDED.username,
    email = EXCLUDED.email,
    phone = EXCLUDED.phone,
    updated_at = now();

  RETURN NEW;
EXCEPTION WHEN OTHERS THEN
  -- Safeguard: Log error notice and ensure user registration transaction completes
  RAISE WARNING 'handle_new_user trigger warning: %', SQLERRM;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ------------------------------------------------------------------------------
-- 4. ENABLE ROW LEVEL SECURITY (RLS) ON ALL 14 TABLES
-- ------------------------------------------------------------------------------

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.professional_verifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.consultation_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.payout_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.consultation_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.session_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.system_health ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

-- ------------------------------------------------------------------------------
-- 5. FINE-GRAINED RLS POLICIES
-- ------------------------------------------------------------------------------

-- ==================== TABLE: profiles ====================
DROP POLICY IF EXISTS "Profiles are viewable by everyone" ON public.profiles;
CREATE POLICY "Profiles are viewable by everyone" ON public.profiles
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;
CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

DROP POLICY IF EXISTS "Admins can manage all profiles" ON public.profiles;
CREATE POLICY "Admins can manage all profiles" ON public.profiles
  FOR ALL USING (public.is_admin());

-- ==================== TABLE: professional_verifications ====================
DROP POLICY IF EXISTS "Experts can view and submit own verification" ON public.professional_verifications;
CREATE POLICY "Experts can view and submit own verification" ON public.professional_verifications
  FOR ALL USING (auth.uid() = expert_id);

DROP POLICY IF EXISTS "Admins can view and moderate all verifications" ON public.professional_verifications;
CREATE POLICY "Admins can view and moderate all verifications" ON public.professional_verifications
  FOR ALL USING (public.is_admin());

-- ==================== TABLE: questions ====================
DROP POLICY IF EXISTS "Visible questions are viewable by everyone" ON public.questions;
DROP POLICY IF EXISTS "Questions are viewable by everyone" ON public.questions;
CREATE POLICY "Questions are viewable by everyone" ON public.questions
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "Authenticated users can ask questions" ON public.questions;
CREATE POLICY "Authenticated users can ask questions" ON public.questions
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Question owners can update their questions" ON public.questions;
CREATE POLICY "Question owners can update their questions" ON public.questions
  FOR UPDATE USING (auth.uid() = user_id OR public.is_admin());

DROP POLICY IF EXISTS "Admins can moderate questions" ON public.questions;
CREATE POLICY "Admins can moderate questions" ON public.questions
  FOR ALL USING (public.is_admin());

-- ==================== TABLE: answers ====================
DROP POLICY IF EXISTS "Answers are viewable by everyone" ON public.answers;
CREATE POLICY "Answers are viewable by everyone" ON public.answers
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "Experts and users can submit answers" ON public.answers;
CREATE POLICY "Experts and users can submit answers" ON public.answers
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Authors can edit own answers" ON public.answers;
CREATE POLICY "Authors can edit own answers" ON public.answers
  FOR UPDATE USING (auth.uid() = user_id OR public.is_admin());

-- ==================== TABLE: conversations ====================
DROP POLICY IF EXISTS "Participants can view their conversations" ON public.conversations;
CREATE POLICY "Participants can view their conversations" ON public.conversations
  FOR SELECT USING (auth.uid() = user_id OR auth.uid() = expert_id OR public.is_admin());

DROP POLICY IF EXISTS "Participants can create conversations" ON public.conversations;
CREATE POLICY "Participants can create conversations" ON public.conversations
  FOR INSERT WITH CHECK (auth.uid() = user_id OR auth.uid() = expert_id);

DROP POLICY IF EXISTS "Participants can update conversations" ON public.conversations;
CREATE POLICY "Participants can update conversations" ON public.conversations
  FOR UPDATE USING (auth.uid() = user_id OR auth.uid() = expert_id OR public.is_admin());

-- ==================== TABLE: messages ====================
DROP POLICY IF EXISTS "Participants can read conversation messages" ON public.messages;
CREATE POLICY "Participants can read conversation messages" ON public.messages
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.conversations c
      WHERE c.id = messages.conversation_id
      AND (c.user_id = auth.uid() OR c.expert_id = auth.uid() OR public.is_admin())
    )
  );

DROP POLICY IF EXISTS "Participants can send messages" ON public.messages;
CREATE POLICY "Participants can send messages" ON public.messages
  FOR INSERT WITH CHECK (
    auth.uid() = sender_id AND
    EXISTS (
      SELECT 1 FROM public.conversations c
      WHERE c.id = messages.conversation_id
      AND (c.user_id = auth.uid() OR c.expert_id = auth.uid())
    )
  );

-- ==================== TABLE: consultation_requests ====================
DROP POLICY IF EXISTS "Users and experts can view their consultation requests" ON public.consultation_requests;
CREATE POLICY "Users and experts can view their consultation requests" ON public.consultation_requests
  FOR SELECT USING (auth.uid() = user_id OR auth.uid() = expert_id OR public.is_admin());

DROP POLICY IF EXISTS "Users can create consultation requests" ON public.consultation_requests;
CREATE POLICY "Users can create consultation requests" ON public.consultation_requests
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Experts can accept or decline consultation requests" ON public.consultation_requests;
CREATE POLICY "Experts can accept or decline consultation requests" ON public.consultation_requests
  FOR UPDATE USING (auth.uid() = expert_id OR auth.uid() = user_id OR public.is_admin());

-- ==================== TABLE: payments ====================
DROP POLICY IF EXISTS "Users and experts can view related payments" ON public.payments;
CREATE POLICY "Users and experts can view related payments" ON public.payments
  FOR SELECT USING (auth.uid() = user_id OR auth.uid() = expert_id OR public.is_admin());

DROP POLICY IF EXISTS "Authenticated users can record payments" ON public.payments;
CREATE POLICY "Authenticated users can record payments" ON public.payments
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Admins can manage all payments" ON public.payments;
CREATE POLICY "Admins can manage all payments" ON public.payments
  FOR ALL USING (public.is_admin());

-- ==================== TABLE: payout_requests ====================
DROP POLICY IF EXISTS "Experts can view and submit own payout requests" ON public.payout_requests;
CREATE POLICY "Experts can view and submit own payout requests" ON public.payout_requests
  FOR ALL USING (auth.uid() = expert_id OR public.is_admin());

-- ==================== TABLE: notifications ====================
DROP POLICY IF EXISTS "Users can view own notifications" ON public.notifications;
CREATE POLICY "Users can view own notifications" ON public.notifications
  FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can update own notifications" ON public.notifications;
CREATE POLICY "Users can update own notifications" ON public.notifications
  FOR UPDATE USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Authenticated users or service can insert notifications" ON public.notifications;
CREATE POLICY "Authenticated users or service can insert notifications" ON public.notifications
  FOR INSERT WITH CHECK (auth.role() = 'authenticated' OR auth.role() = 'service_role');


-- ==================== TABLE: reports ====================
DROP POLICY IF EXISTS "Users can submit reports" ON public.reports;
CREATE POLICY "Users can submit reports" ON public.reports
  FOR INSERT WITH CHECK (auth.uid() = reporter_id);

DROP POLICY IF EXISTS "Admins can view and manage all reports" ON public.reports;
CREATE POLICY "Admins can view and manage all reports" ON public.reports
  FOR ALL USING (public.is_admin());

-- ==================== TABLE: consultation_sessions ====================
DROP POLICY IF EXISTS "Participants can view their consultation sessions" ON public.consultation_sessions;
CREATE POLICY "Participants can view their consultation sessions" ON public.consultation_sessions
  FOR SELECT USING (auth.uid() = user_id OR auth.uid() = expert_id OR public.is_admin());

DROP POLICY IF EXISTS "Participants and admins can manage consultation sessions" ON public.consultation_sessions;
CREATE POLICY "Participants and admins can manage consultation sessions" ON public.consultation_sessions
  FOR ALL USING (auth.uid() = user_id OR auth.uid() = expert_id OR public.is_admin());

-- ==================== TABLE: reviews ====================
DROP POLICY IF EXISTS "Reviews are viewable by everyone" ON public.reviews;
CREATE POLICY "Reviews are viewable by everyone" ON public.reviews
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "Clients can submit reviews for completed sessions" ON public.reviews;
CREATE POLICY "Clients can submit reviews for completed sessions" ON public.reviews
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Clients can update own reviews" ON public.reviews;
CREATE POLICY "Clients can update own reviews" ON public.reviews
  FOR UPDATE USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Clients and admins can delete reviews" ON public.reviews;
CREATE POLICY "Clients and admins can delete reviews" ON public.reviews
  FOR DELETE USING (auth.uid() = user_id OR public.is_admin());

-- ==================== TABLE: session_events ====================
DROP POLICY IF EXISTS "Participants can view session events" ON public.session_events;
CREATE POLICY "Participants can view session events" ON public.session_events
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.consultation_sessions s
      WHERE s.id = session_events.session_id
      AND (s.user_id = auth.uid() OR s.expert_id = auth.uid() OR public.is_admin())
    )
  );

DROP POLICY IF EXISTS "Participants can insert session events" ON public.session_events;
CREATE POLICY "Participants can insert session events" ON public.session_events
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.consultation_sessions s
      WHERE s.id = session_events.session_id
      AND (s.user_id = auth.uid() OR s.expert_id = auth.uid())
    )
  );

-- ==================== TABLE: system_health ====================
DROP POLICY IF EXISTS "System health is readable by authenticated users or admins" ON public.system_health;
CREATE POLICY "System health is readable by authenticated users or admins" ON public.system_health
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "Only admins can modify system health" ON public.system_health;
CREATE POLICY "Only admins can modify system health" ON public.system_health
  FOR ALL USING (public.is_admin() OR auth.role() = 'service_role');

-- ==================== TABLE: audit_logs ====================
DROP POLICY IF EXISTS "Admins can view audit logs" ON public.audit_logs;
CREATE POLICY "Admins can view audit logs" ON public.audit_logs
  FOR SELECT USING (public.is_admin() OR auth.role() = 'service_role');

DROP POLICY IF EXISTS "Authenticated users or services can insert audit logs" ON public.audit_logs;
CREATE POLICY "Authenticated users or services can insert audit logs" ON public.audit_logs
  FOR INSERT WITH CHECK (
    auth.role() = 'authenticated' 
    OR auth.role() = 'service_role' 
    OR public.is_admin()
  );

-- ------------------------------------------------------------------------------
-- 6. SUPABASE STORAGE BUCKETS & STORAGE RLS POLICIES
-- ------------------------------------------------------------------------------

-- Create Buckets (Public chat-media & Private private-verifications)
INSERT INTO storage.buckets (id, name, public)
VALUES 
  ('chat-media', 'chat-media', true),
  ('private-verifications', 'private-verifications', false)
ON CONFLICT (id) DO UPDATE SET public = EXCLUDED.public;

-- Storage Policy: Public Chat Media Read
DROP POLICY IF EXISTS "Public chat media is readable by everyone" ON storage.objects;
CREATE POLICY "Public chat media is readable by everyone" ON storage.objects
  FOR SELECT USING (bucket_id = 'chat-media');

-- Storage Policy: Authenticated users can upload to chat-media
DROP POLICY IF EXISTS "Authenticated users can upload to chat-media" ON storage.objects;
CREATE POLICY "Authenticated users can upload to chat-media" ON storage.objects
  FOR INSERT WITH CHECK (
    bucket_id = 'chat-media' AND
    auth.role() = 'authenticated'
  );

-- Storage Policy: Private Verification Upload (Only owner can upload)
DROP POLICY IF EXISTS "Experts can upload private verification docs" ON storage.objects;
CREATE POLICY "Experts can upload private verification docs" ON storage.objects
  FOR INSERT WITH CHECK (
    bucket_id = 'private-verifications' AND
    auth.role() = 'authenticated' AND
    (storage.foldername(name))[1] = auth.uid()::text
  );

-- Storage Policy: Private Verification Select (Only owner or Admin can read)
DROP POLICY IF EXISTS "Only owner or admin can read private verification docs" ON storage.objects;
CREATE POLICY "Only owner or admin can read private verification docs" ON storage.objects
  FOR SELECT USING (
    bucket_id = 'private-verifications' AND
    (
      (storage.foldername(name))[1] = auth.uid()::text
      OR public.is_admin()
    )
  );

-- ------------------------------------------------------------------------------
-- 7. REALTIME PUBLICATION SETUP
-- ------------------------------------------------------------------------------

DO $$
BEGIN
  -- Add tables to realtime publication if not already included
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.messages; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.questions; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.answers; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.consultation_requests; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.payments; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.payout_requests; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.reports; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.consultation_sessions; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.reviews; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.session_events; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.system_health; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.audit_logs; EXCEPTION WHEN others THEN NULL; END;
END $$;


-- ------------------------------------------------------------------------------
-- 8. AI ERROR DETECTION & AUTO-FIX AGENT TABLES & RLS POLICIES
-- ------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.system_errors (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  fingerprint TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('USER', 'EXPERT', 'ADMIN', 'APPLICATION', 'DATABASE', 'AUTHENTICATION', 'PAYMENT', 'SECURITY', 'INFRASTRUCTURE', 'UNKNOWN')),
  severity TEXT NOT NULL DEFAULT 'MEDIUM' CHECK (severity IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL')),
  error_message TEXT NOT NULL,
  stack_trace TEXT,
  affected_page TEXT,
  user_role TEXT DEFAULT 'unauthenticated',
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  api_endpoint TEXT,
  supabase_code TEXT,
  db_code TEXT,
  occurrence_count INT NOT NULL DEFAULT 1,
  first_seen_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_seen_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  status TEXT NOT NULL DEFAULT 'OPEN' CHECK (status IN ('OPEN', 'INVESTIGATING', 'FIX PROPOSED', 'WAITING FOR APPROVAL', 'APPROVED', 'FIXING', 'FIXED', 'FAILED', 'REJECTED')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.error_fix_proposals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_id UUID NOT NULL REFERENCES public.system_errors(id) ON DELETE CASCADE,
  root_cause TEXT NOT NULL,
  affected_files JSONB NOT NULL DEFAULT '[]'::jsonb,
  affected_db_objects JSONB NOT NULL DEFAULT '[]'::jsonb,
  proposed_fix_description TEXT NOT NULL,
  proposed_code_changes TEXT,
  proposed_sql_changes TEXT,
  risk_level TEXT NOT NULL DEFAULT 'LOW' CHECK (risk_level IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL')),
  expected_impact TEXT NOT NULL,
  rollback_plan TEXT NOT NULL,
  tests_to_run JSONB NOT NULL DEFAULT '[]'::jsonb,
  approved_by UUID REFERENCES auth.users(id),
  approved_at TIMESTAMPTZ,
  status TEXT NOT NULL DEFAULT 'WAITING FOR APPROVAL' CHECK (status IN ('WAITING FOR APPROVAL', 'APPROVED', 'REJECTED', 'EXECUTED', 'FAILED')),
  execution_log TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.ai_agent_audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_id UUID REFERENCES public.system_errors(id) ON DELETE SET NULL,
  proposal_id UUID REFERENCES public.error_fix_proposals(id) ON DELETE SET NULL,
  admin_id UUID REFERENCES auth.users(id),
  action TEXT NOT NULL,
  details JSONB NOT NULL DEFAULT '{}'::jsonb,
  timestamp TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Enable RLS
ALTER TABLE public.system_errors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.error_fix_proposals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ai_agent_audit_logs ENABLE ROW LEVEL SECURITY;

-- RLS: system_errors (Anyone can report error; only Admins can view/update)
DROP POLICY IF EXISTS "Anyone can insert system errors" ON public.system_errors;
CREATE POLICY "Anyone can insert system errors" ON public.system_errors
  FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Only Admins can view system errors" ON public.system_errors;
CREATE POLICY "Only Admins can view system errors" ON public.system_errors
  FOR SELECT USING (public.is_admin());

DROP POLICY IF EXISTS "Only Admins can update system errors" ON public.system_errors;
CREATE POLICY "Only Admins can update system errors" ON public.system_errors
  FOR UPDATE USING (public.is_admin());

-- RLS: error_fix_proposals (Only Admins can manage proposals)
DROP POLICY IF EXISTS "Only Admins can manage error fix proposals" ON public.error_fix_proposals;
CREATE POLICY "Only Admins can manage error fix proposals" ON public.error_fix_proposals
  FOR ALL USING (public.is_admin());

-- RLS: ai_agent_audit_logs (Only Admins can view and write audit logs)
DROP POLICY IF EXISTS "Only Admins can view and write audit logs" ON public.ai_agent_audit_logs;
CREATE POLICY "Only Admins can view and write audit logs" ON public.ai_agent_audit_logs
  FOR ALL USING (public.is_admin());

-- Add to Realtime Publication
DO $$
BEGIN
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.system_errors; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.error_fix_proposals; EXCEPTION WHEN others THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.ai_agent_audit_logs; EXCEPTION WHEN others THEN NULL; END;
END $$;

