import fs from 'fs';
import path from 'path';

const projectDir = 'd:/ASKEXPERT';

// Scan all .html and .js files
function getAllFiles(dir, exts) {
  let files = [];
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const e of entries) {
    const full = path.join(dir, e.name);
    if (e.isDirectory()) {
      if (e.name !== 'node_modules' && e.name !== '.git' && e.name !== 'dist' && e.name !== 'scratch') {
        files = files.concat(getAllFiles(full, exts));
      }
    } else if (exts.some(ext => e.name.endsWith(ext))) {
      files.push(full);
    }
  }
  return files;
}

const targetFiles = getAllFiles(projectDir, ['.html', '.js']);
const tableQueries = {};

for (const file of targetFiles) {
  const content = fs.readFileSync(file, 'utf8');
  const relPath = path.relative(projectDir, file);

  // Match supabase.from("table")
  const matches = content.matchAll(/(?:supabase|sb)\s*\.\s*from\s*\(\s*["']([^"']+)["']\s*\)([\s\S]*?)(?=(?:supabase|sb|\n\s*\n|\bfunction\b|\bconst\b|\blet\b|\basync\b|\<\/script\>))/g);

  for (const m of matches) {
    const table = m[1];
    const chain = m[2];

    if (!tableQueries[table]) {
      tableQueries[table] = {
        files: new Set(),
        selects: new Set(),
        inserts: new Set(),
        updates: new Set(),
        eqs: new Set(),
        ins: new Set()
      };
    }
    tableQueries[table].files.add(relPath);

    // Extract .select("...")
    const selMatches = chain.matchAll(/\.select\s*\(\s*["']([^"']+)["']/g);
    for (const s of selMatches) tableQueries[table].selects.add(s[1]);

    // Extract .insert(...)
    const insMatches = chain.matchAll(/\.insert\s*\(\s*(\{[^}]+\}|\[[\s\S]*?\])/g);
    for (const ins of insMatches) tableQueries[table].inserts.add(ins[1].replace(/\s+/g, ' ').slice(0, 100));

    // Extract .update(...)
    const updMatches = chain.matchAll(/\.update\s*\(\s*(\{[^}]+\})/g);
    for (const u of updMatches) tableQueries[table].updates.add(u[1].replace(/\s+/g, ' ').slice(0, 100));

    // Extract .eq("col", ...)
    const eqMatches = chain.matchAll(/\.eq\s*\(\s*["']([^"']+)["']/g);
    for (const eq of eqMatches) tableQueries[table].eqs.add(eq[1]);
  }
}

console.log("=== ALL TABLES QUERIED IN CODE ===");
for (const [table, data] of Object.entries(tableQueries)) {
  console.log(`\nTABLE: [${table}] (used in ${data.files.size} files)`);
  console.log(`  Files: ${Array.from(data.files).join(', ')}`);
  if (data.selects.size) console.log(`  Select columns: ${Array.from(data.selects).join(' | ')}`);
  if (data.eqs.size) console.log(`  Filtered by (.eq): ${Array.from(data.eqs).join(', ')}`);
  if (data.updates.size) console.log(`  Updates: ${Array.from(data.updates).slice(0, 3).join(' | ')}`);
}
