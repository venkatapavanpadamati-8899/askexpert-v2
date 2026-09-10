-- ==============================================================================
-- ASKEXPERT MIGRATION: 20260910_4_atomic_wallet_settlement_and_payouts.sql
-- Purpose:
--   1. Create public.wallet_transactions immutable ledger table with unique
--      idempotency constraint preventing double-credits.
--   2. Ensure public.profiles.wallet_balance column exists.
--   3. Implement atomic consultation settlement RPC public.settle_consultation_session(...)
--      using real schema columns (user_id, expert_id, payment_id, status,
--      conversation_id, expert_net_earnings). Restricted strictly to service_role.
--   4. Implement atomic payout request RPC public.request_payout(...) that derives
--      identity strictly from auth.uid(), enforces role = 'expert', and reserves
--      and debits expert wallet balance upfront. Executable by authenticated users.
--   5. Implement atomic payout rejection RPC public.admin_reject_payout(...) that restores
--      reserved funds exactly once with an immutable refund ledger transaction.
--      Restricted strictly to service_role.
--   6. Add provider audit columns to public.payout_requests for RazorpayX tracking.
--
-- SECURITY ARCHITECTURE NOTICE:
--   - settle_consultation_session and admin_reject_payout accept caller/admin UUID parameters.
--     To prevent parameter-tampering identity spoofing, EXECUTE on both functions is
--     REVOKED from authenticated and anon, and GRANTED EXCLUSIVELY to service_role.
--     Client browsers invoke the Edge Functions (session-end, process-payout), which
--     verify JWT authenticity and admin roles before calling these RPCs via service_role.
--   - request_payout is callable by authenticated users, but derives caller identity
--     strictly from auth.uid() and validates the expert role and balance under row lock.
-- ==============================================================================

BEGIN;

-- 1. Ensure profiles.wallet_balance exists safely
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'profiles' AND column_name = 'wallet_balance'
  ) THEN
    ALTER TABLE public.profiles ADD COLUMN wallet_balance NUMERIC(12, 2) NOT NULL DEFAULT 0;
  END IF;
END $$;

-- 2. Create wallet_transactions ledger table
CREATE TABLE IF NOT EXISTS public.wallet_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  amount NUMERIC(12, 2) NOT NULL,
  transaction_type TEXT NOT NULL CHECK (transaction_type IN ('consultation_earning', 'payout_withdrawal', 'refund', 'adjustment')),
  reference_id UUID,
  reference_table TEXT,
  description TEXT,
  balance_after NUMERIC(12, 2),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Unique index to prevent duplicate credit/debit for the same reference item
CREATE UNIQUE INDEX IF NOT EXISTS uq_wallet_tx_ref_type
  ON public.wallet_transactions (reference_id, transaction_type)
  WHERE reference_id IS NOT NULL;

-- Enable RLS on wallet_transactions
ALTER TABLE public.wallet_transactions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view own wallet transactions" ON public.wallet_transactions;
CREATE POLICY "Users can view own wallet transactions"
  ON public.wallet_transactions
  FOR SELECT
  TO authenticated
  USING (user_id = (SELECT auth.uid()) OR (SELECT public.is_admin()));

-- 3. Add RazorpayX / provider payout tracking columns to payout_requests
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'payout_requests' AND column_name = 'provider_payout_id'
  ) THEN
    ALTER TABLE public.payout_requests ADD COLUMN provider_payout_id TEXT;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'payout_requests' AND column_name = 'utr'
  ) THEN
    ALTER TABLE public.payout_requests ADD COLUMN utr TEXT;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_schema = 'public' AND table_name = 'payout_requests' AND column_name = 'failure_reason'
  ) THEN
    ALTER TABLE public.payout_requests ADD COLUMN failure_reason TEXT;
  END IF;
END $$;

-- ==============================================================================
-- 4. Atomic Consultation Session Settlement RPC (SERVICE_ROLE ONLY)
-- SECURITY RATIONALE:
-- This function accepts a caller-supplied UUID (p_caller_id) to record event triggers
-- and reviews. If granted to 'authenticated' or 'anon', malicious clients could spoof
-- p_caller_id or settle arbitrary sessions. Therefore, EXECUTE is strictly REVOKED
-- from PUBLIC, anon, and authenticated, and GRANTED ONLY to service_role.
-- The trusted session-end Edge Function verifies the caller's JWT prior to invocation.
-- ==============================================================================
CREATE OR REPLACE FUNCTION public.settle_consultation_session(
  p_session_id UUID,
  p_caller_id UUID,
  p_rating INT DEFAULT NULL,
  p_comment TEXT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_session RECORD;
  v_net_earnings NUMERIC(12, 2);
  v_new_balance NUMERIC(12, 2);
  v_now TIMESTAMPTZ := now();
  v_is_admin BOOLEAN := false;
BEGIN
  -- Verify caller authenticated identity
  IF p_caller_id IS NULL THEN
    RETURN jsonb_build_object('success', false, 'error', 'UNAUTHORIZED', 'message', 'Caller ID required');
  END IF;

  -- Check if caller is admin
  SELECT (role = 'admin') INTO v_is_admin
  FROM public.profiles
  WHERE id = p_caller_id;

  -- Lock the consultation session row for update to eliminate race conditions
  SELECT * INTO v_session
  FROM public.consultation_sessions
  WHERE id = p_session_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RETURN jsonb_build_object('success', false, 'error', 'SESSION_NOT_FOUND', 'message', 'Consultation session does not exist');
  END IF;

  -- Validate participant authorization: caller must be user_id (client), expert_id, or admin
  IF p_caller_id != v_session.user_id AND p_caller_id != v_session.expert_id AND NOT COALESCE(v_is_admin, false) THEN
    RETURN jsonb_build_object('success', false, 'error', 'FORBIDDEN', 'message', 'Unauthorized: You are not a participant in this consultation');
  END IF;

  -- Idempotency Guard: Check if already settled
  IF v_session.status = 'completed' THEN
    SELECT wallet_balance INTO v_new_balance FROM public.profiles WHERE id = v_session.expert_id;
    RETURN jsonb_build_object(
      'success', true,
      'already_settled', true,
      'session_id', p_session_id,
      'status', 'completed',
      'expert_net_earnings', v_session.expert_net_earnings,
      'current_wallet_balance', v_new_balance,
      'message', 'Session was previously settled and finalized'
    );
  ELSIF v_session.status != 'active' THEN
    RETURN jsonb_build_object(
      'success', false,
      'error', 'INVALID_STATUS',
      'message', 'Cannot settle session with status: ' || v_session.status
    );
  END IF;

  -- Update session status to completed
  UPDATE public.consultation_sessions
  SET status = 'completed',
      ended_at = v_now
  WHERE id = p_session_id;

  -- Close associated conversation if present
  IF v_session.conversation_id IS NOT NULL THEN
    UPDATE public.conversations
    SET status = 'closed'
    WHERE id = v_session.conversation_id;
  END IF;

  -- Atomically credit expert's wallet balance
  v_net_earnings := COALESCE(v_session.expert_net_earnings, 0);

  UPDATE public.profiles
  SET wallet_balance = COALESCE(wallet_balance, 0) + v_net_earnings
  WHERE id = v_session.expert_id
  RETURNING wallet_balance INTO v_new_balance;

  -- Insert immutable ledger transaction (Unique index uq_wallet_tx_ref_type prevents duplicates)
  INSERT INTO public.wallet_transactions (
    user_id,
    amount,
    transaction_type,
    reference_id,
    reference_table,
    description,
    balance_after,
    created_at
  ) VALUES (
    v_session.expert_id,
    v_net_earnings,
    'consultation_earning',
    p_session_id,
    'consultation_sessions',
    'Consultation earnings settled for session #' || substr(p_session_id::text, 1, 8),
    v_new_balance,
    v_now
  );

  -- Process Client Review if provided by client (user_id)
  IF p_rating IS NOT NULL AND p_rating >= 1 AND p_rating <= 5 AND p_caller_id = v_session.user_id THEN
    IF NOT EXISTS (SELECT 1 FROM public.reviews WHERE session_id = p_session_id AND user_id = p_caller_id) THEN
      INSERT INTO public.reviews (
        session_id,
        user_id,
        expert_id,
        rating,
        comment,
        created_at
      ) VALUES (
        p_session_id,
        p_caller_id,
        v_session.expert_id,
        p_rating,
        p_comment,
        v_now
      );

      -- Recalculate average rating for expert without assuming updated_at
      UPDATE public.profiles
      SET rating = sub.avg_r,
          reviews_count = sub.cnt
      FROM (
        SELECT round(avg(rating)::numeric, 2) AS avg_r, count(*) AS cnt
        FROM public.reviews
        WHERE expert_id = v_session.expert_id
      ) sub
      WHERE id = v_session.expert_id;
    END IF;
  END IF;

  -- Record session completion event
  INSERT INTO public.session_events (
    session_id,
    event_type,
    triggered_by,
    metadata,
    created_at
  ) VALUES (
    p_session_id,
    'session_completed',
    p_caller_id,
    jsonb_build_object(
      'expert_net_earnings', v_net_earnings,
      'wallet_balance_after', v_new_balance,
      'rating', p_rating,
      'ended_at', v_now
    ),
    v_now
  );

  -- Notify expert of earnings credit
  INSERT INTO public.notifications (
    user_id,
    type,
    title,
    message,
    related_id,
    is_read,
    created_at
  ) VALUES (
    v_session.expert_id,
    'session_completed',
    '✅ Consultation Earnings Credited',
    'Session finalized. ₹' || v_net_earnings::text || ' has been added to your wallet balance. New balance: ₹' || v_new_balance::text,
    v_session.conversation_id,
    false,
    v_now
  );

  -- Notify client (user_id) of successful conclusion
  INSERT INTO public.notifications (
    user_id,
    type,
    title,
    message,
    related_id,
    is_read,
    created_at
  ) VALUES (
    v_session.user_id,
    'session_completed',
    '✓ Consultation Concluded',
    'Your consultation session has concluded successfully.',
    v_session.conversation_id,
    false,
    v_now
  );

  RETURN jsonb_build_object(
    'success', true,
    'session_id', p_session_id,
    'expert_net_earnings', v_net_earnings,
    'new_wallet_balance', v_new_balance,
    'ended_at', v_now
  );
END;
$$;

-- 5. Atomic Payout Request RPC (AUTHENTICATED - IDENTITY STRICTLY FROM auth.uid())
CREATE OR REPLACE FUNCTION public.request_payout(
  p_expert_id UUID,
  p_amount NUMERIC,
  p_notes TEXT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_caller_uid UUID;
  v_caller_role TEXT;
  v_current_balance NUMERIC(12, 2);
  v_new_balance NUMERIC(12, 2);
  v_payout_id UUID;
  v_payout_ref TEXT;
  v_now TIMESTAMPTZ := now();
BEGIN
  -- Strict caller identity: MUST derive exclusively from auth.uid()
  v_caller_uid := auth.uid();
  IF v_caller_uid IS NULL THEN
    RETURN jsonb_build_object('success', false, 'error', 'UNAUTHORIZED', 'message', 'Authentication required');
  END IF;

  -- Do not trust client-supplied parameter: caller may ONLY request for their own account
  IF p_expert_id IS NOT NULL AND p_expert_id != v_caller_uid THEN
    RETURN jsonb_build_object('success', false, 'error', 'FORBIDDEN', 'message', 'You can only request payouts for your own authenticated profile');
  END IF;

  IF p_amount IS NULL OR p_amount <= 0 THEN
    RETURN jsonb_build_object('success', false, 'error', 'INVALID_AMOUNT', 'message', 'Payout amount must be greater than zero');
  END IF;

  -- Lock expert profile for update and verify expert role
  SELECT role, wallet_balance INTO v_caller_role, v_current_balance
  FROM public.profiles
  WHERE id = v_caller_uid
  FOR UPDATE;

  IF NOT FOUND THEN
    RETURN jsonb_build_object('success', false, 'error', 'PROFILE_NOT_FOUND', 'message', 'Profile record not found');
  END IF;

  IF v_caller_role != 'expert' THEN
    RETURN jsonb_build_object('success', false, 'error', 'FORBIDDEN', 'message', 'Only verified experts can request payout withdrawals');
  END IF;

  IF COALESCE(v_current_balance, 0) < p_amount THEN
    RETURN jsonb_build_object(
      'success', false,
      'error', 'INSUFFICIENT_FUNDS',
      'message', 'Requested payout amount exceeds available wallet balance (₹' || COALESCE(v_current_balance, 0)::text || ')'
    );
  END IF;

  -- Deduct / reserve requested balance upfront
  UPDATE public.profiles
  SET wallet_balance = wallet_balance - p_amount
  WHERE id = v_caller_uid
  RETURNING wallet_balance INTO v_new_balance;

  v_payout_ref := 'PAY-' || floor(extract(epoch from v_now) * 1000)::text;

  -- Create payout_requests row bound strictly to v_caller_uid
  INSERT INTO public.payout_requests (
    expert_id,
    amount,
    status,
    notes,
    payout_reference,
    created_at
  ) VALUES (
    v_caller_uid,
    p_amount,
    'pending',
    COALESCE(p_notes, 'Payout withdrawal requested via expert portal'),
    v_payout_ref,
    v_now
  )
  RETURNING id INTO v_payout_id;

  -- Record debit / reservation ledger entry
  INSERT INTO public.wallet_transactions (
    user_id,
    amount,
    transaction_type,
    reference_id,
    reference_table,
    description,
    balance_after,
    created_at
  ) VALUES (
    v_caller_uid,
    -p_amount,
    'payout_withdrawal',
    v_payout_id,
    'payout_requests',
    'Reserved for payout withdrawal #' || substr(v_payout_id::text, 1, 8),
    v_new_balance,
    v_now
  );

  RETURN jsonb_build_object(
    'success', true,
    'payout_id', v_payout_id,
    'payout_reference', v_payout_ref,
    'amount', p_amount,
    'new_wallet_balance', v_new_balance
  );
END;
$$;

-- ==============================================================================
-- 6. Atomic Admin Payout Rejection RPC (SERVICE_ROLE ONLY)
-- SECURITY RATIONALE:
-- This function accepts a caller-supplied admin UUID (p_admin_id). If granted to
-- 'authenticated' or 'anon', standard users could forge admin UUIDs or trigger
-- unauthorized payout rejections. Therefore, EXECUTE is strictly REVOKED from
-- PUBLIC, anon, and authenticated, and GRANTED ONLY to service_role.
-- The trusted process-payout Edge Function authenticates the caller, asserts the
-- 'admin' role via Supabase Auth/Profiles, and only then executes this RPC.
-- ==============================================================================
CREATE OR REPLACE FUNCTION public.admin_reject_payout(
  p_payout_id UUID,
  p_admin_id UUID,
  p_reason TEXT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
DECLARE
  v_payout RECORD;
  v_new_balance NUMERIC(12, 2);
  v_is_admin BOOLEAN := false;
  v_now TIMESTAMPTZ := now();
  v_reason TEXT := COALESCE(p_reason, 'Rejected by administrator');
BEGIN
  -- Verify admin caller
  SELECT (role = 'admin') INTO v_is_admin
  FROM public.profiles
  WHERE id = p_admin_id;

  IF NOT COALESCE(v_is_admin, false) THEN
    RETURN jsonb_build_object('success', false, 'error', 'FORBIDDEN', 'message', 'Only administrators can reject payouts');
  END IF;

  -- Lock payout request
  SELECT * INTO v_payout
  FROM public.payout_requests
  WHERE id = p_payout_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RETURN jsonb_build_object('success', false, 'error', 'PAYOUT_NOT_FOUND', 'message', 'Payout request does not exist');
  END IF;

  IF v_payout.status = 'rejected' THEN
    RETURN jsonb_build_object('success', false, 'error', 'ALREADY_REJECTED', 'message', 'Payout was already rejected and refunded');
  END IF;

  IF v_payout.status = 'paid' THEN
    RETURN jsonb_build_object('success', false, 'error', 'ALREADY_PAID', 'message', 'Cannot reject a payout that has already been disbursed');
  END IF;

  -- Mark payout as rejected
  UPDATE public.payout_requests
  SET status = 'rejected',
      failure_reason = v_reason,
      notes = v_reason,
      processed_at = v_now
  WHERE id = p_payout_id;

  -- Restore reserved funds to expert's wallet
  UPDATE public.profiles
  SET wallet_balance = COALESCE(wallet_balance, 0) + v_payout.amount
  WHERE id = v_payout.expert_id
  RETURNING wallet_balance INTO v_new_balance;

  -- Record unique refund ledger transaction (guaranteed unique by uq_wallet_tx_ref_type)
  INSERT INTO public.wallet_transactions (
    user_id,
    amount,
    transaction_type,
    reference_id,
    reference_table,
    description,
    balance_after,
    created_at
  ) VALUES (
    v_payout.expert_id,
    v_payout.amount,
    'refund',
    p_payout_id,
    'payout_requests',
    'Refund of rejected payout #' || substr(p_payout_id::text, 1, 8) || ': ' || v_reason,
    v_new_balance,
    v_now
  );

  -- Notify expert of refund
  INSERT INTO public.notifications (
    user_id,
    type,
    title,
    message,
    related_id,
    is_read,
    created_at
  ) VALUES (
    v_payout.expert_id,
    'payout_rejected',
    '❌ Payout Request Rejected',
    'Your withdrawal request of ₹' || v_payout.amount::text || ' was rejected: ' || v_reason || '. Funds have been restored to your wallet.',
    p_payout_id,
    false,
    v_now
  );

  RETURN jsonb_build_object(
    'success', true,
    'payout_id', p_payout_id,
    'restored_amount', v_payout.amount,
    'new_wallet_balance', v_new_balance
  );
END;
$$;

-- ==============================================================================
-- EXACT PRIVILEGE GRANTS & REVOCATIONS:
-- 1. settle_consultation_session accepts caller UUID; strictly service_role only.
-- 2. admin_reject_payout accepts admin UUID; strictly service_role only.
-- 3. request_payout derives identity strictly from auth.uid(); authenticated & service_role.
-- ==============================================================================

REVOKE ALL ON FUNCTION public.settle_consultation_session(UUID, UUID, INT, TEXT) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.settle_consultation_session(UUID, UUID, INT, TEXT) TO service_role;

REVOKE ALL ON FUNCTION public.admin_reject_payout(UUID, UUID, TEXT) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.admin_reject_payout(UUID, UUID, TEXT) TO service_role;

REVOKE ALL ON FUNCTION public.request_payout(UUID, NUMERIC, TEXT) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.request_payout(UUID, NUMERIC, TEXT) TO authenticated, service_role;

COMMIT;
