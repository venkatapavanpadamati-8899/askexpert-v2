import{s as g}from"./supabaseClient-CjmhKtb4.js";const C=document.getElementById("searchInput"),f=document.getElementById("searchClearBtn"),v=document.getElementById("categoryFilter"),k=document.getElementById("statusFilter"),I=document.getElementById("sortFilter"),y=document.querySelectorAll(".chip-btn"),r=document.getElementById("questionsGrid"),w=document.getElementById("emptyState"),L=document.getElementById("errorState"),T=document.getElementById("errorMessage"),A=document.getElementById("retryBtn"),$=document.getElementById("resetFiltersBtn"),_=document.getElementById("totalQuestionsCount"),Q=document.getElementById("resultsCountText"),b=[{id:"q-101",title:"Domestic arbitration clause compliance with MCA & RBI mandates",description:"Need guidance on drafting domestic arbitration and IP indemnity clauses for an Indian SaaS vendor contract under the 2026 corporate compliance revisions.",category:"Legal Advisor / Lawyer",language:"English",status:"answered",answers_count:2,created_at:new Date(Date.now()-36e5*3).toISOString()},{id:"q-102",title:"GST input tax credit reconciliation discrepancy for Q3 filing",description:"Encountered an invoice mismatch under GSTR-2B with an unregistered vendor. Seeking advice on the safest rectification route to prevent scrutiny notices.",category:"Chartered Accountant / Tax Expert",language:"English",status:"open",answers_count:1,created_at:new Date(Date.now()-36e5*8).toISOString()},{id:"q-103",title:"Microservices database partition strategy for multi-tenant SaaS",description:"Evaluating Row-Level Security (RLS) PostgreSQL schema isolation versus multi-database deployment on Supabase/Cloud for fintech compliance.",category:"Software & Cloud Architect",language:"English",status:"answered",answers_count:3,created_at:new Date(Date.now()-36e5*24).toISOString()},{id:"q-104",title:"Patent prior art search protocol for medical device innovation",description:"Conducting novelty and freedom-to-operate analysis for an IoT-based non-invasive glucose monitor before filing provisional patent with IPO.",category:"Legal Advisor / Lawyer",language:"English",status:"open",answers_count:0,created_at:new Date(Date.now()-36e5*48).toISOString()}];let o=[],c="all",d="all",p="newest",u="",m=null;async function B(){R();try{let t=[];if(g){const{data:s,error:a}=await g.from("questions").select("*").order("created_at",{ascending:!1});a?console.warn("Supabase fetch error (using fallback storage):",a.message):s&&s.length>0&&(t=s)}let e=[];try{e=JSON.parse(localStorage.getItem("askexpert_questions")||"[]")}catch(s){console.warn("localStorage parse error:",s)}const n=[...t];e.forEach(s=>{n.some(a=>a.id===s.id||a.title===s.title)||n.push({id:s.id,title:s.title||s.description,description:s.description||"",category:s.profession||s.category||"General",language:s.language||"English",status:(s.status||"open").toLowerCase(),answers_count:s.answers_count||0,created_at:s.createdAt||s.created_at||new Date().toISOString()})}),n.length===0?o=b:(b.forEach(s=>{n.some(a=>a.id===s.id)||n.push(s)}),o=n),_.textContent=o.length,i(),M()}catch(t){console.error("fetchQuestions exception:",t),O(t.message||"Failed to load questions from database.")}}function M(){g&&(m&&g.removeChannel(m),m=g.channel("public:questions").on("postgres_changes",{event:"INSERT",schema:"public",table:"questions"},t=>{const e=t.new;o.some(n=>n.id===e.id)||(o.unshift(e),_.textContent=o.length,i())}).on("postgres_changes",{event:"UPDATE",schema:"public",table:"questions"},t=>{const e=t.new,n=o.findIndex(s=>s.id===e.id);n!==-1&&(o[n]=e,i())}).subscribe())}function i(){let t=[...o];if(u.trim()){const e=u.toLowerCase().trim();t=t.filter(n=>{const s=(n.title||"").toLowerCase(),a=(n.description||"").toLowerCase(),l=(n.category||"").toLowerCase(),h=(n.language||"").toLowerCase();return s.includes(e)||a.includes(e)||l.includes(e)||h.includes(e)})}c!=="all"&&(t=t.filter(e=>(e.category||"").toLowerCase().includes(c.toLowerCase()))),d!=="all"&&(t=t.filter(e=>{const n=(e.status||"open").toLowerCase();return d==="open"?n==="open":d==="answered"?n==="answered"||n==="assigned":d==="resolved"?n==="resolved"||n==="closed":!0})),t.sort((e,n)=>p==="newest"?new Date(n.created_at||0)-new Date(e.created_at||0):p==="oldest"?new Date(e.created_at||0)-new Date(n.created_at||0):p==="answers"?(n.answers_count||0)-(e.answers_count||0):0),F(t)}function F(t){if(r.style.display="grid",w.style.display="none",L.style.display="none",Q.textContent=`Showing ${t.length} question${t.length===1?"":"s"}`,t.length===0){r.style.display="none",w.style.display="block";return}r.innerHTML="",t.forEach(e=>{const n=document.createElement("article");n.className="question-card",n.setAttribute("role","button"),n.setAttribute("tabindex","0");const s=`question-details.html?id=${encodeURIComponent(e.id)}`;n.addEventListener("click",()=>{window.location.href=s}),n.addEventListener("keydown",D=>{D.key==="Enter"&&(window.location.href=s)});const a=G(e.category||"General"),l=(e.status||"open").toLowerCase(),h=l==="answered"?"✓ Answered":l==="resolved"?"Resolved":"● Open",S=e.answers_count||0,x=H(e.created_at);n.innerHTML=`
          <div>
            <div class="card-top">
              <span class="category-tag ${a.cssClass}">
                ${a.icon} ${E(a.label)}
              </span>
              <span class="status-pill ${l}">
                ${h}
              </span>
            </div>

            <div class="card-body">
              <h2 class="question-title">
                ${E(e.title||e.description||"Untitled Question")}
              </h2>
              <p class="question-snippet">
                ${E(e.description||"Click to view details and verified answers.")}
              </p>
            </div>
          </div>

          <div class="card-footer">
            <div class="card-footer-left">
              <div class="asker-badge" title="Verified Asker">
                <span class="asker-avatar">👤</span>
                <span>Client</span>
              </div>
              <span>•</span>
              <span>${x}</span>
            </div>

            <div style="display: flex; align-items: center; gap: 10px;">
              <span class="answer-count-badge" title="Answers received">
                💬 ${S} ${S===1?"answer":"answers"}
              </span>
              <span class="action-arrow">→</span>
            </div>
          </div>
        `,r.appendChild(n)})}function R(){r.style.display="grid",w.style.display="none",L.style.display="none",r.innerHTML=`
        <div class="skeleton-card">
          <div class="skeleton-line" style="width: 30%;"></div>
          <div class="skeleton-line skeleton-title"></div>
          <div class="skeleton-line" style="width: 100%;"></div>
          <div class="skeleton-line" style="width: 60%;"></div>
        </div>
        <div class="skeleton-card">
          <div class="skeleton-line" style="width: 30%;"></div>
          <div class="skeleton-line skeleton-title"></div>
          <div class="skeleton-line" style="width: 100%;"></div>
          <div class="skeleton-line" style="width: 60%;"></div>
        </div>
        <div class="skeleton-card">
          <div class="skeleton-line" style="width: 30%;"></div>
          <div class="skeleton-line skeleton-title"></div>
          <div class="skeleton-line" style="width: 100%;"></div>
          <div class="skeleton-line" style="width: 60%;"></div>
        </div>
      `}function O(t){r.style.display="none",w.style.display="none",L.style.display="block",T.textContent=t}C.addEventListener("input",t=>{u=t.target.value,f.style.display=u?"block":"none",i()});f.addEventListener("click",()=>{C.value="",u="",f.style.display="none",i()});v.addEventListener("change",t=>{c=t.target.value,y.forEach(e=>{e.classList.toggle("active",e.dataset.category.toLowerCase()===c.toLowerCase())}),i()});k.addEventListener("change",t=>{d=t.target.value,i()});I.addEventListener("change",t=>{p=t.target.value,i()});y.forEach(t=>{t.addEventListener("click",()=>{y.forEach(e=>e.classList.remove("active")),t.classList.add("active"),c=t.dataset.category,v.value=c,v.value||(v.value="all"),i()})});$.addEventListener("click",()=>{C.value="",u="",f.style.display="none",c="all",d="all",p="newest",v.value="all",k.value="all",I.value="newest",y.forEach(t=>t.classList.toggle("active",t.dataset.category==="all")),i()});A.addEventListener("click",B);function G(t){const e=t.toLowerCase();return e.includes("law")||e.includes("legal")?{label:"Legal & Law",icon:"⚖️",cssClass:"legal"}:e.includes("tax")||e.includes("accountant")||e.includes("gst")||e.includes("ca")?{label:"Tax & Accounting",icon:"📊",cssClass:"tax"}:e.includes("software")||e.includes("cloud")||e.includes("tech")||e.includes("code")?{label:"Tech & Architecture",icon:"💻",cssClass:"tech"}:e.includes("doctor")||e.includes("health")||e.includes("medical")?{label:"Doctor & Healthcare",icon:"🩺",cssClass:"health"}:e.includes("financial")||e.includes("wealth")||e.includes("finance")?{label:"Finance & Wealth",icon:"💰",cssClass:"tax"}:e.includes("business")||e.includes("startup")?{label:"Business & Startup",icon:"🚀",cssClass:"legal"}:{label:t.split("/")[0].trim(),icon:"📌",cssClass:""}}function H(t){if(!t)return"Recently";const e=new Date(t),n=Math.floor((Date.now()-e.getTime())/1e3);if(n<60)return"Just now";const s=Math.floor(n/60);if(s<60)return`${s}m ago`;const a=Math.floor(s/60);if(a<24)return`${a}h ago`;const l=Math.floor(a/24);return l<30?`${l}d ago`:e.toLocaleDateString([],{month:"short",day:"numeric"})}function E(t){if(!t)return"";const e=document.createElement("div");return e.textContent=t,e.innerHTML}B();
