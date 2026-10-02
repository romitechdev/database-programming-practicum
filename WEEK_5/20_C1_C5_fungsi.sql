
CREATE OR REPLACE FUNCTION fn_gaji_berjalan(p_emp_no INT)
RETURNS INT
LANGUAGE sql
STABLE
AS $$
    SELECT g.gaji
    FROM gaji g
    WHERE g.emp_no = p_emp_no
      AND g.to_date = DATE '9999-01-01'
    LIMIT 1;
$$;

CREATE OR REPLACE FUNCTION fn_nama_dept(p_emp_no INT)
RETURNS VARCHAR
LANGUAGE sql
STABLE
AS $$
    SELECT COALESCE(
        (SELECT d.nama_dept
         FROM penempatan p
         JOIN departemen d ON d.dept_no = p.dept_no
         WHERE p.emp_no = p_emp_no
           AND p.to_date = DATE '9999-01-01'
         LIMIT 1),
        'Tidak Ditempatkan'
    );
$$;

CREATE OR REPLACE FUNCTION fn_gaji_rata_dept(p_dept_no CHAR(4))
RETURNS INT
LANGUAGE sql
STABLE
AS $$
    SELECT COALESCE(ROUND(AVG(g.gaji))::INT, 0)
    FROM gaji g
    JOIN penempatan p ON p.emp_no = g.emp_no
    WHERE p.dept_no = p_dept_no
      AND p.to_date = DATE '9999-01-01'
      AND g.to_date = DATE '9999-01-01';
$$;

CREATE OR REPLACE FUNCTION fn_peringkat_gaji(p_emp_no INT)
RETURNS VARCHAR
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_gaji   INT;
    v_dept   CHAR(4);
    v_rata   INT;
BEGIN
    v_gaji := fn_gaji_berjalan(p_emp_no);
    IF v_gaji IS NULL THEN
        RETURN 'Tidak Ada Gaji';
    END IF;
    SELECT p.dept_no INTO v_dept
    FROM penempatan p
    WHERE p.emp_no = p_emp_no AND p.to_date = DATE '9999-01-01'
    LIMIT 1;
    IF v_dept IS NULL THEN
        RETURN 'Tidak Ditempatkan';
    END IF;
    v_rata := fn_gaji_rata_dept(v_dept);
    IF v_rata = 0 THEN
        RETURN 'Data Rata-rata Tidak Ada';
    END IF;
    IF v_gaji > v_rata * 1.05 THEN
        RETURN 'Di Atas Rata-rata';
    ELSIF v_gaji < v_rata * 0.95 THEN
        RETURN 'Di Bawah Rata-rata';
    ELSE
        RETURN 'Sekitar Rata-rata';
    END IF;
END;
$$;

CREATE OR REPLACE FUNCTION fn_total_kenaikan(p_emp_no INT)
RETURNS INT
LANGUAGE sql
STABLE
AS $$
    SELECT COALESCE(MAX(g.gaji) - MIN(g.gaji), 0)
    FROM gaji g
    WHERE g.emp_no = p_emp_no;
$$;
