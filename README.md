# Database Programming Practicum

Practicum assignments for the **Database Programming** course (Semester 3, S1 Information Systems, Faculty of Engineering, Universitas Negeri Surabaya).

| Report | PDF |
|--------|-----|
| Week 5 — Stored Functions, Triggers & Views | [WEEK_5/laporan/laporan.pdf](WEEK_5/laporan/laporan.pdf) |
| Week 7 — Query Optimization | [WEEK_7/laporan/main.pdf](WEEK_7/laporan/main.pdf) |

## Environment

- PostgreSQL 18 (local)
- Dataset: `employees` (300,024 employees, 2,844,047 salary records)
- GUI used: Navicat Premium

## Structure

| Folder | Content |
|--------|---------|
| `WEEK_4/` | Report (PDF) |
| `WEEK_5/` | Stored functions, triggers, views — SQL files + LaTeX report |
| `WEEK_7/` | Query optimization — SQL files + LaTeX report |

## How to Run

All SQL files are **PostgreSQL**. The original assignment is written in MySQL syntax; every statement has already been converted, so no further changes are needed.

### 1. Prepare the source dataset

The scripts read the classic `employees` dataset via a foreign table (`postgres_fdw`). Load it once:

```sql
CREATE DATABASE employees;
-- import the employees dataset (employees, salaries, dept_emp, departments)
```

The first file of each week (`01_*.sql`) creates a working database and copies the data from `employees`.

### 2. Running with Navicat

1. Connect to PostgreSQL (`localhost:5432`).
2. Open a **New Query** window. **Make sure the dropdown at the top shows the correct working database** (e.g. `db_fungsi_hr` or `db_optimasi`), not another one.
3. Open the SQL file, press `Ctrl+A` to select everything, paste into the query window, and press `F5`.
   - `Ctrl+A` is **required** — `F5` without a selection runs only the first statement.
   - For files that intentionally contain an error (validation/trigger proof), run statement by statement: click the line, then `F5`.
4. Results appear in the **Results** tab (grid) and **Messages** tab (success/error/EXPLAIN plan). Screenshot each one as evidence for the report.
5. Run the files **in filename order** — later files depend on objects created by earlier ones.
6. To start over: run the `cleanup.sql` / `60_*.sql` file first, then begin from file `02`.

### 3. Running with other clients (pgAdmin, DBeaver, psql, ...)

- **psql** — the most straightforward:
  ```bash
  psql -h localhost -U romi -d db_optimasi -f 02_P2_tabel.sql
  ```
  or simply pipe a file: `psql -d db_optimasi -f 03_P3_struktur.sql`
- **pgAdmin / DBeaver / DataGrip** — open a query console, paste the whole file content, and execute. Same rules as Navicat: run in order, and run intentional-error statements one at a time.
- Note: the scripts contain no psql-only meta-commands (`\timing`, `\d`, ...), so they run unchanged in any SQL client.

### 4. Benchmark notes (Week 7)

- Each benchmark query was measured **3 times**; the reported number is the **median**, taken after one warm-up run.
- Plans were captured with `EXPLAIN (ANALYZE, BUFFERS)`.
- Only **one variable** is changed per experiment (an index, or a rewrite) so the effect is attributable.
- All measured values are also stored in the `catatan_kinerja` table (see `04_P5_catatan.sql` and `05_rekap_hasil.sql`).

## Week 5 — Stored Functions, Triggers, and Views

SQL files are numbered in execution order:

- `01`–`04`: Setup (database, tables, data, function tests)
- `10`–`11`: Part B (functions, tests)
- `20`–`21`: Part C (additional functions)
- `30`–`35`: Part D (profiles, retirement, department summary, validation, triggers, views)
- `40`–`46`: Part E (inventory, testing, debugging, benchmarks)
- `50`–`52`: Part G (additional tasks)

Report source: `WEEK_5/laporan/laporan.tex` (compile with `pdflatex laporan_praktik.tex`)

## Week 7 — Query Optimization

SQL files are numbered in execution order:

- `01`–`05`: Setup (database, tables, structure, performance log, results summary)
- `10`–`17`: Part B (index impact: baseline, primary key, last\_name, composite index, leftmost prefix, covering index, non-sargable predicates, write cost)
- `20`–`26`: Part C (rewriting: IN / EXISTS / JOIN, correlated subquery, `SELECT *`, ORDER BY, pagination, subqueries, DISTINCT)
- `30`–`36`: Part D (functions, triggers, summary table, verification)
- `40`–`44`: Part E (case studies: OFFSET, CONCAT, highest salary per department, NOT IN, recruitment summary)
- `50`–`52`: Part G (partitioning, ANALYZE, forced index)
- `60`: Cleanup

Report source: `WEEK_7/laporan/main.tex` (compile with `pdflatex main.tex` — run twice for the table of contents)

Practicum screenshots: `WEEK_5/screenshot/` and `WEEK_7/screenshot/` (also embedded in the report under `ASSETS/`).
