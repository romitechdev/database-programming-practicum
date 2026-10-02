CREATE EXTENSION IF NOT EXISTS postgres_fdw;

DROP SERVER IF EXISTS employees_srv CASCADE;
CREATE SERVER employees_srv FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'localhost', dbname 'employees');
CREATE USER MAPPING FOR romi SERVER employees_srv
    OPTIONS (user 'reader_employees', password 'reader123');

CREATE FOREIGN TABLE f_employees (emp_no int, birth_date date, first_name varchar(14),
    last_name varchar(16), gender char(1), hire_date date)
    SERVER employees_srv OPTIONS (schema_name 'public', table_name 'employees');
CREATE FOREIGN TABLE f_salaries (emp_no int, salary int, from_date date, to_date date)
    SERVER employees_srv OPTIONS (schema_name 'public', table_name 'salaries');
CREATE FOREIGN TABLE f_dept_emp (emp_no int, dept_no char(4), from_date date, to_date date)
    SERVER employees_srv OPTIONS (schema_name 'public', table_name 'dept_emp');
CREATE FOREIGN TABLE f_departments (dept_no char(4), dept_name varchar(40))
    SERVER employees_srv OPTIONS (schema_name 'public', table_name 'departments');

CREATE TABLE pegawai    AS SELECT * FROM f_employees;
CREATE TABLE gaji       AS SELECT * FROM f_salaries;
CREATE TABLE penempatan AS SELECT * FROM f_dept_emp;
CREATE TABLE departemen AS SELECT * FROM f_departments;

ANALYZE pegawai, gaji, penempatan, departemen;

SELECT 'pegawai' AS tabel, count(*) AS baris FROM pegawai
UNION ALL SELECT 'gaji', count(*) FROM gaji
UNION ALL SELECT 'penempatan', count(*) FROM penempatan
UNION ALL SELECT 'departemen', count(*) FROM departemen
ORDER BY tabel;
