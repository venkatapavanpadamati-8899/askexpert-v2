import fs from 'fs';
import path from 'path';

const projectDir = 'd:/ASKEXPERT';
const htmlFiles = fs.readdirSync(projectDir).filter(f => f.endsWith('.html'));

const unescapedInnerHTML = [];

for (const file of htmlFiles) {
  const filePath = path.join(projectDir, file);
  const content = fs.readFileSync(filePath, 'utf8');

  // Find occurrences of .innerHTML = `...` or .innerHTML = ...
  const lines = content.split('\n');
  lines.forEach((line, lineNum) => {
    if (line.includes('.innerHTML') && (line.includes('${') || line.includes('+'))) {
      // Check if it uses escapeHTML or sanitize
      const hasEscape = line.includes('escapeHTML') || line.includes('sanitize') || line.includes('encodeURIComponent');
      // If it has variable interpolation without escapeHTML
      const variables = line.match(/\$\{([^}]+)\}/g) || [];
      const suspiciousVars = variables.filter(v => 
        !v.includes('escapeHTML') && 
        !v.includes('encodeURIComponent') &&
        !v.includes('.length') &&
        !v.includes('Math.') &&
        !v.includes('Date') &&
        !v.includes('count') &&
        !v.includes('Count') &&
        !v.includes('id') &&
        !v.includes('Id') &&
        !v.includes('badge') &&
        !v.includes('Badge') &&
        !v.includes('Class') &&
        !v.includes('class') &&
        !v.includes('Icon') &&
        !v.includes('icon') &&
        !v.includes('style') &&
        !v.includes('Color') &&
        !v.includes('color')
      );

      if (suspiciousVars.length > 0) {
        unescapedInnerHTML.push({ file, lineNum: lineNum + 1, line: line.trim(), suspiciousVars });
      }
    }
  });
}

console.log(`Found ${unescapedInnerHTML.length} potentially unescaped innerHTML instances:`);
unescapedInnerHTML.slice(0, 30).forEach(item => {
  console.log(`  [${item.file}:${item.lineNum}] vars: ${item.suspiciousVars.join(', ')}`);
});
