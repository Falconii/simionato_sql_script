set PGUSER=postgres
set PGPASSWORD=123456
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_apons_execucao.bak   	--verbose --role "postgres" --format=c --blobs  			--table "apons_execucao"   		"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_apons_planejamento.bak  	--verbose --role "postgres" --format=c --blobs  			--table "apons_planejamento"	"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_atividades.bak   		--verbose --role "postgres" --format=c --blobs  			--table "atividades"       		"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_clientes.bak         	--verbose --role "postgres" --format=c --blobs  			--table "clientes"         		"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_condicoes_pagto.bak     	--verbose --role "postgres" --format=c --blobs  			--table "condicoes_pagto"  	 	"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_empresas.bak            	--verbose --role "postgres" --format=c --blobs  			--table "empresas"         	    "db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_estruturas.bak          	--verbose --role "postgres" --format=c --blobs  			--table "estruturas"       	 	"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_feriados.bak            	--verbose --role "postgres" --format=c --blobs  			--table "feriados"         		"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_grupos_eco.bak       	--verbose --role "postgres" --format=c --blobs  			--table "grupos_eco"       		"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_grupos_user.bak       	--verbose --role "postgres" --format=c --blobs  			--table "grupos_user"      	  	"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_header.bak            	--verbose --role "postgres" --format=c --blobs  			--table "header"           	  	"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_motivos_apo.bak         	--verbose --role "postgres" --format=c --blobs  			--table "motivos_apo"      		"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_projeto_valores.bak     	--verbose --role "postgres" --format=c --blobs  			--table "projeto_valores"  		"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_projetos.bak            	--verbose --role "postgres" --format=c --blobs  			--table "projetos"         		"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_tarefas.bak             	--verbose --role "postgres" --format=c --blobs  			--table "tarefas"          		"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_tarefas_projeto.bak     	--verbose --role "postgres" --format=c --blobs  			--table "tarefas_projeto"  	 	"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_trabalhos_projeto.bak   	--verbose --role "postgres" --format=c --blobs  			--table "trabalhos_projeto"	    "db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_uf.bak                  	--verbose --role "postgres" --format=c --blobs  			--table "uf"               	 	"db_control_time_auditor_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_timer\local\tab_usuarios.bak            	--verbose --role "postgres" --format=c --blobs  			--table "usuarios"         		"db_control_time_auditor_homologacao"
pause
