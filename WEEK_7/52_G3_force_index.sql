-- G3: Force index (enable_seqscan=off)
SET enable_seqscan = off;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE last_name = 'Simmel';
RESET enable_seqscan;

-- Perbandingan: enable_seqscan=on (default)
SET enable_seqscan = on;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE last_name = 'Simmel';
