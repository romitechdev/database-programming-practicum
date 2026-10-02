-- G1: Partisi by range from_date
CREATE TABLE gaji_part (LIKE gaji INCLUDING ALL) PARTITION BY RANGE (from_date);
CREATE TABLE gaji_p_1985 PARTITION OF gaji_part FOR VALUES FROM ('1985-01-01') TO ('1990-01-01');
CREATE TABLE gaji_p_1990 PARTITION OF gaji_part FOR VALUES FROM ('1990-01-01') TO ('1995-01-01');
CREATE TABLE gaji_p_1995 PARTITION OF gaji_part FOR VALUES FROM ('1995-01-01') TO ('2000-01-01');
CREATE TABLE gaji_p_2000 PARTITION OF gaji_part FOR VALUES FROM ('2000-01-01') TO ('9999-01-01');

INSERT INTO gaji_part SELECT * FROM gaji;
ANALYZE gaji_part;

-- Query: gaji periode 1985-1989 (hanya baca 1 partisi)
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM gaji_part WHERE from_date >= '1985-01-01' AND from_date < '1990-01-01';

DROP TABLE gaji_part CASCADE;
