SELECT
    name,
    setting,
    boot_val,
    unit
FROM
    pg_settings
WHERE
    setting <> boot_val;
/* vim: set expandtab:ts=4:sw=4 */
