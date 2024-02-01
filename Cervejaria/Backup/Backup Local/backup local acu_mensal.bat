set PGUSER=postgres
set PGPASSWORD=123456
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_contabilidade\local\tab_acu_mensal.bak   	  --verbose --role "postgres" --format=c --blobs  		--table "acu_mensal"		"db_cervejaria_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_contabilidade\local\tab_contacontabil.bak      --verbose --role "postgres" --format=c --blobs  		--table "contacontabil"	"db_cervejaria_homologacao"
pause
