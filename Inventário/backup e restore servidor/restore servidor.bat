set PGUSER=postgres
set PGPASSWORD=S1m10n4t0SQL
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_apons_execucao.bak   
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_apons_planejamento.bak 
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_atividades.bak   	
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_clientes.bak         
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_condicoes_pagto.bak   
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_empresas.bak          
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_estruturas.bak        
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_feriados.bak          
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_grupos_eco.bak       
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_grupos_user.bak       
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_header.bak            
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_motivos_apo.bak       
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_projeto_valores.bak   
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_projetos.bak          
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_tarefas.bak           
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_tarefas_projeto.bak   
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_trabalhos_projeto.bak 
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_uf.bak                
pg_restore -h 192.168.0.161  -U postgres -p 49777 -d db_control_time_auditor_a E:\BACKUP_APPS\Timer\tab_usuarios.bak 
pause         

