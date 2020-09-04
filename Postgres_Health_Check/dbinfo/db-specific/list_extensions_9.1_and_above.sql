-- requires 9.1.0+
SELECT
    name,
    default_version,
    installed_version,
    LEFT (
        comment,
        30 ) AS comment
FROM
    pg_available_extensions
WHERE
    installed_version IS NOT NULL
ORDER BY
    name;
/* vim: set expandtab:ts=4:sw=4 */
