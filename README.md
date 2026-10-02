# Praktikum Basis Data

Materi praktikum mata kuliah Pemrograman Basis Data, Semester 3, Program Studi S1 Sistem Informasi, Fakultas Teknik, Universitas Negeri Surabaya.

## Lingkungan

- PostgreSQL 18
- Navicat Premium (GUI)
- Dataset: `employees` (300.024 pegawai, 2.844.047 gaji)

## Struktur

| Folder | Isi |
|--------|-----|
| `WEEK_4/` | Laporan (PDF) |
| `WEEK_5/` | Praktikum fungsi, trigger, view (file `.sql` + laporan LaTeX) |
| `WEEK_7/` | Praktikum optimasi query (file `.sql` + laporan LaTeX) |

## Week 5 — Fungsi dan Basis Data

File SQL diurutkan sesuai eksekusi:

- `01`–`04`: Persiapan (database, tabel, data, uji fungsi)
- `10`–`11`: Bagian B (fungsi, uji)
- `20`–`21`: Bagian C (fungsi lanjutan)
- `30`–`35`: Bagian D (profil, pensiun, rekap, validasi, trigger, view)
- `40`–`46`: Bagian E (inventaris, uji, debug, benchmark)
- `50`–`52`: Bagian G (tugas tambahan)

Laporan: `WEEK_5/laporan/` (compile dengan `pdflatex laporan_praktik.tex`)

## Week 7 — Optimasi Query

File SQL diurutkan sesuai eksekusi:

- `01`–`05`: Persiapan (database, tabel, struktur, catatan, rekap)
- `10`–`17`: Bagian B (pengaruh indeks: baseline, PK, last\_name, gabungan, awalan kiri, covering, sargable, biaya tulis)
- `20`–`26`: Bagian C (rewrite: IN/EXISTS/JOIN, korelasi, SELECT \*, ORDER BY, paging, subquery, DISTINCT)
- `30`–`36`: Bagian D (fungsi, trigger, ringkasan, verifikasi)
- `40`–`44`: Bagian E (studi kasus: OFFSET, CONCAT, gaji tertinggi, NOT IN, rekap)
- `50`–`52`: Bagian G (partisi, ANALYZE, force index)
- `60`: Cleanup

Laporan: `WEEK_7/laporan/` (compile dengan `pdflatex main.tex` dua kali)

Screenshot praktikum tersimpan di `WEEK_7/screenshot/` dan `WEEK_7/laporan/ASSETS/`.
