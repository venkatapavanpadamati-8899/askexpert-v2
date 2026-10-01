# College Safety E2E Testing Suite

## Requirements
- Node.js 18+
- Playwright (`npm install -D @playwright/test`)
- Test accounts provisioned in a staging/test Supabase project.

## Setup Instructions

1. **DO NOT USE PRODUCTION DATABASE.**
2. Set up your staging database.
3. Run the SQL fixtures file located at `setup/TEST_DATA_SETUP.sql` on your test database. (Or use the Supabase Auth UI to create the test users first, then run the SQL to map them).
4. Copy `.env.example` to `.env` in this directory.
5. Fill in the `.env` file with the test user credentials and your staging project's Supabase URL and ANON KEY.

## Running Tests

To run the full suite:
```bash
npx playwright test tests/college-safety/safety.spec.js
```

To run with a visible browser (UI mode):
```bash
npx playwright test tests/college-safety/safety.spec.js --ui
```

To debug a specific test:
```bash
npx playwright test tests/college-safety/safety.spec.js --debug
```
