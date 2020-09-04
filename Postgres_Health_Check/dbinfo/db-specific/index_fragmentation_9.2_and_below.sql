-- requires pgstattuple extension be installed
SELECT (
        x.a )
.indexrelname,
    (
        x.b )
.*
FROM (
        SELECT
            a,
            pgstatindex (
                a.indexrelid ) AS b
FROM
    pg_stat_user_indexes a )
    x
WHERE (x.a).schemaname <> 'pg_catalog' and (x.a).schemaname not in (select extname from pg_extension)
ORDER BY
    leaf_fragmentation DESC;
/* vim: set expandtab:ts=4:sw=4 */
