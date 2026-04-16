import cors from 'cors';
import express from 'express';

import adminRoutes from './routes/adminRoutes.js';
import appointmentRoutes from './routes/appointmentRoutes.js';
import authRoutes from './routes/authRoutes.js';
import barberRoutes from './routes/barberRoutes.js';
import healthRoutes from './routes/healthRoutes.js';
import i18nRoutes from './routes/i18nRoutes.js';
import languageRoutes from './routes/languageRoutes.js';
import { errorHandler, notFoundHandler } from './middlewares/errorMiddleware.js';

const app = express();
const defaultOrigins = [
  'http://localhost:5173',
  'http://localhost:8080',
  'https://chincoacortes.selfmachine.com.br',
  'https://italianexample.selfmachine.com.br',
];
const appointmentDebugLogs = String(process.env.APPOINTMENT_DEBUG_LOGS || '').trim() === 'true';

function normalizeOrigin(origin) {
  return String(origin || '').trim().replace(/\/+$/, '');
}

function getAllowedOrigins() {
  const fromCorsOrigins = (process.env.CORS_ORIGINS || '')
    .split(',')
    .map((origin) => normalizeOrigin(origin))
    .filter(Boolean);

  const fromFrontendOrigin = process.env.FRONTEND_ORIGIN ? [normalizeOrigin(process.env.FRONTEND_ORIGIN)] : [];

  return [...new Set([...defaultOrigins.map(normalizeOrigin), ...fromCorsOrigins, ...fromFrontendOrigin])];
}

const allowedOrigins = getAllowedOrigins();

app.use(
  cors({
    origin(origin, callback) {
      const normalizedOrigin = normalizeOrigin(origin);

      if (!origin || allowedOrigins.includes(normalizedOrigin)) {
        callback(null, true);
        return;
      }

      callback(new Error(`Origin not allowed by CORS: ${origin}`));
    },
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Origin', 'X-Requested-With', 'Content-Type', 'Accept', 'Authorization'],
    optionsSuccessStatus: 204,
  }),
);

app.use((req, res, next) => {
  const requestOrigin = normalizeOrigin(req.headers.origin);

  if (requestOrigin && allowedOrigins.includes(requestOrigin)) {
    res.header('Access-Control-Allow-Origin', requestOrigin);
    res.header('Vary', 'Origin');
  }

  res.header('Access-Control-Allow-Methods', 'GET,POST,PUT,PATCH,DELETE,OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin,X-Requested-With,Content-Type,Accept,Authorization');

  if (req.method === 'OPTIONS') {
    return res.sendStatus(204);
  }

  return next();
});

const requestBodyLimit = String(process.env.REQUEST_BODY_LIMIT || '10mb').trim() || '10mb';
app.use(express.json({ limit: requestBodyLimit }));
app.use(express.urlencoded({ extended: true, limit: requestBodyLimit }));

if (appointmentDebugLogs) {
  app.use((req, res, next) => {
    if (!req.path.startsWith('/api/appointments')) {
      return next();
    }

    const startedAt = Date.now();
    const payload = req.method === 'POST' ? req.body : req.query;
    const authHeader = req.headers.authorization;

    console.log(
      '[appointments:req]',
      JSON.stringify({
        method: req.method,
        path: req.path,
        payload,
        hasAuth: Boolean(authHeader),
      }),
    );

    res.on('finish', () => {
      console.log(
        '[appointments:res]',
        JSON.stringify({
          method: req.method,
          path: req.path,
          statusCode: res.statusCode,
          durationMs: Date.now() - startedAt,
        }),
      );
    });

    return next();
  });
}

app.use('/api', healthRoutes);
app.use('/api/auth', authRoutes);
app.use('/api/barbers', barberRoutes);
app.use('/api/appointments', appointmentRoutes);
app.use('/api/languages', languageRoutes);
app.use('/api/i18n', i18nRoutes);
app.use('/api/admin', adminRoutes);

app.use(notFoundHandler);
app.use(errorHandler);

export { allowedOrigins };
export default app;
