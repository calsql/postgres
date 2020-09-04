SELECT
    datname,
    pg_size_pretty (
        pg_database_size (
            oid ) )
FROM
    pg_database
ORDER BY
    pg_database_size (
        oid )
    DESC;
/* vim: set expandtab:ts=4:sw=4 */
