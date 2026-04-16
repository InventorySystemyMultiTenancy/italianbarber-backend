import { AppError } from '../utils/appError.js';
import { listTranslationsByLanguageCode } from '../repositories/i18nRepository.js';

const LANGUAGE_CODE_REGEX = /^[a-z]{2,10}$/;

export async function getI18nDictionaryByCode(rawCode) {
  const code = String(rawCode || '').trim().toLowerCase();

  if (!LANGUAGE_CODE_REGEX.test(code)) {
    throw new AppError('codigo de idioma invalido', 422, 'VALIDATION_ERROR');
  }

  const rows = await listTranslationsByLanguageCode(code);

  if (!rows) {
    throw new AppError('Idioma nao encontrado', 404, 'LANGUAGE_NOT_FOUND');
  }

  if (!rows[0].enabled) {
    throw new AppError('Idioma desativado', 404, 'LANGUAGE_NOT_FOUND');
  }

  return rows.reduce((accumulator, row) => {
    if (row.key) {
      accumulator[row.key] = row.value;
    }

    return accumulator;
  }, {});
}
