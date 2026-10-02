-- B8: Biaya insert 10.000 baris
-- Buat tabel uji
DROP TABLE IF EXISTS uji_insert;
CREATE TABLE uji_insert (emp_no INT, gaji INT, dari DATE, sampai DATE);

-- Insert 10.000 baris TANPA indeks
INSERT INTO uji_insert SELECT emp_no, salary, from_date, to_date FROM gaji LIMIT 10000;

-- Buat indeks
CREATE INDEX idx_uji_empno ON uji_insert (emp_no);
CREATE INDEX idx_uji_gaji ON uji_insert (gaji);

-- Insert 10.000 baris DENGAN indeks
INSERT INTO uji_insert SELECT emp_no, salary, from_date, to_date FROM gaji LIMIT 10000 OFFSET 10000;

DROP TABLE uji_insert;
