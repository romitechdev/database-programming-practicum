-- D3: Fungsi di WHERE vs langsung
-- Fungsi di WHERE (non-sargable)
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM pegawai WHERE fn_gaji_berjalan(emp_no) > 90000;

-- Langsung (sargable)
EXPLAIN (ANALYZE, BUFFERS) SELECT p.* FROM pegawai p JOIN gaji s ON s.emp_no = p.emp_no AND s.to_date = '9999-01-01' WHERE s.salary > 90000;
