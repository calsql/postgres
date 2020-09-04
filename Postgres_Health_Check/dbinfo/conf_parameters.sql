SELECT
    name,
    context,
    unit,
    setting,
    boot_val,
    reset_val
FROM
    pg_settings
ORDER BY
    context,
    name;
/* vim: set expandtab:ts=4:sw=4 */
