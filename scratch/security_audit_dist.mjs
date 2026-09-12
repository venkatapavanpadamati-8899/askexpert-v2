import fs from 'fs';
import path from 'path';

const DIST = path.resolve('dist');

const forbiddenPatterns = [
  { name: 'service_role key pattern', regex: /eyJhbGciOi[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+/g, filter: (t) => t.includes('service_role') },
  { name: 'Supabase secret keyword', regex: /SUPABASE_SERVICE_ROLE_KEY/gi },
  { name: 'Razorpay secret keyword', regex: /RAZORPAY_KEY_SECRET/gi },
  { name: 'Razorpay webhook secret keyword', regex: /RAZORPAY_WEBHOOK_SECRET/gi },
  { name: 'Daily API secret keyword', regex: /DAILY_API_KEY/gi },
  { name: 'Hardcoded passwords', regex: /(?:password|passwd|pwd)\s*[:=]\s*['"][^'"]{8,}['"]/gi, filter: (t) => !t.includes('Password') && !t.includes('type=') },
  { name: '12-digit Aadhaar number literal', regex: /\b[2-9]\d{3}\s?\d{4}\s?\d{4}\b/g, filter: (t) => !t.includes('0000') },
  { name: 'Fake verification claims', regex: /(?:100%\s*genuine|100%\s*authentic|Government\s*verified|Officially\s*verified)/gi },
  { name: 'preview=true in production links', regex: /preview=true/gi },
  { name: 'Client-side admin approval bypass', regex: /admin_review_professional_verification\s*\(\s*[^)]*approved[^)]*\)/gi },
  { name: 'Direct client wallet credit', regex: /wallet_balance\s*=\s*wallet_balance\s*\+/gi }
];

function scanFiles(dir) {
  let findings = [];
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      findings = findings.concat(scanFiles(fullPath));
    } else if (entry.isFile() && (entry.name.endsWith('.js') || entry.name.endsWith('.html') || entry.name.endsWith('.css'))) {
      const content = fs.readFileSync(fullPath, 'utf8');
      for (const rule of forbiddenPatterns) {
        const matches = content.match(rule.regex);
        if (matches) {
          const validMatches = rule.filter ? matches.filter(rule.filter) : matches;
          if (validMatches.length > 0) {
            findings.push({
              file: path.relative(DIST, fullPath),
              rule: rule.name,
              matches: validMatches.slice(0, 3)
            });
          }
        }
      }
    }
  }
  return findings;
}

const results = scanFiles(DIST);
console.log('=== PRODUCTION BUILD SECURITY AUDIT RESULTS ===');
if (results.length === 0) {
  console.log('PASS: ZERO critical/high security findings detected in dist/ !');
} else {
  console.log(`WARNING: ${results.length} findings detected:`);
  console.log(JSON.stringify(results, null, 2));
}
