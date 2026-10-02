-- C6: Agregasi subquery vs JOIN+GROUP BY
-- Subquery: rata-rata gaji per departemen (korelasi)
EXPLAIN (ANALYZE, BUFFERS) SELECT d.dept_no, d.dept_name, (SELECT AVG(s.salary) FROM gaji s JOIN penempatan pe ON pe.emp_no = s.emp_no WHERE pe.dept_no = d.dept_no) AS rata_gaji FROM departemen d;

-- JOIN + GROUP BY
EXPLAIN (ANALYZE, BUFFERS) SELECT d.dept_no, d.dept_name, AVG(s.salary) AS rata_gaji FROM departemen d JOIN penempatan pe ON pe.dept_no = d.dept_no JOIN gaji s ON s.emp_no = pe.emp_no GROUP BY d.dept_no, d.dept_name;
