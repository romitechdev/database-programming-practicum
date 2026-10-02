-- B2: Tambah PK + indeks emp_no
ALTER TABLE pegawai ADD PRIMARY KEY (emp_no);
ALTER TABLE gaji    ADD PRIMARY KEY (emp_no, from_date);
CREATE INDEX idx_gaji_empno ON gaji (emp_no);

-- Ulangi Q1
SELECT * FROM pegawai WHERE emp_no = 250000; -- pemanasan
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE emp_no = 250000;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE emp_no = 250000;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE emp_no = 250000;

-- Ulangi Q2
SELECT * FROM gaji WHERE emp_no = 250000; -- pemanasan
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE emp_no = 250000;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE emp_no = 250000;
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE emp_no = 250000;
