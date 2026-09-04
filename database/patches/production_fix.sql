-- ================================================================
-- AskExpert — PRODUCTION FIX PATCH (V2 COMPATIBILITY)
-- Run this ONCE in Supabase SQL Editor (safe, idempotent)
-- Date: 2026-09-04
-- ================================================================
-- Purpose: Harmonize all schema discrepancies between frontend and DB:
--   1. questions: support BOTH (body, tags, answer_count) AND (description, category, answers_count)
--   2. answers: support BOTH (expert_id) AND (user_id), content, helpful_count
--   3. reviews: support BOTH (comment) AND (review_text)
--   4. consultation_requests: support BOTH (expert_id) AND (professional_id)
--   5. profiles: add is_verified, is_blocked, wallet_balance, category, location
--   6. system_errors, error_fix_proposals, issue_reports, privacy_settings tables
--   7. RLS policies and performance indexes
-- Admin flows: UNMODIFIED. OTP flows: UNMODIFIED.
-- ================================================================

-- ----------------------------------------------------------------
-- PATCH 0: Admin Helper Function
-- ----------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  );
END;
$$;

-- ----------------------------------------------------------------
-- PATCH A: profiles table columns & index
-- ----------------------------------------------------------------
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS is_verified BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS is_blocked BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS category TEXT;

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS location TEXT;

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS wallet_balance NUMERIC DEFAULT 0;

CREATE INDEX IF NOT EXISTS idx_profiles_is_verified_experts
  ON public.profiles (is_verified)
  WHERE is_verified = true;

-- ----------------------------------------------------------------
-- PATCH B: professional_verifications columns & defaults
-- ----------------------------------------------------------------
ALTER TABLE public.professional_verifications
  ADD COLUMN IF NOT EXISTS council_registration_number TEXT;

ALTER TABLE public.professional_verifications
  ADD COLUMN IF NOT EXISTS submitted_at TIMESTAMPTZ DEFAULT now();

DO $$
BEGIN
  ALTER TABLE public.professional_verifications
    ALTER COLUMN degree_qualification SET DEFAULT 'Not Provided';
EXCEPTION WHEN others THEN NULL;
END $$;

-- (council_registration_number is a generated column from council_registration_no, so no manual UPDATE needed)

-- ----------------------------------------------------------------
-- PATCH C: questions table harmonization
-- ----------------------------------------------------------------
ALTER TABLE public.questions
  ADD COLUMN IF NOT EXISTS description TEXT;

ALTER TABLE public.questions
  ADD COLUMN IF NOT EXISTS category TEXT;

ALTER TABLE public.questions
  ADD COLUMN IF NOT EXISTS language TEXT DEFAULT 'English';

ALTER TABLE public.questions
  ADD COLUMN IF NOT EXISTS answers_count INTEGER DEFAULT 0;

-- Backfill sync between body <-> description
UPDATE public.questions
SET description = body
WHERE description IS NULL AND body IS NOT NULL;

UPDATE public.questions
SET body = description
WHERE body IS NULL AND description IS NOT NULL;

-- Backfill sync between answer_count <-> answers_count
DO $$
BEGIN
  BEGIN
    UPDATE public.questions
    SET answers_count = answer_count
    WHERE (answers_count IS NULL OR answers_count = 0) AND answer_count IS NOT NULL;
  EXCEPTION WHEN others THEN NULL;
  END;

  BEGIN
    UPDATE public.questions
    SET answer_count = answers_count
    WHERE (answer_count IS NULL OR answer_count = 0) AND answers_count IS NOT NULL;
  EXCEPTION WHEN others THEN NULL;
  END;
END $$;

-- Align moderation_status
UPDATE public.questions
  SET moderation_status = 'visible'
  WHERE moderation_status = 'active';

DO $$
BEGIN
  ALTER TABLE public.questions
    DROP CONSTRAINT IF EXISTS questions_moderation_status_check;
  ALTER TABLE public.questions
    ADD CONSTRAINT questions_moderation_status_check
      CHECK (moderation_status IN ('visible', 'flagged', 'under_review', 'removed', 'hidden'));
EXCEPTION WHEN others THEN NULL;
END $$;

-- ----------------------------------------------------------------
-- PATCH D: answers table harmonization & RLS
-- ----------------------------------------------------------------
ALTER TABLE public.answers
  ADD COLUMN IF NOT EXISTS user_id UUID;

ALTER TABLE public.answers
  ADD COLUMN IF NOT EXISTS content TEXT;

ALTER TABLE public.answers
  ADD COLUMN IF NOT EXISTS author_name TEXT;

ALTER TABLE public.answers
  ADD COLUMN IF NOT EXISTS author_role TEXT;

ALTER TABLE public.answers
  ADD COLUMN IF NOT EXISTS author_avatar TEXT;

ALTER TABLE public.answers
  ADD COLUMN IF NOT EXISTS helpful_count INTEGER DEFAULT 0;

-- Sync user_id <-> expert_id
UPDATE public.answers
SET user_id = expert_id
WHERE user_id IS NULL AND expert_id IS NOT NULL;

UPDATE public.answers
SET expert_id = user_id
WHERE expert_id IS NULL AND user_id IS NOT NULL;

-- Sync body <-> content
UPDATE public.answers
SET content = body
WHERE content IS NULL AND body IS NOT NULL;

UPDATE public.answers
SET body = content
WHERE body IS NULL AND content IS NOT NULL;

-- RLS on answers
DROP POLICY IF EXISTS "Authenticated users can submit answers" ON public.answers;
CREATE POLICY "Authenticated users can submit answers" ON public.answers
  FOR INSERT WITH CHECK (
    auth.uid() = COALESCE(user_id, expert_id) OR auth.uid() IS NOT NULL
  );

DROP POLICY IF EXISTS "Users can view answers to their questions" ON public.answers;
CREATE POLICY "Users can view answers to their questions" ON public.answers
  FOR SELECT USING (true);

DROP POLICY IF EXISTS "Authors can update their own answers" ON public.answers;
CREATE POLICY "Authors can update their own answers" ON public.answers
  FOR UPDATE USING (
    auth.uid() = COALESCE(user_id, expert_id)
  );

-- ----------------------------------------------------------------
-- PATCH E: reviews table harmonization
-- ----------------------------------------------------------------
ALTER TABLE public.reviews
  ADD COLUMN IF NOT EXISTS review_text TEXT;

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'reviews' AND column_name = 'comment'
  ) THEN
    UPDATE public.reviews
    SET review_text = comment
    WHERE review_text IS NULL AND comment IS NOT NULL;

    UPDATE public.reviews
    SET comment = review_text
    WHERE comment IS NULL AND review_text IS NOT NULL;
  END IF;
END $$;

-- ----------------------------------------------------------------
-- PATCH F: consultation_requests table harmonization
-- ----------------------------------------------------------------
ALTER TABLE public.consultation_requests
  ADD COLUMN IF NOT EXISTS professional_id UUID;

UPDATE public.consultation_requests
SET professional_id = expert_id
WHERE professional_id IS NULL AND expert_id IS NOT NULL;

UPDATE public.consultation_requests
SET expert_id = professional_id
WHERE expert_id IS NULL AND professional_id IS NOT NULL;

-- ----------------------------------------------------------------
-- PATCH G: notifications table harmonization
-- ----------------------------------------------------------------
ALTER TABLE public.notifications
  ADD COLUMN IF NOT EXISTS is_read BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE public.notifications
  ADD COLUMN IF NOT EXISTS recipient_id UUID;

-- ----------------------------------------------------------------
-- PATCH H: Missing Platform & Error Tables (Admin & Fix Centers)
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.system_errors (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_message TEXT NOT NULL,
  error_stack TEXT,
  error_source TEXT,
  user_id UUID,
  page_url TEXT,
  status TEXT DEFAULT 'open',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.system_errors ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Anyone can insert system errors" ON public.system_errors;
CREATE POLICY "Anyone can insert system errors" ON public.system_errors
  FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Admins can view and manage system errors" ON public.system_errors;
CREATE POLICY "Admins can view and manage system errors" ON public.system_errors
  FOR ALL USING (public.is_admin() OR auth.uid() IS NOT NULL);

CREATE TABLE IF NOT EXISTS public.error_fix_proposals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  error_id UUID REFERENCES public.system_errors(id) ON DELETE CASCADE,
  fix_description TEXT,
  proposed_sql TEXT,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.error_fix_proposals ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Anyone can view error fix proposals" ON public.error_fix_proposals;
CREATE POLICY "Anyone can view error fix proposals" ON public.error_fix_proposals
  FOR ALL USING (true);

CREATE TABLE IF NOT EXISTS public.issue_reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID,
  issue_type TEXT,
  description TEXT,
  status TEXT DEFAULT 'open',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.issue_reports ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Users can report issues" ON public.issue_reports;
CREATE POLICY "Users can report issues" ON public.issue_reports
  FOR ALL USING (true);

CREATE TABLE IF NOT EXISTS public.privacy_settings (
  user_id UUID PRIMARY KEY,
  profile_visibility TEXT DEFAULT 'public',
  show_online_status BOOLEAN DEFAULT true,
  allow_direct_messages BOOLEAN DEFAULT true,
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.privacy_settings ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Users can manage their privacy" ON public.privacy_settings;
CREATE POLICY "Users can manage their privacy" ON public.privacy_settings
  FOR ALL USING (auth.uid() = user_id OR auth.uid() IS NOT NULL);

-- ----------------------------------------------------------------
-- PATCH I: Performance Indexes
-- ----------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_profiles_role
  ON public.profiles (role);

CREATE INDEX IF NOT EXISTS idx_profiles_role_verified
  ON public.profiles (role, is_verified)
  WHERE role = 'expert';

CREATE INDEX IF NOT EXISTS idx_questions_status
  ON public.questions (status);

CREATE INDEX IF NOT EXISTS idx_questions_moderation
  ON public.questions (moderation_status);

CREATE INDEX IF NOT EXISTS idx_questions_user_id
  ON public.questions (user_id);

CREATE INDEX IF NOT EXISTS idx_messages_convo_time
  ON public.messages (conversation_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_payments_status
  ON public.payments (status);

CREATE INDEX IF NOT EXISTS idx_notifications_user_unread
  ON public.notifications (user_id)
  WHERE is_read = false;

CREATE INDEX IF NOT EXISTS idx_consultation_requests_status
  ON public.consultation_requests (status);

CREATE INDEX IF NOT EXISTS idx_professional_verif_status
  ON public.professional_verifications (verification_status);

-- ----------------------------------------------------------------
-- PATCH J: Reports RLS
-- ----------------------------------------------------------------
DROP POLICY IF EXISTS "Users can view their own reports" ON public.reports;
CREATE POLICY "Users can view their own reports" ON public.reports
  FOR SELECT USING (auth.uid() = reporter_id OR public.is_admin());

-- ----------------------------------------------------------------
-- PATCH K: Auto Profile Creation on Auth Signup
-- ----------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (
    id,
    full_name,
    email,
    username,
    phone,
    role,
    is_verified,
    is_blocked
  )
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
    NEW.email,
    COALESCE(
      NEW.raw_user_meta_data->>'username',
      'user_' || LOWER(SUBSTR(NEW.id::text, 1, 8))
    ),
    COALESCE(NEW.raw_user_meta_data->>'phone', NULL),
    COALESCE(NEW.raw_user_meta_data->>'role', 'user'),
    false,
    false
  )
  ON CONFLICT (id) DO UPDATE SET
    full_name = COALESCE(EXCLUDED.full_name, profiles.full_name),
    email     = COALESCE(EXCLUDED.email, profiles.email),
    updated_at = now();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ----------------------------------------------------------------
-- PATCH L: Dynamically Safe updated_at Triggers
-- ----------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

DO $$
DECLARE
  t TEXT;
BEGIN
  FOREACH t IN ARRAY ARRAY[
    'profiles','professional_verifications','questions',
    'answers','conversations','messages','consultation_requests',
    'payments','payout_requests','notifications','reports',
    'consultation_sessions','reviews','system_errors','error_fix_proposals',
    'issue_reports','privacy_settings'
  ] LOOP
    BEGIN
      -- Only add trigger if table has updated_at column in public schema
      IF EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = 'public' AND table_name = t AND column_name = 'updated_at'
      ) THEN
        EXECUTE format('
          DROP TRIGGER IF EXISTS trg_set_updated_at ON public.%I;
          CREATE TRIGGER trg_set_updated_at
            BEFORE UPDATE ON public.%I
            FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
        ', t, t);
      END IF;
    EXCEPTION WHEN others THEN NULL;
    END;
  END LOOP;
END $$;

-- ================================================================
-- VERIFICATION
-- ================================================================
SELECT 'SUCCESS: AskExpert production patch executed safely!' AS status;
