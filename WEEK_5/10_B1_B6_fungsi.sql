
CREATE OR REPLACE FUNCTION fn_usia(p_tgl_lahir DATE)
RETURNS INT
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    v_usia INT;
BEGIN
    IF p_tgl_lahir IS NULL THEN
        RETURN NULL;
    END IF;
    IF p_tgl_lahir > CURRENT_DATE THEN
        RAISE EXCEPTION 'tanggal lahir tidak valid: %', p_tgl_lahir;
    END IF;
    v_usia := EXTRACT(YEAR FROM AGE(CURRENT_DATE, p_tgl_lahir));
    RETURN v_usia;
END;
$$;

CREATE OR REPLACE FUNCTION fn_masa_kerja(p_tgl_masuk DATE)
RETURNS INT
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    v_masa INT;
BEGIN
    IF p_tgl_masuk IS NULL THEN
        RETURN NULL;
    END IF;
    IF p_tgl_masuk > CURRENT_DATE THEN
        RAISE EXCEPTION 'tanggal masuk tidak valid: %', p_tgl_masuk;
    END IF;
    v_masa := EXTRACT(YEAR FROM AGE(CURRENT_DATE, p_tgl_masuk));
    RETURN v_masa;
END;
$$;

CREATE OR REPLACE FUNCTION fn_masa_kerja_teks(p_tgl_masuk DATE)
RETURNS VARCHAR
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    v_tahun INT;
    v_bulan INT;
BEGIN
    IF p_tgl_masuk IS NULL THEN
        RETURN NULL;
    END IF;
    IF p_tgl_masuk > CURRENT_DATE THEN
        RAISE EXCEPTION 'tanggal masuk tidak valid: %', p_tgl_masuk;
    END IF;
    v_tahun := EXTRACT(YEAR FROM AGE(CURRENT_DATE, p_tgl_masuk));
    v_bulan := EXTRACT(MONTH FROM AGE(CURRENT_DATE, p_tgl_masuk));
    IF v_tahun = 0 AND v_bulan = 0 THEN
        RETURN 'kurang dari 1 bulan';
    ELSIF v_bulan = 0 THEN
        RETURN v_tahun || ' tahun';
    ELSIF v_tahun = 0 THEN
        RETURN v_bulan || ' bulan';
    ELSE
        RETURN v_tahun || ' tahun ' || v_bulan || ' bulan';
    END IF;
END;
$$;

CREATE OR REPLACE FUNCTION fn_rapikan_nama(p_nama VARCHAR(50))
RETURNS VARCHAR
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    v_bersih VARCHAR;
    v_hasil  VARCHAR;
BEGIN
    IF p_nama IS NULL THEN
        RETURN NULL;
    END IF;
    v_bersih := TRIM(BOTH ' ' FROM REGEXP_REPLACE(p_nama, '\s+', ' ', 'g'));
    IF v_bersih = '' THEN
        RETURN '';
    END IF;
    v_hasil := LOWER(v_bersih);
    SELECT string_agg(
               UPPER(LEFT(w, 1)) || SUBSTRING(w FROM 2),
               ' ' ORDER BY ordinality
           )
    INTO v_hasil
    FROM regexp_split_to_table(v_bersih, ' ') WITH ORDINALITY AS t(w, ordinality);
    RETURN v_hasil;
END;
$$;

CREATE OR REPLACE FUNCTION fn_group_thousands(p BIGINT)
RETURNS TEXT
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    s      TEXT := ABS(p)::TEXT;
    n      INT  := LENGTH(s);
    result TEXT := '';
    pos    INT  := n;
BEGIN
    WHILE pos > 0 LOOP
        IF pos - 3 >= 1 THEN
            result := SUBSTRING(s FROM pos - 2 FOR 3) || '.' || result;
        ELSE
            result := SUBSTRING(s FROM 1 FOR pos) || '.' || result;
        END IF;
        pos := pos - 3;
    END LOOP;
    IF LENGTH(result) > 0 AND SUBSTRING(result FROM LENGTH(result) FOR 1) = '.' THEN
        result := SUBSTRING(result FROM 1 FOR LENGTH(result) - 1);
    END IF;
    RETURN result;
END;
$$;

CREATE OR REPLACE FUNCTION fn_format_rupiah(p_nilai DECIMAL(12,2))
RETURNS VARCHAR
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    v_integ BIGINT;
    v_koma  INT;
    v_tanda TEXT := '';
BEGIN
    IF p_nilai IS NULL THEN
        RETURN NULL;
    END IF;
    IF p_nilai < 0 THEN
        v_tanda := '-';
    END IF;
    v_integ := FLOOR(ABS(p_nilai))::BIGINT;
    v_koma  := FLOOR((ABS(p_nilai) - v_integ) * 100)::INT;
    IF (ABS(p_nilai) - v_integ) >= 0.5 THEN
        v_integ := v_integ + 1;
        v_koma  := 0;
    END IF;
    RETURN 'Rp ' || v_tanda || fn_group_thousands(v_integ)
           || CASE WHEN v_koma > 0 THEN '.' || TO_CHAR(v_koma, 'FM00') ELSE '' END;
END;
$$;

CREATE OR REPLACE FUNCTION fn_kategori_gaji(p_gaji INT)
RETURNS VARCHAR
LANGUAGE plpgsql
IMMUTABLE
AS $$
BEGIN
    IF p_gaji IS NULL THEN
        RETURN NULL;
    END IF;
    IF p_gaji < 0 THEN
        RAISE EXCEPTION 'gaji tidak valid: %', p_gaji;
    END IF;
    RETURN CASE
        WHEN p_gaji < 45000  THEN 'Rendah'
        WHEN p_gaji < 70000  THEN 'Menengah'
        WHEN p_gaji < 100000 THEN 'Tinggi'
        ELSE 'Sangat Tinggi'
    END;
END;
$$;
