SELECT
    c.relname AS tablename,
    n.nspname AS schemaname,
    CASE
        WHEN t.spcname IS NULL THEN 'pg_default'
        ELSE t.spcname
    END AS tablespace,
    pg_catalog.array_to_string (
        c.reloptions || ARRAY (
            SELECT
                'toast.' || x
FROM
    pg_catalog.unnest (
        tc.reloptions )
    x ),
        ', ' ) AS reloptions,
    c.relpersistence,
    tc.relname AS toast_table
FROM
    pg_catalog.pg_class c
    LEFT JOIN pg_catalog.pg_class tc ON (
        c.reltoastrelid = tc.oid )
    LEFT JOIN pg_catalog.pg_namespace n ON (
        c.relnamespace = n.oid )
    LEFT JOIN pg_catalog.pg_tablespace t ON (
        c.reltablespace = t.oid )
WHERE
    c.relkind = 'r'
    AND n.nspname NOT IN (
        'pg_catalog',
        'information_schema',
        'sys',
        'dbo' )
    AND (
        c.reloptions IS NOT NULL
        OR tc.reloptions IS NOT NULL );
/* vim: set expandtab:ts=4:sw=4 */
