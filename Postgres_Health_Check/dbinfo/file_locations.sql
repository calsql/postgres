SELECT
    name,
    setting
FROM
    pg_settings
WHERE
    category = 'File Locations';
/* vim: set expandtab:ts=4:sw=4 */
