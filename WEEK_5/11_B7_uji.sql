
SELECT 'fn_usia' AS fungsi,
       '1990-05-15'::date AS masukan,
       fn_usia('1990-05-15') AS hasil;
SELECT 'fn_usia' AS fungsi, NULL AS masukan, fn_usia(NULL) AS hasil;
SELECT fn_usia('2030-01-01');

SELECT 'fn_masa_kerja' AS fungsi,
       '2014-03-10'::date AS masukan,
       fn_masa_kerja('2014-03-10') AS hasil;
SELECT 'fn_masa_kerja' AS fungsi, NULL AS masukan, fn_masa_kerja(NULL) AS hasil;
SELECT fn_masa_kerja('2030-01-01');

SELECT 'fn_masa_kerja_teks' AS fungsi,
       '2014-03-10'::date AS masukan,
       fn_masa_kerja_teks('2014-03-10') AS hasil;
SELECT 'fn_masa_kerja_teks' AS fungsi, NULL AS masukan, fn_masa_kerja_teks(NULL) AS hasil;
SELECT fn_masa_kerja_teks((CURRENT_DATE - INTERVAL '3 week')::DATE);

SELECT 'fn_rapikan_nama' AS fungsi,
       '  george   F.   SMITH ' AS masukan,
       fn_rapikan_nama('  george   F.   SMITH ') AS hasil;
SELECT 'fn_rapikan_nama' AS fungsi, NULL AS masukan, fn_rapikan_nama(NULL) AS hasil;
SELECT 'fn_rapikan_nama' AS fungsi, '' AS masukan, fn_rapikan_nama('') AS hasil;

SELECT 'fn_format_rupiah' AS fungsi,
       62500::decimal(12,2) AS masukan,
       fn_format_rupiah(62500) AS hasil;
SELECT fn_format_rupiah(1234567.5);
SELECT 'fn_format_rupiah' AS fungsi, NULL AS masukan, fn_format_rupiah(NULL) AS hasil;

SELECT 'fn_kategori_gaji' AS fungsi, 40000 AS masukan, fn_kategori_gaji(40000) AS hasil;
SELECT fn_kategori_gaji(50000);
SELECT fn_kategori_gaji(75000);
SELECT fn_kategori_gaji(150000);
SELECT 'fn_kategori_gaji' AS fungsi, NULL AS masukan, fn_kategori_gaji(NULL) AS hasil;
SELECT fn_kategori_gaji(-1000);
