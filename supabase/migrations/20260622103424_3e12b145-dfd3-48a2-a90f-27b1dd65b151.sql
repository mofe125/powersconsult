
DROP POLICY IF EXISTS "Anyone can submit an application" ON public.applications;

CREATE POLICY "Anyone can submit an application"
  ON public.applications
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (
    length(btrim(full_name)) > 1
    AND email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'
  );

CREATE POLICY "No direct read access to applications"
  ON public.applications
  FOR SELECT
  TO anon, authenticated
  USING (false);

CREATE POLICY "No direct updates to applications"
  ON public.applications
  FOR UPDATE
  TO anon, authenticated
  USING (false)
  WITH CHECK (false);

CREATE POLICY "No direct deletes from applications"
  ON public.applications
  FOR DELETE
  TO anon, authenticated
  USING (false);

DROP POLICY IF EXISTS "Anyone can upload application documents" ON storage.objects;

CREATE POLICY "Restricted uploads to applications bucket"
  ON storage.objects
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (
    bucket_id = 'applications'
    AND (storage.foldername(name))[1] ~ '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'
    AND lower(name) ~ '\.(pdf|doc|docx|png|jpg|jpeg|webp|zip)$'
  );
