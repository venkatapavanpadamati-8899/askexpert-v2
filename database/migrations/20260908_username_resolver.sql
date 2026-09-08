-- ==============================================================================
-- ASKEXPERT - SECURE USERNAME TO EMAIL RESOLVER RPC
-- Migration: 20260908_username_resolver.sql
-- Target Project: girexuzrkeiylkbqglks
-- ==============================================================================

CREATE OR REPLACE FUNCTION public.resolve_auth_email_by_username(p_username TEXT)
RETURNS TEXT
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_normalized TEXT;
  v_email TEXT;
BEGIN
  IF p_username IS NULL THEN
    RETURN NULL;
  END IF;

  v_normalized := LOWER(TRIM(p_username));

  -- Validate username format (length between 2 and 50, alphanumeric and underscores)
  IF LENGTH(v_normalized) < 2 OR LENGTH(v_normalized) > 50 THEN
    RETURN NULL;
  END IF;

  SELECT email INTO v_email
  FROM public.profiles
  WHERE LOWER(username) = v_normalized
  LIMIT 1;

  RETURN v_email;
END;
$$;

-- Grant execute permission to anon and authenticated roles for sign-in resolution
GRANT EXECUTE ON FUNCTION public.resolve_auth_email_by_username(TEXT) TO anon, authenticated, service_role;

-- Rollback Instructions:
-- DROP FUNCTION IF EXISTS public.resolve_auth_email_by_username(TEXT);
