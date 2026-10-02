
CREATE OR REPLACE FUNCTION _fn_terbilang_riban(p INT)
RETURNS TEXT
LANGUAGE sql
IMMUTABLE
AS $$
    WITH cte AS (
        SELECT FLOOR(p/100)::INT AS r, FLOOR((p%100)/10)::INT AS pu, (p%100)%10 AS sa
    ),
    sat AS (
        SELECT CASE sa WHEN 1 THEN 'satu' WHEN 2 THEN 'dua' WHEN 3 THEN 'tiga'
               WHEN 4 THEN 'empat' WHEN 5 THEN 'lima' WHEN 6 THEN 'enam'
               WHEN 7 THEN 'tujuh' WHEN 8 THEN 'delapan' WHEN 9 THEN 'sembilan'
               ELSE '' END AS s FROM cte
    ),
    pu_kata AS (
        SELECT CASE pu WHEN 2 THEN 'dua puluh' WHEN 3 THEN 'tiga puluh'
               WHEN 4 THEN 'empat puluh' WHEN 5 THEN 'lima puluh'
               WHEN 6 THEN 'enam puluh' WHEN 7 THEN 'tujuh puluh'
               WHEN 8 THEN 'delapan puluh' WHEN 9 THEN 'sembilan puluh'
               ELSE '' END AS s FROM cte
    ),
    bel AS (
        SELECT CASE
            WHEN pu=1 AND sa=0 THEN 'sebelas'
            WHEN pu=1 AND sa=1 THEN 'dua belas'
            WHEN pu=1 AND sa=2 THEN 'tiga belas'
            WHEN pu=1 AND sa=3 THEN 'empat belas'
            WHEN pu=1 AND sa=4 THEN 'lima belas'
            WHEN pu=1 AND sa=5 THEN 'enam belas'
            WHEN pu=1 AND sa=6 THEN 'tujuh belas'
            WHEN pu=1 AND sa=7 THEN 'delapan belas'
            WHEN pu=1 AND sa=8 THEN 'sembilan belas'
            ELSE '' END AS s FROM cte
    )
    SELECT TRIM(
        (CASE WHEN r>0 THEN (CASE r WHEN 1 THEN 'satu' WHEN 2 THEN 'dua'
                 WHEN 3 THEN 'tiga' WHEN 4 THEN 'empat' WHEN 5 THEN 'lima'
                 WHEN 6 THEN 'enam' WHEN 7 THEN 'tujuh' WHEN 8 THEN 'delapan'
                 WHEN 9 THEN 'sembilan' END) || ' ratus' ELSE '' END)
        || ' ' || (SELECT s FROM bel)
        || ' ' || (CASE WHEN pu>=2 THEN (SELECT s FROM pu_kata) || ' ' || (SELECT s FROM sat) ELSE '' END)
        || ' ' || (CASE WHEN pu=0 AND sa>0 THEN (SELECT s FROM sat) ELSE '' END)
    )
    FROM cte;
$$;

CREATE OR REPLACE FUNCTION fn_terbilang(p_nilai INT)
RETURNS VARCHAR
LANGUAGE sql
IMMUTABLE
AS $$
    WITH c AS (
        SELECT
            FLOOR(p_nilai/1000000)::INT AS juta,
            FLOOR((p_nilai%1000000)/1000)::INT AS ribu,
            p_nilai%1000 AS sisa
    ),
    rakit AS (
        SELECT TRIM(
            (CASE WHEN juta>0 THEN _fn_terbilang_riban(juta) || ' juta' ELSE '' END)
            || ' ' || (CASE WHEN ribu>0 THEN _fn_terbilang_riban(ribu) || ' ribu' ELSE '' END)
            || ' ' || (CASE WHEN sisa>0 THEN _fn_terbilang_riban(sisa) ELSE '' END)
        ) AS s FROM c
    )
    SELECT CASE WHEN s = '' THEN 'nol' ELSE REGEXP_REPLACE(s, '\s+', ' ', 'g') END
    FROM rakit;
$$;

SELECT '62500'     AS input, fn_terbilang(62500)     AS hasil UNION ALL
SELECT '0',         fn_terbilang(0)        UNION ALL
SELECT '105',       fn_terbilang(105)      UNION ALL
SELECT '11',        fn_terbilang(11)       UNION ALL
SELECT '20',        fn_terbilang(20)       UNION ALL
SELECT '1000000',   fn_terbilang(1000000)  UNION ALL
SELECT '1234567',   fn_terbilang(1234567);
