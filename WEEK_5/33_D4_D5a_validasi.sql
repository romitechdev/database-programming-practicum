CREATE OR REPLACE FUNCTION fn_validasi_gaji(p_emp_no INT, p_gaji_baru INT)
RETURNS VARCHAR
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_gaji_jalan INT;
    v_dept       CHAR(4);
    v_rata       INT;
BEGIN
    v_gaji_jalan := fn_gaji_berjalan(p_emp_no);
    IF v_gaji_jalan IS NULL THEN
        RETURN 'DITOLAK: pegawai tidak memiliki gaji berjalan';
    END IF;
    IF p_gaji_baru < v_gaji_jalan THEN
        RETURN 'DITOLAK: gaji baru lebih kecil dari gaji berjalan';
    END IF;
    IF p_gaji_baru > v_gaji_jalan * 1.30 THEN
        RETURN 'DITOLAK: kenaikan melebihi 30% dari gaji berjalan';
    END IF;
    SELECT pe.dept_no INTO v_dept
    FROM penempatan pe
    WHERE pe.emp_no = p_emp_no AND pe.to_date = DATE '9999-01-01'
    LIMIT 1;
    IF v_dept IS NOT NULL THEN
        v_rata := fn_gaji_rata_dept(v_dept);
        IF v_rata > 0 AND p_gaji_baru > v_rata * 2 THEN
            RETURN 'DITOLAK: gaji baru melampaui 2x rata-rata departemen';
        END IF;
    END IF;
    RETURN 'VALID';
END;
$$;

SELECT
    10001 AS emp_no,
    90000 AS gaji_usul,
    fn_validasi_gaji(10001, 90000) AS hasil_cek;

SELECT fn_validasi_gaji(10001, 88958)  AS s1_sama,
       fn_validasi_gaji(10001, 80000)  AS s2_kurang,
       fn_validasi_gaji(10001, 115000) AS s3_naik_30,
       fn_validasi_gaji(10001, 95000)  AS s4_wajar;
