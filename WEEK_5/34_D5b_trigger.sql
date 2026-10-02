CREATE OR REPLACE FUNCTION trg_validasi_gaji()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_hasil VARCHAR;
BEGIN
    IF NEW.gaji IS DISTINCT FROM OLD.gaji THEN
        v_hasil := fn_validasi_gaji(NEW.emp_no, NEW.gaji);
        IF v_hasil <> 'VALID' THEN
            RAISE EXCEPTION 'Perubahan gaji ditolak: %', v_hasil;
        END IF;
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_cek_gaji ON gaji;
CREATE TRIGGER trg_cek_gaji
BEFORE UPDATE OF gaji ON gaji
FOR EACH ROW
EXECUTE FUNCTION trg_validasi_gaji();
