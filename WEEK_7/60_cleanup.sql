-- Cleanup: DROP semua objek buatan
DROP TRIGGER IF EXISTS trg_gaji_ubah ON gaji;
DROP FUNCTION IF EXISTS trg_maintain_ringkasan();
DROP FUNCTION IF EXISTS fn_gaji_berjalan(INT);
DROP TABLE IF EXISTS ringkasan_gaji_dept;
DROP INDEX IF EXISTS idx_gaji_empno;
DROP INDEX IF EXISTS idx_pegawai_lastname;
DROP INDEX IF EXISTS idx_gaji_todate_salary;
DROP INDEX IF EXISTS idx_gaji_salary_todate;
DROP INDEX IF EXISTS idx_gaji_covering;
DROP INDEX IF EXISTS idx_pegawai_hire;
DROP FOREIGN TABLE IF EXISTS f_employees, f_salaries, f_dept_emp, f_departments;
DROP SERVER IF EXISTS employees_srv CASCADE;
