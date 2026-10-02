-- C5: OFFSET vs keyset pagination
-- OFFSET (halaman 1000, 20 item per halaman)
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai ORDER BY emp_no LIMIT 20 OFFSET 20000;

-- Keyset (bawaan: terakhir emp_no di halaman sebelumnya)
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE emp_no > 20000 ORDER BY emp_no LIMIT 20;
