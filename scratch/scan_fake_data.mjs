import fs from 'fs';
import path from 'path';

const htmlFiles = fs.readdirSync('.').filter(f => f.endsWith('.html'));

console.log(`Scanning ${htmlFiles.length} HTML files for mock/fake/dummy runtime patterns...`);

const findings = [];

for (const file of htmlFiles) {
  const content = fs.readFileSync(file, 'utf8');
  const lines = content.split('\n');

  lines.forEach((line, idx) => {
    // Exclude register.html Demo OTP explicitly
    if (file === 'register.html' && (line.includes('demoOtp') || line.includes('Demo OTP'))) {
      return;
    }
    // Exclude comments or explanations that describe mock removal or tests
    if (line.includes('//') && (line.includes('removed') || line.includes('no dummy') || line.includes('no fake') || line.includes('do not use fake'))) {
      return;
    }

    if (line.toLowerCase().includes('example.com')) {
      findings.push({ file, line: idx + 1, text: line.trim(), issue: 'Contains example.com' });
    }
    if (/\b(mock|dummy|fake)\b/i.test(line) && !line.includes('Mock Interviews')) {
      findings.push({ file, line: idx + 1, text: line.trim(), issue: 'Contains mock/dummy/fake keyword' });
    }
  });
}

console.log(`Found ${findings.length} potential mock/dummy occurrences.`);
findings.forEach(f => console.log(`[${f.file}:${f.line}] ${f.issue} -> ${f.text.slice(0, 100)}`));
