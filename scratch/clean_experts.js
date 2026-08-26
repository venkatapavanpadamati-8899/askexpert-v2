import fs from 'fs';

const filePath = 'd:/ASKEXPERT/experts.html';
let code = fs.readFileSync(filePath, 'utf8');

const startTag = 'const SEED_EXPERTS = [';
const endTag = 'let selectedDomain = "all";';

const startIdx = code.indexOf(startTag);
const endIdx = code.indexOf(endTag);

if (startIdx !== -1 && endIdx !== -1) {
  const commentStart = code.lastIndexOf('/*', startIdx);
  const commentEnd = code.lastIndexOf('/*', endIdx);
  code = code.slice(0, commentStart) + code.slice(commentEnd);
  fs.writeFileSync(filePath, code, 'utf8');
  console.log('Successfully removed SEED_EXPERTS array!');
} else {
  console.log('Indexes not found:', startIdx, endIdx);
}
