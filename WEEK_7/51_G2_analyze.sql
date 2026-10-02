-- G2: Pengaruh ANALYZE
-- Ubah data sehingga statistik lama jadi tidak akurat
UPDATE gaji SET salary = salary * 1.1 WHERE emp_no BETWEEN 400000 AND 401000;

-- Query dengan statistik basi (planner belum tahu data berubah)
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary > 100000;

-- ANALYZE untuk memperbarui statistik
ANALYZE gaji;

-- Query dengan statistik segar
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary > 100000;
