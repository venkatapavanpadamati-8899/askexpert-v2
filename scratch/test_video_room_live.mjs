import fs from 'fs';

async function runLiveTest() {
  const envFile = fs.readFileSync('.env', 'utf8').split('\n');
  const supabaseUrl = envFile.find(l => l.startsWith('VITE_SUPABASE_URL'))?.split('=')[1]?.trim();
  const anonKey = envFile.find(l => l.startsWith('VITE_SUPABASE_ANON_KEY'))?.split('=')[1]?.trim();

  if (!supabaseUrl || !anonKey) {
    console.error("Missing SUPABASE URL or ANON KEY in .env");
    process.exit(1);
  }

  console.log("=== STARTING LIVE VIDEO ROOM TEST ===");

  // 1. Seed data using test-helper edge function
  console.log("1. Seeding test data...");
  const seedRes = await fetch(`${supabaseUrl}/functions/v1/test-helper`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${anonKey}` },
    body: JSON.stringify({ action: 'seed' })
  });

  if (!seedRes.ok) {
    console.error("Failed to seed data", await seedRes.text());
    process.exit(1);
  }

  const seedData = await seedRes.json();
  console.log("Seed successful:", seedData);

  // 2. Login as user to get token
  console.log("2. Logging in as seeded user...");
  const loginRes = await fetch(`${supabaseUrl}/auth/v1/token?grant_type=password`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'apikey': anonKey },
    body: JSON.stringify({ email: seedData.userEmail, password: 'Password123!' })
  });
  
  if (!loginRes.ok) {
    console.error("Login failed", await loginRes.text());
    // Cleanup
    await fetch(`${supabaseUrl}/functions/v1/test-helper`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${anonKey}` },
      body: JSON.stringify({ action: 'cleanup', ...seedData })
    });
    process.exit(1);
  }

  const loginData = await loginRes.json();
  const token = loginData.access_token;

  // 3. Call video-room Edge Function
  console.log(`3. Invoking video-room function for session ${seedData.sessionId}...`);
  const videoRes = await fetch(`${supabaseUrl}/functions/v1/video-room`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` },
    body: JSON.stringify({ session_id: seedData.sessionId, mode: 'video' })
  });

  const videoStatus = videoRes.status;
  const videoBody = await videoRes.text();

  console.log("Video Room Response:", videoStatus);
  console.log(videoBody);

  // 4. Cleanup
  console.log("4. Cleaning up test data...");
  await fetch(`${supabaseUrl}/functions/v1/test-helper`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${anonKey}` },
    body: JSON.stringify({ action: 'cleanup', ...seedData })
  });

  if (videoStatus === 200 && videoBody.includes('room_url') && videoBody.includes('token')) {
    console.log("✅ LIVE VIDEO ROOM TEST PASSED!");
    process.exit(0);
  } else {
    console.log("❌ LIVE VIDEO ROOM TEST FAILED!");
    process.exit(1);
  }
}

runLiveTest();
