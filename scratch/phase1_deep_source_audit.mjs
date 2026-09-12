// scratch/phase1_deep_source_audit.mjs
import fs from 'fs';
import path from 'path';

const ROOT = path.resolve('.');
const SRC_EXTS = ['.html', '.js', '.mjs', '.ts', '.css'];
const IGNORE_DIRS = ['node_modules', '.git', 'scratch', '.vscode', '.temp'];

let allFiles = [];

function walk(dir) {
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    if (IGNORE_DIRS.includes(entry.name)) continue;
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      walk(full);
    } else if (SRC_EXTS.includes(path.extname(entry.name))) {
      allFiles.push(full);
    }
  }
}

walk(ROOT);

console.log(`Found ${allFiles.length} source & dist files to audit.`);

const findings = {
  serviceRoleInFrontend: [],
  hardcodedSecrets: [],
  adminBypasses: [],
  localStorageAdminProof: [],
  emptyCatchBlocks: [],
  todoFixme: [],
  brokenLocalAssetLinks: [],
  brokenInternalHrefLinks: []
};

// Check asset references in html files
const htmlFiles = allFiles.filter(f => f.endsWith('.html') && !f.includes(`${path.sep}dist${path.sep}`));

for (const htmlFile of htmlFiles) {
  const content = fs.readFileSync(htmlFile, 'utf8');
  const relPath = path.relative(ROOT, htmlFile);

  // Check local hrefs and srcs
  const srcMatches = [...content.matchAll(/(?:src|href)=["']([^"':#?]+)["']/g)];
  for (const match of srcMatches) {
    const target = match[1];
    if (target.startsWith('http') || target.startsWith('mailto:') || target.startsWith('tel:') || target.startsWith('data:') || target.startsWith('blob:')) continue;
    
    // Resolve target relative to htmlFile or ROOT
    let resolved = path.resolve(path.dirname(htmlFile), target);
    let resolvedRoot = path.resolve(ROOT, target.startsWith('/') ? target.slice(1) : target);

    if (!fs.existsSync(resolved) && !fs.existsSync(resolvedRoot)) {
      // Could it be a route that Vite or cleanUrls handles, like /login or /admin-dashboard?
      const asHtml = resolvedRoot + '.html';
      if (!fs.existsSync(asHtml)) {
        findings.brokenInternalHrefLinks.push({ file: relPath, link: target });
      }
    }
  }
}

// Audit all non-dist JS/HTML files for security & code quality
const nonDistFiles = allFiles.filter(f => !f.includes(`${path.sep}dist${path.sep}`));

for (const file of nonDistFiles) {
  const content = fs.readFileSync(file, 'utf8');
  const relPath = path.relative(ROOT, file);

  // Service role key in frontend
  if (/service_role|eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9\.[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+/g.test(content)) {
    if (!relPath.startsWith(`supabase${path.sep}functions`)) {
      findings.serviceRoleInFrontend.push({ file: relPath });
    }
  }

  // Hardcoded passwords
  if (/password\s*===\s*["'][^"']+["']/i.test(content) || /admin123|Pavan@123/i.test(content)) {
    // Check if it's in demo OTP comments or scratch
    findings.hardcodedSecrets.push({ file: relPath });
  }

  // Admin bypass
  if (/localStorage\.getItem\(["']isAdmin["']\)|sessionStorage\.getItem\(["']isAdmin["']\)/i.test(content)) {
    findings.adminBypasses.push({ file: relPath });
  }

  // Empty catch
  if (/catch\s*\([^)]*\)\s*\{\s*\}/g.test(content)) {
    findings.emptyCatchBlocks.push({ file: relPath });
  }

  // TODO / FIXME
  const lines = content.split('\n');
  lines.forEach((line, idx) => {
    if (/(TODO|FIXME):?/i.test(line) && !line.includes('// scratch')) {
      findings.todoFixme.push({ file: relPath, line: idx + 1, text: line.trim() });
    }
  });
}

console.log('--- AUDIT RESULTS ---');
console.log('Service role keys in frontend:', findings.serviceRoleInFrontend.length);
console.log('Hardcoded secrets/passwords:', findings.hardcodedSecrets.length, findings.hardcodedSecrets);
console.log('Admin bypasses via storage:', findings.adminBypasses.length);
console.log('Empty catch blocks:', findings.emptyCatchBlocks.length);
console.log('TODO / FIXME items:', findings.todoFixme.length);
console.log('Broken internal href/src links:', findings.brokenInternalHrefLinks.length, findings.brokenInternalHrefLinks);

fs.writeFileSync('scratch/phase1_findings.json', JSON.stringify(findings, null, 2));
