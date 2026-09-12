import fs from 'fs';

const reg = fs.readFileSync('register.html', 'utf8');
const ver = fs.readFileSync('professional-verification.html', 'utf8');

const regMatch = reg.match(/<select id="expertCategory"[^>]*>([\s\S]*?)<\/select>/);
const verMatch = ver.match(/<select id="vProfession"[^>]*>([\s\S]*?)<\/select>/);

const regOpts = (regMatch[1].match(/<option /g) || []).length;
// subtracting 1 for the placeholder "Select Domain Specialization"
const verOpts = (verMatch[1].match(/<option /g) || []).length;
const verActualCategories = verOpts - 1;

console.log('register.html #expertCategory options:', regOpts);
console.log('professional-verification.html #vProfession total options:', verOpts, '(categories:', verActualCategories, ')');

if (regOpts < 25 || verActualCategories < 25) {
  console.error('FAILED: Fewer than 25 categories found!');
  process.exit(1);
} else {
  console.log(`SUCCESS: Category count verification passed! (register: ${regOpts}, verification: ${verActualCategories})`);
}
