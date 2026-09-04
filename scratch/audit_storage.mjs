import fs from 'fs';
import path from 'path';

const projectDir = 'd:/ASKEXPERT';
const htmlFiles = fs.readdirSync(projectDir).filter(f => f.endsWith('.html'));

const storageUsages = [];

for (const file of htmlFiles) {
  const filePath = path.join(projectDir, file);
  const content = fs.readFileSync(filePath, 'utf8');

  const matches = content.matchAll(/(?:localStorage|sessionStorage)\.(?:getItem|setItem|removeItem)\s*\(\s*["']([^"']+)["']/g);
  for (const m of matches) {
    storageUsages.push({ file, key: m[1], type: m[0].startsWith('local') ? 'local' : 'session' });
  }
}

// Group by key
const byKey = {};
for (const u of storageUsages) {
  if (!byKey[u.key]) byKey[u.key] = { type: u.type, files: new Set() };
  byKey[u.key].files.add(u.file);
}

console.log("=== STORAGE KEYS AUDIT ===");
for (const [key, val] of Object.entries(byKey)) {
  console.log(`[${val.type}] "${key}": used in ${Array.from(val.files).join(', ')}`);
}
