SELECT
    p.emp_no                                  AS nomor_pegawai,
    fn_rapikan_nama(p.nama_depan || ' ' || p.nama_belakang) AS nama_lengkap,
    p.tgl_lahir                               AS tgl_lahir,
    fn_usia(p.tgl_lahir)                      AS usia_kini,
    (p.tgl_lahir + INTERVAL '60 years')::DATE AS tgl_memasuki_60,
    ((p.tgl_lahir + INTERVAL '60 years')::DATE - CURRENT_DATE) AS sisa_hari_ke_60
FROM pegawai p
WHERE fn_usia(p.tgl_lahir) BETWEEN 55 AND 59
ORDER BY fn_usia(p.tgl_lahir) ASC, p.tgl_lahir ASC;

SELECT
    MIN(fn_usia(tgl_lahir)) AS usia_termuda,
    MAX(fn_usia(tgl_lahir)) AS usia_tertua,
    ROUND(AVG(fn_usia(tgl_lahir)))::INT AS usia_rata
FROM pegawai;
