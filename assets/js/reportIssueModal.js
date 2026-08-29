// assets/js/reportIssueModal.js
/**
 * Global Issue & Feature Request Reporting Modal for AskExpert
 * Enables any authenticated user, client, or verified expert to report bugs or request features.
 * Integrates with AI Issue Analyzer to generate fix proposals for Admin Review.
 */
import { supabase } from "./supabaseClient.js";
import { analyzeIssueAndGenerateProposal } from "./aiIssueAnalyzer.js";

export function initReportIssueModal() {
  if (document.getElementById("reportIssueModalWrap")) return;

  const modalHtml = `
    <div id="reportIssueModalWrap" class="modal-backdrop" style="display:none;position:fixed;inset:0;background:rgba(2,8,20,0.85);backdrop-filter:blur(8px);z-index:99999;align-items:center;justify-content:center;padding:16px;">
      <div class="modal-card" style="background:#0a192f;border:1px solid rgba(0,217,255,0.25);border-radius:16px;max-width:540px;width:100%;padding:24px;color:#fff;box-shadow:0 20px 40px rgba(0,0,0,0.6);font-family:Inter,system-ui,sans-serif;">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;border-bottom:1px solid rgba(255,255,255,0.08);padding-bottom:12px;">
          <div style="display:flex;align-items:center;gap:10px;">
            <span style="font-size:22px;">🛠️</span>
            <div>
              <h2 style="font-size:17px;font-weight:800;color:#fff;margin:0;">Report Issue or Feature Request</h2>
              <span style="font-size:11.5px;color:#00d9ff;">Directly analyzed by AskExpert AI • Admin Gated</span>
            </div>
          </div>
          <button type="button" id="closeReportModalBtn" style="background:none;border:none;color:#8892b0;font-size:20px;cursor:pointer;">✕</button>
        </div>

        <form id="reportIssueForm" style="display:flex;flex-direction:column;gap:12px;">
          <div>
            <label style="display:block;font-size:12px;color:#8892b0;margin-bottom:4px;font-weight:600;">Report Type</label>
            <select id="reportIssueType" style="width:100%;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.15);border-radius:8px;padding:8px 12px;color:#fff;font-size:13px;" required>
              <option value="bug">🐛 Bug / Technical Error</option>
              <option value="feature_request">💡 New Feature Request</option>
              <option value="improvement">⚡ Performance & UX Improvement</option>
              <option value="security">🔒 Security or Privacy Concern</option>
            </select>
          </div>

          <div>
            <label style="display:block;font-size:12px;color:#8892b0;margin-bottom:4px;font-weight:600;">Summary Title</label>
            <input type="text" id="reportIssueTitle" placeholder="e.g. Chat WebSocket reconnection lag under low bandwidth" style="width:100%;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.15);border-radius:8px;padding:8px 12px;color:#fff;font-size:13px;" required />
          </div>

          <div>
            <label style="display:block;font-size:12px;color:#8892b0;margin-bottom:4px;font-weight:600;">Detailed Description</label>
            <textarea id="reportIssueDesc" rows="3" placeholder="Provide full context, observed behavior vs expected behavior..." style="width:100%;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.15);border-radius:8px;padding:8px 12px;color:#fff;font-size:13px;" required></textarea>
          </div>

          <div>
            <label style="display:block;font-size:12px;color:#8892b0;margin-bottom:4px;font-weight:600;">Steps to Reproduce (Optional)</label>
            <textarea id="reportIssueSteps" rows="2" placeholder="1. Go to page... 2. Click on... 3. Error occurs" style="width:100%;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.15);border-radius:8px;padding:8px 12px;color:#fff;font-size:13px;"></textarea>
          </div>

          <div style="display:flex;gap:12px;">
            <div style="flex:1;">
              <label style="display:block;font-size:12px;color:#8892b0;margin-bottom:4px;font-weight:600;">Severity Level</label>
              <select id="reportIssueSeverity" style="width:100%;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.15);border-radius:8px;padding:8px 12px;color:#fff;font-size:13px;">
                <option value="low">🟢 Low (Cosmetic / Minor)</option>
                <option value="medium" selected>🟡 Medium (Standard)</option>
                <option value="high">🟠 High (Impacting Workflow)</option>
                <option value="critical">🔴 Critical (Blocking System)</option>
              </select>
            </div>
          </div>

          <div id="reportStatusFeedback" style="display:none;padding:10px;border-radius:8px;font-size:12px;margin-top:4px;"></div>

          <div style="display:flex;justify-content:flex-end;gap:10px;margin-top:12px;border-top:1px solid rgba(255,255,255,0.08);padding-top:14px;">
            <button type="button" id="cancelReportBtn" style="background:none;border:1px solid rgba(255,255,255,0.2);color:#8892b0;padding:8px 16px;border-radius:8px;font-size:13px;cursor:pointer;">Cancel</button>
            <button type="submit" id="submitReportBtn" style="background:linear-gradient(135deg,#00d9ff,#7952ff);border:none;color:#fff;font-weight:700;padding:8px 20px;border-radius:8px;font-size:13px;cursor:pointer;display:flex;align-items:center;gap:6px;">
              <span>🚀</span>
              <span>Submit for AI Analysis</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  `;

  document.body.insertAdjacentHTML("beforeend", modalHtml);

  const wrap = document.getElementById("reportIssueModalWrap");
  const closeBtn = document.getElementById("closeReportModalBtn");
  const cancelBtn = document.getElementById("cancelReportBtn");
  const form = document.getElementById("reportIssueForm");
  const submitBtn = document.getElementById("submitReportBtn");
  const feedback = document.getElementById("reportStatusFeedback");

  const closeModal = () => { wrap.style.display = "none"; };
  closeBtn.addEventListener("click", closeModal);
  cancelBtn.addEventListener("click", closeModal);

  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    submitBtn.disabled = true;
    submitBtn.innerHTML = "<span>⏳</span> Analyzing with AI...";

    const type = document.getElementById("reportIssueType").value;
    const title = document.getElementById("reportIssueTitle").value.trim();
    const desc = document.getElementById("reportIssueDesc").value.trim();
    const steps = document.getElementById("reportIssueSteps").value.trim();
    const severity = document.getElementById("reportIssueSeverity").value;

    let reporterId = sessionStorage.getItem("askexpert_user_id");

    // Fetch session user if not in sessionStorage
    if (!reporterId && supabase) {
      const { data: { session } } = await supabase.auth.getSession();
      if (session?.user) reporterId = session.user.id;
    }

    if (!reporterId) {
      reporterId = "00000000-0000-0000-0000-000000000000"; // fallback identifier
    }

    const reportRecord = {
      reporter_id: reporterId,
      report_type: type,
      title: title,
      description: desc,
      steps_to_reproduce: steps,
      severity: severity,
      status: "pending_ai"
    };

    try {
      let createdReport = reportRecord;
      if (supabase && reporterId !== "00000000-0000-0000-0000-000000000000") {
        const { data, error } = await supabase
          .from("issue_reports")
          .insert(reportRecord)
          .select()
          .single();

        if (error) throw error;
        createdReport = data;
      } else {
        createdReport.id = "rep-local-" + Date.now();
      }

      // Generate AI Fix Proposal
      const proposal = await analyzeIssueAndGenerateProposal(createdReport);

      feedback.style.display = "block";
      feedback.style.background = "rgba(0,217,255,0.12)";
      feedback.style.border = "1px solid #00d9ff";
      feedback.style.color = "#00d9ff";
      feedback.innerHTML = `✓ <strong>Issue Logged & Analyzed!</strong> AI proposal #${proposal.id ? String(proposal.id).slice(0,8) : "GEN"} created with risk level: <strong>${proposal.risk_level.toUpperCase()}</strong>. It is now awaiting Admin review in the AI Fix Center.`;

      submitBtn.innerHTML = "Submitted ✓";
      setTimeout(() => {
        closeModal();
        form.reset();
        submitBtn.disabled = false;
        submitBtn.innerHTML = "<span>🚀</span> Submit for AI Analysis";
        feedback.style.display = "none";
      }, 2500);

    } catch (err) {
      console.error("Issue report submit error:", err);
      feedback.style.display = "block";
      feedback.style.background = "rgba(255,71,87,0.15)";
      feedback.style.border = "1px solid #ff4757";
      feedback.style.color = "#ff4757";
      feedback.textContent = `Submission failed: ${err.message}`;
      submitBtn.disabled = false;
      submitBtn.innerHTML = "Retry Submission";
    }
  });
}

export function openReportIssueModal() {
  initReportIssueModal();
  const wrap = document.getElementById("reportIssueModalWrap");
  if (wrap) wrap.style.display = "flex";
}
