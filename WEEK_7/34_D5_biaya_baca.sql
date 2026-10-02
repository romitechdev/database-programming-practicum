-- D5: Biaya baca (JOIN vs ringkasan)
-- JOIN (hitung dari sumber)
EXPLAIN (ANALYZE, BUFFERS) SELECT d.dept_no, d.dept_name, COUNT(s.salary) AS total, AVG(s.salary) AS rata, MAX(s.salary) AS tertinggi, MIN(s.salary) AS terendah
FROM departemen d
JOIN penempatan pe ON pe.dept_no = d.dept_no AND pe.to_date = '9999-01-01'
JOIN gaji s ON s.emp_no = pe.emp_no AND s.to_date = '9999-01-01'
GROUP BY d.dept_no, d.dept_name;

-- Ringkasan (baca tabel kecil)
EXPLAIN (ANALYZE, BUFFERS) SELECT r.dept_no, d.dept_name, r.total, r.rata, r.tertinggi, r.terendah
FROM ringkasan_gaji_dept r
JOIN departemen d ON d.dept_no = r.dept_no;
