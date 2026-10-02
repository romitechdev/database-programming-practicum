-- E2: Pencarian CONCAT LIKE
SELECT * FROM pegawai WHERE first_name || ' ' || last_name LIKE '%John Smith%';
