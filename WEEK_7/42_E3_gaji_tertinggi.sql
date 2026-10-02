-- E3: Gaji tertinggi per dept (subquery)
SELECT d.dept_no, d.dept_name, MAX(s.salary) AS gaji_tertinggi
FROM departemen d
JOIN penempatan pe ON pe.dept_no = d.dept_no AND pe.to_date = '9999-01-01'
JOIN gaji s ON s.emp_no = pe.emp_no AND s.to_date = '9999-01-01'
GROUP BY d.dept_no, d.dept_name;
