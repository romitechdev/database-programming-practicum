SELECT indexname, indexdef FROM pg_indexes
WHERE schemaname = 'public' AND tablename IN ('pegawai','gaji','penempatan','departemen')
ORDER BY tablename, indexname;

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name IN ('pegawai','gaji','penempatan','departemen')
ORDER BY table_name, ordinal_position;
