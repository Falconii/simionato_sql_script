set PGUSER=postgres
set PGPASSWORD=dmcm0yHrIfOxnVhzWoUd
set HOST=containers-us-west-155.railway.app
set PORT=7513
set DB=railway
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_apons_execucao.bak   		--verbose --role "postgres" --format=c --blobs  			--table "apons_execucao"   		"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_apons_planejamento.bak   	--verbose --role "postgres" --format=c --blobs  			--table "apons_planejamento"	"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_atividades.bak   			--verbose --role "postgres" --format=c --blobs  			--table "atividades"       		"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_clientes.bak         		--verbose --role "postgres" --format=c --blobs  			--table "clientes"         		"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_empresas.bak            	--verbose --role "postgres" --format=c --blobs  			--table "empresas"         	    "railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_estruturas.bak          	--verbose --role "postgres" --format=c --blobs  			--table "estruturas"       	 	"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_feriados.bak            	--verbose --role "postgres" --format=c --blobs  			--table "feriados"         		"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_grupos_eco.bak       		--verbose --role "postgres" --format=c --blobs  			--table "grupos_eco"       		"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_grupos_user.bak       	--verbose --role "postgres" --format=c --blobs  			--table "grupos_user"      	  	"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_motivos_apo.bak         	--verbose --role "postgres" --format=c --blobs  			--table "motivos_apo"      		"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_projetos.bak            	--verbose --role "postgres" --format=c --blobs  			--table "projetos"         		"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_uf.bak                  	--verbose --role "postgres" --format=c --blobs  			--table "uf"               	 	"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_usuarios.bak            	--verbose --role "postgres" --format=c --blobs  			--table "usuarios"         		"railway"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h containers-us-west-155.railway.app -U postgres -p 7513 -f C:\backup_timer\railway\tab_feriados.bak            	--verbose --role "postgres" --format=c --blobs  			--table "feriados"         		"railway"
pause
