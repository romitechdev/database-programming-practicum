-- C7: DISTINCT vs GROUP BY
-- Daftar dept_no unik
EXPLAIN (ANALYZE, BUFFERS) SELECT DISTINCT dept_no FROM penempatan;

EXPLAIN (ANALYZE, BUFFERS) SELECT dept_no FROM penempatan GROUP BY dept_no;
