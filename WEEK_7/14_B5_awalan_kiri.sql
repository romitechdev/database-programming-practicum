-- B5: Aturan awalan kiri (leftmost prefix)
-- Pakai idx_gaji_salary_todate (salary, to_date)
-- Query 1: WHERE salary = 90000 (pakai kolom pertama) -> harus pakai indeks
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary = 90000;

-- Query 2: WHERE to_date = '9999-01-01' (hanya kolom kedua) -> tidak bisa pakai indeks
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE to_date = '9999-01-01';

-- Query 3: WHERE salary = 90000 AND to_date = '9999-01-01' (dua-duanya) -> pakai indeks penuh
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary = 90000 AND to_date = '9999-01-01';
