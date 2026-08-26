import fs from 'fs';
import path from 'path';

console.log("=================================================================");
console.log("     ASKEXPERT FINAL PRODUCTION READINESS & CODEBASE SCANNER      ");
console.log("=================================================================\n");

const rootDir = "d:/ASKEXPERT";
const extensions = [".html", ".js", ".ts", ".sql", ".json"];

let totalFilesChecked = 0;
let todoList = [];
let fixmeList = [];
let consoleLogCount = 0;
let secretsExposed = [];
let mockBypassesFound = [];

function scanDirectory(dir) {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const fullPath = path.join(dir, file);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      if (!fullPath.includes("node_modules") && !fullPath.includes(".git") && !fullPath.includes("dist") && !fullPath.includes("scratch")) {
        scanDirectory(fullPath);
      }
    } else if (extensions.includes(path.extname(fullPath))) {
      totalFilesChecked++;
      const content = fs.readFileSync(fullPath, "utf8");
      const relativePath = path.relative(rootDir, fullPath);

      // 1. Scan TODO
      if (content.includes("TODO:")) {
        const matches = content.match(/TODO:.*$/gm) || [];
        matches.forEach(m => todoList.push({ file: relativePath, item: m.trim() }));
      }

      // 2. Scan FIXME
      if (content.includes("FIXME:")) {
        const matches = content.match(/FIXME:.*$/gm) || [];
        matches.forEach(m => fixmeList.push({ file: relativePath, item: m.trim() }));
      }

      // 3. Scan console.log in JS/TS/HTML
      if (file.endsWith(".js") || file.endsWith(".ts") || file.endsWith(".html")) {
        const logs = (content.match(/console\.log/g) || []).length;
        consoleLogCount += logs;
      }

      // 4. Scan secret exposure
      if (content.includes("SUPABASE_SERVICE_ROLE_KEY") && !fullPath.includes("supabase/functions") && !fullPath.includes("supabase-security.sql")) {
        secretsExposed.push(relativePath);
      }

      // 5. Scan auth/payment mock bypasses
      if (content.includes('email.includes("admin")') || content.includes('askexpert_admin_auth')) {
        mockBypassesFound.push(relativePath);
      }
    }
  }
}

scanDirectory(rootDir);

console.log(`Total Files Inspected: ${totalFilesChecked}`);
console.log(`TODO items found: ${todoList.length}`);
console.log(`FIXME items found: ${fixmeList.length}`);
console.log(`console.log occurrences: ${consoleLogCount}`);
console.log(`Exposed secrets in client code: ${secretsExposed.length}`);
console.log(`Auth/Payment mock bypasses: ${mockBypassesFound.length}\n`);

if (todoList.length > 0) {
  console.log("--- TODO Items ---");
  todoList.slice(0, 5).forEach(t => console.log(`  ${t.file}: ${t.item}`));
}
if (secretsExposed.length > 0) {
  console.log("--- Exposed Secrets ---");
  secretsExposed.forEach(s => console.log(`  ${s}`));
}
if (mockBypassesFound.length > 0) {
  console.log("--- Mock Bypasses ---");
  mockBypassesFound.forEach(m => console.log(`  ${m}`));
}
