set PGUSER=postgres
set PGPASSWORD=123456
"C:\Program Files\PostgreSQL\10\bin\pg_restore" -h localhost  -U postgres -p 5432 -d db_control_time_auditor_homologacao C:\backup_timer\local\tab_empresas.bak        
pause         

