-- B4: Uji 2 susunan indeks gabungan untuk Q4
-- Q4: SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';

-- Susunan 1: (to_date, salary) — equality di depan
DROP INDEX IF EXISTS idx_gaji_todate_salary;
CREATE INDEX idx_gaji_todate_salary ON gaji (to_date, salary);
ANALYZE gaji;

SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01'; -- pemanasan
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';

-- Susunan 2: (salary, to_date) — range di depan
DROP INDEX IF EXISTS idx_gaji_salary_todate;
CREATE INDEX idx_gaji_salary_todate ON gaji (salary, to_date);
ANALYZE gaji;

SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01'; -- pemanasan
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = '9999-01-01';
