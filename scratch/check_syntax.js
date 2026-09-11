import fs from 'node:fs';
import vm from 'node:vm';

const filesToCheck = [
  'login.html',
  'admin-login.html',
  'admin-dashboard.html',
  'admin-ai-fix-center.html',
  'dashboard.html'
];

let hasErrors = false;

for (const file of filesToCheck) {
  const content = fs.readFileSync(file, 'utf8');
  const scriptRegex = /<script\b[^>]*>([\s\S]*?)<\/script>/gi;
  let match;
  let index = 1;
  while ((match = scriptRegex.exec(content)) !== null) {
    const code = match[1].trim();
    if (!code) continue;
    try {
      // Parse code using vm.Script to verify syntax (treating modules/imports appropriately)
      // If code contains import/export, wrap or check with vm.SourceTextModule if available, or parse
      new vm.Script(code.replace(/import\s+[\s\S]*?from\s+['"][^'"]+['"];?/g, '// import')
                        .replace(/export\s+[\s\S]*?;/g, '// export'));
      console.log(`✓ [SYNTAX OK] ${file} (script #${index})`);
    } catch (err) {
      console.error(`❌ [SYNTAX ERROR] ${file} (script #${index}):`, err.message);
      hasErrors = true;
    }
    index++;
  }
}

if (hasErrors) {
  process.exit(1);
} else {
  console.log('\nAll modified files passed JavaScript syntax assertions cleanly!');
}
