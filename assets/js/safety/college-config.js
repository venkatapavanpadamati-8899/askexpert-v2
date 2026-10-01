import { supabase } from '../common/supabaseClient.js';

let state = { user: null, profile: null, college: null, staffList: [], contactList: [] };
const $ = (id) => document.getElementById(id);
const escapeHTML = (value = '') => { const e = document.createElement('span'); e.textContent = value; return e.innerHTML; };

function setNotice(msg, kind = '') { const el = $('notice'); el.className = `notice ${kind}`; el.textContent = msg; }

// Tab navigation
document.querySelectorAll('.section-tabs button').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.section-tabs button').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    const tab = btn.dataset.tab;
    document.querySelectorAll('section[id^="tab-"]').forEach(s => s.style.display = 'none');
    $(`tab-${tab}`).style.display = 'block';
  });
});

async function loadCollege() {
  if (!state.profile?.college_id) {
    setNotice('Your account is not assigned to a college.', 'error');
    return;
  }
  const { data, error } = await supabase.from('colleges').select('*').eq('id', state.profile.college_id).single();
  if (error) { setNotice('Failed to load college: ' + error.message, 'error'); return; }
  state.college = data;
  $('collegeName').value = data.name || '';
  $('collegeCode').value = data.code || '';
}

async function saveCollege() {
  if (!state.college) return;
  const name = $('collegeName').value.trim();
  const code = $('collegeCode').value.trim();
  if (!name) { setNotice('College name is required.', 'error'); return; }
  
  const { error } = await supabase.from('colleges').update({ name, code: code || null }).eq('id', state.college.id);
  if (error) { setNotice('Failed to save: ' + error.message, 'error'); return; }
  setNotice('College information saved.', 'success');
}

async function loadDepartments() {
  if (!state.profile?.college_id) return;
  const { data, error } = await supabase.from('profiles')
    .select('department')
    .eq('college_id', state.profile.college_id)
    .not('department', 'is', null);
  
  if (error) { $('departmentList').innerHTML = '<p class="error">Failed to load departments.</p>'; return; }
  
  const depts = [...new Set((data || []).map(d => d.department).filter(Boolean))].sort();
  
  if (!depts.length) {
    $('departmentList').innerHTML = '<p class="empty">No departments found. Departments are populated when students and staff are assigned to this college.</p>';
    return;
  }
  
  $('departmentList').innerHTML = depts.map(d => `
    <div style="display: inline-block; background: rgba(255,255,255,0.05); padding: 8px 16px; border-radius: 8px; margin: 4px; font-weight: 600;">
      ${escapeHTML(d)}
    </div>
  `).join('');
}

async function loadStaff() {
  if (!state.profile?.college_id) return;
  const { data, error } = await supabase.from('safety_staff')
    .select('*, profile:profiles!profile_id(full_name, email, department)')
    .eq('college_id', state.profile.college_id);
  
  if (error) { $('staffList').innerHTML = '<p class="error">Failed to load staff.</p>'; return; }
  state.staffList = data || [];
  
  if (!state.staffList.length) {
    $('staffList').innerHTML = '<p class="empty">No safety staff configured for this college.</p>';
    return;
  }
  
  $('staffList').innerHTML = state.staffList.map(s => `
    <div class="staff-card">
      <div class="info">
        <p><strong>${escapeHTML(s.profile?.full_name || 'Unknown')}</strong></p>
        <p>${escapeHTML(s.profile?.email || '')}</p>
        <p>Department: ${escapeHTML(s.profile?.department || 'N/A')}</p>
        <span class="badge ${escapeHTML(s.staff_role)}">${escapeHTML(s.staff_role?.replace(/_/g, ' ').toUpperCase())}</span>
        ${s.availability ? ` · <span style="font-size:12px; color:${s.availability === 'AVAILABLE' ? 'var(--success)' : 'var(--text-muted)'};">${escapeHTML(s.availability)}</span>` : ''}
      </div>
      <div>
        <button class="btn btn-outline" style="font-size:12px; padding:6px 10px;" onclick="window.toggleStaff('${s.id}', ${!s.is_active})">${s.is_active ? 'Deactivate' : 'Activate'}</button>
      </div>
    </div>
  `).join('');
}

async function addStaff() {
  const email = $('newStaffEmail').value.trim();
  const role = $('newStaffRole').value;
  if (!email) { setNotice('Email is required.', 'error'); return; }
  
  // Find user by email
  const { data: profiles, error: pErr } = await supabase.from('profiles').select('id').eq('email', email).limit(1);
  if (pErr || !profiles?.length) { setNotice('User not found. They must register first.', 'error'); return; }
  
  const profileId = profiles[0].id;
  const { error } = await supabase.from('safety_staff').insert({
    profile_id: profileId,
    college_id: state.profile.college_id,
    staff_role: role,
    is_active: true
  });
  
  if (error) { setNotice('Failed: ' + error.message, 'error'); return; }
  setNotice(`Staff member added as ${role}.`, 'success');
  $('newStaffEmail').value = '';
  await loadStaff();
}

window.toggleStaff = async (staffId, active) => {
  const { error } = await supabase.from('safety_staff').update({ is_active: active }).eq('id', staffId);
  if (error) { setNotice('Failed: ' + error.message, 'error'); return; }
  await loadStaff();
};

async function loadContacts() {
  if (!state.profile?.college_id) return;
  const { data, error } = await supabase.from('safety_contacts')
    .select('*')
    .eq('college_id', state.profile.college_id)
    .order('created_at', { ascending: true });
  
  if (error) { $('contactList').innerHTML = '<p class="error">Failed to load contacts.</p>'; return; }
  state.contactList = data || [];
  
  if (!state.contactList.length) {
    $('contactList').innerHTML = '<p class="empty">No emergency contacts configured. Add official college contacts below.</p>';
    return;
  }
  
  $('contactList').innerHTML = state.contactList.map(c => `
    <div class="staff-card">
      <div class="info">
        <p><strong>${escapeHTML(c.name)}</strong></p>
        <p>Role: ${escapeHTML(c.contact_role)}</p>
        <p>${c.phone ? `Phone: ${escapeHTML(c.phone)}` : ''} ${c.email ? `· Email: ${escapeHTML(c.email)}` : ''}</p>
      </div>
      <div>
        <button class="btn btn-danger" style="font-size:12px; padding:6px 10px;" onclick="window.removeContact('${c.id}')">Remove</button>
      </div>
    </div>
  `).join('');
}

async function addContact() {
  const name = $('contactName').value.trim();
  const role = $('contactRole').value.trim();
  const phone = $('contactPhone').value.trim();
  const email = $('contactEmail').value.trim();
  
  if (!name || !role) { setNotice('Name and role are required.', 'error'); return; }
  if (!phone && !email) { setNotice('At least one contact method (phone or email) is required.', 'error'); return; }
  
  const { error } = await supabase.from('safety_contacts').insert({
    college_id: state.profile.college_id,
    name, contact_role: role, phone: phone || null, email: email || null, is_active: true
  });
  
  if (error) { setNotice('Failed: ' + error.message, 'error'); return; }
  setNotice('Emergency contact added.', 'success');
  $('contactName').value = '';
  $('contactRole').value = '';
  $('contactPhone').value = '';
  $('contactEmail').value = '';
  await loadContacts();
}

window.removeContact = async (id) => {
  if (!confirm('Remove this emergency contact?')) return;
  const { error } = await supabase.from('safety_contacts').delete().eq('id', id);
  if (error) { setNotice('Failed: ' + error.message, 'error'); return; }
  await loadContacts();
};

async function init() {
  const { data: { session } } = await supabase.auth.getSession();
  if (!session) { location.href = 'admin-login.html'; return; }
  state.user = session.user;
  
  const { data: profile } = await supabase.from('profiles').select('id, full_name, college_id, role').eq('id', session.user.id).single();
  state.profile = profile;
  
  // Only admin/faculty can configure
  if (!profile || !['admin', 'super_admin', 'faculty'].includes(profile.role)) {
    setNotice('You are not authorized to configure college settings.', 'error');
    return;
  }
  
  await Promise.all([loadCollege(), loadDepartments(), loadStaff(), loadContacts()]);
}

$('btnSaveCollege').addEventListener('click', saveCollege);
$('btnAddStaff').addEventListener('click', addStaff);
$('btnAddContact').addEventListener('click', addContact);

init();
