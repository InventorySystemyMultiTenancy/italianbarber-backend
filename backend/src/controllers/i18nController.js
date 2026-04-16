import { sendSuccess } from '../utils/apiResponse.js';
import { getI18nDictionaryByCode } from '../services/i18nService.js';

export async function getI18nByCode(req, res, next) {
  try {
    const translations = await getI18nDictionaryByCode(req.params.code);
    return sendSuccess(res, 200, translations);
  } catch (error) {
    return next(error);
  }
}
