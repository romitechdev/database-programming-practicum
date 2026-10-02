-- B6: Covering index (Index Only Scan)
-- Query: SELECT emp_no, salary FROM gaji WHERE to_date = '9999-01-01' ORDER BY salary;
-- Tanpa covering: butuh heap fetch
EXPLAIN (ANALYZE, BUFFERS) SELECT emp_no, salary FROM gaji WHERE to_date = '9999-01-01' ORDER BY salary;

-- Buat covering index
CREATE INDEX idx_gaji_covering ON gaji (to_date, salary) INCLUDE (emp_no);
ANALYZE gaji;

-- Dengan covering: Index Only Scan
EXPLAIN (ANALYZE, BUFFERS) SELECT emp_no, salary FROM gaji WHERE to_date = '9999-01-01' ORDER BY salary;
