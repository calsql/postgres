SELECT
  current_database ( )
,
  name,
  setting
FROM
  pg_settings
WHERE
  source = 'database';
