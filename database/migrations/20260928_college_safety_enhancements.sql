-- College Safety Enhancements
-- 1. Add evidence_urls array to safety_incidents
ALTER TABLE public.safety_incidents
  ADD COLUMN IF NOT EXISTS evidence_urls text[] DEFAULT '{}';

-- 2. Create safety_evidence storage bucket
INSERT INTO storage.buckets (id, name, public) 
VALUES ('safety_evidence', 'safety_evidence', false)
ON CONFLICT (id) DO NOTHING;

-- 3. Storage Policies
CREATE POLICY "Students can upload evidence for own incidents" 
ON storage.objects FOR INSERT TO authenticated 
WITH CHECK (
  bucket_id = 'safety_evidence' AND 
  (auth.uid() = owner)
);

CREATE POLICY "Safety staff can view evidence for their college" 
ON storage.objects FOR SELECT TO authenticated 
USING (
  bucket_id = 'safety_evidence' AND 
  (
    auth.uid() = owner OR
    public.is_admin() OR
    public.is_safety_staff_for((SELECT college_id FROM public.profiles WHERE id::text = (string_to_array(name, '/'))[1]))
  )
);
