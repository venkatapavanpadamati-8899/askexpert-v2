-- AskExpert production storage hardening. Apply after the profile security migration.
BEGIN;

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES
  ('avatars', 'avatars', true, 5242880, ARRAY['image/jpeg', 'image/png', 'image/webp']),
  ('kyc-documents', 'kyc-documents', false, 10485760, ARRAY['application/pdf', 'image/jpeg', 'image/png']),
  ('chat-attachments', 'chat-attachments', false, 26214400, ARRAY['image/jpeg', 'image/png', 'image/webp', 'application/pdf', 'text/plain', 'audio/mpeg', 'audio/webm', 'video/mp4', 'video/webm'])
ON CONFLICT (id) DO UPDATE SET public = EXCLUDED.public, file_size_limit = EXCLUDED.file_size_limit, allowed_mime_types = EXCLUDED.allowed_mime_types;

DROP POLICY IF EXISTS "Avatar images are public" ON storage.objects;
CREATE POLICY "Avatar images are public" ON storage.objects FOR SELECT USING (bucket_id = 'avatars');
DROP POLICY IF EXISTS "Users manage own avatars" ON storage.objects;
CREATE POLICY "Users manage own avatars" ON storage.objects FOR ALL TO authenticated
  USING (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text)
  WITH CHECK (bucket_id = 'avatars' AND (storage.foldername(name))[1] = auth.uid()::text);

DROP POLICY IF EXISTS "Users upload own KYC documents" ON storage.objects;
CREATE POLICY "Users upload own KYC documents" ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'kyc-documents' AND (storage.foldername(name))[1] = auth.uid()::text);
DROP POLICY IF EXISTS "KYC owners and admins can read documents" ON storage.objects;
CREATE POLICY "KYC owners and admins can read documents" ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'kyc-documents' AND ((storage.foldername(name))[1] = auth.uid()::text OR public.is_admin()));
DROP POLICY IF EXISTS "KYC owners may replace pending documents" ON storage.objects;
CREATE POLICY "KYC owners may replace pending documents" ON storage.objects FOR UPDATE TO authenticated
  USING (bucket_id = 'kyc-documents' AND (storage.foldername(name))[1] = auth.uid()::text)
  WITH CHECK (bucket_id = 'kyc-documents' AND (storage.foldername(name))[1] = auth.uid()::text);

DROP POLICY IF EXISTS "Conversation participants upload attachments" ON storage.objects;
CREATE POLICY "Conversation participants upload attachments" ON storage.objects FOR INSERT TO authenticated
  WITH CHECK (bucket_id = 'chat-attachments' AND (storage.foldername(name))[2] = auth.uid()::text AND EXISTS (
    SELECT 1 FROM public.conversations c WHERE c.id::text = (storage.foldername(name))[1] AND auth.uid() IN (c.user_id, c.expert_id)
  ));
DROP POLICY IF EXISTS "Conversation participants read attachments" ON storage.objects;
CREATE POLICY "Conversation participants read attachments" ON storage.objects FOR SELECT TO authenticated
  USING (bucket_id = 'chat-attachments' AND EXISTS (
    SELECT 1 FROM public.conversations c WHERE c.id::text = (storage.foldername(name))[1] AND auth.uid() IN (c.user_id, c.expert_id)
  ));

ALTER TABLE public.professional_verifications
  ADD COLUMN IF NOT EXISTS degree_document_path TEXT,
  ADD COLUMN IF NOT EXISTS license_document_path TEXT;
COMMIT;
