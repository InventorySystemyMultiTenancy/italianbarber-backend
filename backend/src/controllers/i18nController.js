import { sendSuccess } from '../utils/apiResponse.js';
import { getI18nDictionaryByCode } from '../services/i18nService.js';
import { translateEntriesByProvider } from '../services/translationGatewayService.js';

export async function getI18nByCode(req, res, next) {
  try {
    const translations = await getI18nDictionaryByCode(req.params.code);
    return sendSuccess(res, 200, translations);
  } catch (error) {
    return next(error);
  }
}

export async function postTranslateByProvider(req, res, next) {
  try {
    const data = await translateEntriesByProvider({
      provider: req.body.provider,
      source: req.body.source,
      target: req.body.target,
      entries: req.body.entries,
      context: req.body.context,
    });

    return sendSuccess(res, 200, data);
  } catch (error) {
    return next(error);
  }
}
