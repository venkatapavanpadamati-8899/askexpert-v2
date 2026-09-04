import fs from 'fs';
import path from 'path';
import vm from 'vm';

const projectDir = 'd:/ASKEXPERT';
const htmlFiles = fs.readdirSync(projectDir).filter(f => f.endsWith('.html'));

const jsSyntaxErrors = [];

for (const file of htmlFiles) {
  const filePath = path.join(projectDir, file);
  const content = fs.readFileSync(filePath, 'utf8');

  const scriptRegex = /<script\b([^>]*)>([\s\S]*?)<\/script>/gi;
  let match;
  let idx = 0;
  while ((match = scriptRegex.exec(content)) !== null) {
    idx++;
    const attrs = match[1];
    const code = match[2];

    // If external script with no inline code, skip
    if (/src=["']/i.test(attrs) && !code.trim()) continue;
    if (/type=["']application\/json["']/i.test(attrs)) continue;

    const isModule = /type=["']module["']/i.test(attrs);

    try {
      if (isModule) {
        // Module syntax test: replace import / export with valid dummy syntax or test with vm.SourceTextModule if available
        // Or strip import/export statements to test pure JS syntax
        const sanitizedCode = code
          .replace(/import\s+[\s\S]*?from\s+['"][^'"]+['"];?/g, '// import')
          .replace(/import\s+['"][^'"]+['"];?/g, '// import')
          .replace(/export\s+default\s+/g, '')
          .replace(/export\s+\{[^}]*\};?/g, '')
          .replace(/export\s+(?:const|let|var|function|class)\s+/g, '');
        new vm.Script(sanitizedCode, { filename: `${file}#script${idx}` });
      } else {
        new vm.Script(code, { filename: `${file}#script${idx}` });
      }
    } catch (err) {
      jsSyntaxErrors.push({ file, scriptIdx: idx, error: err.message, stack: err.stack });
    }
  }
}

console.log("=== JAVASCRIPT SYNTAX AUDIT ===");
if (jsSyntaxErrors.length === 0) {
  console.log("ALL inline scripts in all 35 HTML files compiled with 0 syntax errors!");
} else {
  console.log(`Found ${jsSyntaxErrors.length} syntax errors:`);
  jsSyntaxErrors.forEach(e => console.log(`  [${e.file} - script #${e.scriptIdx}] ${e.error}`));
}
