const BASE = 'https://girexuzrkeiylkbqglks.supabase.co/functions/v1';
const ANON = 'sb_publishable_KryT6X0fLpvKJdSbUx3HpA_nkZYr98P';

const funcs = [
  'payment-create',
  'payment-verify',
  'payment-webhook',
  'process-payout',
  'process-refund',
  'resolve-dispute',
  'session-dispute',
  'session-end',
  'session-start',
  'start-identity-verification',
  'verify-identity-otp',
  'video-room'
];

async function checkEdgeFunctions() {
  console.log('=== CHECKING DEPLOYED EDGE FUNCTIONS ===');
  for (const fn of funcs) {
    const url = `${BASE}/${fn}`;
    try {
      // Send OPTIONS to check CORS / deployment
      const optRes = await fetch(url, {
        method: 'OPTIONS',
        headers: {
          'apikey': ANON
        }
      });
      // Send GET / POST to check response
      const postRes = await fetch(url, {
        method: 'POST',
        headers: {
          'apikey': ANON,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
      });
      const postText = await postRes.text();
      console.log(`[${postRes.status}] ${fn.padEnd(30)} -> OPTIONS:${optRes.status} | POST:${postRes.status} -> ${postText.slice(0, 100)}`);
    } catch (err) {
      console.log(`[ERR] ${fn.padEnd(30)} -> ${err.message}`);
    }
  }
}

checkEdgeFunctions();
