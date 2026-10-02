CREATE OR REPLACE VIEW v_profil_pegawai AS
SELECT
    p.emp_no                                        AS nomor_pegawai,
    fn_rapikan_nama(p.nama_depan || ' ' || p.nama_belakang) AS nama_lengkap,
    fn_usia(p.tgl_lahir)                            AS usia,
    fn_masa_kerja_teks(p.tgl_masuk)                 AS masa_kerja,
    fn_nama_dept(p.emp_no)                          AS departemen,
    fn_format_rupiah(fn_gaji_berjalan(p.emp_no))    AS gaji_berjalan,
    fn_kategori_gaji(fn_gaji_berjalan(p.emp_no))    AS kategori_gaji,
    fn_peringkat_gaji(p.emp_no)                     AS peringkat_dept
FROM pegawai p
WHERE fn_gaji_berjalan(p.emp_no) IS NOT NULL;

SELECT * FROM v_profil_pegawai ORDER BY nomor_pegawai LIMIT 10;
