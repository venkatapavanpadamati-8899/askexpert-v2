-- ================================================================
-- AskExpert - 25 Default Domains Seeder Script for Supabase PostgreSQL
-- ================================================================

-- 1. Ensure Table Structure Exists
CREATE TABLE IF NOT EXISTS public.domains (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    description TEXT,
    icon TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS and public read policy if not already enabled
ALTER TABLE public.domains ENABLE ROW LEVEL SECURITY;

DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'domains' AND policyname = 'Public domains read policy'
    ) THEN
        CREATE POLICY "Public domains read policy" ON public.domains FOR SELECT USING (true);
    END IF;
END $$;

-- 2. Insert 25 Rich Domain Records
INSERT INTO public.domains (name, slug, description, icon) VALUES
('Business & Entrepreneurship', 'business', 'Business strategy, startup guidance, management, and scaling advice from experienced founders and consultants.', 'briefcase'),
('Medical & Healthcare', 'medical-health', 'Medical opinions, healthcare advice, wellness strategies, and clinical insights from certified medical professionals.', 'activity'),
('Legal & Judiciary', 'legal', 'Legal consultation, documentation review, corporate law, family law, and rights advisories from verified advocates.', 'shield'),
('Finance & Investment', 'finance', 'Wealth management, stock market analysis, investment planning, and personal financial planning.', 'dollar-sign'),
('Technology & Software', 'technology', 'Software architecture, cloud infrastructure, AI development, cybersecurity, and code review from senior tech leaders.', 'code'),
('Engineering & Architecture', 'engineering', 'Structural design, civil engineering, electrical systems, product design, and architectural guidance.', 'cpu'),
('Psychology & Mental Health', 'psychology', 'Mental wellness, counseling, therapy insights, stress management, and emotional support from licensed psychologists.', 'heart'),
('Education & Career', 'education', 'Academic guidance, higher education counseling, skill development, and career path roadmap.', 'book-open'),
('Agriculture & Farming', 'agriculture', 'Agronomy, organic farming techniques, crop management, soil health, and agri-business advisory.', 'sun'),
('Real Estate & Property', 'real-estate', 'Property valuation, real estate investments, land legal verification, and rental market analysis.', 'home'),
('Marketing & Growth', 'marketing', 'Digital marketing strategy, SEO, brand positioning, social media growth, and content marketing advisory.', 'trending-up'),
('Human Resources & Hiring', 'human-resources', 'Talent acquisition, organizational policy, interview prep, performance management, and HR compliance.', 'users'),
('Tax & Accounting', 'tax-accounting', 'GST filing, income tax planning, auditing, bookkeeping, and corporate tax structuring from chartered accountants.', 'file-text'),
('Government Services', 'government-services', 'Guidance on government schemes, civic documentation, passports, licenses, and public sector procedures.', 'award'),
('Insurance & Risk', 'insurance', 'Health insurance selection, life policy analysis, property risk management, and claims advisory.', 'umbrella'),
('Travel & Tourism', 'travel-tourism', 'Itinerary planning, visa guidance, luxury travel, budget travel tips, and destination advisories.', 'map-pin'),
('Fashion & Beauty', 'fashion-beauty', 'Personal styling, skincare, wardrobe design, beauty consultations, and fashion industry trends.', 'feather'),
('Fitness & Nutrition', 'fitness-nutrition', 'Personalized fitness routines, diet plans, body transformation, and sports nutrition counseling.', 'target'),
('Arts & Design', 'arts-design', 'UI/UX design reviews, graphic design, fine arts, interior design, and creative direction.', 'palette'),
('Media & Entertainment', 'media-entertainment', 'Film production, music recording, journalism, broadcasting, and content creation guidance.', 'film'),
('Science & Research', 'science-research', 'Scientific methodology, research publishing, biotechnology, physics, and lab research consulting.', 'globe'),
('Environment & Sustainability', 'environment', 'Environmental impact assessment, renewable energy, waste management, and sustainability strategy.', 'leaf'),
('Automotive & Transport', 'automotive', 'Vehicle buying guide, EV technology, automotive repair advice, and logistics optimization.', 'truck'),
('Sports & Athletics', 'sports', 'Sports coaching, athletic training, endurance planning, and competitive strategy advice.', 'dribbble'),
('E-Commerce & Retail', 'ecommerce-retail', 'Online store setup, supply chain management, inventory control, and retail expansion strategy.', 'shopping-bag')
ON CONFLICT (slug) DO NOTHING;
