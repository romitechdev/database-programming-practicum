
INSERT INTO uji_fungsi (nama_fungsi, masukan, diharapkan) VALUES
('fn_usia',            '1990-05-15',  '36'),
('fn_usia',            '2000-01-01',  '26'),
('fn_masa_kerja',      '2014-03-10',  '12'),
('fn_masa_kerja_teks', '2014-03-10',  '12 tahun 6 bulan'),
('fn_rapikan_nama',    '  george   smith ', 'George Smith'),
('fn_format_rupiah',   '62500',       'Rp 62.500'),
('fn_format_rupiah',   '1234567',     'Rp 1.234.567'),
('fn_kategori_gaji',   '40000',       'Rendah'),
('fn_kategori_gaji',   '50000',       'Menengah'),
('fn_kategori_gaji',   '75000',       'Tinggi'),
('fn_kategori_gaji',   '150000',      'Sangat Tinggi'),
('fn_gaji_berjalan',   '10001',       '88958'),
('fn_gaji_berjalan',   '99999',       'NULL'),
('fn_nama_dept',       '10001',       'Development'),
('fn_nama_dept',       '99999',       'Tidak Ditempatkan'),
('fn_total_kenaikan',  '10001',       '28841');

UPDATE uji_fungsi uf
SET diperoleh = CASE
        WHEN uf.nama_fungsi = 'fn_usia'            THEN fn_usia(uf.masukan::DATE)::TEXT
        WHEN uf.nama_fungsi = 'fn_masa_kerja'      THEN fn_masa_kerja(uf.masukan::DATE)::TEXT
        WHEN uf.nama_fungsi = 'fn_masa_kerja_teks' THEN fn_masa_kerja_teks(uf.masukan::DATE)
        WHEN uf.nama_fungsi = 'fn_rapikan_nama'    THEN fn_rapikan_nama(uf.masukan)
        WHEN uf.nama_fungsi = 'fn_format_rupiah'   THEN fn_format_rupiah(uf.masukan::DECIMAL(12,2))
        WHEN uf.nama_fungsi = 'fn_kategori_gaji'   THEN fn_kategori_gaji(uf.masukan::INT)
        WHEN uf.nama_fungsi = 'fn_gaji_berjalan'   THEN COALESCE(fn_gaji_berjalan(uf.masukan::INT)::TEXT, 'NULL')
        WHEN uf.nama_fungsi = 'fn_nama_dept'       THEN fn_nama_dept(uf.masukan::INT)
        WHEN uf.nama_fungsi = 'fn_total_kenaikan'  THEN fn_total_kenaikan(uf.masukan::INT)::TEXT
    END,
    status = CASE
        WHEN (CASE
                WHEN uf.nama_fungsi = 'fn_usia'            THEN fn_usia(uf.masukan::DATE)::TEXT
                WHEN uf.nama_fungsi = 'fn_masa_kerja'      THEN fn_masa_kerja(uf.masukan::DATE)::TEXT
                WHEN uf.nama_fungsi = 'fn_masa_kerja_teks' THEN fn_masa_kerja_teks(uf.masukan::DATE)
                WHEN uf.nama_fungsi = 'fn_rapikan_nama'    THEN fn_rapikan_nama(uf.masukan)
                WHEN uf.nama_fungsi = 'fn_format_rupiah'   THEN fn_format_rupiah(uf.masukan::DECIMAL(12,2))
                WHEN uf.nama_fungsi = 'fn_kategori_gaji'   THEN fn_kategori_gaji(uf.masukan::INT)
                WHEN uf.nama_fungsi = 'fn_gaji_berjalan'   THEN COALESCE(fn_gaji_berjalan(uf.masukan::INT)::TEXT, 'NULL')
                WHEN uf.nama_fungsi = 'fn_nama_dept'       THEN fn_nama_dept(uf.masukan::INT)
                WHEN uf.nama_fungsi = 'fn_total_kenaikan'  THEN fn_total_kenaikan(uf.masukan::INT)::TEXT
             END) = uf.diharapkan
             THEN 'LULUS' ELSE 'GAGAL'
    END
WHERE uf.status IS NULL;

SELECT id_uji, nama_fungsi, masukan, diharapkan, diperoleh, status
FROM uji_fungsi
ORDER BY id_uji;

SELECT
    count(*) FILTER (WHERE status = 'LULUS') AS jumlah_lulus,
    count(*) FILTER (WHERE status = 'GAGAL') AS jumlah_gagal,
    count(*) AS total
FROM uji_fungsi;
