const res = await fetch('https://askexpert-v2.vercel.app/register.html?ts=' + Date.now());
const html = await res.text();
const match = html.match(/<select id="expertCategory"[^>]*>([\s\S]*?)<\/select>/);
if (match) {
  const count = (match[1].match(/<option /g) || []).length;
  console.log('LIVE Vercel register.html expert categories count:', count);
} else {
  console.log('expertCategory not found in live HTML');
}

const vRes = await fetch('https://askexpert-v2.vercel.app/professional-verification.html?ts=' + Date.now());
const vHtml = await vRes.text();
const vMatch = vHtml.match(/<select id="vProfession"[^>]*>([\s\S]*?)<\/select>/);
if (vMatch) {
  const vCount = (vMatch[1].match(/<option /g) || []).length;
  console.log('LIVE Vercel professional-verification.html vProfession total options:', vCount);
} else {
  console.log('vProfession not found in live HTML');
}
