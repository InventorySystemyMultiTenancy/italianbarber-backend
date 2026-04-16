SET search_path TO public;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS languages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT NOT NULL,
  name TEXT NOT NULL,
  country_code CHAR(2) NOT NULL,
  flag TEXT,
  enabled BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT languages_code_lowercase_check CHECK (code = lower(code)),
  CONSTRAINT languages_country_code_uppercase_check CHECK (country_code = upper(country_code)),
  CONSTRAINT languages_country_code_length_check CHECK (char_length(country_code) = 2)
);

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'languages_code_unique'
      AND conrelid = 'languages'::regclass
  ) THEN
    ALTER TABLE languages
      ADD CONSTRAINT languages_code_unique UNIQUE (code);
  END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_languages_enabled ON languages (enabled);

CREATE TABLE IF NOT EXISTS translation_keys (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  key TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CONSTRAINT uq_translation_keys_key UNIQUE (key)
);

CREATE TABLE IF NOT EXISTS language_translations (
  language_id UUID NOT NULL REFERENCES languages(id) ON DELETE CASCADE,
  key TEXT NOT NULL REFERENCES translation_keys(key) ON DELETE CASCADE,
  value TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (language_id, key)
);

CREATE INDEX IF NOT EXISTS idx_language_translations_language_id ON language_translations (language_id);
CREATE INDEX IF NOT EXISTS idx_language_translations_key ON language_translations (key);

INSERT INTO languages (code, name, country_code, flag, enabled)
VALUES
  ('it', 'Italiano', 'IT', '🇮🇹', true),
  ('ma', 'Moroccan', 'MA', '🇲🇦', true)
ON CONFLICT ON CONSTRAINT languages_code_unique DO UPDATE
SET
  name = EXCLUDED.name,
  country_code = EXCLUDED.country_code,
  flag = EXCLUDED.flag,
  enabled = EXCLUDED.enabled,
  updated_at = NOW();
