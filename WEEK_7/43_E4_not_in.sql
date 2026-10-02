-- E4: NOT IN → LEFT JOIN/NOT EXISTS
-- NOT IN (jebakan: NULL)
EXPLAIN (ANALYZE, BUFFERS) SELECT emp_no, first_name, last_name FROM pegawai WHERE emp_no NOT IN (SELECT emp_no FROM penempatan WHERE to_date = '9999-01-01');

-- NOT EXISTS (lebih aman)
EXPLAIN (ANALYZE, BUFFERS) SELECT p.emp_no, p.first_name, p.last_name FROM pegawai p WHERE NOT EXISTS (SELECT 1 FROM penempatan pe WHERE pe.emp_no = p.emp_no AND pe.to_date = '9999-01-01');
