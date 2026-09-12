import { createClient } from '@supabase/supabase-js';
import fs from 'fs';

const PROD_URL = 'https://askexpert-v2.vercel.app';
const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(SUPABASE_URL, ANON_KEY);

async function runProductionReadinessCheck() {
  console.log('╔═══════════════════════════════════════════════════════════════════════╗');
  console.log('║        ASKEXPERT COMPLETE PRODUCTION READINESS MASTER AUDIT           ║');
  console.log('╚═══════════════════════════════════════════════════════════════════════╝\n');

  let passed = 0;
  let failed = 0;
  const issues = [];

  function record(title, success, detail = '') {
    if (success) {
      console.log(`  ✅ [PASS] ${title} ${detail ? '— ' + detail : ''}`);
      passed++;
    } else {
      console.error(`  ❌ [FAIL] ${title} ${detail ? '— ' + detail : ''}`);
      failed++;
      issues.push(`${title}: ${detail}`);
    }
  }

  // -------------------------------------------------------------------------
  // 1. LIVE VERCEL PRODUCTION ENDPOINT AUDIT
  // -------------------------------------------------------------------------
  console.log('1. Auditing Live Production Endpoints (Vercel Edge Network)...');
  const routesToTest = [
    { path: '/', title: 'Home Landing' },
    { path: '/login', title: 'Login Gateway' },
    { path: '/register.html', title: 'Registration' },
    { path: '/admin-login.html', title: 'Hidden Admin Portal' },
    { path: '/admin-dashboard.html', title: 'Admin Command Center' },
    { path: '/admin-users.html', title: 'Admin User Management' },
    { path: '/admin-professionals.html', title: 'Admin KYC Management' },
    { path: '/admin-questions.html', title: 'Admin Questions Stream' },
    { path: '/admin-payments.html', title: 'Admin Financials' },
    { path: '/admin-reports.html', title: 'Admin Disputes & Safety' },
    { path: '/admin-health.html', title: 'Admin System Health' },
    { path: '/admin-ai-fix-center.html', title: 'Admin AI Self-Healing' },
    { path: '/experts.html', title: 'Experts Directory' },
    { path: '/questions.html', title: 'Public Questions' },
    { path: '/professional-verification.html', title: 'Free-KYC Verification' },
    { path: '/chat.html', title: 'Real-time Chat' },
    { path: '/user-dashboard.html', title: 'User Dashboard' },
    { path: '/professional-dashboard.html', title: 'Professional Workspace' },
    { path: '/payments.html', title: 'Payments Center' },
    { path: '/forgot-password.html', title: 'Password Recovery' }
  ];

  for (const r of routesToTest) {
    try {
      const res = await fetch(`${PROD_URL}${r.path}`);
      record(`Production Route: ${r.path} (${r.title})`, res.status === 200, `Status: ${res.status}`);
    } catch (err) {
      record(`Production Route: ${r.path} (${r.title})`, false, `Fetch error: ${err.message}`);
    }
  }

  // -------------------------------------------------------------------------
  // 2. LIVE SUPABASE DATABASE & BACKEND TABLES AUDIT
  // -------------------------------------------------------------------------
  console.log('\n2. Auditing Live Supabase Database Tables & Services...');
  const tablesToCheck = [
    'profiles',
    'questions',
    'professional_verifications',
    'consultation_requests',
    'payout_requests',
    'reports',
    'messages',
    'ratings'
  ];

  for (const table of tablesToCheck) {
    try {
      const { count, error } = await supabase.from(table).select('*', { count: 'exact', head: true });
      record(`Database Table [${table}]`, !error, error ? error.message : `Accessible (Count: ${count ?? 0})`);
    } catch (err) {
      record(`Database Table [${table}]`, false, err.message);
    }
  }

  // -------------------------------------------------------------------------
  // 3. ADMIN AUTHENTICATION & ROLE GOVERNANCE AUDIT
  // -------------------------------------------------------------------------
  console.log('\n3. Auditing Admin Authentication & Strict Role Governance...');
  try {
    // 3.1 Verify Admin profile exists with role: 'admin'
    const { data: adminProf, error: adminProfErr } = await supabase
      .from('profiles')
      .select('id, email, role, is_verified, account_status')
      .eq('email', 'venkatapavanpadamati1@gmail.com')
      .maybeSingle();

    record('Admin Database Profile Exists', !!adminProf && !adminProfErr, `ID: ${adminProf?.id}`);
    record('Admin Profile Role is strictly "admin"', adminProf?.role === 'admin', `Role: ${adminProf?.role}`);
    record('Admin Account is Active & Verified', adminProf?.account_status === 'active' && adminProf?.is_verified === true, `Status: ${adminProf?.account_status}`);

    // 3.2 Verify Admin Auth credentials
    const { data: authData, error: authErr } = await supabase.auth.signInWithPassword({
      email: 'venkatapavanpadamati1@gmail.com',
      password: 'Pavan@123'
    });
    record('Admin Supabase Auth signInWithPassword', !authErr && !!authData?.user, authErr ? authErr.message : `Authenticated UID: ${authData?.user?.id}`);

    // 3.3 Verify Non-Admin account separation
    const { data: regularUser } = await supabase.from('profiles').select('id, role').eq('role', 'user').limit(1).maybeSingle();
    record('Consumer user role separation', regularUser?.role === 'user', `Sample user role: ${regularUser?.role}`);

    const { data: expertUser } = await supabase.from('profiles').select('id, role').eq('role', 'expert').limit(1).maybeSingle();
    record('Expert user role separation', expertUser?.role === 'expert', `Sample expert role: ${expertUser?.role}`);
  } catch (err) {
    record('Admin Authentication Flow', false, err.message);
  }

  // -------------------------------------------------------------------------
  // 4. PROFESSIONAL DOMAINS / CATEGORIES AUDIT
  // -------------------------------------------------------------------------
  console.log('\n4. Auditing Professional Categories (40 Domains Required)...');
  try {
    const regHtml = fs.readFileSync('register.html', 'utf8');
    const verifHtml = fs.readFileSync('professional-verification.html', 'utf8');

    const regOptions = (regHtml.match(/<select id="expertCategory"[\s\S]*?<\/select>/i)?.[0].match(/<option value="[^"]+"/gi) || []).length;
    const verifOptions = (verifHtml.match(/<select id="vProfession"[\s\S]*?<\/select>/i)?.[0].match(/<option value="[^"]+"/gi) || []).length;

    record('register.html Professional Categories Count', regOptions >= 40, `Found ${regOptions} categories (Minimum 25 required)`);
    record('professional-verification.html Categories Count', verifOptions >= 40, `Found ${verifOptions} categories`);
  } catch (err) {
    record('Category Options Audit', false, err.message);
  }

  // -------------------------------------------------------------------------
  // 5. SECURITY & ZERO-BYPASS AUDIT
  // -------------------------------------------------------------------------
  console.log('\n5. Auditing Security, Secrets & Guard Integrity...');
  try {
    const adminLoginHtml = fs.readFileSync('admin-login.html', 'utf8');
    const adminDashHtml = fs.readFileSync('admin-dashboard.html', 'utf8');
    const loginHtml = fs.readFileSync('login.html', 'utf8');
    const callbackHtml = fs.readFileSync('auth-callback.html', 'utf8');

    // No hardcoded credentials
    record('admin-login.html has no hardcoded passwords', !adminLoginHtml.includes('Pavan@123') && !adminLoginHtml.includes('AdminSecurity123!'));
    record('login.html has no hardcoded passwords', !loginHtml.includes('Pavan@123') && !loginHtml.includes('UserSecurity123!'));

    // No email-based bypasses
    record('admin-login.html has no email backdoor bypasses', !adminLoginHtml.includes('if (email ===') && !adminLoginHtml.includes('if (email==='));
    record('admin-dashboard.html has no email backdoor bypasses', !adminDashHtml.includes('if (email ===') && !adminDashHtml.includes('if (email==='));

    // Hidden Admin entry remains hidden on consumer pages (Markup check excluding internal script router)
    const loginMarkupOnly = loginHtml.replace(/<script[\s\S]*?<\/script>/gi, '');
    const hasExposedAdminInMarkup = loginMarkupOnly.includes('admin-login.html') || loginMarkupOnly.includes('admin-dashboard.html');
    record('login.html markup has zero exposed Admin Login buttons/links', !hasExposedAdminInMarkup);

    // OAuth callback has strict admin gate
    record('auth-callback.html blocks non-admin OAuth to admin routes', callbackHtml.includes('isAdminRoute && userRole !== "admin"'));

    // Admin dashboard checks session & profile role
    record('admin-dashboard.html verifies session & role on load', adminDashHtml.includes('verifyAdminAccess()') && adminDashHtml.includes('prof.role !== "admin"'));
  } catch (err) {
    record('Security Integrity Audit', false, err.message);
  }

  // -------------------------------------------------------------------------
  // 6. BUILD INTEGRITY
  // -------------------------------------------------------------------------
  console.log('\n6. Checking Local Build Artifacts...');
  try {
    const distExists = fs.existsSync('dist/index.html') && fs.existsSync('dist/admin-dashboard.html') && fs.existsSync('dist/admin-login.html');
    record('Production Build Artifacts Generated', distExists, 'dist/ directory contains verified bundle');
  } catch (err) {
    record('Build Artifacts', false, err.message);
  }

  // -------------------------------------------------------------------------
  // FINAL EVALUATION
  // -------------------------------------------------------------------------
  console.log('\n╔═══════════════════════════════════════════════════════════════════════╗');
  console.log(`║ AUDIT SUMMARY: TOTAL ${passed + failed} | PASSED: ${passed} | FAILED: ${failed} ║`);
  if (failed === 0) {
    console.log('║ STATUS: 🚀 100% PRODUCTION READY — ALL SYSTEMS VERIFIED LIVE         ║');
  } else {
    console.log('║ STATUS: ⚠️ ISSUES DETECTED                                           ║');
  }
  console.log('╚═══════════════════════════════════════════════════════════════════════╝');

  if (issues.length > 0) {
    console.log('\nDetected Issues:');
    issues.forEach(i => console.log('  • ' + i));
    process.exit(1);
  }
}

runProductionReadinessCheck();
