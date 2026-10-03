import { supabase } from '../common/supabaseClient.js';

const MAX_TRACKING_MS = 30 * 60 * 1000;
let state = { user: null, profile: null, incident: null, watchId: null, channel: null };
const $ = (id) => document.getElementById(id);
const escapeHTML = (value = '') => { const e = document.createElement('span'); e.textContent = value; return e.innerHTML; };

function setNotice(message, kind = '') { const el = $('notice'); el.className = `notice ${kind}`; el.textContent = message; }
function stopTracking() { if (state.watchId !== null) navigator.geolocation.clearWatch(state.watchId); state.watchId = null; $('trackingState').textContent = 'Not sharing'; }

async function loadContacts() {
  const { data } = await supabase.from('safety_contacts').select('name, contact_role, phone, email').eq('is_active', true);
  const el = $('contacts');
  if (!data?.length) { el.textContent = 'College emergency contacts are not configured yet.'; return; }
  el.innerHTML = data.map(c => `<p><strong>${escapeHTML(c.contact_role)}:</strong> ${escapeHTML(c.name)} ${c.phone ? `· <a href="tel:${encodeURIComponent(c.phone)}">Call</a>` : ''} ${c.email ? `· <a href="mailto:${encodeURIComponent(c.email)}">Email</a>` : ''}</p>`).join('');
}

async function publishLocation(position) {
  if (!state.incident || !state.incident.location_sharing_enabled) return;
  const { coords } = position;
  const { error } = await supabase.from('safety_locations').insert({ incident_id: state.incident.id, latitude: coords.latitude, longitude: coords.longitude, accuracy: coords.accuracy });
  if (error) { setNotice(`Location update failed: ${error.message}`, 'error'); return; }
  $('lastLocation').textContent = `Updated ${new Date().toLocaleTimeString()} (±${Math.round(coords.accuracy || 0)}m)`;
}

function positionError(error) {
  setNotice(error.code === 1 ? 'Location permission was denied. Your incident remains active without location.' : 'Could not determine your location. Try again when signal improves.', 'error');
}

async function enableLocation(live = false) {
  if (!state.incident) return;
  if (!navigator.geolocation) return setNotice('This browser does not support location sharing.', 'error');

  const expires = new Date(Date.now() + (live ? MAX_TRACKING_MS : 5 * 60 * 1000)).toISOString();
  const { data, error } = await supabase.from('safety_incidents').update({ location_sharing_enabled: true, location_sharing_expires_at: expires }).eq('id', state.incident.id).select().single();
  if (error) return setNotice(error.message, 'error');
  state.incident = data;
  $('trackingState').textContent = live ? 'Sharing Live for up to 30 minutes' : 'Sharing single location update';

  if (live) {
    state.watchId = navigator.geolocation.watchPosition(publishLocation, positionError, { enableHighAccuracy: true, timeout: 15000, maximumAge: 10000 });
    setTimeout(stopTracking, MAX_TRACKING_MS);
  } else {
    navigator.geolocation.getCurrentPosition(publishLocation, positionError, { enableHighAccuracy: true, timeout: 15000, maximumAge: 0 });
  }
}

async function uploadEvidence(incidentId) {
  const fileInput = $('evidenceUpload');
  if (!fileInput.files.length) return;

  for (const file of fileInput.files) {
    // 7. EVIDENCE INTEGRITY: size limit, metadata
    if (file.size > 10 * 1024 * 1024) { setNotice(`${file.name} is too large. Max 10MB.`, 'error'); continue; }

    const fileExt = file.name.split('.').pop();
    // The incident and uploader are part of the immutable Storage path; RLS validates both.
    const filePath = `${incidentId}/${state.user.id}/${Date.now()}_${Math.random().toString(36).substring(7)}.${fileExt}`;

    // Calculate real cryptographic hash for non-repudiation and evidence integrity.
    const arrayBuffer = await file.arrayBuffer();
    const hashBuffer = await crypto.subtle.digest('SHA-256', arrayBuffer);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
    const actualHash = `sha256:${hashHex}`;

    const { error: uploadError } = await supabase.storage.from('safety_evidence').upload(filePath, file);
    if (!uploadError) {
      await supabase.from('safety_evidence').insert({
        incident_id: incidentId,
        file_path: filePath,
        filename: file.name,
        file_type: file.type || 'unknown',
        file_size: file.size,
        content_hash: actualHash,
        uploaded_by: state.user.id
      });
    }
  }
}

async function loadMessages() {
  if (!state.incident) return;
  const { data, error } = await supabase.from('safety_messages')
    .select('message, created_at, sender:profiles!sender_id(full_name)')
    .eq('incident_id', state.incident.id)
    .eq('is_internal', false)
    .order('created_at', { ascending: true });

  if (error) { console.error('Error loading messages:', error.message); return; }

  const el = $('caseMessages');
  if (!data.length) { el.innerHTML = '<p style="color: var(--text-muted); font-size: 13px;">No messages yet.</p>'; return; }

  el.innerHTML = data.map(m => `
    <div style="margin-bottom: 8px; font-size: 14px;">
      <strong style="color: var(--primary);">${escapeHTML(m.sender?.full_name || 'Authority')}:</strong>
      <span style="color: var(--text);">${escapeHTML(m.message)}</span>
      <div style="font-size: 11px; color: var(--text-muted);">${new Date(m.created_at).toLocaleTimeString()}</div>
    </div>
  `).join('');
  el.scrollTop = el.scrollHeight;
}

async function sendMessage() {
  if (!state.incident) return;
  const msgInput = $('chatMessage');
  const text = msgInput.value.trim();
  if (!text) return;

  const { error } = await supabase.from('safety_messages').insert({
    incident_id: state.incident.id,
    sender_id: state.user.id,
    message: text,
    is_internal: false
  });

  if (error) { alert('Failed to send message: ' + error.message); return; }
  msgInput.value = '';
  await loadMessages();
}

async function loadIncident() {
  const { data, error } = await supabase.from('safety_incidents')
    .select('*, assigned_responder:profiles!assigned_responder_id(full_name, role, department, email)')
    .eq('student_id', state.user.id)
    .in('status', ['ACTIVE', 'ACKNOWLEDGED', 'RESPONDING', 'INVESTIGATION', 'WAITING_FOR_INFORMATION', 'RESOLUTION_PROPOSED'])
    .order('created_at', { ascending: false }).limit(1).maybeSingle();
  if (error) return setNotice(error.message, 'error');
  state.incident = data;
  $('incidentPanel').hidden = !data;
  $('sosForm').hidden = !!data;

  if (data) {
    $('incidentId').textContent = `Incident: ${data.id.slice(0, 8).toUpperCase()} | Type: ${data.incident_type} | Severity: ${data.severity}`;
    $('incidentStatus').textContent = data.status;
    $('trackingState').textContent = data.location_sharing_enabled ? 'Location sharing enabled' : 'Not sharing';

    if (data.assigned_responder) {
      $('assignmentCard').hidden = false;
      const r = data.assigned_responder;
      $('assigneeName').textContent = r.full_name || 'Unknown Officer';

      // Fetch the staff role from safety_staff table
      let staffRole = 'Responder';
      if (data.assigned_responder_id) {
        let staffData = null;
        if (data.college_id && data.college_id !== 'null') {
          const res = await supabase.from('safety_staff')
            .select('staff_role, availability')
            .eq('profile_id', data.assigned_responder_id)
            .eq('college_id', data.college_id)
            .maybeSingle();
          staffData = res.data;
        }
        if (staffData) {
          staffRole = staffData.staff_role?.replace(/_/g, ' ').toUpperCase() || 'Responder';
          const avail = staffData.availability || 'AVAILABLE';
          const availColor = avail === 'AVAILABLE' ? '#20d889' : (avail === 'BUSY' ? '#f59e0b' : '#94a3b8');
          $('assigneeContact').innerHTML = `
            <p><strong>Designation:</strong> ${escapeHTML(staffRole)}</p>
            <p><strong>Department:</strong> ${escapeHTML(r.department || 'N/A')}</p>
            <p><strong>Availability:</strong> <span style="color: ${availColor};">● ${escapeHTML(avail)}</span></p>
            <p style="font-size: 13px; color: var(--text-muted); margin-top: 8px;">
              Use the case messaging system below to communicate with the assigned authority.
            </p>
          `;
        } else {
          $('assigneeContact').innerHTML = `<p>Contact your college admin for exact communication channels.</p>`;
        }
      }
      $('assigneeRole').textContent = staffRole;
    } else {
      $('assignmentCard').hidden = true;
    }

    await loadMessages();
  }
}

// Local basic keyword AI risk analyzer
function localAIAnalyze(text) {
  const lower = text.toLowerCase();
  let flags = [];
  if (lower.includes('threat') || lower.includes('kill') || lower.includes('attack')) flags.push('Contains threat language.');
  if (lower.includes('follow') || lower.includes('stalk')) flags.push('Contains stalking indicators.');
  if (lower.includes('touch') || lower.includes('harass')) flags.push('Contains harassment indicators.');
  return flags;
}

let lastSOSTime = 0;

let isSubmitting = false;

async function createIncident(isSOS = false) {
  if (isSubmitting) return;
  isSubmitting = true;
  try {
    if (!state.profile?.college_id || state.profile.college_id === 'null') return setNotice('Your account is not assigned to a college. Contact support.', 'error');

    // Abuse protection: SOS cooldown
    if (isSOS) {
      const now = Date.now();
      if (now - lastSOSTime < 60000) {
        return setNotice('Please wait a moment before sending another SOS. Your previous SOS is active.', 'error');
      }
    }

    const message = $('message').value.trim();
    if (!message) return setNotice('Please describe the problem.', 'error');

    // AI local check
    const riskFlags = localAIAnalyze(message);
    let aiExplanation = '';
    if (riskFlags.length > 0) {
      aiExplanation = riskFlags.join(' ');
      $('aiAnalysisBox').style.display = 'block';
      $('aiAnalysisText').textContent = aiExplanation;
    } else {
      $('aiAnalysisBox').style.display = 'none';
    }

    const confirmMsg = isSOS ? 'Send this EMERGENCY request immediately?' : 'Submit this complaint securely?';
    if (!confirm(confirmMsg)) return;

    if (isSOS) lastSOSTime = Date.now();

    setNotice('Checking for duplicates...', '');

    // 5. INCIDENT DEDUPLICATION check
    let is_possible_duplicate = false;
    let duplicate_of_id = null;

    const searchType = isSOS ? 'medical_emergency' : $('category').value;
    const { data: recent } = await supabase.from('safety_incidents')
      .select('id')
      .eq('college_id', state.profile.college_id)
      .eq('incident_type', searchType)
      .gte('created_at', new Date(Date.now() - 15 * 60000).toISOString())
      .limit(1);

    if (recent && recent.length > 0) {
      is_possible_duplicate = true;
      duplicate_of_id = recent[0].id;
    }

    setNotice('Submitting incident...', '');

    const { data, error } = await supabase.from('safety_incidents').insert({
      college_id: state.profile.college_id,
      student_id: state.user.id,
      incident_type: searchType,
      severity: isSOS ? 'CRITICAL' : $('severity').value,
      message,
      is_anonymous: $('isAnonymous').checked,
      ai_risk_explanation: aiExplanation || null,
      is_possible_duplicate,
      duplicate_of_id
    }).select().single();

    if (error) return setNotice(`Failed: ${error.message}`, 'error');

    state.incident = data;
    setNotice('Incident submitted. Uploading evidence...', '');
    await uploadEvidence(data.id);
    state.incident = data;
    setNotice('Submitted successfully. Your college safety team has been notified.', 'success');
    await loadIncident();
  } finally {
    isSubmitting = false;
  }
}

async function cancelSOS() {
  if (!state.incident || !confirm('Close this incident?')) return;
  const { error } = await supabase.from('safety_incidents').update({ status: 'CANCELLED' }).eq('id', state.incident.id);
  if (error) return setNotice(error.message, 'error');
  stopTracking(); state.incident = null; setNotice('Incident closed.', 'success'); await loadIncident();
}

async function init() {
  window.addEventListener('online', () => setNotice('Connection restored.', 'success'));
  window.addEventListener('offline', () => setNotice('Connection interrupted. Actions may be delayed.', 'error'));

  const { data: { session } } = await supabase.auth.getSession();
  if (!session) { location.href = 'login.html'; return; }
  state.user = session.user;
  const { data: profile, error } = await supabase.from('profiles').select('id, full_name, college_id').eq('id', session.user.id).single();
  if (error) return setNotice('Could not load your safety profile.', 'error');
  state.profile = profile;
  $('studentName').textContent = profile.full_name || 'Student';
  await loadContacts();
  await loadIncident();
  state.channel = supabase.channel(`student-safety-${state.user.id}`)
    .on('postgres_changes', { event: '*', schema: 'public', table: 'safety_incidents', filter: `student_id=eq.${state.user.id}` }, async () => { await loadIncident(); })
    .on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'safety_messages' }, async () => { await loadMessages(); })
    .subscribe();
}

$('btnSubmitComplaint').addEventListener('click', () => createIncident(false));
$('btnSendSOS').addEventListener('click', () => createIncident(true));
$('shareLocation').addEventListener('click', () => enableLocation(false));
$('liveLocation').addEventListener('click', () => enableLocation(true));
$('cancelSOS').addEventListener('click', cancelSOS);
if($('btnSendMessage')) $('btnSendMessage').addEventListener('click', sendMessage);

window.addEventListener('beforeunload', () => { stopTracking(); state.channel && supabase.removeChannel(state.channel); });
init();
