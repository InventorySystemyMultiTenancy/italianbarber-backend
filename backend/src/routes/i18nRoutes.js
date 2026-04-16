import { Router } from 'express';

import { getI18nByCode, postTranslateByProvider } from '../controllers/i18nController.js';

const router = Router();

router.post('/translate', postTranslateByProvider);
router.get('/:code', getI18nByCode);

export default router;
