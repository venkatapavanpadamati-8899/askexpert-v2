# College Creation Guide

This guide details the schema and instructions for safely creating a new record in the `public.colleges` table for the AskExpert platform.

## 1. Verified Schema: `public.colleges`

| Column | Type | Constraints | Default |
|---|---|---|---|
| `id` | `uuid` | PRIMARY KEY | `gen_random_uuid()` |
| `name` | `text` | NOT NULL | - |
| `code` | `text` | UNIQUE | - |
| `created_at` | `timestamptz` | NOT NULL | `now()` |

## 2. RLS & Permissions
- Row Level Security (RLS) is **ENABLED**.
- **INSERT Policy**: There is no specific `FOR INSERT` policy for regular authenticated users.
- **Admin Access**: The policy `"Admins manage colleges" FOR ALL` restricts modifications (INSERT/UPDATE/DELETE) exclusively to users where `public.is_admin()` returns true.
- **Service Role**: Running this query directly in the Supabase Dashboard SQL Editor will bypass RLS.

## 3. SQL INSERT Template

```sql
-- Replace the placeholders with your actual college details
INSERT INTO public.colleges (name, code)
VALUES (
  'SRKR Engineering College', -- Replace with your college name
  'SRKREC'                    -- Replace with a unique short code
)
RETURNING id, name, code, created_at;
```

### Which values must be replaced?
- `'SRKR Engineering College'`: Update if necessary, though it looks correct for your context.
- `'SRKREC'`: Update if you prefer a different unique college code.

*(Note: `id` and `created_at` are handled automatically by their DEFAULT constraints.)*

## 4. Execution Instructions
Because RLS blocks standard authenticated users from creating colleges, you **must execute this SQL via the Supabase Dashboard SQL Editor**.

1. Go to your Supabase project.
2. Open the **SQL Editor** -> **New Query**.
3. Paste the provided SQL template above (with your replaced values).
4. Click **Run**.

## 5. Verification
The `RETURNING *` clause in the SQL will immediately show you the generated `id` (UUID). 
**Save this UUID!** You will need it to assign students and safety staff in the next steps.
