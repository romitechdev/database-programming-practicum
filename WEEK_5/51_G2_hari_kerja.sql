
CREATE OR REPLACE FUNCTION date_diff_days(a DATE, b DATE)
RETURNS INT LANGUAGE sql IMMUTABLE AS $$
    SELECT (b - a)::INT;
$$;

CREATE OR REPLACE FUNCTION fn_hari_kerja(p_awal DATE, p_akhir DATE)
RETURNS INT
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    v_total      INT;
    v_minggu     INT;
    v_sisa       INT;
    v_hari_sisa  INT;
    v_dow        INT;
    v_i          INT;
BEGIN
    IF p_awal IS NULL OR p_akhir IS NULL THEN
        RETURN NULL;
    END IF;
    IF p_akhir < p_awal THEN
        RAISE EXCEPTION 'tanggal akhir harus >= tanggal awal';
    END IF;

    v_total  := date_diff_days(p_awal, p_akhir);
    v_minggu := v_total / 7;
    v_sisa   := v_total % 7;

    v_hari_sisa := 0;
    FOR v_i IN 0 .. v_sisa LOOP
        v_dow := EXTRACT(ISODOW FROM (p_awal + (v_minggu * 7) + v_i))::INT;
        IF v_dow <= 5 THEN
            v_hari_sisa := v_hari_sisa + 1;
        END IF;
    END LOOP;

    RETURN (v_minggu * 5) + v_hari_sisa;
END;
$$;

SELECT '2024-01-01' AS awal, '2024-01-31' AS akhir,
       fn_hari_kerja('2024-01-01', '2024-01-31') AS hari_kerja
UNION ALL
SELECT '2024-01-01', '2024-03-31',
       fn_hari_kerja('2024-01-01', '2024-03-31')
UNION ALL
SELECT '2024-10-07', '2024-10-11',
       fn_hari_kerja('2024-10-07', '2024-10-11')
UNION ALL
SELECT '2024-01-15', '2024-01-15',
       fn_hari_kerja('2024-01-15', '2024-01-15');
