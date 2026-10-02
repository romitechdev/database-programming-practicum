
CREATE TABLE pegawai (
    emp_no        INT PRIMARY KEY,
    nama_depan    VARCHAR(50)  NOT NULL,
    nama_belakang VARCHAR(50)  NOT NULL,
    tgl_lahir     DATE         NOT NULL,
    gender        CHAR(1)      NOT NULL CHECK (gender IN ('M','F')),
    tgl_masuk     DATE         NOT NULL
);

CREATE TABLE departemen (
    dept_no   CHAR(4)    PRIMARY KEY,
    nama_dept VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE penempatan (
    emp_no    INT  NOT NULL REFERENCES pegawai    (emp_no)  ON DELETE CASCADE,
    dept_no   CHAR(4) NOT NULL REFERENCES departemen (dept_no) ON DELETE CASCADE,
    from_date DATE NOT NULL,
    to_date   DATE NOT NULL,
    PRIMARY KEY (emp_no, dept_no, from_date)
);

CREATE TABLE gaji (
    id_gaji   INT  GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    emp_no    INT NOT NULL REFERENCES pegawai (emp_no) ON DELETE CASCADE,
    gaji      INT NOT NULL,
    from_date DATE NOT NULL,
    to_date   DATE NOT NULL,
    UNIQUE (emp_no, from_date)
);

CREATE INDEX idx_penempatan_emp ON penempatan (emp_no);
CREATE INDEX idx_gaji_emp       ON gaji (emp_no);
