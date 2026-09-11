import fs from 'node:fs';
import { createClient } from '@supabase/supabase-js';

console.log('====================================================');
console.log('ASKEXPERT LOGIN DOM & RUNTIME SIMULATION TEST');
console.log('====================================================\n');

const SUPABASE_URL = 'https://girexuzrkeiylkbqglks.supabase.co';
const SUPABASE_ANON_KEY = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Mock browser storage and environment
const mockStorage = {
  session: {},
  local: {},
  setItem(store, k, v) { this[store][k] = String(v); },
  getItem(store, k) { return this[store][k] || null; },
  removeItem(store, k) { delete this[store][k]; },
  clear(store) { this[store] = {}; }
};

let locationReplacedWith = null;
const mockLocation = {
  search: '',
  replace(url) { locationReplacedWith = url; },
  href: 'http://localhost:5174/login.html'
};

// Simulate executeLogin logic with real Supabase call
async function simulateExecuteLogin(emailOrUsername, password) {
  locationReplacedWith = null;
  const rawInput = (emailOrUsername || "").trim();
  let targetEmail = rawInput.toLowerCase();
  let targetPassword = password;

  if (!targetEmail.includes("@")) {
    const { data: profile } = await supabase
      .from("profiles")
      .select("email, role")
      .ilike("username", targetEmail)
      .maybeSingle();

    if (profile && profile.email) {
      targetEmail = profile.email.toLowerCase();
    } else {
      throw new Error("No account found with this username. Please check your username or sign in with your email.");
    }
  }

  const { data, error } = await supabase.auth.signInWithPassword({
    email: targetEmail,
    password: targetPassword
  });

  if (error) {
    if (error.message && error.message.includes("Invalid login credentials")) {
      throw new Error("Invalid email or password. Please check your credentials.");
    }
    throw error;
  }

  // Authoritative profile check
  const { data: userProfile } = await supabase
    .from("profiles")
    .select("id, role, is_verified, account_status, is_blocked")
    .eq("id", data.user.id)
    .maybeSingle();

  if (userProfile?.account_status === "suspended" || userProfile?.account_status === "blocked" || userProfile?.is_blocked === true) {
    await supabase.auth.signOut();
    throw new Error("Your account has been suspended or restricted. Please contact support.");
  }

  const trustedRole = userProfile?.role || "user";
  mockStorage.setItem('session', 'askexpert_user_role', trustedRole);

  if (trustedRole === "admin") {
    mockLocation.replace("admin-dashboard.html");
  } else if (trustedRole === "expert" || trustedRole === "professional") {
    mockLocation.replace(userProfile?.is_verified ? "professional-dashboard.html" : "professional-verification.html");
  } else {
    mockLocation.replace("user-dashboard.html");
  }
}

// Test 1: Simulating login with raw "admin" and "admin" password
console.log('Testing: Login attempt with "admin" and "admin" password...');
try {
  await simulateExecuteLogin('admin', 'admin');
  console.error('❌ FAIL: Login should have thrown an error!');
  process.exit(1);
} catch (err) {
  const adminRoleSet = mockStorage.getItem('session', 'askexpert_user_role') === 'admin';
  const redirectedToAdmin = locationReplacedWith === 'admin-dashboard.html';
  if (!adminRoleSet && !redirectedToAdmin) {
    console.log('✓ PASS: Login failed as expected:', err.message);
    console.log('✓ PASS: No admin role assigned in storage, no admin redirect occurred.');
  } else {
    console.error('❌ FAIL: Admin bypass detected!');
    process.exit(1);
  }
}

// Test 2: Simulating login with old shortcut "admin.audit@askexpert.com" and arbitrary password
console.log('\nTesting: Login attempt with "admin.audit@askexpert.com" and "badpassword"...');
try {
  await simulateExecuteLogin('admin.audit@askexpert.com', 'badpassword');
  console.error('❌ FAIL: Should have failed auth!');
  process.exit(1);
} catch (err) {
  const adminRoleSet = mockStorage.getItem('session', 'askexpert_user_role') === 'admin';
  const redirectedToAdmin = locationReplacedWith === 'admin-dashboard.html';
  if (!adminRoleSet && !redirectedToAdmin) {
    console.log('✓ PASS: Rejected by Supabase:', err.message);
    console.log('✓ PASS: Zero unauthorized redirects or privileges granted.');
  } else {
    console.error('❌ FAIL: Unauthorized admin redirect occurred!');
    process.exit(1);
  }
}

console.log('\n====================================================');
console.log('ALL SIMULATED SECURITY FLOWS VERIFIED SUCCESSFULLY!');
console.log('====================================================\n');
