import fs from 'fs';

let html = fs.readFileSync('experts.html', 'utf8');

// 1. Add CSS styles
const customCss = `
    /* Scalable Pagination & Badges */
    .pagination-bar {
      display: flex;
      align-items: center;
      justify-content: space-between;
      flex-wrap: wrap;
      gap: 16px;
      margin-top: 30px;
      padding: 16px 20px;
      background: var(--card-bg);
      border: 1px solid var(--card-border);
      border-radius: 16px;
    }

    .page-numbers-group {
      display: flex;
      align-items: center;
      gap: 6px;
      flex-wrap: wrap;
    }

    .page-btn {
      padding: 8px 14px;
      border-radius: 10px;
      font-size: 13px;
      font-weight: 750;
      background: rgba(255, 255, 255, 0.05);
      border: 1px solid rgba(255, 255, 255, 0.1);
      color: var(--white);
      cursor: pointer;
      transition: all 0.2s ease;
    }

    .page-btn:hover:not(:disabled) {
      background: rgba(0, 217, 255, 0.15);
      border-color: var(--cyan);
      color: var(--cyan);
    }

    .page-btn.active {
      background: var(--cyan);
      color: #031120;
      border-color: var(--cyan);
      font-weight: 900;
    }

    .page-btn:disabled {
      opacity: 0.4;
      cursor: not-allowed;
    }

    .badge-demo {
      display: inline-flex;
      align-items: center;
      gap: 3px;
      padding: 2px 7px;
      border-radius: 6px;
      background: rgba(255, 170, 0, 0.15);
      border: 1px solid rgba(255, 170, 0, 0.35);
      color: #ffaa00;
      font-size: 10.5px;
      font-weight: 800;
    }

    .badge-cat-tag {
      font-size: 11px;
      font-weight: 700;
      color: var(--cyan);
      background: rgba(0, 217, 255, 0.08);
      padding: 2px 8px;
      border-radius: 6px;
      border: 1px solid rgba(0, 217, 255, 0.2);
    }
`;

if (!html.includes('.pagination-bar')) {
  html = html.replace('</style>', `${customCss}\n  </style>`);
}

// 2. Replace section from <section class="controls-panel"> to </section> (expertsGrid)
const controlsPanelStartIndex = html.indexOf('<section class="controls-panel">');
const expertsGridEndIndex = html.indexOf('</section>', html.indexOf('id="expertsGrid"')) + '</section>'.length;

if (controlsPanelStartIndex === -1 || expertsGridEndIndex === -1) {
  console.error("Could not find controls-panel or expertsGrid bounds");
  process.exit(1);
}

const newControlsPanelHTML = `<section class="controls-panel">
      
      <!-- Search Row -->
      <div class="search-row">
        <div class="search-bar">
          <span>🔍</span>
          <input type="text" id="expertSearchInput" class="search-input" placeholder="Search across 1,000+ experts by name, category, specialization, skills, or city..." />
        </div>
      </div>

      <!-- Domain Filter Chips (Quick Categories) -->
      <div class="chips-row" id="domainChipsContainer">
        <button type="button" class="chip-btn active" data-domain="all">All Categories</button>
        <button type="button" class="chip-btn" data-domain="Agriculture & Farming">🌾 Agriculture</button>
        <button type="button" class="chip-btn" data-domain="Technology & Software">💻 Technology</button>
        <button type="button" class="chip-btn" data-domain="AI & Machine Learning">🤖 AI & ML</button>
        <button type="button" class="chip-btn" data-domain="Law & Legal">⚖️ Law & Legal</button>
        <button type="button" class="chip-btn" data-domain="Finance & Accounting">📊 Finance & CA</button>
        <button type="button" class="chip-btn" data-domain="Medicine & Healthcare">🩺 Healthcare</button>
        <button type="button" class="chip-btn" data-domain="Business & Startup">🚀 Startup & Business</button>
        <button type="button" class="chip-btn" data-domain="Civil Engineering">🏗️ Civil Engineering</button>
        <button type="button" class="chip-btn" data-domain="Education & Study Abroad">🎓 Study Abroad</button>
        <button type="button" class="chip-btn" data-domain="Government & Civil Services">🏛️ Civil Services</button>
      </div>

      <!-- Dropdown Filter Controls -->
      <div class="filters-bar">
        <div class="filters-group">
          
          <!-- Extensible 40 Categories Dropdown -->
          <select id="categoryFilter" class="filter-select" aria-label="Category filter" style="min-width: 210px;">
            <option value="all">🌐 All Professional Categories (40+)</option>
            <option value="Agriculture & Farming">🌾 Agriculture & Farming</option>
            <option value="Technology & Software">💻 Technology & Software</option>
            <option value="AI & Machine Learning">🤖 AI & Machine Learning</option>
            <option value="Cybersecurity">🛡️ Cybersecurity</option>
            <option value="Education & Teachers">📚 Education & Teachers</option>
            <option value="Law & Legal">⚖️ Law & Legal</option>
            <option value="Finance & Accounting">📊 Finance & Accounting</option>
            <option value="Banking">🏦 Banking</option>
            <option value="Taxation">💸 Taxation</option>
            <option value="Business & Startup">🚀 Business & Startup</option>
            <option value="Marketing">📢 Marketing</option>
            <option value="Human Resources & Careers">👔 Human Resources & Careers</option>
            <option value="Medicine & Healthcare">🩺 Medicine & Healthcare</option>
            <option value="Mental Wellness">🧠 Mental Wellness</option>
            <option value="Civil Engineering">🏗️ Civil Engineering</option>
            <option value="Architecture">🏛️ Architecture</option>
            <option value="Mechanical Engineering">⚙️ Mechanical Engineering</option>
            <option value="Electrical Engineering">⚡ Electrical Engineering</option>
            <option value="Electronics">🔌 Electronics</option>
            <option value="Government & Civil Services">🏛️ Government & Civil Services</option>
            <option value="District Administration / Collector">🎖️ District Administration / Collector</option>
            <option value="Real Estate">🏠 Real Estate</option>
            <option value="Insurance">📋 Insurance</option>
            <option value="Investment & Wealth Management">📈 Investment & Wealth Management</option>
            <option value="Science & Research">🔬 Science & Research</option>
            <option value="Environment">🌿 Environment</option>
            <option value="Construction">👷 Construction</option>
            <option value="Automobile">🚘 Automobile</option>
            <option value="Travel & Tourism">✈️ Travel & Tourism</option>
            <option value="Food & Nutrition">🥗 Food & Nutrition</option>
            <option value="Fitness & Sports">🏋️ Fitness & Sports</option>
            <option value="Education & Study Abroad">🎓 Education & Study Abroad</option>
            <option value="Digital Marketing">📈 Digital Marketing</option>
            <option value="Design & UI/UX">🎨 Design & UI/UX</option>
            <option value="Software Development">💻 Software Development</option>
            <option value="Cloud & DevOps">☁️ Cloud & DevOps</option>
            <option value="Data Science">📊 Data Science</option>
            <option value="HR & Recruitment">👥 HR & Recruitment</option>
            <option value="Legal Compliance">📜 Legal Compliance</option>
            <option value="Other Professional Services">🛠️ Other Professional Services</option>
          </select>

          <!-- Rating Filter -->
          <select id="ratingFilter" class="filter-select" aria-label="Rating filter">
            <option value="0">⭐ All Ratings</option>
            <option value="4.8">4.8+ Stars</option>
            <option value="4.5">4.5+ Stars</option>
            <option value="4.0">4.0+ Stars</option>
          </select>

          <!-- Sort Filter -->
          <select id="sortFilter" class="filter-select" aria-label="Sort filter">
            <option value="rating_desc">⭐ Highest Rating First</option>
            <option value="exp_desc">📅 Most Experienced First</option>
            <option value="fee_asc">💰 Fee: Low to High</option>
            <option value="fee_desc">💰 Fee: High to Low</option>
            <option value="newest">🆕 Newest First</option>
          </select>

          <!-- Fee Filter -->
          <select id="feeFilter" class="filter-select" aria-label="Fee filter">
            <option value="all">💰 All Pricing</option>
            <option value="under1000">Under ₹1,000</option>
            <option value="1000to2000">₹1,000 - ₹2,000</option>
            <option value="above2000">₹2,000+</option>
          </select>

          <!-- Language Filter -->
          <select id="languageFilter" class="filter-select" aria-label="Language filter">
            <option value="all">🌐 All Languages</option>
            <option value="English">English</option>
            <option value="Hindi">Hindi</option>
            <option value="Telugu">Telugu</option>
            <option value="Tamil">Tamil</option>
            <option value="Marathi">Marathi</option>
            <option value="Gujarati">Gujarati</option>
            <option value="Kannada">Kannada</option>
          </select>

          <!-- Availability Filter -->
          <label class="available-toggle-label">
            <input type="checkbox" id="availableOnlyToggle" style="accent-color: var(--green);" />
            <span>🟢 Available Now</span>
          </label>
        </div>

        <div class="results-count-text" id="resultsCountText">
          Loading experts directory...
        </div>
      </div>

    </section>

    <!-- Experts Cards Grid -->
    <section class="experts-grid" id="expertsGrid">
      <!-- Skeletons shown during initial load -->
      <div class="skeleton-card">
        <div style="display: flex; gap: 14px; margin-bottom: 14px;">
          <div style="width: 72px; height: 72px; background: rgba(255,255,255,0.08); border-radius: 18px;"></div>
          <div style="flex: 1;">
            <div class="skeleton-line" style="width: 60%;"></div>
            <div class="skeleton-line" style="width: 90%;"></div>
          </div>
        </div>
        <div class="skeleton-line"></div>
        <div class="skeleton-line" style="width: 75%;"></div>
      </div>
      <div class="skeleton-card">
        <div style="display: flex; gap: 14px; margin-bottom: 14px;">
          <div style="width: 72px; height: 72px; background: rgba(255,255,255,0.08); border-radius: 18px;"></div>
          <div style="flex: 1;">
            <div class="skeleton-line" style="width: 60%;"></div>
            <div class="skeleton-line" style="width: 90%;"></div>
          </div>
        </div>
        <div class="skeleton-line"></div>
        <div class="skeleton-line" style="width: 75%;"></div>
      </div>
    </section>

    <!-- Scalable Pagination Bar -->
    <div id="paginationBar" class="pagination-bar" style="display: none;"></div>`;

html = html.substring(0, controlsPanelStartIndex) + newControlsPanelHTML + html.substring(expertsGridEndIndex);

// 3. Replace script functions
const scriptStartIndex = html.indexOf('/* ========================================================');
const scriptEndIndex = html.lastIndexOf('</script>');

const newScriptBody = `
    /* ========================================================
       SCALABLE EXPERTS SYSTEM WITH DB PAGINATION
       ======================================================== */
    let selectedDomain = "all";
    let currentPage = 1;
    const pageSize = 12;
    let totalExpertsCount = 0;
    let searchDebounceTimer = null;

    async function initDirectory() {
      setupFilters();
      await loadExpertsFromSupabase();
    }

    function normalizeExpertData(item) {
      return {
        id: item.id,
        full_name: item.full_name || "Verified Expert",
        role: item.role || "expert",
        headline: item.headline || item.specialization || "Verified Specialist",
        specialization: item.specialization || item.category || "Consultant",
        category: item.category || item.specialization || "General",
        experience_years: item.experience_years || 5,
        languages: Array.isArray(item.languages) ? item.languages : ["English"],
        rating: item.rating ? parseFloat(item.rating) : 4.8,
        reviews_count: item.reviews_count || 50,
        consultation_fee: item.consultation_fee ? parseFloat(item.consultation_fee) : 1000,
        avatar_url: item.avatar_url || "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80",
        skills: Array.isArray(item.skills) ? item.skills : ["Advisory", "Consultation"],
        availability_status: item.availability_status || "available",
        account_status: item.account_status || "active",
        verified: true,
        is_demo: !!item.is_demo,
        location: item.location || "India"
      };
    }

    async function loadExpertsFromSupabase() {
      const grid = document.getElementById("expertsGrid");
      const countEl = document.getElementById("resultsCountText");

      const searchTerm = document.getElementById("expertSearchInput").value.trim();
      const categoryFilter = document.getElementById("categoryFilter").value;
      const ratingFilter = parseFloat(document.getElementById("ratingFilter").value) || 0;
      const feeFilter = document.getElementById("feeFilter").value;
      const languageFilter = document.getElementById("languageFilter").value;
      const availableOnly = document.getElementById("availableOnlyToggle").checked;
      const sortFilter = document.getElementById("sortFilter").value;

      const effectiveCategory = categoryFilter !== "all" ? categoryFilter : (selectedDomain !== "all" ? selectedDomain : null);

      try {
        let expertsList = [];
        let totalCount = 0;
        let fetchedFromDb = false;

        if (supabase) {
          let query = supabase
            .from("profiles")
            .select("*", { count: "exact" })
            .eq("role", "expert");

          if (effectiveCategory) {
            query = query.or(\`category.ilike.%\${effectiveCategory}%,specialization.ilike.%\${effectiveCategory}%\`);
          }

          if (searchTerm) {
            query = query.or(\`full_name.ilike.%\${searchTerm}%,headline.ilike.%\${searchTerm}%,specialization.ilike.%\${searchTerm}%,category.ilike.%\${searchTerm}%,location.ilike.%\${searchTerm}%\`);
          }

          if (ratingFilter > 0) {
            query = query.gte("rating", ratingFilter);
          }

          if (availableOnly) {
            query = query.eq("availability_status", "available");
          }

          if (feeFilter === "under1000") query = query.lt("consultation_fee", 1000);
          else if (feeFilter === "1000to2000") query = query.gte("consultation_fee", 1000).lte("consultation_fee", 2000);
          else if (feeFilter === "above2000") query = query.gt("consultation_fee", 2000);

          if (sortFilter === "rating_desc") query = query.order("rating", { ascending: false });
          else if (sortFilter === "exp_desc") query = query.order("experience_years", { ascending: false });
          else if (sortFilter === "fee_asc") query = query.order("consultation_fee", { ascending: true });
          else if (sortFilter === "fee_desc") query = query.order("consultation_fee", { ascending: false });
          else if (sortFilter === "newest") query = query.order("created_at", { ascending: false });
          else query = query.order("rating", { ascending: false });

          // DB-side Range Pagination
          const from = (currentPage - 1) * pageSize;
          const to = from + pageSize - 1;
          query = query.range(from, to);

          const { data, count, error } = await query;

          if (!error && data && data.length > 0) {
            fetchedFromDb = true;
            expertsList = data.map(normalizeExpertData);
            totalCount = count !== null ? count : data.length;
          }
        }

        // Fallback filtering if DB returned empty or offline mode
        if (!fetchedFromDb) {
          let filtered = SEED_EXPERTS.slice();

          if (effectiveCategory) {
            const catLower = effectiveCategory.toLowerCase();
            filtered = filtered.filter(e =>
              (e.category || "").toLowerCase().includes(catLower) ||
              (e.specialization || "").toLowerCase().includes(catLower) ||
              (e.headline || "").toLowerCase().includes(catLower)
            );
          }

          if (searchTerm) {
            const term = searchTerm.toLowerCase();
            filtered = filtered.filter(e =>
              e.full_name.toLowerCase().includes(term) ||
              (e.headline || "").toLowerCase().includes(term) ||
              (e.specialization || "").toLowerCase().includes(term) ||
              (e.category || "").toLowerCase().includes(term) ||
              (e.location || "").toLowerCase().includes(term) ||
              (e.skills || []).some(s => s.toLowerCase().includes(term))
            );
          }

          if (ratingFilter > 0) filtered = filtered.filter(e => e.rating >= ratingFilter);
          if (availableOnly) filtered = filtered.filter(e => e.availability_status === "available");
          if (feeFilter === "under1000") filtered = filtered.filter(e => e.consultation_fee < 1000);
          else if (feeFilter === "1000to2000") filtered = filtered.filter(e => e.consultation_fee >= 1000 && e.consultation_fee <= 2000);
          else if (feeFilter === "above2000") filtered = filtered.filter(e => e.consultation_fee > 2000);

          if (sortFilter === "rating_desc") filtered.sort((a, b) => b.rating - a.rating);
          else if (sortFilter === "exp_desc") filtered.sort((a, b) => b.experience_years - a.experience_years);
          else if (sortFilter === "fee_asc") filtered.sort((a, b) => a.consultation_fee - b.consultation_fee);
          else if (sortFilter === "fee_desc") filtered.sort((a, b) => b.consultation_fee - a.consultation_fee);

          totalCount = filtered.length;
          const from = (currentPage - 1) * pageSize;
          expertsList = filtered.slice(from, from + pageSize);
        }

        totalExpertsCount = totalCount;
        renderExperts(expertsList, totalCount);
        renderPagination(totalCount);

      } catch (err) {
        console.error("loadExperts error:", err);
        renderExperts(SEED_EXPERTS.slice(0, pageSize), SEED_EXPERTS.length);
        renderPagination(SEED_EXPERTS.length);
      }
    }

    function renderExperts(list, totalCount) {
      const grid = document.getElementById("expertsGrid");
      const countEl = document.getElementById("resultsCountText");
      grid.innerHTML = "";

      const formattedTotal = totalCount ? totalCount.toLocaleString() : "0";
      countEl.innerHTML = \`<strong>\${formattedTotal}</strong> Experts Available\`;

      if (list.length === 0) {
        grid.innerHTML = \`
          <div class="empty-state">
            <div class="empty-icon">🔍</div>
            <div class="empty-title">No Experts Match Your Criteria</div>
            <p class="empty-text">Try adjusting your search query, selecting a different category, or resetting filters.</p>
            <button type="button" id="resetFiltersBtn" class="btn btn-secondary" style="display: inline-flex;">
              Reset All Filters
            </button>
          </div>
        \`;
        document.getElementById("resetFiltersBtn").addEventListener("click", resetAllFilters);
        return;
      }

      list.forEach(exp => {
        const card = document.createElement("article");
        card.className = "expert-card";

        const isOnline = exp.availability_status === "available";
        const dotClass = isOnline ? "dot-online" : "dot-offline";
        const langsStr = (exp.languages || []).join(", ");
        const skillsHTML = (exp.skills || []).slice(0, 3).map(s => \`<span class="skill-badge">\${escapeHTML(s)}</span>\`).join("");

        const profileUrl = \`expert-profile.html?expert=\${encodeURIComponent(exp.id)}\`;
        const chatUrl = \`chat.html?expert=\${encodeURIComponent(exp.id)}\`;

        const demoBadge = exp.is_demo ? \`<span class="badge-demo">DEMO</span>\` : '';
        const catBadge = exp.category ? \`<span class="badge-cat-tag">\${escapeHTML(exp.category)}</span>\` : '';

        card.innerHTML = \`
          <div>
            <!-- Top Profile & Badges -->
            <div class="expert-card-top">
              <div class="avatar-box">
                <img src="\${escapeHTML(exp.avatar_url)}" alt="\${escapeHTML(exp.full_name)}" class="avatar-img" />
                <div class="dot-status \${dotClass}" title="\${isOnline ? 'Online & Available' : 'Currently Offline'}"></div>
              </div>

              <div class="expert-meta">
                <div class="expert-name-title">
                  <span class="expert-name">\${escapeHTML(exp.full_name)}</span>
                  <span class="badge-verif">✓ Verified</span>
                  \${demoBadge}
                </div>
                <div style="margin-top: 2px; margin-bottom: 2px;">
                  \${catBadge}
                </div>
                <p class="expert-headline">\${escapeHTML(exp.headline)}</p>
                <div class="meta-badges-row">
                  <span style="color: var(--gold); font-weight: 750;">★ \${exp.rating}</span>
                  <span>(\${exp.reviews_count})</span>
                  <span>•</span>
                  <span>📅 \${exp.experience_years}+ Yrs</span>
                </div>
              </div>
            </div>

            <!-- Languages & Skills -->
            <div style="margin-top: 14px;">
              <div style="font-size: 11.5px; color: var(--muted); margin-bottom: 6px;">
                🌐 \${escapeHTML(langsStr)} \${exp.location ? ' • 📍 ' + escapeHTML(exp.location) : ''}
              </div>
              <div class="skills-wrap">
                \${skillsHTML}
              </div>
            </div>
          </div>

          <!-- Bottom Fee & Actions -->
          <div class="card-footer-details">
            <div class="fee-col">
              <span>Consultation</span>
              <strong>₹\${exp.consultation_fee}</strong>
            </div>

            <div class="card-actions-row">
              <a href="\${profileUrl}" class="btn-profile-link" title="View credentials & background">
                Profile
              </a>
              <a href="\${chatUrl}" class="btn-chat-link" title="Start live chat consultation">
                <span>💬</span> Consult
              </a>
            </div>
          </div>
        \`;

        grid.appendChild(card);
      });
    }

    function renderPagination(totalCount) {
      const pagBar = document.getElementById("paginationBar");
      if (!pagBar) return;

      const totalPages = Math.ceil(totalCount / pageSize);
      if (totalPages <= 1) {
        pagBar.style.display = "none";
        return;
      }

      pagBar.style.display = "flex";

      const startItem = (currentPage - 1) * pageSize + 1;
      const endItem = Math.min(currentPage * pageSize, totalCount);

      let pagesHTML = '';
      const maxButtons = 5;
      let startPage = Math.max(1, currentPage - 2);
      let endPage = Math.min(totalPages, startPage + maxButtons - 1);
      if (endPage - startPage < maxButtons - 1) {
        startPage = Math.max(1, endPage - maxButtons + 1);
      }

      if (startPage > 1) {
        pagesHTML += \`<button class="page-btn" data-page="1">1</button>\`;
        if (startPage > 2) pagesHTML += \`<span style="color:var(--muted);">...</span>\`;
      }

      for (let p = startPage; p <= endPage; p++) {
        const activeClass = p === currentPage ? 'active' : '';
        pagesHTML += \`<button class="page-btn \${activeClass}" data-page="\${p}">\${p}</button>\`;
      }

      if (endPage < totalPages) {
        if (endPage < totalPages - 1) pagesHTML += \`<span style="color:var(--muted);">...</span>\`;
        pagesHTML += \`<button class="page-btn" data-page="\${totalPages}">\${totalPages}</button>\`;
      }

      pagBar.innerHTML = \`
        <div style="font-size: 13px; color: var(--muted);">
          Showing <strong>\${startItem.toLocaleString()}–\${endItem.toLocaleString()}</strong> of <strong>\${totalCount.toLocaleString()}</strong> experts
        </div>

        <div class="page-numbers-group">
          <button class="page-btn" id="prevPageBtn" \${currentPage === 1 ? 'disabled' : ''}>‹ Prev</button>
          \${pagesHTML}
          <button class="page-btn" id="nextPageBtn" \${currentPage === totalPages ? 'disabled' : ''}>Next ›</button>
        </div>
      \`;

      const prevBtn = document.getElementById("prevPageBtn");
      const nextBtn = document.getElementById("nextPageBtn");

      if (prevBtn && currentPage > 1) {
        prevBtn.addEventListener("click", () => goToPage(currentPage - 1));
      }
      if (nextBtn && currentPage < totalPages) {
        nextBtn.addEventListener("click", () => goToPage(currentPage + 1));
      }

      pagBar.querySelectorAll(".page-btn[data-page]").forEach(btn => {
        btn.addEventListener("click", (e) => {
          const p = parseInt(e.target.dataset.page, 10);
          if (p && p !== currentPage) goToPage(p);
        });
      });
    }

    function goToPage(page) {
      currentPage = page;
      loadExpertsFromSupabase();
      window.scrollTo({ top: 260, behavior: 'smooth' });
    }

    function setupFilters() {
      const searchInput = document.getElementById("expertSearchInput");
      if (searchInput) {
        searchInput.addEventListener("input", () => {
          clearTimeout(searchDebounceTimer);
          searchDebounceTimer = setTimeout(() => {
            currentPage = 1;
            loadExpertsFromSupabase();
          }, 300);
        });
      }

      const chipButtons = document.querySelectorAll(".chip-btn");
      chipButtons.forEach(btn => {
        btn.addEventListener("click", () => {
          chipButtons.forEach(b => b.classList.remove("active"));
          btn.classList.add("active");
          selectedDomain = btn.dataset.domain;
          
          const catDropdown = document.getElementById("categoryFilter");
          if (catDropdown) {
            catDropdown.value = selectedDomain;
            if (!catDropdown.value) catDropdown.value = "all";
          }
          
          currentPage = 1;
          loadExpertsFromSupabase();
        });
      });

      const catDropdown = document.getElementById("categoryFilter");
      if (catDropdown) {
        catDropdown.addEventListener("change", (e) => {
          const val = e.target.value;
          selectedDomain = val;
          chipButtons.forEach(b => b.classList.toggle("active", b.dataset.domain === val));
          if (val === "all") chipButtons[0].classList.add("active");

          currentPage = 1;
          loadExpertsFromSupabase();
        });
      }

      ["ratingFilter", "feeFilter", "languageFilter", "sortFilter"].forEach(id => {
        const el = document.getElementById(id);
        if (el) {
          el.addEventListener("change", () => {
            currentPage = 1;
            loadExpertsFromSupabase();
          });
        }
      });

      const availToggle = document.getElementById("availableOnlyToggle");
      if (availToggle) {
        availToggle.addEventListener("change", () => {
          currentPage = 1;
          loadExpertsFromSupabase();
        });
      }
    }

    function resetAllFilters() {
      document.getElementById("expertSearchInput").value = "";
      document.getElementById("categoryFilter").value = "all";
      document.getElementById("ratingFilter").value = "0";
      document.getElementById("sortFilter").value = "rating_desc";
      document.getElementById("feeFilter").value = "all";
      document.getElementById("languageFilter").value = "all";
      document.getElementById("availableOnlyToggle").checked = false;

      const chipButtons = document.querySelectorAll(".chip-btn");
      chipButtons.forEach(b => b.classList.remove("active"));
      chipButtons[0].classList.add("active");
      selectedDomain = "all";

      currentPage = 1;
      loadExpertsFromSupabase();
      showToast("✓ All filters reset.");
    }

    function showToast(msg) {
      const toast = document.getElementById("toastPill");
      if (!toast) return;
      toast.textContent = msg;
      toast.classList.add("show");
      setTimeout(() => {
        toast.classList.remove("show");
      }, 3500);
    }

    function escapeHTML(str) {
      if (!str) return "";
      const div = document.createElement("div");
      div.textContent = str;
      return div.innerHTML;
    }

    // Start App
    initDirectory();
`;

html = html.substring(0, scriptStartIndex) + newScriptBody + '\n  </script>\n</body>\n</html>\n';

fs.writeFileSync('experts.html', html);
console.log('Successfully updated experts.html with complete scalable system!');
