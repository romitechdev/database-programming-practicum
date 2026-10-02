-- D4: Tabel ringkasan + trigger
CREATE TABLE ringkasan_gaji_dept (
    dept_no   CHAR(4) PRIMARY KEY,
    total     BIGINT,
    rata      DECIMAL(10,2),
    tertinggi INT,
    terendah  INT
);

-- Isi awal
INSERT INTO ringkasan_gaji_dept
SELECT d.dept_no, COUNT(s.salary), AVG(s.salary), MAX(s.salary), MIN(s.salary)
FROM departemen d
JOIN penempatan pe ON pe.dept_no = d.dept_no AND pe.to_date = '9999-01-01'
JOIN gaji s ON s.emp_no = pe.emp_no AND s.to_date = '9999-01-01'
GROUP BY d.dept_no;

-- Trigger
CREATE OR REPLACE FUNCTION trg_maintain_ringkasan()
RETURNS TRIGGER AS $$
DECLARE
    v_dept CHAR(4);
BEGIN
    -- Cari dept_no dari penempatan (asumsi: pegawai punya 1 dept aktif)
    SELECT dept_no INTO v_dept FROM penempatan
    WHERE emp_no = NEW.emp_no AND to_date = '9999-01-01'
    LIMIT 1;
    IF v_dept IS NULL THEN RETURN NEW; END IF;

    -- Hapus ringkasan lama, hitung ulang
    DELETE FROM ringkasan_gaji_dept WHERE dept_no = v_dept;
    INSERT INTO ringkasan_gaji_dept
    SELECT d.dept_no, COUNT(s.salary), AVG(s.salary), MAX(s.salary), MIN(s.salary)
    FROM departemen d
    JOIN penempatan pe ON pe.dept_no = d.dept_no AND pe.to_date = '9999-01-01'
    JOIN gaji s ON s.emp_no = pe.emp_no AND s.to_date = '9999-01-01'
    WHERE d.dept_no = v_dept
    GROUP BY d.dept_no;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_gaji_ubah
AFTER INSERT OR UPDATE OR DELETE ON gaji
FOR EACH ROW EXECUTE FUNCTION trg_maintain_ringkasan();
