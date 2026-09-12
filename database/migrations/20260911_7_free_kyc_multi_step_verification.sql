-- ============================================================================
-- Migration: 20260911_7_free_kyc_multi_step_verification.sql
-- Description: Final Free-KYC Multi-Step Expert Verification Schema
--              Supports optional ID docs, address details, last-four consistency,
--              and server-side gating for admin-only approval.
-- ============================================================================

BEGIN;

-- 1. Add Free-KYC columns to public.professional_verifications
ALTER TABLE public.professional_verifications
  ADD COLUMN IF NOT EXISTS identity_document_type TEXT DEFAULT 'Aadhaar',
  ADD COLUMN IF NOT EXISTS masked_identity_number TEXT,
  ADD COLUMN IF NOT EXISTS last_four_consistency TEXT DEFAULT 'UNABLE_TO_DETERMINE',
  ADD COLUMN IF NOT EXISTS address_street TEXT,
  ADD COLUMN IF NOT EXISTS address_city TEXT,
  ADD COLUMN IF NOT EXISTS address_state TEXT,
  ADD COLUMN IF NOT EXISTS address_pincode TEXT,
  ADD COLUMN IF NOT EXISTS address_country TEXT DEFAULT 'India',
  ADD COLUMN IF NOT EXISTS degree_university TEXT,
  ADD COLUMN IF NOT EXISTS passing_year INT,
  ADD COLUMN IF NOT EXISTS council_name TEXT,
  ADD COLUMN IF NOT EXISTS license_expiry_date DATE,
  ADD COLUMN IF NOT EXISTS ai_advisory_report JSONB;

-- Ensure check constraints for last_four_consistency if not present
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'chk_prof_verif_last_four_consistency'
  ) THEN
    ALTER TABLE public.professional_verifications
      ADD CONSTRAINT chk_prof_verif_last_four_consistency
      CHECK (last_four_consistency IN ('CONSISTENT', 'DO_NOT_MATCH', 'UNABLE_TO_DETERMINE', 'NOT_PROVIDED'));
  END IF;
END $$;

-- 2. Update secure RPC function for Admin Approval / Rejection / Resubmission
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
  -- Strict Admin check: caller must be authenticated and have role = 'admin'
  IF v_admin_id IS NULL OR NOT EXISTS (
    SELECT 1 FROM public.profiles WHERE id = v_admin_id AND role = 'admin'
  ) THEN
    RAISE EXCEPTION 'Only authorised administrators can review KYC applications';
  END IF;

  IF v_decision NOT IN ('APPROVED', 'REJECTED', 'RESUBMISSION_REQUIRED') THEN
    RAISE EXCEPTION 'Unsupported KYC decision: %', v_decision;
  END IF;

  IF v_decision IN ('REJECTED', 'RESUBMISSION_REQUIRED') AND coalesce(trim(p_reason), '') = '' THEN
    RAISE EXCEPTION 'A reason is required for rejection or resubmission';
  END IF;

  SELECT * INTO v_verification
  FROM public.professional_verifications
  WHERE expert_id = p_expert_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'KYC application not found for expert_id: %', p_expert_id;
  END IF;

  IF v_decision = 'APPROVED' THEN
    -- Required professional documents check
    IF v_verification.degree_document_path IS NULL
       OR v_verification.license_document_path IS NULL THEN
      RAISE EXCEPTION 'Required professional KYC documents (Degree and Council License) must be present before approval';
    END IF;

    UPDATE public.professional_verifications
    SET verification_status = 'approved',
        identity_verified = true,
        degree_verified = true,
        council_verified = true,
        rejection_reason = NULL,
        identity_status = 'MANUAL_REVIEW_REQUIRED',
        updated_at = now()
    WHERE expert_id = p_expert_id;

    -- Grant verified status to expert profile
    UPDATE public.profiles
    SET is_verified = true,
        is_blocked = false,
        updated_at = now()
    WHERE id = p_expert_id;
  ELSE
    -- Rejection or Resubmission Required
    UPDATE public.professional_verifications
    SET verification_status = CASE WHEN v_decision = 'REJECTED' THEN 'rejected' ELSE 'pending' END,
        identity_verified = false,
        degree_verified = false,
        council_verified = false,
        rejection_reason = trim(p_reason),
        updated_at = now()
    WHERE expert_id = p_expert_id;

    -- Unset verified status
    UPDATE public.profiles
    SET is_verified = false,
        updated_at = now()
    WHERE id = p_expert_id;
  END IF;

  -- Log action in audit logs if table exists
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
        'advisory_notice', 'Free-KYC workflow: AI findings are advisory only; this is an administrator server-side decision.'
      )
    );
  END IF;

  RETURN jsonb_build_object(
    'success', true,
    'decision', v_decision,
    'expert_id', p_expert_id,
    'timestamp', now()
  );
END;
$$;

REVOKE ALL ON FUNCTION public.admin_review_professional_verification(UUID, TEXT, TEXT) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.admin_review_professional_verification(UUID, TEXT, TEXT) TO authenticated, service_role;

COMMIT;
