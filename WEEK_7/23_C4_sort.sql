-- C4: Sort (filesort) vs indeks
-- Tanpa indeks ORDER BY: butuh explicit sort
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai ORDER BY hire_date LIMIT 20;

-- Dengan indeks pada kolom ORDER BY
CREATE INDEX idx_pegawai_hire ON pegawai (hire_date);
ANALYZE pegawai;

-- Dengan indeks: tidak perlu sort
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai ORDER BY hire_date LIMIT 20;
