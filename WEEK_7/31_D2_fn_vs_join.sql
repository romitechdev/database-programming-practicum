-- D2: Fungsi per baris vs JOIN
-- Fungsi per baris (300.024 panggilan)
EXPLAIN (ANALYZE, BUFFERS) SELECT emp_no, first_name, last_name, fn_gaji_berjalan(emp_no) AS gaji_berjalan FROM pegawai;

-- JOIN
EXPLAIN (ANALYZE, BUFFERS) SELECT p.emp_no, p.first_name, p.last_name, s.salary AS gaji_berjalan FROM pegawai p JOIN gaji s ON s.emp_no = p.emp_no AND s.to_date = '9999-01-01';
