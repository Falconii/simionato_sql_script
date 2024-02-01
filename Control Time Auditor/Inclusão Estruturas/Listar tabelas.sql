SELECT *
FROM pg_catalog.pg_tables
WHERE schemaname != 'pg_catalog' AND 
    schemaname != 'information_schema' and hasindexes
ORDER BY tablename


SELECT * FROM CLIENTES