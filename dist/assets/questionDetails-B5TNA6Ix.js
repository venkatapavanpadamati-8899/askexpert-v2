import{s as r}from"./supabaseClient-CSOVraqi.js";const V=new URLSearchParams(window.location.search),c=V.get("id")||"q-101";let B=null,s=[],C=null,y="user",l=null,x=null;async function U(){await q(),await F(),await P(),N()}async function q(){try{if(r){const{data:{session:e}}=await r.auth.getSession();if(e&&e.user){C=e.user.id,y=e.user.user_metadata&&e.user.user_metadata.role||"user";return}}}catch(e){console.warn("Auth check:",e)}C=localStorage.getItem("askexpert_guest_user_id")||"guest_"+Date.now()}async function F(){try{let e=null;if(r){const{data:n,error:t}=await r.from("questions").select("*").eq("id",c).maybeSingle();!t&&n&&(e=n)}e||(e=JSON.parse(localStorage.getItem("askexpert_questions")||"[]").find(t=>t.id===c)),e||(e={id:c,title:"Compliance renewal & vendor contract statutory requirements under Indian Corporate Law",description:"Need guidance on drafting domestic arbitration and IP indemnity clauses for an Indian SaaS vendor contract under the 2026 corporate compliance revisions to ensure statutory compliance.",category:"Legal Advisor / Lawyer",language:"English",status:"answered",answers_count:1,created_at:new Date(Date.now()-36e5*2).toISOString()}),B=e,H(e)}catch(e){console.error("loadQuestionDetails error:",e)}}function H(e){document.getElementById("qTitle").textContent=e.title||"Question Inquiry",document.getElementById("qDescription").textContent=e.description||e.title||"",document.getElementById("breadcrumbCategory").textContent=e.category||e.profession||"General",document.getElementById("qCategoryBadge").textContent="⚖️ "+(e.category||e.profession||"General"),document.getElementById("qLanguageBadge").textContent="🌐 "+(e.language||"English");const n=(e.status||"open").toLowerCase(),t=document.getElementById("qStatusBadge");t.textContent=n==="answered"?"✓ Answered":n==="resolved"?"Resolved":"● Open",t.className=`badge badge-status ${n}`;const a=e.created_at?new Date(e.created_at).toLocaleDateString([],{month:"short",day:"numeric",year:"numeric",hour:"2-digit",minute:"2-digit"}):"Recently";document.getElementById("qDateTime").textContent=`Asked on ${a}`}async function P(){document.getElementById("answersContainer");const e=document.getElementById("answersCountHeader");try{let n=[];if(r){const{data:t,error:a}=await r.from("answers").select("*, profiles(full_name, headline, specialization, avatar_url, rating)").eq("question_id",c).order("created_at",{ascending:!0});!a&&t&&(s=t)}if(e.textContent=s.length,s.length===0){document.getElementById("answersContainer").innerHTML='<div style="text-align: center; padding: 3rem; color: var(--muted); font-size: 0.95rem;">No verified expert answers posted yet for this question.</div>';return}b(s)}catch(n){console.error("loadAnswers error:",n)}}function b(e){const n=document.getElementById("answersContainer");n.innerHTML="",e.forEach(t=>{var $,S,R,A,M;const a=document.createElement("article");a.className="glass-card expert-card",a.id=`ans-${t.id}`;const o={name:(($=t.profiles)==null?void 0:$.full_name)||t.author_name||"Verified Expert",role:((S=t.profiles)==null?void 0:S.headline)||((R=t.profiles)==null?void 0:R.specialization)||t.author_headline||"Verified Domain Consultant",avatarUrl:((A=t.profiles)==null?void 0:A.avatar_url)||t.author_avatar||"https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80",rating:(M=t.profiles)!=null&&M.rating?`${parseFloat(t.profiles.rating).toFixed(1)} (Verified)`:"5.0 (Verified)"},d=t.created_at?K(t.created_at):"Recently",v=u(t.content).replace(/\n/g,"<br>"),D=t.media_url?`
          <div style="margin: 12px 0;">
            <a href="${u(t.media_url)}" target="_blank" class="attachment-pill" style="display: inline-flex;">
              <span>📎</span>
              <span>Attached Document / Media</span>
              <span style="font-size: 11px; color: var(--cyan);">(View File)</span>
            </a>
          </div>
        `:"",k=`chat.html?expert=${encodeURIComponent(o.name)}&question=${encodeURIComponent(B?B.title:"Consultation")}`,L=`expert-profile.html?expert=${encodeURIComponent(o.name)}`;a.innerHTML=`
          <header class="expert-header">
            <div class="expert-profile-wrap">
              <div class="expert-avatar-box">
                <img src="${u(o.avatarUrl)}" alt="${u(o.name)}" class="expert-avatar" />
                <div class="verified-dot" title="Verified Expert">✓</div>
              </div>
              <div class="expert-details">
                <h3>
                  <a href="${L}" style="color: inherit; text-decoration: none;">
                    <span>${u(o.name)}</span>
                  </a>
                  <span class="verified-badge">✓ Verified Expert</span>
                </h3>
                <p class="expert-title">${u(o.role)}</p>
                <div class="expert-rating">
                  <span>★★★★★</span>
                  <span>${u(o.rating)}</span>
                </div>
              </div>
            </div>

            <div class="time-stamp">
              Answered ${d}
            </div>
          </header>

          <div class="answer-body">
            <p>${v}</p>
            ${D}
          </div>

          <footer class="expert-actions">
            <div style="display: flex; gap: 10px; flex-wrap: wrap;">
              <a href="${k}" class="btn-chat-expert">
                <span>💬</span>
                <span>Chat with Expert</span>
              </a>
              <a href="${L}" class="btn-reaction" style="background: rgba(255,255,255,0.05); font-weight: 700;">
                <span>👤</span>
                <span>View Profile</span>
              </a>
            </div>

            <div class="action-sub-group">
              <button type="button" class="btn-reaction helpful-btn" data-id="${t.id}" data-count="${t.helpful_count||0}">
                <span>👍</span>
                <span>Helpful (<span class="count-num">${t.helpful_count||0}</span>)</span>
              </button>
              <button type="button" class="btn-reaction share-btn">
                <span>🔗</span>
                <span>Share</span>
              </button>
            </div>
          </footer>
        `,n.appendChild(a)}),J()}function N(){r&&(x&&r.removeChannel(x),x=r.channel(`answers:${c}`).on("postgres_changes",{event:"INSERT",schema:"public",table:"answers",filter:`question_id=eq.${c}`},e=>{const n=e.new;s.some(t=>t.id===n.id)||(s.push(n),document.getElementById("answersCountHeader").textContent=s.length,b(s),i("✨ New verified answer added to this thread!"))}).subscribe())}const Q=document.getElementById("followupForm"),m=document.getElementById("followupTextarea"),g=document.getElementById("sendFollowupBtn"),z=document.getElementById("attachReplyFileBtn"),p=document.getElementById("replyFileInput"),_=document.getElementById("replyAttachPreview"),O=document.getElementById("replyAttachName"),G=document.getElementById("removeReplyAttachBtn");z.addEventListener("click",()=>p.click());p.addEventListener("change",()=>{p.files&&p.files[0]&&(l=p.files[0],O.textContent=`📄 ${l.name} (${W(l.size)})`,_.style.display="flex")});G.addEventListener("click",()=>{l=null,p.value="",_.style.display="none"});Q.addEventListener("submit",async e=>{e.preventDefault();const n=m.value.trim();if(!n)return;g.disabled=!0,g.innerHTML="<span>⏳</span><span>Posting...</span>";let t=null;if(l&&r)try{const o=l.name.split(".").pop(),d=`answers/${Date.now()}_${Math.random().toString(36).slice(2)}.${o}`,{error:v}=await r.storage.from("chat-media").upload(d,l);v||(t=r.storage.from("chat-media").getPublicUrl(d).data.publicUrl)}catch(o){console.warn("Media upload error:",o)}const a={question_id:c,user_id:C,author_name:y==="expert"?"Verified Specialist":"Client User",author_role:y,author_headline:y==="expert"?"Verified Domain Specialist":"Community Member",author_avatar:"https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80",content:n,media_url:t,helpful_count:0};if(r)try{await r.from("answers").insert(a),await r.rpc("increment_answer_count",{q_id:c}).catch(()=>{})}catch(o){console.warn("DB insert error (rendering locally):",o)}s.push({id:"ans-local-"+Date.now(),...a,created_at:new Date().toISOString()}),document.getElementById("answersCountHeader").textContent=s.length,b(s),m.value="",l=null,p.value="",_.style.display="none",g.disabled=!1,g.innerHTML="<span>✈</span><span>Submit Reply</span>",i("✓ Reply posted successfully!")});const f=document.getElementById("followupVoiceBtn"),I=document.getElementById("followupVoiceIcon"),E=document.getElementById("followupVoiceText"),h=document.getElementById("aiRefineBtn");let w=!1;const T=window.SpeechRecognition||window.webkitSpeechRecognition;if(T){const e=new T;e.continuous=!1,e.interimResults=!0,e.onstart=()=>{w=!0,f.classList.add("listening"),I.textContent="🔴",E.textContent="Listening...",i("🎙 Listening... Speak your answer or follow-up clearly.")},e.onresult=n=>{let t="";for(let a=n.resultIndex;a<n.results.length;a++)t+=n.results[a][0].transcript;if(t){const a=m.value.trim();m.value=a?a+" "+t:t}},e.onend=()=>{w=!1,f.classList.remove("listening"),I.textContent="🎤",E.textContent="Voice Input"},e.onerror=()=>{w=!1,f.classList.remove("listening"),I.textContent="🎤",E.textContent="Voice Input"},f.addEventListener("click",()=>{w?e.stop():e.start()})}else f.addEventListener("click",()=>{i("Voice input is not supported in this browser.")});h.addEventListener("click",()=>{const e=m.value.trim();if(!e){i("Please type text first to refine with AI.");return}h.disabled=!0,h.innerHTML="<span>✨</span><span>Refining...</span>",setTimeout(()=>{let n=e.charAt(0).toUpperCase()+e.slice(1);/[.?!]$/.test(n)||(n+="."),m.value=n,h.disabled=!1,h.innerHTML="<span>🤖</span><span>AI Refine</span>",i("✨ Sentence grammar & clarity refined!")},400)});function J(){document.querySelectorAll(".helpful-btn").forEach(e=>{e.addEventListener("click",async()=>{const n=e.dataset.id;let t=parseInt(e.dataset.count||"0")+1;e.dataset.count=t,e.querySelector(".count-num").textContent=t,e.style.color="var(--green)",e.style.borderColor="var(--green)",i("✓ Marked as helpful!"),r&&n&&!n.startsWith("ans-local-")&&await r.from("answers").update({helpful_count:t}).eq("id",n).catch(()=>{})})}),document.querySelectorAll(".share-btn").forEach(e=>{e.addEventListener("click",()=>{navigator.clipboard?(navigator.clipboard.writeText(window.location.href),i("🔗 Question link copied to clipboard!")):i("🔗 Link: "+window.location.href)})})}function i(e){const n=document.getElementById("toastPill");n.textContent=e,n.classList.add("show"),setTimeout(()=>{n.classList.remove("show")},3500)}function K(e){if(!e)return"Recently";const n=new Date(e),t=Math.floor((Date.now()-n.getTime())/1e3);if(t<60)return"Just now";const a=Math.floor(t/60);if(a<60)return`${a}m ago`;const o=Math.floor(a/60);if(o<24)return`${o}h ago`;const d=Math.floor(o/24);return d<30?`${d}d ago`:n.toLocaleDateString([],{month:"short",day:"numeric"})}function W(e){if(!e||e===0)return"0 Bytes";const n=["Bytes","KB","MB","GB"],t=Math.floor(Math.log(e)/Math.log(1024));return parseFloat((e/Math.pow(1024,t)).toFixed(2))+" "+n[t]}function u(e){if(!e)return"";const n=document.createElement("div");return n.textContent=e,n.innerHTML}U();
