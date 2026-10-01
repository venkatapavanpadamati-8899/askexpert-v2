-- database/migrations/20260929_college_safety_duplicate_schema_fix.sql

ALTER TABLE public.safety_incidents
  ADD COLUMN IF NOT EXISTS is_anonymous boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS duplicate_hash text,
  ADD COLUMN IF NOT EXISTS is_possible_duplicate boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS duplicate_of_id uuid REFERENCES public.safety_incidents(id) ON DELETE SET NULL;
