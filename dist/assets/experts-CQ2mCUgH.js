import{s as B}from"./supabaseClient-CSOVraqi.js";let y="all",l=1;const h=12;let L=0,_=null;async function F(){T(),await f()}function k(e){return{id:e.id,full_name:e.full_name||"Verified Expert",role:e.role||"expert",headline:e.headline||e.specialization||"Verified Specialist",specialization:e.specialization||e.category||"Consultant",category:e.category||e.specialization||"General",experience_years:e.experience_years||5,languages:Array.isArray(e.languages)?e.languages:["English"],rating:e.rating?parseFloat(e.rating):5,reviews_count:e.reviews_count||0,consultation_fee:e.consultation_fee?parseFloat(e.consultation_fee):1e3,avatar_url:e.avatar_url||"https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80",skills:Array.isArray(e.skills)?e.skills:["Advisory","Consultation"],availability_status:e.availability_status||"available",account_status:e.account_status||"active",verified:!0,is_demo:!1,location:e.location||"India"}}async function f(){document.getElementById("expertsGrid"),document.getElementById("resultsCountText");const e=document.getElementById("expertSearchInput").value.trim(),n=document.getElementById("categoryFilter").value,s=parseFloat(document.getElementById("ratingFilter").value)||0,u=document.getElementById("feeFilter").value;document.getElementById("languageFilter").value;const r=document.getElementById("availableOnlyToggle").checked,t=document.getElementById("sortFilter").value,i=n!=="all"?n:y!=="all"?y:null;try{let o=[],c=0;if(B){let a=B.from("profiles").select("*",{count:"exact"}).eq("role","expert").eq("is_verified",!0);i&&(a=a.or(`category.ilike.%${i}%,specialization.ilike.%${i}%`)),e&&(a=a.or(`full_name.ilike.%${e}%,headline.ilike.%${e}%,specialization.ilike.%${e}%,category.ilike.%${e}%,location.ilike.%${e}%`)),s>0&&(a=a.gte("rating",s)),r&&(a=a.eq("availability_status","available")),u==="under1000"?a=a.lt("consultation_fee",1e3):u==="1000to2000"?a=a.gte("consultation_fee",1e3).lte("consultation_fee",2e3):u==="above2000"&&(a=a.gt("consultation_fee",2e3)),t==="rating_desc"?a=a.order("rating",{ascending:!1}):t==="exp_desc"?a=a.order("experience_years",{ascending:!1}):t==="fee_asc"?a=a.order("consultation_fee",{ascending:!0}):t==="fee_desc"?a=a.order("consultation_fee",{ascending:!1}):t==="newest"?a=a.order("created_at",{ascending:!1}):a=a.order("rating",{ascending:!1});const m=(l-1)*h,d=m+h-1;a=a.range(m,d);const{data:g,count:p,error:b}=await a;b?console.error("Supabase query error:",b):g&&(o=g.map(k),c=p!==null?p:g.length)}L=c,$(o,c),I(c)}catch(o){console.error("loadExperts error:",o),$([],0),I(0)}}function $(e,n){const s=document.getElementById("expertsGrid"),u=document.getElementById("resultsCountText");s.innerHTML="";const r=n?n.toLocaleString():"0";if(u.innerHTML=`<strong>${r}</strong> Experts Available`,e.length===0){s.innerHTML=`
          <div class="empty-state">
            <div class="empty-icon">🔍</div>
            <div class="empty-title">No verified experts available</div>
            <p class="empty-text">There are currently no verified experts matching your selection in the database. Please try resetting filters or check back later.</p>
            <button type="button" id="resetFiltersBtn" class="btn btn-secondary" style="display: inline-flex;">
              Reset All Filters
            </button>
          </div>
        `,document.getElementById("resetFiltersBtn").addEventListener("click",w);return}e.forEach(t=>{const i=document.createElement("article");i.className="expert-card";const o=t.availability_status==="available",c=o?"dot-online":"dot-offline",a=(t.languages||[]).join(", "),m=(t.skills||[]).slice(0,3).map(x=>`<span class="skill-badge">${v(x)}</span>`).join(""),d=`expert-profile.html?expert=${encodeURIComponent(t.id)}`,g=`chat.html?expert=${encodeURIComponent(t.id)}`,p=t.is_demo?'<span class="badge-demo">DEMO</span>':"",b=t.category?`<span class="badge-cat-tag">${v(t.category)}</span>`:"";i.innerHTML=`
          <div>
            <!-- Top Profile & Badges -->
            <div class="expert-card-top">
              <div class="avatar-box">
                <img src="${v(t.avatar_url)}" alt="${v(t.full_name)}" class="avatar-img" />
                <div class="dot-status ${c}" title="${o?"Online & Available":"Currently Offline"}"></div>
              </div>

              <div class="expert-meta">
                <div class="expert-name-title">
                  <span class="expert-name">${v(t.full_name)}</span>
                  <span class="badge-verif">✓ Verified</span>
                  ${p}
                </div>
                <div style="margin-top: 2px; margin-bottom: 2px;">
                  ${b}
                </div>
                <p class="expert-headline">${v(t.headline)}</p>
                <div class="meta-badges-row">
                  <span style="color: var(--gold); font-weight: 750;">★ ${t.rating}</span>
                  <span>(${t.reviews_count})</span>
                  <span>•</span>
                  <span>📅 ${t.experience_years}+ Yrs</span>
                </div>
              </div>
            </div>

            <!-- Languages & Skills -->
            <div style="margin-top: 14px;">
              <div style="font-size: 11.5px; color: var(--muted); margin-bottom: 6px;">
                🌐 ${v(a)} ${t.location?" • 📍 "+v(t.location):""}
              </div>
              <div class="skills-wrap">
                ${m}
              </div>
            </div>
          </div>

          <!-- Bottom Fee & Actions -->
          <div class="card-footer-details">
            <div class="fee-col">
              <span>Consultation</span>
              <strong>₹${t.consultation_fee}</strong>
            </div>

            <div class="card-actions-row">
              <a href="${d}" class="btn-profile-link" title="View credentials & background">
                Profile
              </a>
              <a href="${g}" class="btn-chat-link" title="Start live chat consultation">
                <span>💬</span> Consult
              </a>
            </div>
          </div>
        `,s.appendChild(i)})}function I(e){const n=document.getElementById("paginationBar");if(!n)return;const s=Math.ceil(e/h);if(s<=1){n.style.display="none";return}n.style.display="flex";const u=(l-1)*h+1,r=Math.min(l*h,e);let t="";const i=5;let o=Math.max(1,l-2),c=Math.min(s,o+i-1);c-o<i-1&&(o=Math.max(1,c-i+1)),o>1&&(t+='<button class="page-btn" data-page="1">1</button>',o>2&&(t+='<span style="color:var(--muted);">...</span>'));for(let d=o;d<=c;d++)t+=`<button class="page-btn ${d===l?"active":""}" data-page="${d}">${d}</button>`;c<s&&(c<s-1&&(t+='<span style="color:var(--muted);">...</span>'),t+=`<button class="page-btn" data-page="${s}">${s}</button>`),n.innerHTML=`
        <div style="font-size: 13px; color: var(--muted);">
          Showing <strong>${u.toLocaleString()}–${r.toLocaleString()}</strong> of <strong>${e.toLocaleString()}</strong> experts
        </div>

        <div class="page-numbers-group">
          <button class="page-btn" id="prevPageBtn" ${l===1?"disabled":""}>‹ Prev</button>
          ${t}
          <button class="page-btn" id="nextPageBtn" ${l===s?"disabled":""}>Next ›</button>
        </div>
      `;const a=document.getElementById("prevPageBtn"),m=document.getElementById("nextPageBtn");a&&l>1&&a.addEventListener("click",()=>E(l-1)),m&&l<s&&m.addEventListener("click",()=>E(l+1)),n.querySelectorAll(".page-btn[data-page]").forEach(d=>{d.addEventListener("click",g=>{const p=parseInt(g.target.dataset.page,10);p&&p!==l&&E(p)})})}function E(e){l=e,f(),window.scrollTo({top:260,behavior:"smooth"})}function T(){const e=document.getElementById("expertSearchInput");e&&e.addEventListener("input",()=>{clearTimeout(_),_=setTimeout(()=>{l=1,f()},300)});const n=document.querySelectorAll(".chip-btn");n.forEach(r=>{r.addEventListener("click",()=>{n.forEach(i=>i.classList.remove("active")),r.classList.add("active"),y=r.dataset.domain;const t=document.getElementById("categoryFilter");t&&(t.value=y,t.value||(t.value="all")),l=1,f()})});const s=document.getElementById("categoryFilter");s&&s.addEventListener("change",r=>{const t=r.target.value;y=t,n.forEach(i=>i.classList.toggle("active",i.dataset.domain===t)),t==="all"&&n[0].classList.add("active"),l=1,f()}),["ratingFilter","feeFilter","languageFilter","sortFilter"].forEach(r=>{const t=document.getElementById(r);t&&t.addEventListener("change",()=>{l=1,f()})});const u=document.getElementById("availableOnlyToggle");u&&u.addEventListener("change",()=>{l=1,f()})}function w(){document.getElementById("expertSearchInput").value="",document.getElementById("categoryFilter").value="all",document.getElementById("ratingFilter").value="0",document.getElementById("sortFilter").value="rating_desc",document.getElementById("feeFilter").value="all",document.getElementById("languageFilter").value="all",document.getElementById("availableOnlyToggle").checked=!1;const e=document.querySelectorAll(".chip-btn");e.forEach(n=>n.classList.remove("active")),e[0].classList.add("active"),y="all",l=1,f(),S("✓ All filters reset.")}function S(e){const n=document.getElementById("toastPill");n&&(n.textContent=e,n.classList.add("show"),setTimeout(()=>{n.classList.remove("show")},3500))}function v(e){if(!e)return"";const n=document.createElement("div");return n.textContent=e,n.innerHTML}F();
