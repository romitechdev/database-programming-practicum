
CREATE TABLE IF NOT EXISTS cache_gaji_rata_dept (
    dept_no     CHAR(4) PRIMARY KEY,
    rata_rata   INT      NOT NULL,
    dibuat_pada TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION fn_gaji_rata_dept_cached(p_dept_no CHAR(4))
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_cache INT;
BEGIN
    SELECT rata_rata INTO v_cache
    FROM cache_gaji_rata_dept
    WHERE dept_no = p_dept_no
      AND dibuat_pada > NOW() - INTERVAL '1 hour';

    IF v_cache IS NOT NULL THEN
        RETURN v_cache;
    END IF;

    v_cache := COALESCE(
        (SELECT ROUND(AVG(g.gaji))::INT
         FROM gaji g
         JOIN penempatan p ON p.emp_no = g.emp_no
         WHERE p.dept_no = p_dept_no
           AND p.to_date = DATE '9999-01-01'
           AND g.to_date = DATE '9999-01-01'), 0);

    INSERT INTO cache_gaji_rata_dept (dept_no, rata_rata, dibuat_pada)
    VALUES (p_dept_no, v_cache, NOW())
    ON CONFLICT (dept_no) DO UPDATE
        SET rata_rata = EXCLUDED.rata_rata, dibuat_pada = NOW();

    RETURN v_cache;
END;
$$;

INSERT INTO cache_gaji_rata_dept (dept_no, rata_rata, dibuat_pada)
SELECT d.dept_no, fn_gaji_rata_dept(d.dept_no), NOW()
FROM departemen d
ON CONFLICT (dept_no) DO NOTHING;

EXPLAIN ANALYZE
SELECT d.nama_dept, fn_gaji_rata_dept(d.dept_no) AS biasa
FROM departemen d ORDER BY d.dept_no;

EXPLAIN ANALYZE
SELECT d.nama_dept, fn_gaji_rata_dept_cached(d.dept_no) AS cached
FROM departemen d ORDER BY d.dept_no;
