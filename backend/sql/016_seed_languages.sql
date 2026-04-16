SET search_path TO public;

-- Upsert all supported languages
INSERT INTO languages (code, name, country_code, flag, enabled)
VALUES
  ('en', 'English',             'GB', '🇬🇧', true),
  ('pt', 'Português (Portugal)','PT', '🇵🇹', true),
  ('it', 'Italiano',            'IT', '🇮🇹', true),
  ('ma', 'Maroquino (Darija)',  'MA', '🇲🇦', true),
  ('es', 'Español',             'ES', '🇪🇸', true)
ON CONFLICT ON CONSTRAINT languages_code_unique DO UPDATE
SET
  name         = EXCLUDED.name,
  country_code = EXCLUDED.country_code,
  flag         = EXCLUDED.flag,
  enabled      = EXCLUDED.enabled,
  updated_at   = NOW();
