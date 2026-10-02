CREATE TABLE catatan_kinerja (
    id_catatan      INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    kode_soal       VARCHAR(30)  NOT NULL,
    keterangan      VARCHAR(200) NOT NULL,
    kondisi         VARCHAR(50)  NOT NULL,
    waktu_ms        DECIMAL(10,2) NULL,
    baris_diperiksa BIGINT     NULL,
    jenis_akses     VARCHAR(30)  NULL,
    dicatat_pada    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);
