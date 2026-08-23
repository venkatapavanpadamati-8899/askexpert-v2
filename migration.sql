-- ==============================================================================
-- ASKEXPERT - SAFE SCHEMA SYNCHRONIZATION & MIGRATION SCRIPT (PURE SQL)
-- ==============================================================================

-- STEP 1: ALIGN & UPGRADE public.profiles
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS headline TEXT,
  ADD COLUMN IF NOT EXISTS specialization TEXT,
  ADD COLUMN IF NOT EXISTS experience_years INT DEFAULT 0,
  ADD COLUMN IF NOT EXISTS languages TEXT[] DEFAULT ARRAY['English'],
  ADD COLUMN IF NOT EXISTS rating NUMERIC(3,2) DEFAULT 5.00,
  ADD COLUMN IF NOT EXISTS reviews_count INT DEFAULT 0,
  ADD COLUMN IF NOT EXISTS consultation_fee NUMERIC(10,2) DEFAULT 1000.00,
  ADD COLUMN IF NOT EXISTS bio TEXT,
  ADD COLUMN IF NOT EXISTS skills TEXT[] DEFAULT ARRAY[]::TEXT[],
  ADD COLUMN IF NOT EXISTS availability_status TEXT DEFAULT 'available',
  ADD COLUMN IF NOT EXISTS account_status TEXT DEFAULT 'active';

-- STEP 2: REBUILD public.questions WITH CANONICAL COLUMNS
DROP POLICY IF EXISTS "Visible questions are viewable by everyone" ON public.questions;
DROP POLICY IF EXISTS "Questions are viewable by everyone" ON public.questions;
DROP POLICY IF EXISTS "Authenticated users can ask questions" ON public.questions;
DROP POLICY IF EXISTS "Question owners can update their questions" ON public.questions;
DROP POLICY IF EXISTS "Admins can moderate questions" ON public.questions;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema='public' AND table_name='questions' AND column_name='user_id') THEN
    DROP TABLE IF EXISTS public.questions CASCADE;
  END IF;
END $$;

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

-- STEP 3: CREATE ALL REMAINING MISSING TABLES (14 TABLES TOTAL)
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

CREATE TABLE IF NOT EXISTS public.conversations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  expert_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'archived', 'closed')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT unique_user_expert_conversation UNIQUE(user_id, expert_id)
);

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

CREATE TABLE IF NOT EXISTS public.reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  reporter_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  reported_user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
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
  resolved_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.consultation_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  conversation_id UUID NOT NULL REFERENCES public.conversations(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  expert_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  payment_id UUID REFERENCES public.payments(id) ON DELETE SET NULL,
  duration_minutes INT NOT NULL DEFAULT 30,
  status TEXT NOT NULL DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'active', 'completed', 'cancelled', 'disputed', 'expired')),
  started_at TIMESTAMPTZ,
  expires_at TIMESTAMPTZ,
  ended_at TIMESTAMPTZ,
  expert_gross_amount NUMERIC(10,2) NOT NULL DEFAULT 0,
  platform_fee NUMERIC(10,2) NOT NULL DEFAULT 0,
  expert_net_earnings NUMERIC(10,2) NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID REFERENCES public.consultation_sessions(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  expert_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.session_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID REFERENCES public.consultation_sessions(id) ON DELETE CASCADE,
  event_type TEXT NOT NULL,
  triggered_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  metadata JSONB DEFAULT '{}'::JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

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
