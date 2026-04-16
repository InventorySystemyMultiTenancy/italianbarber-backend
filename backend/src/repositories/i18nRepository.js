import { query } from '../db/pool.js';

export async function listTranslationsByLanguageCode(code) {
  const result = await query(
    `
      SELECT
        l.id AS language_id,
        l.code,
        l.enabled,
        lt.key,
        lt.value
      FROM languages l
      LEFT JOIN language_translations lt
        ON lt.language_id = l.id
      WHERE l.code = $1
      ORDER BY lt.key ASC NULLS LAST
    `,
    [code],
  );

  if (result.rowCount === 0) {
    return null;
  }

  return result.rows;
}
