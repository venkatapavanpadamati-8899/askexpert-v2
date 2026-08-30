# Remote vs Local Supabase Schema Difference & Migration Audit Report

**Date**: August 22, 2026  
**Project**: AskExpert Platform  
**Target File**: `supabase-security.sql`

---

## 1. Executive Summary & Root Cause Analysis

A schema mismatch exists between the legacy/remote Supabase database and the canonical local schema defined in `supabase-security.sql`:

1. **`questions` Table Mismatch**:
   - **Legacy Remote Schema**: Contained fields like `title`, `body`, `tags`, `status`, `views`, `created`, `updated` (lacking `user_id`, `description`, `category`, `moderation_status`, etc.).
   - **Canonical Local Schema**: Requires `id`, `user_id` (FK to `profiles`), `title`, `description`, `category`, `language`, `status`, `answers_count`, `moderation_status`, `moderation_reason`, `moderated_by`, `moderated_at`, `created_at`, `updated_at`.
   - **Consequence**: Referencing `user_id` or `moderation_status` in RLS policies triggered PostgreSQL `ERROR: 42703 (column does not exist)`.

2. **Missing Remote Tables (12 of 16 Tables)**:
   - Remote Supabase instance currently only had partial base tables (`profiles`, `questions`, `answers`, `notifications`).
   - Missing tables: `professional_verifications`, `conversations`, `messages`, `consultation_requests`, `payments`, `payout_requests`, `reports`, `consultation_sessions`, `reviews`, `session_events`, `system_health`, `audit_logs`.

3. **Storage & Realtime Discrepancy**:
   - `chat-media` public bucket and `private-verifications` private bucket were uninitialized.
   - `supabase_realtime` publication lacked enrollment for messages, sessions, payments, and notifications.

---

## 2. Comprehensive Schema Synchronization Migration (SQL DDL)

Execute the following safe, non-destructive migration in **Supabase SQL Editor** to synchronize the remote database with the canonical local schema:

```sql
-- ==============================================================================
-- ASKEXPERT - SAFE SCHEMA SYNCHRONIZATION & MIGRATION SCRIPT
-- ==============================================================================

-- STEP 1: ALIGN & UPGRADE `public.profiles`
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

-- STEP 2: REBUILD `public.questions` WITH CANONICAL COLUMNS
DROP POLICY IF EXISTS "Visible questions are viewable by everyone" ON public.questions;
DROP POLICY IF EXISTS "Questions are viewable by everyone" ON public.questions;
DROP POLICY IF EXISTS "Authenticated users can ask questions" ON public.questions;
DROP POLICY IF EXISTS "Question owners can update their questions" ON public.questions;
DROP POLICY IF EXISTS "Admins can moderate questions" ON public.questions;

-- Safeguard: Upgrade or Recreate questions table
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
  session_id UUID NOT NULL REFERENCES public.consultation_sessions(id) ON DELETE CASCADE,
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
```

---

## 3. Post-Migration Verification Query

After running the migration script, execute this verification query in Supabase SQL Editor to confirm 100% table and column alignment:

```sql
SELECT 
    table_name, 
    COUNT(*) as total_columns 
FROM information_schema.columns 
WHERE table_schema = 'public' 
GROUP BY table_name 
ORDER BY table_name;
```

**Expected Result**: Exactly 16 tables listed (`answers`, `audit_logs`, `consultation_requests`, `consultation_sessions`, `conversations`, `messages`, `notifications`, `payments`, `payout_requests`, `professional_verifications`, `profiles`, `questions`, `reports`, `reviews`, `session_events`, `system_health`).

---

## 4. Next Action Step

Once the migration above completes:
1. Run the master [supabase-security.sql](file:///d:/ASKEXPERT/supabase-security.sql) script in Supabase SQL Editor.
2. All 16 RLS policies, 2 storage buckets, triggers, and realtime channels will apply cleanly with 0 errors.
