-- D8: Verifikasi ketepatan ringkasan
-- Bandingkan hasil JOIN vs tabel ringkasan
SELECT 'JOIN' AS sumber, d.dept_no, COUNT(s.salary) AS total, ROUND(AVG(s.salary),2) AS rata, MAX(s.salary) AS tertinggi, MIN(s.salary) AS terendah
FROM departemen d
JOIN penempatan pe ON pe.dept_no = d.dept_no AND pe.to_date = '9999-01-01'
JOIN gaji s ON s.emp_no = pe.emp_no AND s.to_date = '9999-01-01'
GROUP BY d.dept_no
UNION ALL
SELECT 'RINGKASAN', dept_no, total, rata, tertinggi, terendah
FROM ringkasan_gaji_dept
ORDER BY dept_no, sumber;
