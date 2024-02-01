set PGUSER=postgres
set PGPASSWORD=123456
pg_restore -h localhost  -U postgres -p 5432 -d db_invetario_web C:\backup_timer\local\tab_clientes.bak         
pg_restore -h localhost  -U postgres -p 5432 -d db_invetario_web C:\backup_timer\local\tab_empresas.bak          
pg_restore -h localhost  -U postgres -p 5432 -d db_invetario_web C:\backup_timer\local\tab_grupos_eco.bak       
pg_restore -h localhost  -U postgres -p 5432 -d db_invetario_web C:\backup_timer\local\tab_grupos_user.bak       
pg_restore -h localhost  -U postgres -p 5432 -d db_invetario_web C:\backup_timer\local\tab_usuarios.bak 
pause         

