set PGUSER=postgres
set PGPASSWORD=123456
;pg_restore -h localhost -p 5432 -d "db_trade_gp_homologacao" "C:\Script SQL\Assessoria Simionato\Backup Trade GP\Restore\tab_clientes.bak"
pg_restore -h localhost -p 5432 -d "db_trade_gp_homologacao" "C:\Script SQL\Assessoria Simionato\Backup Trade GP\Restore\tab_selic.bak"   
pause  "OK"