set PGUSER=postgres
set PGPASSWORD=S1m10n4t0SQL
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h 192.168.0.161 -U postgres -p 49777 -f "C:\Script SQL\Assessoria Simionato\backup Acessoria Producao A\restore\tab_selic.bak"   		--verbose --role "postgres" --format=c --blobs  			--table "selic"   		"db_assessoria_producao_a"
pause "OK"