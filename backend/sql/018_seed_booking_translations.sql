SET search_path TO public;

-- 1. Insert new keys into translation_keys
INSERT INTO translation_keys (key) VALUES
  ('booking_expired_title'),
  ('booking_expired_desc'),
  ('booking_auth_loading'),
  ('booking_title_a'),
  ('booking_title_b'),
  ('booking_subtitle'),
  ('booking_window_prefix'),
  ('booking_window_middle'),
  ('booking_birthday_promo_active'),
  ('booking_birthday_promo_fallback'),
  ('booking_discount_label'),
  ('booking_choose_service'),
  ('booking_loading_services'),
  ('booking_no_services'),
  ('booking_birthday_off_suffix'),
  ('booking_choose_barber'),
  ('booking_loading_barbers'),
  ('booking_retry'),
  ('booking_no_barbers'),
  ('booking_no_photo'),
  ('booking_choose_day'),
  ('booking_available_times'),
  ('booking_select_barber'),
  ('booking_loading_slots'),
  ('booking_no_slots'),
  ('booking_slot_paid'),
  ('booking_slot_scheduled'),
  ('booking_slot_disabled'),
  ('booking_slot_available'),
  ('booking_barber_label'),
  ('booking_birthday_will_apply'),
  ('booking_birthday_applied'),
  ('booking_original_price'),
  ('booking_final_price'),
  ('booking_payment_method'),
  ('booking_in_person_payment'),
  ('booking_submitting'),
  ('booking_confirm')
ON CONFLICT ON CONSTRAINT uq_translation_keys_key DO NOTHING;

-- 2. ITALIANO
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('booking_expired_title',           'Sessione scaduta'),
  ('booking_expired_desc',            'Accedi di nuovo per continuare.'),
  ('booking_auth_loading',            'Caricamento autenticazione...'),
  ('booking_title_a',                 'PRENOTA'),
  ('booking_title_b',                 'ORARIO'),
  ('booking_subtitle',                'Scegli giorno e orario del tuo taglio'),
  ('booking_window_prefix',           'Prenotazioni disponibili da'),
  ('booking_window_middle',           'a'),
  ('booking_birthday_promo_active',   'Promo compleanno attiva'),
  ('booking_birthday_promo_fallback', 'Hai uno sconto compleanno sul servizio idoneo.'),
  ('booking_discount_label',          'Sconto'),
  ('booking_choose_service',          'Scegli il servizio'),
  ('booking_loading_services',        'Caricamento servizi...'),
  ('booking_no_services',             'Nessun servizio disponibile nel catalogo.'),
  ('booking_birthday_off_suffix',     'OFF compleanno'),
  ('booking_choose_barber',           'Scegli il barbiere'),
  ('booking_loading_barbers',         'Caricamento barbieri...'),
  ('booking_retry',                   'Riprova'),
  ('booking_no_barbers',              'Nessun barbiere registrato.'),
  ('booking_no_photo',                'Senza foto'),
  ('booking_choose_day',              'Scegli il giorno'),
  ('booking_available_times',         'Orari disponibili'),
  ('booking_select_barber',           'Seleziona un barbiere.'),
  ('booking_loading_slots',           'Caricamento orari...'),
  ('booking_no_slots',                'Nessun orario disponibile per questa data.'),
  ('booking_slot_paid',               'Pagato'),
  ('booking_slot_scheduled',          'Prenotato'),
  ('booking_slot_disabled',           'Disabilitato'),
  ('booking_slot_available',          'Disponibile'),
  ('booking_barber_label',            'Barbiere'),
  ('booking_birthday_will_apply',     'Lo sconto compleanno verra applicato a questo servizio.'),
  ('booking_birthday_applied',        'Sconto compleanno applicato'),
  ('booking_original_price',          'Prezzo originale'),
  ('booking_final_price',             'Prezzo finale'),
  ('booking_payment_method',          'Metodo di pagamento'),
  ('booking_in_person_payment',       'Pagamento in presenza in barberia'),
  ('booking_submitting',              'Prenotazione...'),
  ('booking_confirm',                 'CONFERMA PRENOTAZIONE')
) AS t(key, value)
WHERE l.code = 'it'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;

-- 3. PORTUGUES
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('booking_expired_title',           'Sessao expirada'),
  ('booking_expired_desc',            'Faz login novamente para continuar.'),
  ('booking_auth_loading',            'A carregar autenticacao...'),
  ('booking_title_a',                 'AGENDAR'),
  ('booking_title_b',                 'HORARIO'),
  ('booking_subtitle',                'Escolhe dia e horario do teu corte'),
  ('booking_window_prefix',           'Agendamentos disponiveis de'),
  ('booking_window_middle',           'ate'),
  ('booking_birthday_promo_active',   'Promo aniversario ativa'),
  ('booking_birthday_promo_fallback', 'Tens desconto de aniversario no servico elegivel.'),
  ('booking_discount_label',          'Desconto'),
  ('booking_choose_service',          'Escolhe o servico'),
  ('booking_loading_services',        'A carregar servicos...'),
  ('booking_no_services',             'Nenhum servico disponivel no catalogo.'),
  ('booking_birthday_off_suffix',     'OFF aniversario'),
  ('booking_choose_barber',           'Escolhe o barbeiro'),
  ('booking_loading_barbers',         'A carregar barbeiros...'),
  ('booking_retry',                   'Tentar novamente'),
  ('booking_no_barbers',              'Nenhum barbeiro registado.'),
  ('booking_no_photo',                'Sem foto'),
  ('booking_choose_day',              'Escolhe o dia'),
  ('booking_available_times',         'Horarios disponiveis'),
  ('booking_select_barber',           'Seleciona um barbeiro.'),
  ('booking_loading_slots',           'A carregar horarios...'),
  ('booking_no_slots',                'Nenhum horario disponivel para esta data.'),
  ('booking_slot_paid',               'Pago'),
  ('booking_slot_scheduled',          'Agendado'),
  ('booking_slot_disabled',           'Desativado'),
  ('booking_slot_available',          'Disponivel'),
  ('booking_barber_label',            'Barbeiro'),
  ('booking_birthday_will_apply',     'O desconto de aniversario sera aplicado a este servico.'),
  ('booking_birthday_applied',        'Desconto de aniversario aplicado'),
  ('booking_original_price',          'Preco original'),
  ('booking_final_price',             'Preco final'),
  ('booking_payment_method',          'Metodo de pagamento'),
  ('booking_in_person_payment',       'Pagamento presencial na barbearia'),
  ('booking_submitting',              'A agendar...'),
  ('booking_confirm',                 'CONFIRMAR AGENDAMENTO')
) AS t(key, value)
WHERE l.code = 'pt'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;

-- 4. ENGLISH
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('booking_expired_title',           'Session expired'),
  ('booking_expired_desc',            'Sign in again to continue.'),
  ('booking_auth_loading',            'Loading authentication...'),
  ('booking_title_a',                 'BOOK'),
  ('booking_title_b',                 'A SLOT'),
  ('booking_subtitle',                'Choose day and time for your haircut'),
  ('booking_window_prefix',           'Bookings available from'),
  ('booking_window_middle',           'to'),
  ('booking_birthday_promo_active',   'Birthday promo active'),
  ('booking_birthday_promo_fallback', 'You have a birthday discount on the eligible service.'),
  ('booking_discount_label',          'Discount'),
  ('booking_choose_service',          'Choose service'),
  ('booking_loading_services',        'Loading services...'),
  ('booking_no_services',             'No services available in the catalogue.'),
  ('booking_birthday_off_suffix',     'OFF birthday'),
  ('booking_choose_barber',           'Choose barber'),
  ('booking_loading_barbers',         'Loading barbers...'),
  ('booking_retry',                   'Retry'),
  ('booking_no_barbers',              'No barbers registered.'),
  ('booking_no_photo',                'No photo'),
  ('booking_choose_day',              'Choose a day'),
  ('booking_available_times',         'Available times'),
  ('booking_select_barber',           'Select a barber.'),
  ('booking_loading_slots',           'Loading slots...'),
  ('booking_no_slots',                'No slots available for this date.'),
  ('booking_slot_paid',               'Paid'),
  ('booking_slot_scheduled',          'Booked'),
  ('booking_slot_disabled',           'Disabled'),
  ('booking_slot_available',          'Available'),
  ('booking_barber_label',            'Barber'),
  ('booking_birthday_will_apply',     'Birthday discount will be applied to this service.'),
  ('booking_birthday_applied',        'Birthday discount applied'),
  ('booking_original_price',          'Original price'),
  ('booking_final_price',             'Final price'),
  ('booking_payment_method',          'Payment method'),
  ('booking_in_person_payment',       'In-person payment at the barbershop'),
  ('booking_submitting',              'Booking...'),
  ('booking_confirm',                 'CONFIRM BOOKING')
) AS t(key, value)
WHERE l.code = 'en'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;

-- 5. ESPANOL
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('booking_expired_title',           'Sesion expirada'),
  ('booking_expired_desc',            'Inicia sesion de nuevo para continuar.'),
  ('booking_auth_loading',            'Cargando autenticacion...'),
  ('booking_title_a',                 'RESERVAR'),
  ('booking_title_b',                 'HORARIO'),
  ('booking_subtitle',                'Elige dia y hora de tu corte'),
  ('booking_window_prefix',           'Reservas disponibles de'),
  ('booking_window_middle',           'a'),
  ('booking_birthday_promo_active',   'Promo cumpleanos activa'),
  ('booking_birthday_promo_fallback', 'Tienes descuento de cumpleanos en el servicio elegible.'),
  ('booking_discount_label',          'Descuento'),
  ('booking_choose_service',          'Elige el servicio'),
  ('booking_loading_services',        'Cargando servicios...'),
  ('booking_no_services',             'Ningun servicio disponible en el catalogo.'),
  ('booking_birthday_off_suffix',     'OFF cumpleanos'),
  ('booking_choose_barber',           'Elige el barbero'),
  ('booking_loading_barbers',         'Cargando barberos...'),
  ('booking_retry',                   'Reintentar'),
  ('booking_no_barbers',              'Ningun barbero registrado.'),
  ('booking_no_photo',                'Sin foto'),
  ('booking_choose_day',              'Elige el dia'),
  ('booking_available_times',         'Horarios disponibles'),
  ('booking_select_barber',           'Selecciona un barbero.'),
  ('booking_loading_slots',           'Cargando horarios...'),
  ('booking_no_slots',                'Ningun horario disponible para esta fecha.'),
  ('booking_slot_paid',               'Pagado'),
  ('booking_slot_scheduled',          'Reservado'),
  ('booking_slot_disabled',           'Deshabilitado'),
  ('booking_slot_available',          'Disponible'),
  ('booking_barber_label',            'Barbero'),
  ('booking_birthday_will_apply',     'El descuento de cumpleanos se aplicara a este servicio.'),
  ('booking_birthday_applied',        'Descuento de cumpleanos aplicado'),
  ('booking_original_price',          'Precio original'),
  ('booking_final_price',             'Precio final'),
  ('booking_payment_method',          'Metodo de pago'),
  ('booking_in_person_payment',       'Pago presencial en la barberia'),
  ('booking_submitting',              'Reservando...'),
  ('booking_confirm',                 'CONFIRMAR RESERVA')
) AS t(key, value)
WHERE l.code = 'es'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;

-- 6. MAROQUINO
INSERT INTO language_translations (language_id, key, value)
SELECT l.id, t.key, t.value
FROM languages l
CROSS JOIN (VALUES
  ('booking_expired_title',           'Session salat'),
  ('booking_expired_desc',            '3awed dkhol bach tkemmel.'),
  ('booking_auth_loading',            'Kayt7emmel l2auth...'),
  ('booking_title_a',                 'HJZ'),
  ('booking_title_b',                 'LWA9T'),
  ('booking_subtitle',                'Khtar nhar w lwa9t dyal l9assa dyalek'),
  ('booking_window_prefix',           'L7jz mota7 men'),
  ('booking_window_middle',           '7tta'),
  ('booking_birthday_promo_active',   'Promo dyal 3id lmilad khdama'),
  ('booking_birthday_promo_fallback', '3endek tkhfida dyal 3id lmilad f service li kayt2ahal.'),
  ('booking_discount_label',          'Tkhfida'),
  ('booking_choose_service',          'Khtar service'),
  ('booking_loading_services',        'Kayt7emmlu services...'),
  ('booking_no_services',             'Ma kayn 7tta service f cataloge.'),
  ('booking_birthday_off_suffix',     'OFF 3id lmilad'),
  ('booking_choose_barber',           'Khtar l7ella9'),
  ('booking_loading_barbers',         'Kayt7emmlu l7ella9a...'),
  ('booking_retry',                   '3awed'),
  ('booking_no_barbers',              'Ma kayn 7tta 7ella9 mssajel.'),
  ('booking_no_photo',                'Bla tswira'),
  ('booking_choose_day',              'Khtar nhar'),
  ('booking_available_times',         'Lwa9t mota7'),
  ('booking_select_barber',           'Khtar 7ella9.'),
  ('booking_loading_slots',           'Kayt7emmlu lwa9t...'),
  ('booking_no_slots',                'Ma kayn 7tta wa9t f had tarikh.'),
  ('booking_slot_paid',               'Mkhalles'),
  ('booking_slot_scheduled',          'M7juz'),
  ('booking_slot_disabled',           'M3attel'),
  ('booking_slot_available',          'Mota7'),
  ('booking_barber_label',            'L7ella9'),
  ('booking_birthday_will_apply',     'Tkhfida dyal 3id lmilad ghadi ttb9a f had service.'),
  ('booking_birthday_applied',        'Ttb9at tkhfida dyal 3id lmilad'),
  ('booking_original_price',          'Taman l2asli'),
  ('booking_final_price',             'Taman l2akhiri'),
  ('booking_payment_method',          'Tari9at lkhlaas'),
  ('booking_in_person_payment',       'Lkhlaas presencial f l7anout'),
  ('booking_submitting',              'Kan7jzo...'),
  ('booking_confirm',                 '2AKKID L7JZ')
) AS t(key, value)
WHERE l.code = 'ma'
ON CONFLICT (language_id, key) DO UPDATE SET value = EXCLUDED.value;
