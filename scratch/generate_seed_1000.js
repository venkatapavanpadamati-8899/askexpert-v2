import fs from 'fs';

const categories = [
  "Agriculture & Farming",
  "Technology & Software",
  "AI & Machine Learning",
  "Cybersecurity",
  "Education & Teachers",
  "Law & Legal",
  "Finance & Accounting",
  "Banking",
  "Taxation",
  "Business & Startup",
  "Marketing",
  "Human Resources & Careers",
  "Medicine & Healthcare",
  "Mental Wellness",
  "Civil Engineering",
  "Architecture",
  "Mechanical Engineering",
  "Electrical Engineering",
  "Electronics",
  "Government & Civil Services",
  "District Administration / Collector",
  "Real Estate",
  "Insurance",
  "Investment & Wealth Management",
  "Science & Research",
  "Environment",
  "Construction",
  "Automobile",
  "Travel & Tourism",
  "Food & Nutrition",
  "Fitness & Sports",
  "Education & Study Abroad",
  "Digital Marketing",
  "Design & UI/UX",
  "Software Development",
  "Cloud & DevOps",
  "Data Science",
  "HR & Recruitment",
  "Legal Compliance",
  "Other Professional Services"
];

const firstNames = ["Rajesh", "Priya", "Vikram", "Ananya", "Siddharth", "Meenakshi", "Amitabh", "Sunita", "Rohan", "Shalini", "Suresh", "Ritu", "Vikramaditya", "Deepa", "Arvind", "Sneha", "Karthik", "Neha", "Devendra", "Preeti", "Alok", "Kavita", "Manish", "Pooja", "Sanjay", "Tanvi", "Varun", "Divya", "Gautam", "Swati"];
const lastNames = ["Sharma", "Verma", "Rao", "Reddy", "Patel", "Agarwal", "Kulkarni", "Menon", "Deshmukh", "Malhotra", "Nambiar", "Hegde", "Bhattacharya", "Joshi", "Swaminathan", "Saxena", "Roy", "Viswanathan", "Gupta", "Singhania", "Bannerjee", "Chopra", "Desai", "Iyengar", "Jain", "Kapoor", "Mukherjee", "Nair", "Pandey", "Sen"];

const locations = ["Hyderabad, India", "Bangalore, India", "Mumbai, India", "Delhi NCR, India", "Chennai, India", "Pune, India", "Kolkata, India", "Ahmedabad, India", "Kochi, India", "Chandigarh, India"];
const avatarUrls = [
  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=300&q=80"
];

function escapeSql(str) {
  return str.replace(/'/g, "''");
}

let sql = `-- ==============================================================================
-- ASKEXPERT - SEED 1000+ EXPERTS MIGRATION (40 CATEGORIES x 21 EXPERTS = 840+ RECORDS)
-- SAFELY INSERTS INTO BOTH auth.users AND public.profiles TO PREVENT FK CONSTRAINTS
-- ALL RECORDS MARKED WITH is_demo = true TO SEPARATE FROM GENUINELY VERIFIED ACCOUNTS
-- ==============================================================================

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS category TEXT,
  ADD COLUMN IF NOT EXISTS location TEXT,
  ADD COLUMN IF NOT EXISTS is_demo BOOLEAN DEFAULT false;

CREATE INDEX IF NOT EXISTS idx_profiles_role_category ON public.profiles(role, category);
CREATE INDEX IF NOT EXISTS idx_profiles_role_rating ON public.profiles(role, rating DESC);
CREATE INDEX IF NOT EXISTS idx_profiles_role_avail ON public.profiles(role, availability_status);
CREATE INDEX IF NOT EXISTS idx_profiles_category ON public.profiles(category);

DO $$
BEGIN
`;

let count = 0;
categories.forEach((cat, catIdx) => {
  for (let i = 1; i <= 21; i++) {
    count++;
    const fn = firstNames[(catIdx * 21 + i) % firstNames.length];
    const ln = lastNames[(catIdx * 21 + i * 3) % lastNames.length];
    const name = `${fn} ${ln}`;
    const hexCat = (catIdx + 1).toString(16).padStart(2, '0');
    const hexNum = i.toString(16).padStart(4, '0');
    const uuid = `a0000000-0000-0000-${hexCat}00-${hexNum}00000000`;
    const username = `${fn.toLowerCase()}_${ln.toLowerCase()}_${catIdx + 1}_${i}`;
    const email = `${username}@demo.askexpert.com`;
    const phone = `+91 98000 ${String(count).padStart(5, '0')}`;
    const expYears = (i % 18) + 3;
    const rating = (4.2 + (i % 8) * 0.1).toFixed(2);
    const reviews = 20 + i * 7 + (catIdx % 5) * 12;
    const fee = 500 + (i % 15) * 150;
    const avatar = avatarUrls[(catIdx + i) % avatarUrls.length];
    const loc = locations[(catIdx + i) % locations.length];
    const spec = `${cat} Specialist Level ${i % 3 + 1}`;
    const headline = `Senior Consultant in ${cat} (${expYears}+ Yrs Exp)`;
    const bio = `Certified professional with ${expYears} years of expertise in ${cat}. Providing high quality consultation and strategic advisory on AskExpert platform.`;
    const avail = (i % 7 === 0) ? 'offline' : (i % 5 === 0 ? 'busy' : 'available');
    
    // 1. Insert into auth.users first to satisfy foreign key constraint
    sql += `  INSERT INTO auth.users (
    id, instance_id, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, role, aud
  ) VALUES (
    '${uuid}', '00000000-0000-0000-0000-000000000000', '${escapeSql(email)}',
    '$2a$10$wT8P2/3rL.e1GkO/2dY7.uQ9vM.hQ2y1vK3lM4nO5pQ6rS7tU8vW',
    NOW(), '{"provider":"email","providers":["email"]}',
    '{"full_name":"${escapeSql(name)}"}', NOW(), NOW(), 'authenticated', 'authenticated'
  ) ON CONFLICT (id) DO NOTHING;\n`;

    // 2. Insert into public.profiles
    sql += `  INSERT INTO public.profiles (
    id, full_name, role, username, email, phone, avatar_url, headline, specialization, category,
    experience_years, languages, rating, reviews_count, consultation_fee, bio, skills,
    availability_status, account_status, location, is_demo
  ) VALUES (
    '${uuid}', '${escapeSql(name)}', 'expert', '${escapeSql(username)}', '${escapeSql(email)}', '${escapeSql(phone)}',
    '${avatar}', '${escapeSql(headline)}', '${escapeSql(spec)}', '${escapeSql(cat)}',
    ${expYears}, ARRAY['English', 'Hindi'], ${rating}, ${reviews}, ${fee},
    '${escapeSql(bio)}', ARRAY['${escapeSql(cat)} Advisory', 'Consultation', 'Strategy'],
    '${avail}', 'active', '${escapeSql(loc)}', true
  ) ON CONFLICT (id) DO UPDATE SET
    full_name = EXCLUDED.full_name,
    headline = EXCLUDED.headline,
    specialization = EXCLUDED.specialization,
    category = EXCLUDED.category,
    experience_years = EXCLUDED.experience_years,
    rating = EXCLUDED.rating,
    reviews_count = EXCLUDED.reviews_count,
    consultation_fee = EXCLUDED.consultation_fee,
    avatar_url = EXCLUDED.avatar_url,
    location = EXCLUDED.location,
    is_demo = true;\n\n`;
  }
});

sql += `END $$;\n\nSELECT count(*) AS total_demo_experts FROM public.profiles WHERE is_demo = true;\n`;

fs.writeFileSync('seed_1000_experts.sql', sql);
console.log(`Generated seed_1000_experts.sql with ${count} experts across ${categories.length} categories! (Includes auth.users + public.profiles seeding)`);
