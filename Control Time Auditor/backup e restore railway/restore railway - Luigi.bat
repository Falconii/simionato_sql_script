set PGUSER=postgres
set PGPASSWORD=123456
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_apons_execucao.bak   	
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_apons_planejamento.bak
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_atividades.bak   		
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_clientes.bak         	
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_empresas.bak          
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_estruturas.bak        
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_feriados.bak          
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_grupos_eco.bak       	
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_grupos_user.bak       
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_motivos_apo.bak       
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_projetos.bak          
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_uf.bak                
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_usuarios.bak          
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_dias_uteis.bak        
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_parametros.bak        
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_tickets_fechamento.bak
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_tickets_libera.bak    
pg_restore -h localhost -p 5432 -d db_timer_homologacao C:\backup_timer\railway\tab_tickets_movi.bak  
pause         

