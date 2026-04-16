SET search_path TO public;

-- ============================================================
-- 1. Upsert translation keys
-- ============================================================
INSERT INTO translation_keys (key) VALUES
  ('brand_name'),
  ('brand_logo_alt'),
  ('language_site'),
  ('language_active'),
  ('nav_book'),
  ('nav_my_appointments'),
  ('nav_my_appointments_short'),
  ('nav_login'),
  ('nav_register'),
  ('nav_languages'),
  ('home_birthday_title'),
  ('home_birthday_fallback'),
  ('home_birthday_suffix'),
  ('home_badge_premium'),
  ('home_hero_title_a'),
  ('home_hero_title_b'),
  ('home_hero_subtitle'),
  ('home_book_now'),
  ('home_services_title_a'),
  ('home_services_title_b'),
  ('home_service_cut_title'),
  ('home_service_cut_desc'),
  ('home_service_beard_title'),
  ('home_service_beard_desc'),
  ('home_service_combo_title'),
  ('home_service_combo_desc'),
  ('home_cta_title_a'),
  ('home_cta_title_b'),
  ('home_cta_subtitle'),
  ('home_start_now'),
  ('home_footer'),
  ('login_title'),
  ('login_phone'),
  ('login_password'),
  ('login_loading'),
  ('login_button'),
  ('login_no_account'),
  ('login_register'),
  ('login_error_title'),
  ('login_welcome_back')
ON CONFLICT ON CONSTRAINT uq_translation_keys_key DO NOTHING;

-- ============================================================
-- 2. Upsert translations per language
-- ============================================================

-- ── Português (PT) ──────────────────────────────────────────
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('brand_name',                'Nome da sua barbearia'),
  ('brand_logo_alt',            'Logo da sua barbearia'),
  ('language_site',             'Idioma do site'),
  ('language_active',           'ativo'),
  ('nav_book',                  'Agendar'),
  ('nav_my_appointments',       'Meus agendamentos'),
  ('nav_my_appointments_short', 'Agend.'),
  ('nav_login',                 'Entrar'),
  ('nav_register',              'Cadastrar'),
  ('nav_languages',             'Idiomas'),
  ('home_birthday_title',       'Parabens! Desconto de aniversario ativo'),
  ('home_birthday_fallback',    'Voce tem 50% no corte hoje.'),
  ('home_birthday_suffix',      'no corte hoje'),
  ('home_badge_premium',        'Barbearia Premium'),
  ('home_hero_title_a',         'ESTILO QUE'),
  ('home_hero_title_b',         'DEFINE VOCE'),
  ('home_hero_subtitle',        'Experiencia premium em corte masculino. Agende online e garanta seu horario.'),
  ('home_book_now',             'AGENDAR AGORA'),
  ('home_services_title_a',     'NOSSOS'),
  ('home_services_title_b',     'SERVICOS'),
  ('home_service_cut_title',    'Corte Masculino'),
  ('home_service_cut_desc',     'Corte personalizado com tecnicas modernas'),
  ('home_service_beard_title',  'Barboterapia'),
  ('home_service_beard_desc',   'Cuidado e acabamento profissional para a barba'),
  ('home_service_combo_title',  'Corte & Barba'),
  ('home_service_combo_desc',   'Combo completo de corte com barba'),
  ('home_cta_title_a',          'PRONTO PARA O'),
  ('home_cta_title_b',          'SEU CORTE'),
  ('home_cta_subtitle',         'Cadastre-se e agende seu horario em segundos.'),
  ('home_start_now',            'COMECAR AGORA'),
  ('home_footer',               '© 2026 Nome da sua barbearia. Todos os direitos reservados.'),
  ('login_title',               'Entrar na sua conta'),
  ('login_phone',               'Telefone'),
  ('login_password',            'Senha'),
  ('login_loading',             'Entrando...'),
  ('login_button',              'Entrar'),
  ('login_no_account',          'Nao tem conta?'),
  ('login_register',            'Cadastre-se'),
  ('login_error_title',         'Erro ao entrar'),
  ('login_welcome_back',        'Bem-vindo de volta!')
) AS t(key, value)
WHERE l.code = 'pt'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();

-- ── Italiano (IT) ───────────────────────────────────────────
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('brand_name',                'Nome del tuo barbiere'),
  ('brand_logo_alt',            'Logo del tuo barbiere'),
  ('language_site',             'Lingua del sito'),
  ('language_active',           'attivo'),
  ('nav_book',                  'Prenota'),
  ('nav_my_appointments',       'I miei appuntamenti'),
  ('nav_my_appointments_short', 'Appunt.'),
  ('nav_login',                 'Accedi'),
  ('nav_register',              'Registrati'),
  ('nav_languages',             'Lingue'),
  ('home_birthday_title',       'Auguri! Sconto di compleanno attivo'),
  ('home_birthday_fallback',    'Hai il 50% sul taglio oggi.'),
  ('home_birthday_suffix',      'sul taglio oggi'),
  ('home_badge_premium',        'Barbiere Premium'),
  ('home_hero_title_a',         'STILE CHE'),
  ('home_hero_title_b',         'TI DEFINISCE'),
  ('home_hero_subtitle',        'Esperienza premium nel taglio maschile. Prenota online e assicurati il tuo orario.'),
  ('home_book_now',             'PRENOTA ORA'),
  ('home_services_title_a',     'I NOSTRI'),
  ('home_services_title_b',     'SERVIZI'),
  ('home_service_cut_title',    'Taglio Maschile'),
  ('home_service_cut_desc',     'Taglio personalizzato con tecniche moderne'),
  ('home_service_beard_title',  'Barba'),
  ('home_service_beard_desc',   'Cura e rifinitura professionale della barba'),
  ('home_service_combo_title',  'Taglio & Barba'),
  ('home_service_combo_desc',   'Combo completo taglio con barba'),
  ('home_cta_title_a',          'PRONTO PER IL'),
  ('home_cta_title_b',          'TUO TAGLIO'),
  ('home_cta_subtitle',         'Registrati e prenota il tuo orario in pochi secondi.'),
  ('home_start_now',            'INIZIA ORA'),
  ('home_footer',               '© 2026 Nome del tuo barbiere. Tutti i diritti riservati.'),
  ('login_title',               'Accedi al tuo account'),
  ('login_phone',               'Telefono'),
  ('login_password',            'Password'),
  ('login_loading',             'Accesso in corso...'),
  ('login_button',              'Accedi'),
  ('login_no_account',          'Non hai un account?'),
  ('login_register',            'Registrati'),
  ('login_error_title',         'Errore di accesso'),
  ('login_welcome_back',        'Bentornato!')
) AS t(key, value)
WHERE l.code = 'it'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();

-- ── English (EN) ────────────────────────────────────────────
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('brand_name',                'Your Barbershop Name'),
  ('brand_logo_alt',            'Your barbershop logo'),
  ('language_site',             'Site language'),
  ('language_active',           'active'),
  ('nav_book',                  'Book'),
  ('nav_my_appointments',       'My appointments'),
  ('nav_my_appointments_short', 'Appts.'),
  ('nav_login',                 'Sign in'),
  ('nav_register',              'Register'),
  ('nav_languages',             'Languages'),
  ('home_birthday_title',       'Happy Birthday! Birthday discount active'),
  ('home_birthday_fallback',    'You have 50% off your haircut today.'),
  ('home_birthday_suffix',      'off your haircut today'),
  ('home_badge_premium',        'Premium Barbershop'),
  ('home_hero_title_a',         'STYLE THAT'),
  ('home_hero_title_b',         'DEFINES YOU'),
  ('home_hero_subtitle',        'Premium men''s haircut experience. Book online and secure your slot.'),
  ('home_book_now',             'BOOK NOW'),
  ('home_services_title_a',     'OUR'),
  ('home_services_title_b',     'SERVICES'),
  ('home_service_cut_title',    'Men''s Haircut'),
  ('home_service_cut_desc',     'Personalised cut with modern techniques'),
  ('home_service_beard_title',  'Beard Therapy'),
  ('home_service_beard_desc',   'Professional beard care and finishing'),
  ('home_service_combo_title',  'Cut & Beard'),
  ('home_service_combo_desc',   'Full combo haircut with beard'),
  ('home_cta_title_a',          'READY FOR'),
  ('home_cta_title_b',          'YOUR CUT'),
  ('home_cta_subtitle',         'Sign up and book your slot in seconds.'),
  ('home_start_now',            'START NOW'),
  ('home_footer',               '© 2026 Your Barbershop Name. All rights reserved.'),
  ('login_title',               'Sign in to your account'),
  ('login_phone',               'Phone'),
  ('login_password',            'Password'),
  ('login_loading',             'Signing in...'),
  ('login_button',              'Sign in'),
  ('login_no_account',          'Don''t have an account?'),
  ('login_register',            'Register'),
  ('login_error_title',         'Sign in error'),
  ('login_welcome_back',        'Welcome back!')
) AS t(key, value)
WHERE l.code = 'en'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();

-- ── Español (ES) ────────────────────────────────────────────
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('brand_name',                'Nombre de tu barbería'),
  ('brand_logo_alt',            'Logo de tu barbería'),
  ('language_site',             'Idioma del sitio'),
  ('language_active',           'activo'),
  ('nav_book',                  'Reservar'),
  ('nav_my_appointments',       'Mis citas'),
  ('nav_my_appointments_short', 'Citas'),
  ('nav_login',                 'Entrar'),
  ('nav_register',              'Registrarse'),
  ('nav_languages',             'Idiomas'),
  ('home_birthday_title',       '¡Feliz cumpleaños! Descuento de cumpleaños activo'),
  ('home_birthday_fallback',    'Tienes 50% de descuento en el corte hoy.'),
  ('home_birthday_suffix',      'en el corte hoy'),
  ('home_badge_premium',        'Barbería Premium'),
  ('home_hero_title_a',         'ESTILO QUE'),
  ('home_hero_title_b',         'TE DEFINE'),
  ('home_hero_subtitle',        'Experiencia premium en corte masculino. Reserva online y asegura tu hora.'),
  ('home_book_now',             'RESERVAR AHORA'),
  ('home_services_title_a',     'NUESTROS'),
  ('home_services_title_b',     'SERVICIOS'),
  ('home_service_cut_title',    'Corte Masculino'),
  ('home_service_cut_desc',     'Corte personalizado con técnicas modernas'),
  ('home_service_beard_title',  'Barboterapia'),
  ('home_service_beard_desc',   'Cuidado y acabado profesional de la barba'),
  ('home_service_combo_title',  'Corte & Barba'),
  ('home_service_combo_desc',   'Combo completo corte con barba'),
  ('home_cta_title_a',          'LISTO PARA'),
  ('home_cta_title_b',          'TU CORTE'),
  ('home_cta_subtitle',         'Regístrate y reserva tu hora en segundos.'),
  ('home_start_now',            'EMPEZAR AHORA'),
  ('home_footer',               '© 2026 Nombre de tu barbería. Todos los derechos reservados.'),
  ('login_title',               'Accede a tu cuenta'),
  ('login_phone',               'Teléfono'),
  ('login_password',            'Contraseña'),
  ('login_loading',             'Entrando...'),
  ('login_button',              'Entrar'),
  ('login_no_account',          '¿No tienes cuenta?'),
  ('login_register',            'Regístrate'),
  ('login_error_title',         'Error al entrar'),
  ('login_welcome_back',        '¡Bienvenido de nuevo!')
) AS t(key, value)
WHERE l.code = 'es'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();

-- ── Maroquino / Darija (MA) ─────────────────────────────────
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('brand_name',                'اسم الحلاق ديالك'),
  ('brand_logo_alt',            'شعار الحلاق'),
  ('language_site',             'لغة الموقع'),
  ('language_active',           'نشيط'),
  ('nav_book',                  'حجز'),
  ('nav_my_appointments',       'مواعيدي'),
  ('nav_my_appointments_short', 'المواعيد'),
  ('nav_login',                 'دخول'),
  ('nav_register',              'تسجيل'),
  ('nav_languages',             'اللغات'),
  ('home_birthday_title',       'عيد ميلاد سعيد! خصم عيد الميلاد نشيط'),
  ('home_birthday_fallback',    'عندك 50% تخفيض على الحلاقة اليوم.'),
  ('home_birthday_suffix',      'على الحلاقة اليوم'),
  ('home_badge_premium',        'حلاق بريميوم'),
  ('home_hero_title_a',         'ستايل'),
  ('home_hero_title_b',         'يعرفك'),
  ('home_hero_subtitle',        'تجربة بريميوم في حلاقة الرجال. احجز أونلاين وضمن وقتك.'),
  ('home_book_now',             'احجز الآن'),
  ('home_services_title_a',     'خدماتنا'),
  ('home_services_title_b',     ''),
  ('home_service_cut_title',    'حلاقة الرجال'),
  ('home_service_cut_desc',     'قصة مخصصة بتقنيات عصرية'),
  ('home_service_beard_title',  'عناية اللحية'),
  ('home_service_beard_desc',   'عناية احترافية وتشطيب اللحية'),
  ('home_service_combo_title',  'قصة وداية'),
  ('home_service_combo_desc',   'كومبو كامل قصة مع داية'),
  ('home_cta_title_a',          'مستعد'),
  ('home_cta_title_b',          'للقصة ديالك'),
  ('home_cta_subtitle',         'سجل واحجز وقتك في ثوان.'),
  ('home_start_now',            'ابدأ الآن'),
  ('home_footer',               '© 2026 اسم الحلاق ديالك. جميع الحقوق محفوظة.'),
  ('login_title',               'دخل لحسابك'),
  ('login_phone',               'رقم الهاتف'),
  ('login_password',            'كلمة السر'),
  ('login_loading',             'جاري الدخول...'),
  ('login_button',              'دخول'),
  ('login_no_account',          'ما عندكش حساب؟'),
  ('login_register',            'سجل'),
  ('login_error_title',         'خطأ في الدخول'),
  ('login_welcome_back',        'مرحبا بيك!')
) AS t(key, value)
WHERE l.code = 'ma'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();
