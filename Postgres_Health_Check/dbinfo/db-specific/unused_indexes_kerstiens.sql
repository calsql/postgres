-- adapted from http://www.craigkerstiens.com/2013/05/30/a-collection-of-indexing-tips/
SELECT
    schemaname AS SCHEMA,
    relname AS TABLE,
    indexrelname AS index,
    pg_size_pretty (
        pg_relation_size (
            i.indexrelid ) ) AS index_size,
    idx_scan AS index_scans
FROM
    pg_stat_user_indexes ui
    JOIN pg_index i ON ui.indexrelid = i.indexrelid
WHERE
    NOT indisunique
    AND idx_scan < 50
    AND pg_relation_size (
        relid )
    > (
        5 * 8192 )
ORDER BY
    pg_relation_size (
        i.indexrelid )
    DESC,
    (
        pg_relation_size (
            i.indexrelid )
        / NULLIF (
            idx_scan,
            0 ) )
    DESC NULLS FIRST;
/* vim: set expandtab:ts=4:sw=4 */
