-- B7: Query yang indeksnya diabaikan
-- Fungsi di kolom WHERE = non-sargable
-- Contoh: WHERE EXTRACT(YEAR FROM birth_date) = 1953  -> indeks birth_date tidak terpakai
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE EXTRACT(YEAR FROM birth_date) = 1953;

-- Perbaikan: tulis range langsung (sargable)
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE birth_date >= '1953-01-01' AND birth_date < '1954-01-01';

-- Contoh 2: UPPER(last_name) = 'SMIMEL' -> non-sargable
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE UPPER(last_name) = 'SMIMEL';

-- Perbaikan: pakai fungsi di sisi data atau citext/collation
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE last_name = 'Simmel';
