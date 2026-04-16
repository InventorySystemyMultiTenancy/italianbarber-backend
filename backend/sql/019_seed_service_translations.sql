SET search_path TO public;

-- 1. Insert service_* keys into translation_keys
INSERT INTO translation_keys (key) VALUES
  ('service_corte'),
  ('service_barboterapia'),
  ('service_corte_barba'),
  ('service_sobrancelha'),
  ('service_raspado'),
  ('service_pezinho'),
  ('service_penteado'),
  ('service_limpeza_pele'),
  ('service_hidratacao'),
  ('service_botox'),
  ('service_progressiva'),
  ('service_relaxamento'),
  ('service_luzes'),
  ('service_platinado'),
  ('service_coloracao')
ON CONFLICT ON CONSTRAINT uq_translation_keys_key DO NOTHING;

-- 2. ITALIANO
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('service_corte',        'Taglio'),
  ('service_barboterapia', 'Barboterapia'),
  ('service_corte_barba',  'Taglio e Barba'),
  ('service_sobrancelha',  'Sopracciglio'),
  ('service_raspado',      'Rasatura'),
  ('service_pezinho',      'Pezinho'),
  ('service_penteado',     'Pettinatura'),
  ('service_limpeza_pele', 'Pulizia Viso'),
  ('service_hidratacao',   'Idratazione'),
  ('service_botox',        'Botox'),
  ('service_progressiva',  'Lisciante'),
  ('service_relaxamento',  'Rilassamento'),
  ('service_luzes',        'Meches'),
  ('service_platinado',    'Platinato'),
  ('service_coloracao',    'Colorazione')
) AS t(key, value)
WHERE l.code = 'it'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;

-- 3. PORTUGUES
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('service_corte',        'Corte'),
  ('service_barboterapia', 'Barboterapia'),
  ('service_corte_barba',  'Corte e Barba'),
  ('service_sobrancelha',  'Sobrancelha'),
  ('service_raspado',      'Raspado'),
  ('service_pezinho',      'Pezinho'),
  ('service_penteado',     'Penteado'),
  ('service_limpeza_pele', 'Limpeza de Pele'),
  ('service_hidratacao',   'Hidratacao'),
  ('service_botox',        'Botox'),
  ('service_progressiva',  'Progressiva'),
  ('service_relaxamento',  'Relaxamento'),
  ('service_luzes',        'Luzes'),
  ('service_platinado',    'Platinado'),
  ('service_coloracao',    'Coloracao')
) AS t(key, value)
WHERE l.code = 'pt'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;

-- 4. ENGLISH
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('service_corte',        'Haircut'),
  ('service_barboterapia', 'Beard Care'),
  ('service_corte_barba',  'Haircut & Beard'),
  ('service_sobrancelha',  'Eyebrow'),
  ('service_raspado',      'Head Shave'),
  ('service_pezinho',      'Baby Fade'),
  ('service_penteado',     'Styling'),
  ('service_limpeza_pele', 'Facial'),
  ('service_hidratacao',   'Moisturizing'),
  ('service_botox',        'Botox'),
  ('service_progressiva',  'Straightening'),
  ('service_relaxamento',  'Relaxer'),
  ('service_luzes',        'Highlights'),
  ('service_platinado',    'Platinum Blonde'),
  ('service_coloracao',    'Coloring')
) AS t(key, value)
WHERE l.code = 'en'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;

-- 5. ESPANOL
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('service_corte',        'Corte'),
  ('service_barboterapia', 'Barboterapia'),
  ('service_corte_barba',  'Corte y Barba'),
  ('service_sobrancelha',  'Ceja'),
  ('service_raspado',      'Afeitado'),
  ('service_pezinho',      'Pezinho'),
  ('service_penteado',     'Peinado'),
  ('service_limpeza_pele', 'Limpieza Facial'),
  ('service_hidratacao',   'Hidratacion'),
  ('service_botox',        'Botox'),
  ('service_progressiva',  'Alisado'),
  ('service_relaxamento',  'Relajante'),
  ('service_luzes',        'Mechas'),
  ('service_platinado',    'Platinado'),
  ('service_coloracao',    'Coloracion')
) AS t(key, value)
WHERE l.code = 'es'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;

-- 6. MAROQUINO
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('service_corte',        'Lfarda'),
  ('service_barboterapia', 'L3naya b llebya'),
  ('service_corte_barba',  'Lfarda w llebya'),
  ('service_sobrancelha',  'L7ajeb'),
  ('service_raspado',      'Lfarda b lmosa'),
  ('service_pezinho',      'Pezinho'),
  ('service_penteado',     'Tcoifa'),
  ('service_limpeza_pele', 'Tndhif lwajh'),
  ('service_hidratacao',   'Rtouba'),
  ('service_botox',        'Botox'),
  ('service_progressiva',  'Tqlid'),
  ('service_relaxamento',  'Rahoun'),
  ('service_luzes',        'Tlwin'),
  ('service_platinado',    'Platini'),
  ('service_coloracao',    'Sbia3')
) AS t(key, value)
WHERE l.code = 'ma'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;
