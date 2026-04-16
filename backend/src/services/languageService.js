import { AppError } from '../utils/appError.js';
import { insertLanguage, listEnabledLanguages } from '../repositories/languageRepository.js';

const LANGUAGE_CODE_REGEX = /^[a-z]{2,10}$/;
const COUNTRY_CODE_REGEX = /^[A-Z]{2}$/;

function normalizeNullable(value) {
  const text = String(value || '').trim();
  return text ? text : null;
}

export async function getPublicLanguages() {
  return listEnabledLanguages();
}

export async function createLanguage({ code, name, countryCode, flag, enabled }) {
  const normalizedCode = String(code || '').trim().toLowerCase();
  const normalizedName = String(name || '').trim();
  const normalizedCountryCode = String(countryCode || '').trim().toUpperCase();
  const normalizedFlag = normalizeNullable(flag);

  if (!normalizedCode) {
    throw new AppError('code obrigatorio', 422, 'VALIDATION_ERROR');
  }

  if (!LANGUAGE_CODE_REGEX.test(normalizedCode)) {
    throw new AppError('code invalido. Use apenas minusculo (2 a 10 letras)', 422, 'VALIDATION_ERROR');
  }

  if (!normalizedName) {
    throw new AppError('name obrigatorio', 422, 'VALIDATION_ERROR');
  }

  if (!normalizedCountryCode) {
    throw new AppError('country_code obrigatorio', 422, 'VALIDATION_ERROR');
  }

  if (!COUNTRY_CODE_REGEX.test(normalizedCountryCode)) {
    throw new AppError('country_code invalido. Use 2 letras maiusculas', 422, 'VALIDATION_ERROR');
  }

  try {
    return await insertLanguage({
      code: normalizedCode,
      name: normalizedName,
      countryCode: normalizedCountryCode,
      flag: normalizedFlag,
      enabled: enabled === undefined ? true : Boolean(enabled),
    });
  } catch (error) {
    if (error.code === '23505') {
      throw new AppError('code ja cadastrado', 409, 'LANGUAGE_CODE_ALREADY_EXISTS');
    }

    throw error;
  }
}
