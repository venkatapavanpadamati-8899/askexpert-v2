import { createClient } from '@supabase/supabase-js';

const supabase = createClient('https://girexuzrkeiylkbqglks.supabase.co', 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P');

async function checkCols() {
  console.log("--- PROFILES ---");
  const { data: p, error: pErr } = await supabase.from('profiles').select('*').limit(1);
  if (p && p.length > 0) {
    console.log("profiles cols:", Object.keys(p[0]));
    console.log("profiles sample:", p[0]);
  } else {
    console.log("profiles empty or error:", pErr);
  }

  console.log("--- ANSWERS ---");
  const { data: a, error: aErr } = await supabase.from('answers').select('*').limit(1);
  if (a && a.length > 0) {
    console.log("answers cols:", Object.keys(a[0]));
  } else {
    console.log("answers empty or error:", aErr);
  }

  console.log("--- QUESTIONS ---");
  const { data: q, error: qErr } = await supabase.from('questions').select('*').limit(1);
  if (q && q.length > 0) {
    console.log("questions cols:", Object.keys(q[0]));
    console.log("questions sample:", q[0]);
  } else {
    console.log("questions empty or error:", qErr);
  }

  console.log("--- PROFESSIONAL_VERIFICATIONS ---");
  const { data: pv, error: pvErr } = await supabase.from('professional_verifications').select('*').limit(1);
  if (pv && pv.length > 0) {
    console.log("pv cols:", Object.keys(pv[0]));
  } else {
    console.log("pv empty or error:", pvErr);
  }
}

checkCols();
