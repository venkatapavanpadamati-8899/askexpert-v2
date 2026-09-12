import fs from 'fs';

const PROD_BASE = 'https://askexpert-v2.vercel.app';

const routes = [
  '/',
  '/index.html',
  '/login',
  '/login.html',
  '/register.html',
  '/admin-login.html',
  '/admin-dashboard.html',
  '/experts',
  '/experts.html',
  '/professional-verification.html',
  '/chat.html',
  '/question-details.html',
  '/user-dashboard.html',
  '/professional-dashboard.html',
  '/questions.html',
  '/payments.html'
];

async function checkRoutes() {
  console.log('--- CHECKING PRODUCTION ROUTES ---');
  const results = [];
  for (const r of routes) {
    const url = `${PROD_BASE}${r}`;
    try {
      const res = await fetch(url);
      const text = await res.text();
      const titleMatch = text.match(/<title>([^<]+)<\/title>/i);
      const title = titleMatch ? titleMatch[1].trim() : 'No title';
      results.push({ route: r, status: res.status, ok: res.ok, title, len: text.length });
      console.log(`[${res.status}] ${r.padEnd(35)} -> "${title}" (${text.length} bytes)`);
    } catch (err) {
      results.push({ route: r, status: 'ERROR', error: err.message });
      console.log(`[ERR] ${r.padEnd(35)} -> ${err.message}`);
    }
  }
  return results;
}

checkRoutes();
