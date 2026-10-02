-- C3: SELECT * vs kolom seperlunya
-- SELECT * (ambil semua kolom)
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE to_date = '9999-01-01';

-- Kolom seperlunya (bisa pakai covering index)
EXPLAIN (ANALYZE, BUFFERS) SELECT emp_no, salary FROM gaji WHERE to_date = '9999-01-01';
