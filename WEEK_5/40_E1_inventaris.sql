SELECT
    routine_name   AS nama_fungsi,
    data_type      AS tipe_kembali,
    routine_type   AS tipe,
    is_deterministic,
    security_type,
    created        AS dibuat,
    last_altered   AS diubah_terakhir
FROM information_schema.routines
WHERE routine_schema = 'public'
  AND routine_type = 'FUNCTION'
  AND routine_name LIKE 'fn\_%'
ORDER BY routine_name;

SELECT
    p.proname        AS nama_fungsi,
    t.typname        AS tipe_kembali,
    CASE p.provolatile
        WHEN 'i' THEN 'IMMUTABLE'
        WHEN 's' THEN 'STABLE'
        WHEN 'v' THEN 'VOLATILE'
    END             AS karakteristik
FROM pg_proc p
JOIN pg_namespace n ON n.oid = p.pronamespace
JOIN pg_type t      ON t.oid = p.prorettype
WHERE n.nspname = 'public'
  AND p.proname LIKE 'fn\_%'
ORDER BY p.proname;
