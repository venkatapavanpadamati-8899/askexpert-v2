import fs from 'fs';

const filePath = 'd:/ASKEXPERT/expert-profile.html';
let code = fs.readFileSync(filePath, 'utf8');

// Replace EXPERT_DIRECTORY and initProfile block
const oldProfileBlockRegex = /\/\* =+\s*EXPERT DIRECTORY[\s\S]*?async function initProfile\(\) \{[\s\S]*?renderProfile\(expertData\);\s*loadExpertAnswers\(expertData\);\s*loadExpertReviews\(expertData\);\s*\}/;

const newProfileBlockCode = `/* ========================================================
   LOAD PROFILE DATA FROM SUPABASE
   ======================================================== */
    async function initProfile() {
      const urlParams = new URLSearchParams(window.location.search);
      const queryParam = urlParams.get("expert") || urlParams.get("id");

      if (!queryParam) {
        renderInvalidProfileUI("No expert profile ID provided.");
        return;
      }

      if (!supabase) {
        renderInvalidProfileUI("Database connection unavailable.");
        return;
      }

      try {
        // Query strictly for verified expert profile
        const { data: dbProfile, error: pErr } = await supabase
          .from("profiles")
          .select("*")
          .eq("id", queryParam)
          .eq("role", "expert")
          .eq("is_verified", true)
          .maybeSingle();

        if (pErr || !dbProfile) {
          renderInvalidProfileUI("The requested expert profile is not verified or does not exist.");
          return;
        }

        // Fetch credentials from verifications table
        const { data: dbVerif } = await supabase
          .from("professional_verifications")
          .select("*")
          .eq("expert_id", dbProfile.id)
          .maybeSingle();

        const expertData = {
          id: dbProfile.id,
          name: dbProfile.full_name || "Verified Expert",
          role: dbProfile.headline || dbProfile.specialization || "Verified Specialist",
          avatarUrl: dbProfile.avatar_url || "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80",
          rating: dbProfile.rating ? parseFloat(dbProfile.rating).toFixed(1) : "5.0",
          reviewsCount: dbProfile.reviews_count || 0,
          experience: dbProfile.experience_years ? \`\${dbProfile.experience_years}+ Yrs Experience\` : "5+ Yrs Experience",
          languages: Array.isArray(dbProfile.languages) ? dbProfile.languages.join(", ") : "English",
          fee: dbProfile.consultation_fee ? \`₹\${dbProfile.consultation_fee}\` : "₹1,000",
          domain: dbProfile.specialization || "Professional Services",
          bio: dbProfile.bio || "Verified professional consultant on AskExpert platform.",
          skills: Array.isArray(dbProfile.skills) ? dbProfile.skills : ["Advisory", "Consultation"],
          degree: dbVerif ? dbVerif.degree_qualification : "Verified Degree & Qualification",
          councilReg: dbVerif && dbVerif.council_registration_no ? \`Council Reg: #\${dbVerif.council_registration_no}\` : "Verified License"
        };

        renderProfile(expertData);
        loadExpertAnswers(expertData);
        loadExpertReviews(expertData);

      } catch (err) {
        console.error("Profile load error:", err);
        renderInvalidProfileUI("Error retrieving expert profile data.");
      }
    }

    function renderInvalidProfileUI(msg) {
      const container = document.querySelector(".profile-container") || document.querySelector("main");
      if (container) {
        container.innerHTML = \`
          <div style="text-align: center; margin: 4rem auto; max-width: 600px; padding: 3rem; background: rgba(239, 68, 68, 0.05); border: 1px solid rgba(239, 68, 68, 0.2); border-radius: 16px;">
            <div style="font-size: 3.5rem; margin-bottom: 1rem;">⚠️</div>
            <h2 style="color: #ef4444; font-size: 1.5rem; margin-bottom: 0.75rem; font-weight: 700;">Expert Profile Unavailable</h2>
            <p style="color: var(--text-muted, #94a3b8); margin-bottom: 2rem; font-size: 1rem; line-height: 1.6;">\${msg}</p>
            <a href="experts.html" class="btn btn-primary" style="padding: 0.85rem 2rem; text-decoration: none; font-weight: 600;">
              Browse Verified Experts Directory
            </a>
          </div>
        \`;
      }
    }`;

code = code.replace(oldProfileBlockRegex, newProfileBlockCode);

// Remove fake review fallback
const oldReviewsFallbackRegex = /if \(reviews\.length === 0\) \{[\s\S]*?\}\s*\}\s*if \(reviews\.length === 0\)/;
const newReviewsFallbackCode = `if (reviews.length === 0) {
          feed.innerHTML = \`<div style="text-align:center; padding: 2rem; color: var(--muted);">No verified client reviews submitted yet.</div>\`;
          if (countEl) countEl.textContent = "0 verified reviews";
          if (ratingValEl) ratingValEl.textContent = "5.0";
          if (reviewsLabel) reviewsLabel.textContent = "Based on verified consultations";
          return;
        }`;

code = code.replace(oldReviewsFallbackRegex, newReviewsFallbackCode);

fs.writeFileSync(filePath, code, 'utf8');
console.log('Cleaned up EXPERT_DIRECTORY and fake reviews in expert-profile.html');
