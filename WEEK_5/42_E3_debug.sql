

CREATE OR REPLACE FUNCTION fn_bonus(p_emp_no INT)
RETURNS NUMERIC(12,2)
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_gaji  INT;
    v_bonus NUMERIC(12,2);
BEGIN
    SELECT g.gaji INTO v_gaji
    FROM gaji g
    WHERE g.emp_no = p_emp_no
      AND g.to_date = DATE '9999-01-01'
    LIMIT 1;

    IF v_gaji IS NULL THEN
        RETURN NULL;
    END IF;

    IF v_gaji > 60000 THEN
        v_bonus := v_gaji * 0.1;
    ELSE
        v_bonus := v_gaji * 0.05;
    END IF;

    RETURN v_bonus;
END;
$$;

SELECT 10001 AS emp_no, fn_bonus(10001) AS bonus;
SELECT 10002 AS emp_no, fn_bonus(10002) AS bonus;
SELECT 99999 AS emp_no, fn_bonus(99999) AS bonus;
