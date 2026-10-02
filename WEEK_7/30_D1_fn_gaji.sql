-- D1: Buat fungsi fn_gaji_berjalan
CREATE OR REPLACE FUNCTION fn_gaji_berjalan(p_emp_no INT)
RETURNS INT AS $$
DECLARE
    v_gaji INT;
BEGIN
    SELECT salary INTO v_gaji
    FROM gaji
    WHERE emp_no = p_emp_no AND to_date = '9999-01-01'
    LIMIT 1;
    RETURN v_gaji;
END;
$$ LANGUAGE plpgsql;
