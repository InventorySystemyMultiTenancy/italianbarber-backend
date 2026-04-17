SET search_path TO public;

-- Add admin_reason_past_slot key (missed in 020)
INSERT INTO translation_keys (key) VALUES ('admin_reason_past_slot')
ON CONFLICT ON CONSTRAINT uq_translation_keys_key DO NOTHING;

INSERT INTO language_translations (language_id, key, value)
SELECT l.id, 'admin_reason_past_slot', v.value
FROM languages l
JOIN (VALUES
  ('it', 'Orario passato nella giornata'),
  ('pt', 'Horario passado no dia atual'),
  ('en', 'Past slot in the current day'),
  ('es', 'Horario pasado en el dia actual'),
  ('ma', 'Lwaqt fat f had nhar')
) AS v(code, value) ON l.code = v.code
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;
