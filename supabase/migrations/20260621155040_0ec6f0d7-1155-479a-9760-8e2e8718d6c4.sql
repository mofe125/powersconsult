
CREATE TABLE public.applications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  date_of_birth DATE,
  gender TEXT,
  state TEXT,
  city TEXT,
  linkedin_url TEXT,
  employment_status TEXT,
  current_job_title TEXT,
  years_of_experience TEXT,
  highest_qualification TEXT,
  industry TEXT,
  expected_salary TEXT,
  skills TEXT,
  certifications TEXT,
  preferred_work_types TEXT[] DEFAULT '{}',
  career_interests TEXT[] DEFAULT '{}',
  cv_path TEXT,
  cover_letter_path TEXT,
  portfolio_path TEXT,
  certificates_path TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

GRANT INSERT ON public.applications TO anon, authenticated;
GRANT ALL ON public.applications TO service_role;

ALTER TABLE public.applications ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can submit an application"
  ON public.applications
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);
