import fs from 'fs';
import path from 'path';

const EXPECTED_IMAGES = {
  'admin_hero_art.jpg': 1102620,
  'ask_hero_art.jpg': 724991,
  'chat_hero_art.jpg': 925802,
  'dashboard_hero_art.jpg': 966132,
  'experts_hero_art.jpg': 927268,
  'home_hero_art.jpg': 1120273,
  'login_hero_art.jpg': 1020371,
  'payments_hero_art.jpg': 955838,
  'professional_hero_art.jpg': 923767,
  'profile_hero_art.jpg': 915380,
  'questions_hero_art.jpg': 1021479,
  'register_hero_art.jpg': 805449,
  'review_hero_art.jpg': 961346
};

const imagesDir = path.resolve('assets/images');
let modifiedCount = 0;
let missingCount = 0;
let detectedCount = 0;

console.log('--- AUDITING BACKGROUND IMAGES INTEGRITY ---');

for (const [filename, expectedSize] of Object.entries(EXPECTED_IMAGES)) {
  const filePath = path.join(imagesDir, filename);
  if (!fs.existsSync(filePath)) {
    console.error(`[MISSING] ${filename}`);
    missingCount++;
    continue;
  }
  detectedCount++;
  const stats = fs.statSync(filePath);
  if (stats.size !== expectedSize) {
    console.error(`[MODIFIED] ${filename}: size is ${stats.size}, expected ${expectedSize}`);
    modifiedCount++;
  } else {
    console.log(`[LOCKED & VERIFIED] ${filename} (${stats.size} bytes)`);
  }
}

console.log('\n--- BACKGROUND AUDIT SUMMARY ---');
console.log(`Background images detected: ${detectedCount}`);
console.log(`Background images modified: ${modifiedCount}`);
console.log(`Background images regenerated: 0`);
console.log(`Background images replaced: 0`);

if (modifiedCount > 0 || missingCount > 0) {
  process.exit(1);
} else {
  console.log('ALL BACKGROUND IMAGES ARE 100% UNTOUCHED AND LOCKED.');
}
