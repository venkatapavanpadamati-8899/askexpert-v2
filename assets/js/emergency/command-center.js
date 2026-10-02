import { supabase } from '../common/supabaseClient.js';

let state = {
  user: null,
  profile: null,
  incidents: [],
  logs: []
};

const $ = (id) => document.getElementById(id);
const escapeHTML = (str) => { const div = document.createElement('div'); div.textContent = str; return div.innerHTML; };

function updateNetworkStatus() {
  const el = $('networkStatus');
  if (navigator.onLine) {
    el.className = 'network-status';
    el.textContent = '● ONLINE';
  } else {
    el.className = 'network-status offline';
    el.textContent = '○ OFFLINE (Reconnecting...)';
  }
}
window.addEventListener('online', updateNetworkStatus);
window.addEventListener('offline', updateNetworkStatus);

function updateStats() {
  const activeSOS = state.incidents.filter(i => i.severity === 'CRITICAL' && i.status !== 'RESOLVED' && i.status !== 'CANCELLED');
  const unack = state.incidents.filter(i => i.status === 'ACTIVE');
  const overdue = state.incidents.filter(i => new Date(i.response_due_at) < new Date() && !['RESOLVED', 'CANCELLED'].includes(i.status));
  const responders = new Set(state.incidents.filter(i => i.assigned_responder_id).map(i => i.assigned_responder_id));
  
  $('statActiveSos').textContent = activeSOS.length;
  $('statUnack').textContent = unack.length;
  $('statOverdue').textContent = overdue.length;
  $('statResponders').textContent = responders.size;
}

function renderIncidents() {
  const list = $('incidentList');
  if (state.incidents.length === 0) {
    list.innerHTML = '<p style="color:var(--text-muted);">No active emergency cases.</p>';
    return;
  }
  
  list.innerHTML = state.incidents.map(inc => {
    const isOverdue = new Date(inc.response_due_at) < new Date();
    const createdDate = new Date(inc.created_at);
    
    // Timer calculate
    const durationMs = Date.now() - createdDate.getTime();
    const mm = Math.floor(durationMs / 60000).toString().padStart(2, '0');
    const ss = Math.floor((durationMs % 60000) / 1000).toString().padStart(2, '0');
    const hh = Math.floor(durationMs / 3600000).toString().padStart(2, '0');
    
    let timerHtml = `<div class="timer ${isOverdue ? 'breached' : ''}">${hh}:${mm}:${ss}</div>`;
    
    return `
      <div class="incident ${inc.severity}">
        <div class="incident-header">
          <div>
            <strong>Case ID: SAF-${inc.id.slice(0, 8).toUpperCase()}</strong>
            <span class="badge ${inc.status === 'ACTIVE' ? 'UNACKNOWLEDGED' : ''}">${escapeHTML(inc.status)}</span>
            ${inc.is_possible_duplicate ? '<span class="badge" style="background:#475569;">Possible Duplicate</span>' : ''}
          </div>
          ${timerHtml}
        </div>
        <div class="incident-meta">
          Priority: ${inc.severity} | Created: ${createdDate.toLocaleTimeString()} | 
          Type: ${inc.incident_type} 
        </div>
        <div style="font-size: 14px; margin-bottom: 12px; color: var(--text);">
          ${escapeHTML(inc.message)}
        </div>
        <div class="actions-grid">
          ${inc.status === 'ACTIVE' ? `<button class="btn-primary" onclick="window.acknowledgeIncident('${inc.id}')">Acknowledge</button>` : ''}
          ${inc.status === 'ACKNOWLEDGED' ? `<button class="btn-primary" onclick="window.assignIncident('${inc.id}')">Assign Self</button>` : ''}
          ${inc.status === 'RESPONDING' ? `<button class="btn-outline" onclick="window.resolveIncident('${inc.id}')">Resolve</button>` : ''}
          <button class="btn-outline" onclick="window.viewCase('${inc.id}')">View Case</button>
        </div>
      </div>
    `;
  }).join('');
  
  updateStats();
}

async function loadIncidents() {
  if (!state.profile?.college_id || state.profile.college_id === 'null') {
    state.incidents = [];
    renderIncidents();
    return;
  }

  const { data, error } = await supabase.from('vw_safety_incidents_safe')
    .select('*')
    .eq('college_id', state.profile.college_id)
    .neq('status', 'CANCELLED')
    .neq('status', 'RESOLVED')
    .order('created_at', { ascending: false });
    
  if (error) { console.error('Failed to load incidents', error); return; }
  state.incidents = data;
  renderIncidents();
}

async function loadSecurityLogs() {
  if (!state.profile?.college_id || state.profile.college_id === 'null') return;

  const { data, error } = await supabase.from('safety_security_events')
    .select('*')
    .eq('college_id', state.profile.college_id)
    .order('created_at', { ascending: false })
    .limit(5);
    
  if (error || !data) return;
  const logsEl = $('securityLogs');
  if (data.length === 0) { logsEl.innerHTML = '<p>No anomalies detected.</p>'; return; }
  
  logsEl.innerHTML = data.map(log => `
    <div style="border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 8px;">
      <span class="badge" style="background:var(--warning); color:#fff;">${log.event_type}</span>
      <span style="margin-left: 8px;">${escapeHTML(log.description)}</span>
      <div style="font-size: 11px; margin-top: 4px;">${new Date(log.created_at).toLocaleString()}</div>
    </div>
  `).join('');
}

window.acknowledgeIncident = async (id) => {
  const { error } = await supabase.from('safety_incidents').update({ 
    status: 'ACKNOWLEDGED', 
    acknowledged_at: new Date().toISOString() 
  }).eq('id', id);
  if (!error) loadIncidents();
};

window.assignIncident = async (id) => {
  const { error } = await supabase.from('safety_incidents').update({ 
    status: 'RESPONDING', 
    assigned_responder_id: state.user.id,
    assigned_at: new Date().toISOString(),
    responding_at: new Date().toISOString()
  }).eq('id', id);
  if (!error) loadIncidents();
};

window.resolveIncident = async (id) => {
  const { error } = await supabase.from('safety_incidents').update({ 
    status: 'RESOLVED',
    resolved_at: new Date().toISOString(),
    closed_at: new Date().toISOString()
  }).eq('id', id);
  if (!error) loadIncidents();
};

window.viewCase = (id) => {
  window.location.href = `college-safety-management.html?case=${id}`;
};

async function init() {
  updateNetworkStatus();
  
  const { data: { session } } = await supabase.auth.getSession();
  if (!session) { location.href = 'login.html'; return; }
  state.user = session.user;
  
  const { data: profile } = await supabase.from('profiles').select('id, college_id').eq('id', state.user.id).single();
  if (!profile || !profile.college_id) {
    document.body.innerHTML = '<h1>Unauthorized</h1>';
    return;
  }
  state.profile = profile;
  
  // Realtime subscription
  supabase.channel('safety-cmd')
    .on('postgres_changes', { event: '*', schema: 'public', table: 'safety_incidents', filter: `college_id=eq.${profile.college_id}` }, () => {
      loadIncidents();
    })
    .subscribe();
    
  // Availability status toggle
  $('staffAvailability').addEventListener('change', async (e) => {
    const val = e.target.value;
    await supabase.from('safety_staff').update({ availability: val }).eq('profile_id', state.user.id);
  });
  
  // Initial load
  await loadIncidents();
  await loadSecurityLogs();
  
  // Tick timer every second
  setInterval(renderIncidents, 1000);
}

document.addEventListener('DOMContentLoaded', init);
