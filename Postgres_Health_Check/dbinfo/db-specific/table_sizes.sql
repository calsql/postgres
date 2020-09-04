SELECT
    relname,
    pg_relation_filepath (
        oid ),
    pg_size_pretty (
        relpages::bigint * 8 * 1024 )
FROM
    pg_class
ORDER BY
    relpages DESC;
/* vim: set expandtab:ts=4:sw=4 */
