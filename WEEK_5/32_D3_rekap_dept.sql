SELECT
    d.nama_dept                                   AS departemen,
    count(DISTINCT p.emp_no)                      AS jumlah_pegawai,
    fn_format_rupiah(fn_gaji_rata_dept(d.dept_no)) AS gaji_rata_rata,
    count(DISTINCT CASE WHEN fn_kategori_gaji(g.gaji) = 'Rendah'        THEN p.emp_no END) AS kat_rendah,
    count(DISTINCT CASE WHEN fn_kategori_gaji(g.gaji) = 'Menengah'      THEN p.emp_no END) AS kat_menengah,
    count(DISTINCT CASE WHEN fn_kategori_gaji(g.gaji) = 'Tinggi'        THEN p.emp_no END) AS kat_tinggi,
    count(DISTINCT CASE WHEN fn_kategori_gaji(g.gaji) = 'Sangat Tinggi' THEN p.emp_no END) AS kat_sangat_tinggi
FROM departemen d
LEFT JOIN penempatan pe ON pe.dept_no = d.dept_no AND pe.to_date = DATE '9999-01-01'
LEFT JOIN pegawai p      ON p.emp_no = pe.emp_no
LEFT JOIN gaji g         ON g.emp_no = p.emp_no AND g.to_date = DATE '9999-01-01'
GROUP BY d.dept_no, d.nama_dept
ORDER BY d.dept_no;
