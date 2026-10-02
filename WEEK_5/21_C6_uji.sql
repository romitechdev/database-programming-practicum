SELECT
    'A (lengkap)'     AS jenis, 10001 AS emp_no,
    fn_gaji_berjalan(10001)  AS gaji_berjalan,
    fn_nama_dept(10001)      AS nama_dept,
    fn_peringkat_gaji(10001) AS peringkat,
    fn_total_kenaikan(10001) AS total_kenaikan
UNION ALL
SELECT
    'B (tanpa gaji berjalan)', 10008,
    fn_gaji_berjalan(10008),
    fn_nama_dept(10008),
    fn_peringkat_gaji(10008),
    fn_total_kenaikan(10008)
UNION ALL
SELECT
    'C (tidak ada)', 99999,
    fn_gaji_berjalan(99999),
    fn_nama_dept(99999),
    fn_peringkat_gaji(99999),
    fn_total_kenaikan(99999);

SELECT dept_no, nama_dept, fn_gaji_rata_dept(dept_no) AS rata_rata
FROM departemen
ORDER BY dept_no;
