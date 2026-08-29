-- ================================================================
-- AskExpert — Database Schema Patches
-- Run these against your Supabase SQL Editor
-- Date: 2026-08-29
-- ================================================================

-- ----------------------------------------------------------------
-- PATCH 1: Add is_verified column to profiles table
-- Needed by admin-professionals.html Approve action
-- ----------------------------------------------------------------
ALTER TABLE profiles
  ADD COLUMN IF NOT EXISTS is_verified BOOLEAN NOT NULL DEFAULT false;

-- Create index for fast lookups on verified experts
CREATE INDEX IF NOT EXISTS idx_profiles_is_verified
  ON profiles (is_verified)
  WHERE is_verified = true;

-- ----------------------------------------------------------------
-- PATCH 2: Add moderation columns to questions table
-- Needed by admin-questions.html Remove action
-- ----------------------------------------------------------------
ALTER TABLE questions
  ADD COLUMN IF NOT EXISTS moderation_status TEXT
    CHECK (moderation_status IN ('active', 'flagged', 'removed'))
    DEFAULT 'active',
  ADD COLUMN IF NOT EXISTS moderation_reason TEXT;

-- Create index for moderation status filtering
CREATE INDEX IF NOT EXISTS idx_questions_moderation_status
  ON questions (moderation_status);

-- ----------------------------------------------------------------
-- PATCH 3: Verify RLS policies on key tables
-- ----------------------------------------------------------------

-- profiles: Admins can update any profile (for approve/block actions)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'profiles'
      AND policyname = 'Admins can update all profiles'
  ) THEN
    CREATE POLICY "Admins can update all profiles"
      ON profiles FOR UPDATE
      USING (
        EXISTS (
          SELECT 1 FROM profiles AS admin_check
          WHERE admin_check.id = auth.uid()
            AND admin_check.role = 'admin'
        )
      );
  END IF;
END
$$;

-- professional_verifications: Admins can read all, update verification_status
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'professional_verifications'
      AND policyname = 'Admins can read all verifications'
  ) THEN
    CREATE POLICY "Admins can read all verifications"
      ON professional_verifications FOR SELECT
      USING (
        EXISTS (
          SELECT 1 FROM profiles
          WHERE id = auth.uid()
            AND role = 'admin'
        )
      );
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'professional_verifications'
      AND policyname = 'Admins can update verifications'
  ) THEN
    CREATE POLICY "Admins can update verifications"
      ON professional_verifications FOR UPDATE
      USING (
        EXISTS (
          SELECT 1 FROM profiles
          WHERE id = auth.uid()
            AND role = 'admin'
        )
      );
  END IF;
END
$$;

-- questions: Admins can update moderation status
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'questions'
      AND policyname = 'Admins can update questions'
  ) THEN
    CREATE POLICY "Admins can update questions"
      ON questions FOR UPDATE
      USING (
        EXISTS (
          SELECT 1 FROM profiles
          WHERE id = auth.uid()
            AND role = 'admin'
        )
      );
  END IF;
END
$$;

-- payments: Admins can read all payments
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'payments'
      AND policyname = 'Admins can read all payments'
  ) THEN
    CREATE POLICY "Admins can read all payments"
      ON payments FOR SELECT
      USING (
        EXISTS (
          SELECT 1 FROM profiles
          WHERE id = auth.uid()
            AND role = 'admin'
        )
      );
  END IF;
END
$$;

-- reports: Admins can read and update all reports
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE tablename = 'reports'
      AND policyname = 'Admins can read all reports'
  ) THEN
    CREATE POLICY "Admins can read all reports"
      ON reports FOR SELECT
      USING (
        EXISTS (
          SELECT 1 FROM profiles
          WHERE id = auth.uid()
            AND role = 'admin'
        )
      );
  END IF;
END
$$;

-- ----------------------------------------------------------------
-- PATCH 4: Add case_code column to reports if not present
-- Used by admin-reports.html for display
-- ----------------------------------------------------------------
ALTER TABLE reports
  ADD COLUMN IF NOT EXISTS case_code TEXT,
  ADD COLUMN IF NOT EXISTS priority TEXT
    CHECK (priority IN ('low', 'medium', 'high', 'critical'))
    DEFAULT 'medium',
  ADD COLUMN IF NOT EXISTS linked_resource_url TEXT;

-- Auto-generate case_code for existing rows
UPDATE reports
  SET case_code = 'REP-' || UPPER(SUBSTR(id::text, 1, 8))
  WHERE case_code IS NULL;

-- ----------------------------------------------------------------
-- PATCH 5: Add answer_count column to questions (if missing)
-- Used by admin-questions.html row render
-- ----------------------------------------------------------------
ALTER TABLE questions
  ADD COLUMN IF NOT EXISTS answer_count INTEGER NOT NULL DEFAULT 0;

-- If answers table exists, backfill counts
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'answers') THEN
    UPDATE questions q
      SET answer_count = (
        SELECT COUNT(*) FROM answers a WHERE a.question_id = q.id
      );
  END IF;
END
$$;

-- ================================================================
-- END OF PATCHES
-- ================================================================
