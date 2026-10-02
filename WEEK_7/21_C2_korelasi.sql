-- C2: Subquery korelasi vs dekorrelasi
-- Korelasi: untuk tiap pegawai, hitung total gajinya
EXPLAIN (ANALYZE, BUFFERS) SELECT p.*, (SELECT SUM(s.salary) FROM gaji s WHERE s.emp_no = p.emp_no) AS total_gaji FROM pegawai p LIMIT 100;

-- Dekorrelasi: JOIN + GROUP BY
EXPLAIN (ANALYZE, BUFFERS) SELECT p.*, x.total_gaji FROM pegawai p JOIN (SELECT emp_no, SUM(salary) AS total_gaji FROM gaji GROUP BY emp_no) x ON x.emp_no = p.emp_no LIMIT 100;
