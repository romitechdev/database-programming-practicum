-- B3: Tambah indeks last_name
CREATE INDEX idx_pegawai_lastname ON pegawai (last_name);

-- Ulangi Q3
SELECT * FROM pegawai WHERE last_name = 'Simmel'; -- pemanasan
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE last_name = 'Simmel';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE last_name = 'Simmel';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE last_name = 'Simmel';
