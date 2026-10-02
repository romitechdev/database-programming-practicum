-- E5: Rekap perekrutan per tahun
SELECT EXTRACT(YEAR FROM hire_date) AS tahun, COUNT(*) AS jumlah
FROM pegawai
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY tahun;
