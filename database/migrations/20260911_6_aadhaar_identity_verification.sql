-- ============================================================================
-- Migration: 20260911_6_aadhaar_identity_verification.sql
-- Description: Add identity verification metadata, rate limiting, and 
--              authorized KYC provider tracking to professional_verifications
-- ============================================================================

BEGIN;

-- 1. Add Identity Verification columns to public.professional_verifications
ALTER TABLE public.professional_verifications
  ADD COLUMN IF NOT EXISTS identity_status TEXT DEFAULT 'NOT_STARTED',
  ADD COLUMN IF NOT EXISTS masked_aadhaar TEXT,
  ADD COLUMN IF NOT EXISTS provider_ref_id TEXT,
  ADD COLUMN IF NOT EXISTS provider_status TEXT,
  ADD COLUMN IF NOT EXISTS consent_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS verified_at TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS document_consistency TEXT DEFAULT 'MANUAL_REVIEW_REQUIRED',
  ADD COLUMN IF NOT EXISTS verification_attempts INT DEFAULT 0;

-- Ensure check constraints exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'chk_prof_verif_identity_status'
  ) THEN
    ALTER TABLE public.professional_verifications
      ADD CONSTRAINT chk_prof_verif_identity_status
      CHECK (identity_status IN (
        'NOT_STARTED',
        'DOCUMENT_UPLOADED',
        'CONSENT_REQUIRED',
        'OTP_REQUESTED',
        'OTP_PENDING',
        'OTP_VERIFIED',
        'PROVIDER_VERIFIED',
        'PROVIDER_FAILED',
        'MANUAL_REVIEW_REQUIRED'
      ));
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'chk_prof_verif_doc_consistency'
  ) THEN
    ALTER TABLE public.professional_verifications
      ADD CONSTRAINT chk_prof_verif_doc_consistency
      CHECK (document_consistency IN ('MATCH', 'MISMATCH', 'MANUAL_REVIEW_REQUIRED'));
  END IF;
END $$;

-- 2. Create Identity Verification Rate Limiting & Audit Table
CREATE TABLE IF NOT EXISTS public.identity_verification_attempts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  ip_address TEXT,
  reference_id TEXT,
  attempt_type TEXT NOT NULL CHECK (attempt_type IN ('OTP_REQUEST', 'OTP_VERIFY')),
  status TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_id_verif_user_created 
  ON public.identity_verification_attempts(user_id, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_id_verif_ip_created 
  ON public.identity_verification_attempts(ip_address, created_at DESC);

ALTER TABLE public.identity_verification_attempts ENABLE ROW LEVEL SECURITY;

-- Experts can only view own attempt logs
DROP POLICY IF EXISTS "Users can view own verification attempts" ON public.identity_verification_attempts;
CREATE POLICY "Users can view own verification attempts"
  ON public.identity_verification_attempts FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

-- Admins can view all verification attempts
DROP POLICY IF EXISTS "Admins can view all verification attempts" ON public.identity_verification_attempts;
CREATE POLICY "Admins can view all verification attempts"
  ON public.identity_verification_attempts FOR SELECT
  TO authenticated
  USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- 3. Enhance admin_review_professional_verification function
CREATE OR REPLACE FUNCTION public.admin_review_professional_verification(
  p_expert_id UUID,
  p_decision TEXT,
  p_reason TEXT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_admin_id UUID := auth.uid();
  v_verification public.professional_verifications%ROWTYPE;
  v_decision TEXT := upper(trim(p_decision));
BEGIN
  IF v_admin_id IS NULL OR NOT EXISTS (
    SELECT 1 FROM public.profiles WHERE id = v_admin_id AND role = 'admin'
  ) THEN
    RAISE EXCEPTION 'Only authorised administrators can review KYC applications';
  END IF;

  IF v_decision NOT IN ('APPROVED', 'REJECTED', 'RESUBMISSION_REQUIRED') THEN
    RAISE EXCEPTION 'Unsupported KYC decision';
  END IF;
  IF v_decision IN ('REJECTED', 'RESUBMISSION_REQUIRED') AND coalesce(trim(p_reason), '') = '' THEN
    RAISE EXCEPTION 'A reason is required for rejection or resubmission';
  END IF;

  SELECT * INTO v_verification
  FROM public.professional_verifications
  WHERE expert_id = p_expert_id
  FOR UPDATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'KYC application not found';
  END IF;

  IF v_decision = 'APPROVED' THEN
    IF v_verification.id_document_path IS NULL
       OR v_verification.degree_document_path IS NULL
       OR v_verification.license_document_path IS NULL THEN
      RAISE EXCEPTION 'All required KYC documents must be present before approval';
    END IF;

    UPDATE public.professional_verifications
    SET verification_status = 'approved',
        identity_verified = true,
        degree_verified = true,
        council_verified = true,
        rejection_reason = NULL,
        identity_status = CASE 
          WHEN v_verification.identity_status = 'PROVIDER_VERIFIED' THEN 'PROVIDER_VERIFIED' 
          ELSE 'MANUAL_REVIEW_REQUIRED' 
        END,
        updated_at = now()
    WHERE expert_id = p_expert_id;

    UPDATE public.profiles
    SET is_verified = true, is_blocked = false, updated_at = now()
    WHERE id = p_expert_id;
  ELSE
    UPDATE public.professional_verifications
    SET verification_status = CASE WHEN v_decision = 'REJECTED' THEN 'rejected' ELSE 'pending' END,
        identity_verified = false,
        degree_verified = false,
        council_verified = false,
        rejection_reason = trim(p_reason),
        updated_at = now()
    WHERE expert_id = p_expert_id;

    UPDATE public.profiles 
    SET is_verified = false, updated_at = now()
    WHERE id = p_expert_id;
  END IF;

  IF to_regclass('public.audit_logs') IS NOT NULL THEN
    INSERT INTO public.audit_logs (action_type, target_table, record_id, details)
    VALUES (
      'PROFESSIONAL_VERIFICATION_' || v_decision,
      'professional_verifications',
      p_expert_id,
      jsonb_build_object(
        'admin_id', v_admin_id,
        'decision', v_decision,
        'reason', nullif(trim(p_reason), ''),
        'identity_status', v_verification.identity_status,
        'masked_aadhaar', v_verification.masked_aadhaar,
        'provider_ref_id', v_verification.provider_ref_id,
        'advisory_notice', 'AI findings are advisory; this is an administrator decision.'
      )
    );
  END IF;

  RETURN jsonb_build_object('success', true, 'decision', v_decision, 'expert_id', p_expert_id);
END;
$$;

REVOKE ALL ON FUNCTION public.admin_review_professional_verification(UUID, TEXT, TEXT) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.admin_review_professional_verification(UUID, TEXT, TEXT) TO authenticated, service_role;

COMMIT;
