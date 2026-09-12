import fs from 'fs';

const content = fs.readFileSync('login.html', 'utf8');
console.log('Login HTML size:', content.length);

// Extract module script
const scriptMatch = content.match(/<script type="module">([\s\S]*?)<\/script>/);
if (scriptMatch) {
  fs.writeFileSync('scratch/login_script_extracted.mjs', scriptMatch[1]);
  console.log('Extracted script to scratch/login_script_extracted.mjs');
} else {
  console.log('No script tag found!');
}
