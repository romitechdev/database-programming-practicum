-- C1: IN vs EXISTS vs JOIN
-- Cari pegawai yang punya gaji > 90000

-- IN
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE emp_no IN (SELECT emp_no FROM gaji WHERE salary > 90000);

-- EXISTS
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai p WHERE EXISTS (SELECT 1 FROM gaji g WHERE g.emp_no = p.emp_no AND g.salary > 90000);

-- JOIN
EXPLAIN (ANALYZE, BUFFERS) SELECT p.* FROM pegawai p JOIN gaji g ON g.emp_no = p.emp_no WHERE g.salary > 90000;
