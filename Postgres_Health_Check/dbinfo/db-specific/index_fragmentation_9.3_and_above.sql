-- requires pgstattuple extension be installed
SELECT
    a.indexrelname,
    b.*
FROM
    pg_stat_user_indexes a,
    LATERAL pgstatindex (
        indexrelid )
    b
WHERE a.schemaname <> 'pg_catalog' and a.schemaname not in (select extname from pg_extension)
ORDER BY
    leaf_fragmentation DESC;
/* vim: set expandtab:ts=4:sw=4 */
