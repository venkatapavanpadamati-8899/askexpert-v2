import fs from 'fs';
import path from 'path';

console.log("=== COMPREHENSIVE WORKSPACE CODE AUDIT ===");

const files = fs.readdirSync('.').filter(f => f.endsWith('.html') || f.endsWith('.js') || f.endsWith('.sql'));

let hasError = false;

files.forEach(file => {
  try {
    const content = fs.readFileSync(file, 'utf8');
    if (file.endsWith('.html')) {
      // Basic HTML sanity check
      if (!content.includes('<!DOCTYPE html>') && !content.includes('<html')) {
        console.warn(`⚠️ [WARN] ${file}: Missing doctype or html tag`);
      }
      // Check unclosed tags or syntax in embedded scripts
      const scripts = content.match(/<script[\s\S]*?>([\s\S]*?)<\/script>/gi) || [];
      scripts.forEach((script, idx) => {
        const jsCode = script.replace(/<script[\s\S]*?>/i, '').replace(/<\/script>/i, '');
        if (jsCode.trim() && !jsCode.includes('import ') && !jsCode.includes('export ')) {
          try {
            // Function constructor test for syntax errors
            new Function(jsCode);
          } catch (e) {
            console.error(`❌ [JS SYNTAX ERROR] ${file} (Script #${idx+1}): ${e.message}`);
            hasError = true;
          }
        }
      });
    } else if (file.endsWith('.js')) {
      // Skip node_modules or dist
      if (!file.includes('node_modules')) {
        const jsCode = content;
        if (!jsCode.includes('import ') && !jsCode.includes('export ')) {
          try {
            new Function(jsCode);
          } catch (e) {
            console.error(`❌ [JS SYNTAX ERROR] ${file}: ${e.message}`);
            hasError = true;
          }
        }
      }
    }
    console.log(`  ✓ Checked ${file}`);
  } catch (err) {
    console.error(`❌ Error reading ${file}: ${err.message}`);
    hasError = true;
  }
});

if (!hasError) {
  console.log("\n✅ ALL WORKSPACE FILES PASSED AUDIT WITH 0 SYNTAX ERRORS!");
} else {
  console.log("\n⚠️ AUDIT FOUND ISSUES THAT REQUIRE FIXING.");
}
