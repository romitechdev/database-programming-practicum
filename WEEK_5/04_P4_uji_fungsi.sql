CREATE TABLE uji_fungsi (
    id_uji      INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_fungsi VARCHAR(64)  NOT NULL,
    masukan     VARCHAR(200) NOT NULL,
    diharapkan  VARCHAR(200) NOT NULL,
    diperoleh   VARCHAR(200) NULL,
    status      VARCHAR(10)  NULL,
    waktu_uji   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);
