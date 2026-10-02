-- D6: Biaya tulis (dengan/tanpa trigger)
-- Buat tabel uji
DROP TABLE IF EXISTS uji_tulis;
CREATE TABLE uji_tulis (emp_no INT, gaji INT, dari DATE, sampai DATE);

-- 1000x insert TANPA trigger
DO $$
DECLARE i INT;
BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO uji_tulis VALUES (100000 + i, 50000 + i, '1990-01-01', '9999-01-01');
    END LOOP;
END $$;

-- 1000x insert DENGAN trigger (pakai tabel gaji asli)
INSERT INTO gaji
SELECT 400000 + g.generate_series, 50000, '1990-01-01', '9999-01-01'
FROM generate_series(1, 1000) AS g(generate_series)
WHERE NOT EXISTS (
  SELECT 1 FROM gaji e WHERE e.emp_no = 400000 + g.generate_series AND e.from_date = '1990-01-01'
);

-- Bersihkan
DELETE FROM gaji WHERE emp_no BETWEEN 400001 AND 401000;
DROP TABLE uji_tulis;
