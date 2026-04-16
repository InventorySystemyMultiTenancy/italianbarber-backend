import { query } from '../db/pool.js';

function mapLanguage(row) {
  return {
    id: row.id,
    code: row.code,
    name: row.name,
    countryCode: row.country_code,
    flag: row.flag || null,
    enabled: Boolean(row.enabled),
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

export async function listEnabledLanguages() {
  const result = await query(
    `
      SELECT id, code, name, country_code, flag, enabled, created_at, updated_at
      FROM languages
      WHERE enabled = true
      ORDER BY name ASC
    `,
  );

  return result.rows.map(mapLanguage);
}

export async function insertLanguage({ code, name, countryCode, flag, enabled }) {
  const result = await query(
    `
      INSERT INTO languages (code, name, country_code, flag, enabled)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING id, code, name, country_code, flag, enabled, created_at, updated_at
    `,
    [code, name, countryCode, flag, enabled],
  );

  return mapLanguage(result.rows[0]);
}

export async function getLanguageByCode(code) {
  const result = await query(
    `
      SELECT id, code, name, country_code, flag, enabled, created_at, updated_at
      FROM languages
      WHERE code = $1
      LIMIT 1
    `,
    [code],
  );

  if (result.rowCount === 0) {
    return null;
  }

  return mapLanguage(result.rows[0]);
}
