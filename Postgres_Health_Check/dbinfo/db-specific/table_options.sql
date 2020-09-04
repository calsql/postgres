-- to find tables with options applied,
-- for example, tables with AUTOVACUUM turned off
SELECT
    relname,
    reloptions
FROM
    pg_class
WHERE
    reloptions IS NOT NULL;
/* vim: set expandtab:ts=4:sw=4 */
