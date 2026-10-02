-- Rekap semua hasil benchmark ke catatan_kinerja
INSERT INTO catatan_kinerja (kode_soal, keterangan, kondisi, waktu_ms, baris_diperiksa, jenis_akses) VALUES
-- B1: Baseline (tanpa indeks)
('B1-Q1', 'SELECT * FROM pegawai WHERE emp_no = 250000', 'sebelum', 30.55, 1, 'Parallel Seq Scan'),
('B1-Q2', 'SELECT * FROM gaji WHERE emp_no = 250000', 'sebelum', 253.09, 15, 'Parallel Seq Scan'),
('B1-Q3', 'SELECT * FROM pegawai WHERE last_name = ''Simmel''', 'sebelum', 37.98, 167, 'Parallel Seq Scan'),
('B1-Q4', 'SELECT * FROM gaji WHERE salary BETWEEN 90000 AND 95000 AND to_date = ''9999-01-01''', 'sebelum', 250.36, 11354, 'Parallel Seq Scan'),
-- B2: Setelah PK + idx emp_no
('B2-Q1', 'SELECT * FROM pegawai WHERE emp_no = 250000', 'sesudah', 0.056, 1, 'Index Scan (pkey)'),
('B2-Q2', 'SELECT * FROM gaji WHERE emp_no = 250000', 'sesudah', 0.051, 15, 'Index Scan (idx_gaji_empno)'),
-- B3: Setelah idx last_name
('B3-Q3', 'SELECT * FROM pegawai WHERE last_name = ''Simmel''', 'sesudah', 0.446, 167, 'Bitmap Heap Scan'),
-- B4: Indeks gabungan
('B4-Q4a', 'Q4 dengan idx (to_date, salary)', 'sesudah', 16.29, 11354, 'Bitmap Heap Scan'),
('B4-Q4b', 'Q4 dengan idx (salary, to_date)', 'sesudah', 21.65, 11354, 'Bitmap Heap Scan'),
-- B5: Awalan kiri
('B5-Q1', 'WHERE salary = 90000 (kolom 1)', 'sesudah', 26.09, 17, 'Bitmap Heap Scan'),
('B5-Q2', 'WHERE to_date = ''9999-01-01'' (kolom 2 saja)', 'sesudah', 848.33, 240124, 'Bitmap Heap Scan (idx lain)'),
('B5-Q3', 'WHERE salary = 90000 AND to_date = ''9999-01-01''', 'sesudah', 0.115, 0, 'Index Scan'),
-- B6: Covering index
('B6-a', 'SELECT emp_no, salary ... tanpa covering', 'sebelum', 523.22, 240124, 'Bitmap Heap Scan + Sort'),
('B6-b', 'SELECT emp_no, salary ... dengan covering', 'sesudah', 96.52, 240124, 'Index Only Scan'),
-- B7: Non-sargable
('B7-a', 'WHERE YEAR(birth_date) = 1953', 'sebelum', 352.13, 22857, 'Seq Scan'),
('B7-b', 'WHERE birth_date >= ''1953-01-01'' AND < ''1954-01-01''', 'sesudah', 184.70, 0, 'Parallel Seq Scan (sargable)'),
('B7-c', 'WHERE UPPER(last_name) = ''SMIMEL''', 'sebelum', NULL, NULL, 'Seq Scan'),
('B7-d', 'WHERE last_name = ''Simmel''', 'sesudah', 1.758, 167, 'Bitmap Heap Scan'),
-- B8: Biaya insert
('B8-a', 'INSERT 10.000 baris tanpa indeks', 'sebelum', 42.66, 10000, 'Seq'),
('B8-b', 'INSERT 10.000 baris dengan 2 indeks', 'sesudah', 116.26, 10000, 'Seq'),
-- C1: IN vs EXISTS vs JOIN
('C1-IN', 'IN (SELECT emp_no ...)', 'perbandingan', 753.79, 41349, 'Hash Right Semi Join'),
('C1-EXISTS', 'EXISTS (SELECT 1 ...)', 'perbandingan', 581.86, 41349, 'Hash Right Semi Join'),
('C1-JOIN', 'JOIN gaji', 'perbandingan', 585.20, 234267, 'Hash Join'),
-- C2: Korelasi vs dekorrelasi
('C2-korelasi', 'Subquery korelasi (100 baris)', 'sebelum', 1.909, 100, 'Seq + 100 Index Scan'),
('C2-dekorrelasi', 'JOIN + GROUP BY (100 baris)', 'sesudah', 0.740, 100, 'Merge Join'),
-- C3: SELECT * vs kolom
('C3-star', 'SELECT * (240.124 baris)', 'sebelum', 1373.89, 240124, 'Bitmap Heap Scan'),
('C3-kolom', 'SELECT emp_no, salary (240.124 baris)', 'sesudah', 174.71, 240124, 'Index Only Scan'),
-- C4: Sort vs indeks
('C4-sort', 'ORDER BY hire_date tanpa indeks', 'sebelum', 100.70, 20, 'top-N heapsort'),
('C4-idx', 'ORDER BY hire_date dengan indeks', 'sesudah', 0.091, 20, 'Index Scan'),
-- C5: OFFSET vs keyset
('C5-offset', 'OFFSET 20000', 'sebelum', 19.49, 20020, 'Index Scan'),
('C5-keyset', 'WHERE emp_no > 20000', 'sesudah', 0.084, 20, 'Index Scan'),
-- C6: Agregasi
('C6-subquery', 'Subquery korelasi (9 dept)', 'sebelum', 8926.84, 9, '9x Hash Join'),
('C6-join', 'JOIN + GROUP BY (9 dept)', 'sesudah', 1877.63, 9, 'Parallel Hash Join'),
-- C7: DISTINCT vs GROUP BY
('C7-distinct', 'SELECT DISTINCT dept_no', 'perbandingan', 102.31, 9, 'Sort + HashAggregate'),
('C7-groupby', 'GROUP BY dept_no', 'perbandingan', 120.30, 9, 'Sort + HashAggregate'),
-- D2: Fungsi vs JOIN
('D2-fungsi', 'fn_gaji_berjalan(emp_no) per baris', 'sebelum', 5963.47, 300024, 'Seq + 300k fn call'),
('D2-join', 'JOIN gaji', 'sesudah', 634.69, 240124, 'Hash Join + Index Only'),
-- D3: Fungsi di WHERE
('D3-fungsi', 'WHERE fn_gaji_berjalan(emp_no) > 90000', 'sebelum', 5204.82, 37438, 'Seq + fn call'),
('D3-join', 'JOIN + WHERE salary > 90000', 'sesudah', 159.54, 37438, 'Parallel Hash Join'),
-- D5: Biaya baca
('D5-join', 'JOIN (hitung dari sumber)', 'sebelum', 628.33, 9, 'Parallel Hash Join'),
('D5-ringkasan', 'Baca ringkasan_gaji_dept', 'sesudah', 0.07, 9, 'Seq Scan (9 baris)'),
-- D6: Biaya tulis
('D6-tanpa', '1000 insert tanpa trigger', 'sebelum', 20.79, 1000, 'Insert'),
('D6-dengan', '1000 insert dengan trigger', 'sesudah', 22.38, 1000, 'Insert + Trigger'),
-- E4: NOT IN vs NOT EXISTS
('E4-notin', 'NOT IN (subquery)', 'sebelum', 450.21, 59900, 'Seq Scan'),
('E4-notexists', 'NOT EXISTS', 'sesudah', 277.29, 59900, 'Parallel Hash Anti Join'),
-- G2: ANALYZE
('G2-basi', 'Statistik basi', 'sebelum', 7.00, 15, 'Index Scan'),
('G2-analyze', 'Setelah ANALYZE', 'sesudah', 0.036, 15, 'Index Scan'),
-- G3: Force index
('G3-off', 'enable_seqscan=off', 'perbandingan', 62.02, 167, 'Bitmap Heap Scan'),
('G3-on', 'enable_seqscan=on (default)', 'perbandingan', 0.425, 167, 'Bitmap Heap Scan');

SELECT kode_soal, keterangan, kondisi, waktu_ms, jenis_akses FROM catatan_kinerja ORDER BY id_catatan;
