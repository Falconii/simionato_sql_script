set PGUSER=postgres
set PGPASSWORD=123456
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_feriados.bak            	--verbose --role "postgres" --format=c --blobs  			--table "feriados"         		"db_control_time_auditor_homologacao"
pause
