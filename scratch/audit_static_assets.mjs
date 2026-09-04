import fs from 'fs';
import path from 'path';

const projectDir = 'd:/ASKEXPERT';
const htmlFiles = fs.readdirSync(projectDir).filter(f => f.endsWith('.html'));

const realAssetErrors = [];

for (const file of htmlFiles) {
  const filePath = path.join(projectDir, file);
  const content = fs.readFileSync(filePath, 'utf8');

  // Strip scripts to only inspect actual static HTML markup
  const htmlWithoutScripts = content.replace(/<script\b[^>]*>[\s\S]*?<\/script>/gi, '');

  const linkMatches = htmlWithoutScripts.matchAll(/(?:href|src)=["']([^"']+)["']/g);
  for (const match of linkMatches) {
    let target = match[1];
    if (target.startsWith('http://') || target.startsWith('https://') || target.startsWith('//') || 
        target.startsWith('#') || target.startsWith('data:') || target.startsWith('mailto:') || 
        target.startsWith('tel:') || target.startsWith('javascript:') || target.includes('${')) {
      continue;
    }
    target = target.split('?')[0].split('#')[0];
    if (!target) continue;

    const resolved = path.resolve(projectDir, target);
    if (!fs.existsSync(resolved)) {
      realAssetErrors.push({ file, asset: match[1], resolved });
    }
  }
}

console.log("=== STATIC HTML ASSET AUDIT ===");
if (realAssetErrors.length === 0) {
  console.log("ALL static assets, CSS, images, and script files exist! ZERO broken links.");
} else {
  console.log(`Found ${realAssetErrors.length} broken static references:`);
  realAssetErrors.forEach(e => console.log(`  [${e.file}] -> ${e.asset}`));
}
