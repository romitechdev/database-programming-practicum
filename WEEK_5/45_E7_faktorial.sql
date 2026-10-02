CREATE OR REPLACE FUNCTION fn_faktorial(p_n INT)
RETURNS BIGINT
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    v_hasil BIGINT := 1;
    v_i     INT;
BEGIN
    IF p_n IS NULL THEN
        RETURN NULL;
    END IF;
    IF p_n < 0 THEN
        RAISE EXCEPTION 'faktorial tidak terdefinisi untuk bilangan negatif: %', p_n;
    END IF;
    IF p_n > 20 THEN
        RAISE EXCEPTION 'n terlalu besar (max 20) untuk BIGINT: %', p_n;
    END IF;
    FOR v_i IN 1 .. p_n LOOP
        v_hasil := v_hasil * v_i;
    END LOOP;
    RETURN v_hasil;
END;
$$;

SELECT fn_faktorial(0)  AS f0,
       fn_faktorial(1)  AS f1,
       fn_faktorial(5)  AS f5,
       fn_faktorial(10) AS f10,
       fn_faktorial(20) AS f20;
