-- http://michael.otacoo.com/manuals/postgresql/useful-queries/
SELECT
    schemaname || '.' || relname AS TABLE,
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
        1024 * 1024 )
ORDER BY
    (
        pg_relation_size (
            i.indexrelid )
        / NULLIF (
            idx_scan,
            0 ) )
    DESC NULLS FIRST,
    pg_relation_size (
        i.indexrelid )
    DESC;
/* vim: set expandtab:ts=4:sw=4 */
