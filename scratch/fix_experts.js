const fs = require('fs');
let c = fs.readFileSync('experts.html', 'utf8');

const target = `    .btn-profile-link {
      padding: 8px 14px;
      border-radius: 10px;
      font-size: 12.5px;
      font-weight: 750;
      background: rgba(255, 255, 255, 0.06);
      border: 1px solid var(--card-border);
      color: var(--white);
      transition: all 0.2s;
    }

    .btn-profile-link:hover {
      background: rgba(255, 255, 255, 0.12);
    }

    .btn-chat-link {
      border: 1px solid var(--card-border);
      border-radius: var(--radius);
      padding: 24px;
      animation: pulse 1.5s infinite ease-in-out;
    }`;

const replacement = `    .btn-profile-link {
      padding: 10px 16px;
      min-height: 44px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      border-radius: 12px;
      font-size: 13px;
      font-weight: 750;
      background: rgba(255, 255, 255, 0.08);
      backdrop-filter: blur(10px);
      border: 1px solid rgba(255, 255, 255, 0.16);
      color: var(--white);
      transition: all 0.2s;
    }

    .btn-profile-link:hover {
      background: rgba(255, 255, 255, 0.16);
      transform: translateY(-1px);
    }

    .btn-chat-link {
      padding: 10px 18px;
      min-height: 44px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      border-radius: 12px;
      font-size: 13px;
      font-weight: 800;
      background: linear-gradient(135deg, #00d9ff, #0077ff);
      color: #031120 !important;
      box-shadow: 0 6px 18px rgba(0, 217, 255, 0.35);
      transition: all 0.2s;
      border: 1px solid rgba(255, 255, 255, 0.25);
    }

    .btn-chat-link:hover {
      transform: translateY(-1px);
      box-shadow: 0 8px 24px rgba(0, 217, 255, 0.55);
      filter: brightness(1.08);
    }

    /* Skeleton Loading Cards */
    .skeleton-card {
      background: var(--card-bg);
      border: 1px solid var(--card-border);
      border-radius: var(--radius);
      padding: 24px;
      animation: pulse 1.5s infinite ease-in-out;
    }`;

// normalize line endings for safe replace
const normC = c.replace(/\r\n/g, '\n');
const normT = target.replace(/\r\n/g, '\n');
const normR = replacement.replace(/\r\n/g, '\n');

if (normC.includes(normT)) {
  const result = normC.replace(normT, normR);
  fs.writeFileSync('experts.html', result, 'utf8');
  console.log('REPLACED SUCCESS');
} else {
  console.log('TARGET NOT FOUND');
}
