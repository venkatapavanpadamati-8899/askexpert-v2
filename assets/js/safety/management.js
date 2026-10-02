import { supabase } from '../common/supabaseClient.js';

let state = { user: null, profile: null, incidents: [], channel: null };
const $ = (id) => document.getElementById(id);
const escapeHTML = (value = '') => { const e = document.createElement('span'); e.textContent = value; return e.innerHTML; };

let targetIncidentForBreakGlass = null;
let activeIncidentId = null;

function fmt(iso) { return iso ? new Date(iso).toLocaleString() : 'N/A'; }

async function logAction(incidentId, action) {
  await supabase.rpc('safety_log_action', { target_incident_id: incidentId, event_action: action });
}

async function updateStatus(id, newStatus) {
  const { error } = await supabase.from('safety_incidents').update({ status: newStatus }).eq('id', id);
  if (error) { alert(error.message); return; }
  await loadIncidents();
}

async function assignToMe(id) {
  const { error } = await supabase.from('safety_incidents').update({ assigned_responder_id: state.user.id, status: 'ACKNOWLEDGED' }).eq('id', id);
  if (error) { alert(error.message); return; }
  await logAction(id, 'assigned_to_self');
  await loadIncidents();
}

async function viewLocation(id) {
  const { data, error } = await supabase.from('safety_locations').select('*').eq('incident_id', id).order('recorded_at', { ascending: false }).limit(1).maybeSingle();
  if (error || !data) { $('location').innerHTML = '<p>No location data available or sharing expired.</p>'; return; }
  
  $('location').innerHTML = `
    <h3>Last Known Location</h3>
    <p>Lat: ${data.latitude}, Lng: ${data.longitude} (Accuracy: ±${Math.round(data.accuracy)}m)</p>
    <p><small>Recorded: ${fmt(data.recorded_at)}</small></p>
    <a href="https://www.google.com/maps/search/?api=1&query=${data.latitude},${data.longitude}" target="_blank">Open in Google Maps</a>
  `;
}

async function escalateIncident(id) {
  const note = prompt('Enter reason for escalation:');
  if (note === null) return;
  const { data, error } = await supabase.rpc('safety_escalate_incident', { target_incident_id: id, escalation_note: note });
  if (error) { alert('Escalation failed: ' + error.message); return; }
  alert('Incident escalated to level ' + data);
  await loadIncidents();
}

function requestBreakGlass(id) {
  targetIncidentForBreakGlass = id;
  $('breakGlassModal').style.display = 'flex';
  $('breakGlassReason').value = '';
}

async function confirmBreakGlass() {
  const reason = $('breakGlassReason').value.trim();
  if (!reason) { alert('A reason is required.'); return; }
  if (!targetIncidentForBreakGlass) return;
  
  const { error } = await supabase.from('safety_break_glass_requests').insert({
    incident_id: targetIncidentForBreakGlass,
    requested_by: state.user.id,
    reason: reason,
    expires_at: new Date(Date.now() + 2 * 60 * 60 * 1000).toISOString() // 2 hours
  });
  
  if (error) { alert('Break-Glass request failed: ' + error.message); return; }
  
  $('breakGlassModal').style.display = 'none';
  alert('Temporary emergency access granted for 2 hours.');
  await loadIncidents();
}

$('btnConfirmBreakGlass').addEventListener('click', confirmBreakGlass);
$('btnCancelBreakGlass').addEventListener('click', () => { $('breakGlassModal').style.display = 'none'; });

async function renderAnalytics() {
  const totalOpen = state.incidents.length;
  const sosAlerts = state.incidents.filter(i => i.severity === 'CRITICAL' || i.incident_type === 'medical_emergency').length;

  let resolvedCount = 0;
  if (state.profile?.college_id) {
    // Fetch resolved today count from DB
    const todayStart = new Date();
    todayStart.setHours(0, 0, 0, 0);
    const { count } = await supabase
      .from('safety_incidents')
      .select('id', { count: 'exact', head: true })
      .eq('college_id', state.profile.college_id)
      .eq('status', 'RESOLVED')
      .gte('updated_at', todayStart.toISOString());
    resolvedCount = count || 0;
  }

  $('statTotalOpen').textContent = totalOpen;
  $('statTotalSOS').textContent = sosAlerts;
  $('statResolvedToday').textContent = resolvedCount;
}

async function renderIncidents() {
  const el = $('list');
  $('count').textContent = state.incidents.length;
  if (!state.incidents.length) { el.innerHTML = '<p>No active incidents found for your college.</p>'; return; }
  
  el.innerHTML = state.incidents.map(i => {
    let actions = '';
    if (i.status === 'ACTIVE') actions += `<button onclick="window.assignToMe('${i.id}')">Acknowledge & Assign to Me</button>`;
    if (i.status === 'ACKNOWLEDGED' || i.status === 'ACTIVE') actions += `<button onclick="window.updateStatus('${i.id}', 'RESPONDING')">Mark Responding</button>`;
    if (i.status !== 'RESOLVED' && i.status !== 'CANCELLED') actions += `<button onclick="window.updateStatus('${i.id}', 'RESOLVED')">Resolve</button>`;
    
    actions += `<button onclick="window.viewLocation('${i.id}')">View Location</button>`;
    actions += `<button onclick="window.escalateIncident('${i.id}')" style="border-color:var(--warning); color:var(--warning);">Escalate</button>`;
    // Simulated break glass if needed
    actions += `<button onclick="window.requestBreakGlass('${i.id}')" style="border-color:var(--danger); color:var(--danger);">Break Glass Access</button>`;

    let evidenceHtml = '';
    if (i.evidence_urls && i.evidence_urls.length > 0) {
      evidenceHtml = '<div class="evidence-links"><p><strong>Evidence:</strong></p>';
      i.evidence_urls.forEach((url, idx) => {
        evidenceHtml += `<a href="#" onclick="alert('In production, this generates a secure signed URL for auth.uid()'); return false;">View Evidence ${idx + 1}</a>`;
      });
      evidenceHtml += '</div>';
    }

    let aiInfo = '';
    if (i.ai_risk_explanation) {
      aiInfo = `<div style="background: rgba(255,100,100,0.1); padding: 8px; border-radius: 4px; margin-top: 8px; border-left: 3px solid #ff6b6b;">
        <small style="color: #ff6b6b;"><strong>AI Risk Indicator:</strong> ${escapeHTML(i.ai_risk_explanation)}</small>
      </div>`;
    }

    const studentName = i.is_anonymous ? 'Anonymous Student' : escapeHTML(i.student?.full_name || 'Unknown');
    const studentDept = i.is_anonymous ? 'Hidden' : escapeHTML(i.student?.department || 'No Dept');

    return `
      <div class="incident ${escapeHTML(i.severity)}">
        <div>
          <h3>${escapeHTML(i.incident_type.replace(/_/g, ' ').toUpperCase())}</h3>
          <p>
            <span class="badge ${escapeHTML(i.status)}">${escapeHTML(i.status)}</span>
            <span class="badge ${escapeHTML(i.severity)}">${escapeHTML(i.severity)}</span>
            ${i.escalation_level > 0 ? `<span class="badge CRITICAL">Escalated L${i.escalation_level}</span>` : ''}
          </p>
          <p><strong>Student:</strong> ${studentName} (${studentDept})</p>
          <p><strong>Message:</strong> ${escapeHTML(i.message)}</p>
          ${evidenceHtml}
          ${aiInfo}
          <div class="meta" style="margin-top: 12px;">
            <small>ID: ${i.id.slice(0, 8).toUpperCase()}</small><br>
            <small>Created: ${fmt(i.created_at)}</small><br>
            <small>Assigned to: ${i.assigned_responder?.full_name || 'Unassigned'}</small>
          </div>
        </div>
        <div class="actions">
          ${actions}
          <button onclick="window.openCaseModal('${i.id}')" style="background: var(--primary); color: #fff;">Case Management</button>
        </div>
      </div>
    `;
  }).join('');
  
  await renderAnalytics();
}

async function loadIncidents() {
  if (!state.profile?.college_id) {
    $('list').innerHTML = '<p class="empty">You are not assigned to a college.</p>';
    await renderAnalytics();
    return;
  }

  const { data, error } = await supabase.from('vw_safety_incidents_safe')
    .select('*')
    .eq('college_id', state.profile.college_id)
    .in('status', ['ACTIVE', 'ACKNOWLEDGED', 'RESPONDING'])
    .order('created_at', { ascending: false });
    
  if (error) { $('list').innerHTML = `<p class="error">Error loading incidents: ${escapeHTML(error.message)}</p>`; return; }
  
  // Fetch profiles for students and responders to avoid PostgREST view relation errors
  const incidents = data || [];
  const profileIds = new Set();
  incidents.forEach(i => {
    if (i.student_id) profileIds.add(i.student_id);
    if (i.assigned_responder_id) profileIds.add(i.assigned_responder_id);
  });
  
  if (profileIds.size > 0) {
    const { data: profiles } = await supabase.from('profiles').select('id, full_name, department, email').in('id', Array.from(profileIds));
    const profileMap = {};
    if (profiles) profiles.forEach(p => profileMap[p.id] = p);
    
    incidents.forEach(i => {
      i.student = i.student_id ? profileMap[i.student_id] : null;
      i.assigned_responder = i.assigned_responder_id ? profileMap[i.assigned_responder_id] : null;
    });
  }
  
  state.incidents = incidents;
  renderIncidents();
}

async function init() {
  const { data: { session } } = await supabase.auth.getSession();
  if (!session) { location.href = 'admin-login.html'; return; }
  state.user = session.user;
  
  const { data: profile } = await supabase.from('profiles').select('id, full_name, college_id').eq('id', session.user.id).single();
  state.profile = profile;
  
  window.updateStatus = updateStatus;
  window.assignToMe = assignToMe;
  window.viewLocation = viewLocation;
  window.escalateIncident = escalateIncident;
  window.requestBreakGlass = requestBreakGlass;
  window.openCaseModal = openCaseModal;
  
  $('tabIncidents').addEventListener('click', () => {
    $('tabIncidents').classList.add('active'); $('tabIncidents').style.background = 'var(--primary)'; $('tabIncidents').style.color = '#fff';
    $('tabAnalytics').classList.remove('active'); $('tabAnalytics').style.background = 'rgba(255,255,255,0.1)'; $('tabAnalytics').style.color = 'var(--text)';
    $('location').style.display = 'block'; $('list').style.display = 'block'; $('analyticsPanel').style.display = 'none';
  });
  
  $('tabAnalytics').addEventListener('click', () => {
    $('tabAnalytics').classList.add('active'); $('tabAnalytics').style.background = 'var(--primary)'; $('tabAnalytics').style.color = '#fff';
    $('tabIncidents').classList.remove('active'); $('tabIncidents').style.background = 'rgba(255,255,255,0.1)'; $('tabIncidents').style.color = 'var(--text)';
    $('location').style.display = 'none'; $('list').style.display = 'none'; $('analyticsPanel').style.display = 'block';
  });

  await loadIncidents();
  
  if (state.profile?.college_id) {
    state.channel = supabase.channel(`college-safety-mgmt-${state.profile.college_id}`)
      .on('postgres_changes', { event: '*', schema: 'public', table: 'safety_incidents', filter: `college_id=eq.${state.profile.college_id}` }, async () => { 
        // Notify authority if it's not them doing the change (simple toast via alert/console)
        console.log('New safety incident update received');
        await loadIncidents(); 
      })
      .on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'safety_messages' }, async (payload) => { 
        if (activeIncidentId === payload.new.incident_id) {
          await loadCaseMessages(activeIncidentId);
        }
      })
      .subscribe();
  }
}

async function openCaseModal(id) {
  activeIncidentId = id;
  $('caseModal').style.display = 'flex';
  await loadCaseMessages(id);
}

async function loadCaseMessages(id) {
  if (!id) return;
  const { data, error } = await supabase.from('safety_messages')
    .select('message, is_internal, created_at, sender:profiles!sender_id(full_name, role)')
    .eq('incident_id', id)
    .order('created_at', { ascending: true });
    
  if (error) { console.error('Error loading messages:', error.message); return; }
  
  const el = $('managementMessages');
  if (!data.length) { el.innerHTML = '<p style="color: var(--text-muted); font-size: 13px;">No messages yet.</p>'; return; }
  
  el.innerHTML = data.map(m => {
    const isInternal = m.is_internal;
    const bg = isInternal ? 'rgba(245, 158, 11, 0.1)' : 'transparent';
    const border = isInternal ? '1px dashed var(--warning)' : 'none';
    const name = m.sender?.full_name || 'System';
    const role = m.sender?.role || 'User';
    
    return `
      <div style="margin-bottom: 8px; font-size: 14px; background: ${bg}; border: ${border}; padding: 6px; border-radius: 6px;">
        <strong style="color: ${isInternal ? 'var(--warning)' : 'var(--primary)'};">${escapeHTML(name)} (${escapeHTML(role)})${isInternal ? ' [INTERNAL]' : ''}:</strong> 
        <span style="color: var(--text);">${escapeHTML(m.message)}</span>
        <div style="font-size: 11px; color: var(--text-muted);">${new Date(m.created_at).toLocaleTimeString()}</div>
      </div>
    `;
  }).join('');
  el.scrollTop = el.scrollHeight;
}

$('btnCloseCaseModal').addEventListener('click', () => { $('caseModal').style.display = 'none'; activeIncidentId = null; });
$('btnChangeStatus').addEventListener('click', () => {
  if(!activeIncidentId) return;
  const newStatus = prompt("Enter new status (ACTIVE, ACKNOWLEDGED, RESPONDING, INVESTIGATION, WAITING_FOR_INFORMATION, RESOLUTION_PROPOSED, RESOLVED, CANCELLED):");
  if(newStatus) updateStatus(activeIncidentId, newStatus.trim().toUpperCase());
});
$('btnAssignSelf').addEventListener('click', () => {
  if(!activeIncidentId) return;
  assignToMe(activeIncidentId);
});
$('btnMgmtSend').addEventListener('click', async () => {
  if(!activeIncidentId) return;
  const msgInput = $('mgmtMessageInput');
  const text = msgInput.value.trim();
  const isInternal = $('mgmtInternalOnly').checked;
  if (!text) return;
  
  const { error } = await supabase.from('safety_messages').insert({
    incident_id: activeIncidentId,
    sender_id: state.user.id,
    message: text,
    is_internal: isInternal
  });
  
  if (error) { alert('Failed to send message: ' + error.message); return; }
  msgInput.value = '';
  $('mgmtInternalOnly').checked = false;
  await loadCaseMessages(activeIncidentId);
});

window.addEventListener('beforeunload', () => { state.channel && supabase.removeChannel(state.channel); });
init();
