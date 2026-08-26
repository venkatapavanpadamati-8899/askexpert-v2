import fs from 'fs';

const chunks = [
  'd:/ASKEXPERT/seed_chunk1.sql',
  'd:/ASKEXPERT/seed_chunk2.sql',
  'd:/ASKEXPERT/seed_chunk3.sql',
  'd:/ASKEXPERT/seed_chunk4.sql',
  'd:/ASKEXPERT/seed_chunk5.sql'
];

chunks.forEach(file => {
  if (fs.existsSync(file)) {
    let sql = fs.readFileSync(file, 'utf8');
    if (!sql.includes('UPDATE public.profiles SET is_verified = true')) {
      sql = sql.replace(
        'END $$;',
        'END $$;\n\n-- ENSURE ALL EXPERTS HAVE IS_VERIFIED = TRUE\nUPDATE public.profiles SET is_verified = true WHERE role = \'expert\';'
      );
      fs.writeFileSync(file, sql, 'utf8');
      console.log(`Updated ${file}`);
    }
  }
});
