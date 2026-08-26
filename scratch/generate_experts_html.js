import fs from 'fs';

// Generate 80+ seed experts covering all 40 categories for fallback/offline mode
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

const firstNames = ["Rajesh", "Priya", "Vikram", "Ananya", "Siddharth", "Meenakshi", "Amitabh", "Sunita", "Rohan", "Shalini", "Suresh", "Ritu", "Vikramaditya", "Deepa", "Arvind", "Sneha", "Karthik", "Neha", "Devendra", "Preeti"];
const lastNames = ["Sharma", "Verma", "Rao", "Reddy", "Patel", "Agarwal", "Kulkarni", "Menon", "Deshmukh", "Malhotra", "Nambiar", "Hegde", "Bhattacharya", "Joshi", "Swaminathan", "Saxena", "Roy", "Viswanathan", "Gupta", "Singhania"];
const avatarUrls = [
  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1594824813590-78965a7dcfd6?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=300&q=80",
  "https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?auto=format&fit=crop&w=300&q=80"
];

const seedExperts = [];
categories.forEach((cat, idx) => {
  for (let i = 1; i <= 2; i++) {
    const fn = firstNames[(idx * 2 + i) % firstNames.length];
    const ln = lastNames[(idx * 3 + i) % lastNames.length];
    const hexCat = (idx + 1).toString(16).padStart(2, '0');
    const hexNum = i.toString(16).padStart(4, '0');
    seedExperts.push({
      id: `a0000000-0000-0000-${hexCat}00-${hexNum}00000000`,
      full_name: `${fn} ${ln}`,
      role: "expert",
      headline: `Senior Specialist in ${cat}`,
      specialization: `${cat} Specialist`,
      category: cat,
      experience_years: 5 + (i * 3) + (idx % 7),
      languages: ["English", (idx % 2 === 0 ? "Hindi" : "Telugu")],
      rating: parseFloat((4.5 + (i % 5) * 0.1).toFixed(1)),
      reviews_count: 35 + idx * 4 + i * 10,
      consultation_fee: 800 + i * 400,
      avatar_url: avatarUrls[(idx + i) % avatarUrls.length],
      skills: [`${cat} Advisory`, "Consultation", "Strategy"],
      availability_status: i === 2 ? "busy" : "available",
      verified: true,
      is_demo: true,
      location: "India"
    });
  }
});

console.log(`Generated ${seedExperts.length} SEED_EXPERTS for frontend fallback!`);

let html = fs.readFileSync('experts.html', 'utf8');

// Replace SEED_EXPERTS array definition
const seedArrayString = `const SEED_EXPERTS = ${JSON.stringify(seedExperts, null, 2)};`;
html = html.replace(/const SEED_EXPERTS = \[[\s\S]*?\];/m, seedArrayString);

fs.writeFileSync('experts.html', html);
console.log('Successfully updated experts.html with SEED_EXPERTS fallback array!');
