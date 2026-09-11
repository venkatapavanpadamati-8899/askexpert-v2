-- Secure, auditable Admin-only KYC decision gate.
-- The caller identity is derived from auth.uid(); it is never accepted from the browser.
BEGIN;

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
    SET verification_status = 'approved', identity_verified = true,
        degree_verified = true, council_verified = true,
        rejection_reason = NULL
    WHERE expert_id = p_expert_id;
    UPDATE public.profiles
    SET is_verified = true, is_blocked = false
    WHERE id = p_expert_id;
  ELSE
    UPDATE public.professional_verifications
    SET verification_status = CASE WHEN v_decision = 'REJECTED' THEN 'rejected' ELSE 'pending' END,
        identity_verified = false, degree_verified = false, council_verified = false,
        rejection_reason = trim(p_reason)
    WHERE expert_id = p_expert_id;
    UPDATE public.profiles SET is_verified = false WHERE id = p_expert_id;
  END IF;

  IF to_regclass('public.audit_logs') IS NOT NULL THEN
    INSERT INTO public.audit_logs (action_type, target_table, record_id, details)
    VALUES (
      'PROFESSIONAL_VERIFICATION_' || v_decision,
      'professional_verifications',
      p_expert_id,
      jsonb_build_object('admin_id', v_admin_id, 'decision', v_decision,
                         'reason', nullif(trim(p_reason), ''),
                         'advisory_notice', 'AI findings are advisory; this is an administrator decision.')
    );
  END IF;

  RETURN jsonb_build_object('success', true, 'decision', v_decision, 'expert_id', p_expert_id);
END;
$$;

REVOKE ALL ON FUNCTION public.admin_review_professional_verification(UUID, TEXT, TEXT) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.admin_review_professional_verification(UUID, TEXT, TEXT) TO authenticated, service_role;
COMMIT;
