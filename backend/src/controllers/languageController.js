import { sendSuccess } from '../utils/apiResponse.js';
import { getPublicLanguages } from '../services/languageService.js';

export async function getLanguages(_req, res, next) {
  try {
    const languages = await getPublicLanguages();
    return sendSuccess(res, 200, languages);
  } catch (error) {
    return next(error);
  }
}
