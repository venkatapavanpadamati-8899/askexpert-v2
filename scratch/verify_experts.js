import fs from 'fs';

const html = fs.readFileSync('experts.html', 'utf8');

// Match SEED_EXPERTS length
const match = html.match(/SEED_EXPERTS = \[\s*([\s\S]*?)\s*\];\s*\/\*/);
if (match) {
  const code = 'const experts = [' + match[1] + ']; experts;';
  try {
    const experts = eval(code);
    console.log(`✅ SEED_EXPERTS verified! Count: ${experts.length}`);
    const categories = new Set(experts.map(e => e.specialization));
    console.log('Categories covered:');
    categories.forEach(c => console.log(`  - ${c}`));
  } catch (err) {
    console.error("Eval error:", err);
  }
} else {
  console.error("Could not parse SEED_EXPERTS from experts.html");
}
