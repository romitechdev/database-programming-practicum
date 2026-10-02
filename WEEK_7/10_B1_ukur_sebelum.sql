-- B1: Pengukuran awal (tanpa indeks)
-- Setiap query: 1 pemanasan + 3 pengukuran, catat median

-- Q1: SELECT * FROM pegawai WHERE emp_no = 250000;
SELECT * FROM pegawai WHERE emp_no = 250000; -- pemanasan
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE emp_no = 250000;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE emp_no = 250000;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE emp_no = 250000;

-- Q2: SELECT * FROM gaji WHERE emp_no = 250000;
SELECT * FROM gaji WHERE emp_no = 250000; -- pemanasan
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE emp_no = 250000;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE emp_no = 250000;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE emp_no = 250000;

-- Q3: SELECT * FROM pegawai WHERE last_name = 'Simmel';
SELECT * FROM pegawai WHERE last_name = 'Simmel'; -- pemanasan
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE last_name = 'Simmel';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE last_name = 'Simmel';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE last_name = 'Simmel';

-- Q4: SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';
SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01'; -- pemanasan
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';
