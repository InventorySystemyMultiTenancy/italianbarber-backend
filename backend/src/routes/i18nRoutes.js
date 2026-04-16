import { Router } from 'express';

import { getI18nByCode } from '../controllers/i18nController.js';

const router = Router();

router.get('/:code', getI18nByCode);

export default router;
