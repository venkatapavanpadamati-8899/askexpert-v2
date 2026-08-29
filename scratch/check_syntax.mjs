import fs from 'fs';
import { execSync } from 'child_process';

const html = fs.readFileSync('forgot-password.html', 'utf8');
const startTag = '<script type="module">';
const endTag = '</script>';
const start = html.indexOf(startTag) + startTag.length;
const end = html.indexOf(endTag, start);
const code = html.slice(start, end);
fs.writeFileSync('scratch/test_script.mjs', code);

try {
  execSync('node --check scratch/test_script.mjs');
  console.log('Valid JS syntax!');
} catch (err) {
  console.log('Error output:\n', err.stderr.toString());
}
