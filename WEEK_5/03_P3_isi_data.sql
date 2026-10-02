
CREATE EXTENSION IF NOT EXISTS postgres_fdw;

DROP SERVER IF EXISTS employees_srv CASCADE;
CREATE SERVER employees_srv FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'localhost', dbname 'employees');
CREATE USER MAPPING FOR romi SERVER employees_srv
    OPTIONS (user 'reader_employees', password 'reader123');

CREATE FOREIGN TABLE f_departments (dept_no char(4), dept_name varchar(40))
    SERVER employees_srv OPTIONS (schema_name 'public', table_name 'departments');
CREATE FOREIGN TABLE f_employees (emp_no int, birth_date date, first_name varchar(14),
    last_name varchar(16), gender char(1), hire_date date)
    SERVER employees_srv OPTIONS (schema_name 'public', table_name 'employees');
CREATE FOREIGN TABLE f_dept_emp (emp_no int, dept_no char(4), from_date date, to_date date)
    SERVER employees_srv OPTIONS (schema_name 'public', table_name 'dept_emp');
CREATE FOREIGN TABLE f_salaries (emp_no int, salary int, from_date date, to_date date)
    SERVER employees_srv OPTIONS (schema_name 'public', table_name 'salaries');

INSERT INTO departemen (dept_no, nama_dept)
SELECT dept_no, dept_name FROM f_departments ORDER BY dept_no;

INSERT INTO pegawai (emp_no, nama_depan, nama_belakang, tgl_lahir, gender, tgl_masuk)
SELECT emp_no, first_name, last_name, birth_date, gender, hire_date
FROM f_employees
WHERE emp_no BETWEEN 10001 AND 15000
ORDER BY emp_no;

INSERT INTO penempatan (emp_no, dept_no, from_date, to_date)
SELECT d.emp_no, d.dept_no, d.from_date, d.to_date
FROM f_dept_emp d JOIN pegawai p ON p.emp_no = d.emp_no;

INSERT INTO gaji (emp_no, gaji, from_date, to_date)
SELECT s.emp_no, s.salary, s.from_date, s.to_date
FROM f_salaries s JOIN pegawai p ON p.emp_no = s.emp_no
ORDER BY s.emp_no, s.from_date;

ANALYZE departemen, pegawai, penempatan, gaji;

SELECT
    (SELECT count(*) FROM departemen) AS departemen,
    (SELECT count(*) FROM pegawai)    AS pegawai,
    (SELECT count(*) FROM penempatan) AS penempatan,
    (SELECT count(*) FROM gaji)       AS gaji;
