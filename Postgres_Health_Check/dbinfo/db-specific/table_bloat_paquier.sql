-- http://michael.otacoo.com/manuals/postgresql/useful-queries/
SELECT
    relname,
    seq_scan,
    idx_scan,
    n_live_tup,
    n_dead_tup,
    to_char (
        n_dead_tup / n_live_tup::real,
        '999D99' ) ::real AS ratio,
    pg_size_pretty (
        pg_relation_size (
            relid ) )
FROM
    pg_stat_all_tables
WHERE
    pg_relation_size (
        relid )
    > 1024 * 1024
    AND n_live_tup > 0
ORDER BY
    n_dead_tup / n_live_tup::real DESC
LIMIT 10;
/* vim: set expandtab:ts=4:sw=4 */
