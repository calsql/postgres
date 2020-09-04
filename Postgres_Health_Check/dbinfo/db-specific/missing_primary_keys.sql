SELECT
    n.nspname AS SCHEMA,
    c.relname AS TABLE
FROM
    pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE
    c.relkind = 'r'
    AND NOT EXISTS (
        SELECT
            1
FROM
    pg_constraint con
WHERE
    con.conrelid = c.oid
    AND con.contype = 'p' )
ORDER BY
    n.nspname,
    c.relname;
/* vim: set expandtab:ts=4:sw=4 */
