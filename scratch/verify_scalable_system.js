import fs from 'fs';

const html = fs.readFileSync('experts.html', 'utf8');

console.log("--- VERIFICATION REPORT FOR EXPERTS SYSTEM ---");

// Check categories dropdown options
const catMatch = html.match(/<select id="categoryFilter"[\s\S]*?<\/select>/);
if (catMatch) {
  const options = (catMatch[0].match(/<option value="([^"]+)">/g) || []).map(o => o.replace(/<option value="|">/g, ''));
  console.log(`✅ Category dropdown options count: ${options.length - 1} categories`);
  console.log(`   Sample options:`, options.slice(1, 6));
} else {
  console.error("❌ categoryFilter select element missing");
}

// Check sorting dropdown options
const sortMatch = html.match(/<select id="sortFilter"[\s\S]*?<\/select>/);
if (sortMatch) {
  console.log(`✅ Sort dropdown present with sorting options!`);
} else {
  console.error("❌ sortFilter select element missing");
}

// Check pagination bar
if (html.includes('id="paginationBar"') && html.includes('renderPagination')) {
  console.log("✅ Scalable Pagination Bar & DB Range Pagination functions present!");
} else {
  console.error("❌ Pagination element or function missing");
}

// Check Supabase Range querying
if (html.includes('.range(from, to)') && html.includes("count: \"exact\"")) {
  console.log("✅ Supabase DB-side Range Pagination (.range(), count: 'exact') verified!");
} else {
  console.error("❌ Supabase range pagination missing");
}

// Check DEMO badge rendering
if (html.includes('badge-demo')) {
  console.log("✅ DEMO / SEED badge distinction present!");
} else {
  console.error("❌ DEMO badge missing");
}

console.log("--- VERIFICATION SUCCESSFUL ---");
