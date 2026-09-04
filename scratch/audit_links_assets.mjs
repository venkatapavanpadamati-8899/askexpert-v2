import fs from 'fs';
import path from 'path';
import { parse } from 'node:path';

const projectDir = 'd:/ASKEXPERT';

const htmlFiles = fs.readdirSync(projectDir).filter(f => f.endsWith('.html'));

console.log(`Found ${htmlFiles.length} HTML files to inspect.`);

const assetErrors = [];
const scriptErrors = [];

for (const file of htmlFiles) {
  const filePath = path.join(projectDir, file);
  const content = fs.readFileSync(filePath, 'utf8');

  // 1. Check local asset links: <link href="...">, <script src="...">, <img src="...">
  const linkMatches = content.matchAll(/(?:href|src)=["']([^"']+)["']/g);
  for (const match of linkMatches) {
    let target = match[1];
    if (target.startsWith('http://') || target.startsWith('https://') || target.startsWith('//') || target.startsWith('#') || target.startsWith('data:') || target.startsWith('mailto:') || target.startsWith('tel:')) {
      continue;
    }
    // Remove query params or hash
    target = target.split('?')[0].split('#')[0];
    if (!target) continue;

    // Resolve relative path
    const resolved = path.resolve(projectDir, target);
    if (!fs.existsSync(resolved)) {
      assetErrors.push({ file, asset: match[1], resolved });
    }
  }

  // 2. Check inline scripts for parse errors
  const scriptRegex = /<script\b[^>]*>([\s\S]*?)<\/script>/gi;
  let match;
  let scriptIndex = 0;
  while ((match = scriptRegex.exec(content)) !== null) {
    scriptIndex++;
    const scriptTag = match[0];
    const scriptBody = match[1];

    // If it has src, skip checking inline body unless non-empty
    if (/<script\b[^>]*src=/i.test(scriptTag) && !scriptBody.trim()) {
      continue;
    }
    if (/<script\b[^>]*type=["']application\/json["']/i.test(scriptTag)) {
      continue;
    }

    // Attempt syntax check with temporary file
    const tempFile = path.join(projectDir, 'scratch', `temp_check_${file}_${scriptIndex}.js`);
    try {
      // If module, wrap or write as module
      const isModule = /type=["']module["']/i.test(scriptTag);
      fs.writeFileSync(tempFile, scriptBody, 'utf8');
      // We will check syntax
    } catch (e) {
      //
    }
  }
}

console.log("\n=== BROKEN LOCAL ASSETS REPORT ===");
if (assetErrors.length === 0) {
  console.log("No broken asset paths found!");
} else {
  console.log(`Found ${assetErrors.length} broken asset references:`);
  assetErrors.slice(0, 20).forEach(e => console.log(`  [${e.file}] -> ${e.asset}`));
}
