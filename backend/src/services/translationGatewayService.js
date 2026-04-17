import { AppError } from '../utils/appError.js';

const DEFAULT_PROVIDER = String(process.env.TRANSLATION_PROVIDER || 'mymemory').trim().toLowerCase();
const MYMEMORY_BASE_URL = String(process.env.MYMEMORY_BASE_URL || 'https://api.mymemory.translated.net').trim().replace(/\/+$/, '');
const MYMEMORY_CONTACT_EMAIL = String(process.env.MYMEMORY_CONTACT_EMAIL || '').trim();
const DEEPL_BASE_URL = String(process.env.DEEPL_BASE_URL || 'https://api-free.deepl.com').trim().replace(/\/+$/, '');
const DEEPL_AUTH_KEY = String(process.env.DEEPL_AUTH_KEY || '').trim();
const REQUEST_TIMEOUT_MS = Number(process.env.TRANSLATION_REQUEST_TIMEOUT_MS || 15000);
const ENABLE_TRANSLATION_FALLBACK = String(process.env.ENABLE_TRANSLATION_FALLBACK || 'true').trim().toLowerCase() !== 'false';

const LANGUAGE_CODE_REGEX = /^[a-z]{2,10}(-[A-Z]{2})?$/;

function parseEntries(entries) {
  if (!entries || typeof entries !== 'object' || Array.isArray(entries)) {
    throw new AppError('entries deve ser um objeto chave/valor', 422, 'VALIDATION_ERROR');
  }

  const pairs = Object.entries(entries)
    .map(([key, value]) => [String(key || '').trim(), String(value ?? '').trim()])
    .filter(([key, value]) => key && value);

  if (pairs.length === 0) {
    throw new AppError('entries deve ter ao menos uma chave com texto', 422, 'VALIDATION_ERROR');
  }

  return pairs;
}

function normalizeLanguageCode(value, fieldName) {
  const normalized = String(value || '').trim();

  if (!normalized) {
    throw new AppError(`${fieldName} obrigatorio`, 422, 'VALIDATION_ERROR');
  }

  if (!LANGUAGE_CODE_REGEX.test(normalized)) {
    throw new AppError(`${fieldName} invalido`, 422, 'VALIDATION_ERROR');
  }

  return normalized;
}

async function fetchWithTimeout(url, options = {}) {
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), REQUEST_TIMEOUT_MS);

  try {
    return await fetch(url, {
      ...options,
      signal: controller.signal,
    });
  } catch (error) {
    if (error.name === 'AbortError') {
      throw new AppError('Timeout ao consultar provedor de traducao', 504, 'TRANSLATION_PROVIDER_TIMEOUT');
    }

    throw error;
  } finally {
    clearTimeout(timeoutId);
  }
}

async function translateWithMyMemory({ source, target, text }) {
  const searchParams = new URLSearchParams({
    q: text,
    langpair: `${source}|${target}`,
  });

  if (MYMEMORY_CONTACT_EMAIL) {
    searchParams.set('de', MYMEMORY_CONTACT_EMAIL);
  }

  const response = await fetchWithTimeout(`${MYMEMORY_BASE_URL}/get?${searchParams.toString()}`, {
    method: 'GET',
  });

  if (!response.ok) {
    const details = await response.text();
    throw new AppError('Falha ao traduzir com MyMemory', 502, 'TRANSLATION_PROVIDER_ERROR', {
      provider: 'mymemory',
      status: response.status,
      details,
    });
  }

  const data = await response.json();
  return String(data?.responseData?.translatedText || '').trim();
}

async function translateWithDeepLBatch({ source, target, pairs, context }) {
  if (!DEEPL_AUTH_KEY) {
    throw new AppError('DEEPL_AUTH_KEY nao configurada', 500, 'TRANSLATION_PROVIDER_NOT_CONFIGURED');
  }

  const deepLTarget = target.toUpperCase();
  const deepLSource = source.includes('-') ? source.toUpperCase() : source.toUpperCase();

  const payload = {
    text: pairs.map(([, value]) => value),
    target_lang: deepLTarget,
    source_lang: deepLSource,
  };

  if (context) {
    payload.context = String(context).trim();
  }

  const response = await fetchWithTimeout(`${DEEPL_BASE_URL}/v2/translate`, {
    method: 'POST',
    headers: {
      Authorization: `DeepL-Auth-Key ${DEEPL_AUTH_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  });

  if (!response.ok) {
    const details = await response.text();
    throw new AppError('Falha ao traduzir com DeepL', 502, 'TRANSLATION_PROVIDER_ERROR', {
      provider: 'deepl',
      status: response.status,
      details,
    });
  }

  const data = await response.json();
  const translations = Array.isArray(data.translations) ? data.translations : [];

  if (translations.length !== pairs.length) {
    throw new AppError('Resposta inesperada do DeepL', 502, 'TRANSLATION_PROVIDER_ERROR', {
      provider: 'deepl',
    });
  }

  return pairs.reduce((accumulator, [key], index) => {
    accumulator[key] = String(translations[index]?.text || '').trim();
    return accumulator;
  }, {});
}

function isProviderUnavailableError(error) {
  return error instanceof AppError
    && error.code === 'TRANSLATION_PROVIDER_ERROR';
}

function getFallbackProviders(selectedProvider) {
  if (selectedProvider === 'deepl') {
    return ['deepl', 'mymemory'];
  }

  if (selectedProvider === 'mymemory' || selectedProvider === 'libretranslate') {
    return ['mymemory', 'deepl'];
  }

  throw new AppError('provider invalido. Use mymemory ou deepl', 422, 'VALIDATION_ERROR');
}

async function translateSingleTextWithProvider(provider, payload) {
  if (provider === 'mymemory') {
    return translateWithMyMemory(payload);
  }

  if (provider === 'deepl') {
    const deepLBatchResult = await translateWithDeepLBatch({
      source: payload.source,
      target: payload.target,
      pairs: [['value', payload.text]],
      context: payload.context,
    });

    return String(deepLBatchResult.value || '').trim();
  }

  throw new AppError('provider invalido. Use mymemory ou deepl', 422, 'VALIDATION_ERROR');
}

export async function translateEntriesByProvider({ provider, source, target, entries, context }) {
  const requestedProvider = String(provider || DEFAULT_PROVIDER).trim().toLowerCase();
  const selectedProvider = requestedProvider === 'libretranslate' ? 'mymemory' : requestedProvider;
  const normalizedSource = normalizeLanguageCode(source, 'source');
  const normalizedTarget = normalizeLanguageCode(target, 'target');
  const pairs = parseEntries(entries);

  const providers = getFallbackProviders(selectedProvider);
  const translatedPairs = await Promise.all(
    pairs.map(async ([key, value]) => {
      let lastError = null;

      for (const providerCandidate of providers) {
        try {
          const translated = await translateSingleTextWithProvider(providerCandidate, {
            source: normalizedSource,
            target: normalizedTarget,
            text: value,
            context,
          });

          if (translated) {
            return [key, translated, providerCandidate];
          }
        } catch (error) {
          lastError = error;

          if (!ENABLE_TRANSLATION_FALLBACK || !isProviderUnavailableError(error)) {
            throw error;
          }
        }
      }

      if (!ENABLE_TRANSLATION_FALLBACK && lastError) {
        throw lastError;
      }

      return [key, value, 'fallback-source'];
    }),
  );

  const providersUsed = [...new Set(translatedPairs.map(([, , providerUsed]) => providerUsed))];

  return {
    provider: providersUsed[0] || selectedProvider,
    providersUsed,
    source: normalizedSource,
    target: normalizedTarget,
    translations: Object.fromEntries(translatedPairs.map(([key, translated]) => [key, translated])),
  };
}
