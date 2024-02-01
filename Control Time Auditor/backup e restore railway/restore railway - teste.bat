set PGUSER=postgres
set PGPASSWORD=123456
"C:\Program Files\PostgreSQL\13\bin\pg_restore" -h localhost  -U postgres -p 5432 -d db_control_time_auditor_homologacao C:\backup_timer\railway\tab_apons_execucao.bak   
"C:\Program Files\PostgreSQL\13\bin\pg_restore" -h localhost  -U postgres -p 5432 -d db_control_time_auditor_homologacao C:\backup_timer\railway\tab_apons_planejamento.bak 
"C:\Program Files\PostgreSQL\13\bin\pg_restore" -h localhost  -U postgres -p 5432 -d db_control_time_auditor_homologacao C:\backup_timer\railway\tab_atividades.bak   	
"C:\Program Files\PostgreSQL\13\bin\pg_restore" -h localhost  -U postgres -p 5432 -d db_control_time_auditor_homologacao C:\backup_timer\railway\tab_clientes.bak          
"C:\Program Files\PostgreSQL\13\bin\pg_restore" -h localhost  -U postgres -p 5432 -d db_control_time_auditor_homologacao C:\backup_timer\railway\tab_empresas.bak          
"C:\Program Files\PostgreSQL\13\bin\pg_restore" -h localhost  -U postgres -p 5432 -d db_control_time_auditor_homologacao C:\backup_timer\railway\tab_feriados.bak        
pause         

