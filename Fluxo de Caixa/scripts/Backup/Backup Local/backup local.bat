set PGUSER=postgres
set PGPASSWORD=123456
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_diane\local\tab_baixas.bak   	--verbose --role "postgres" --format=c --blobs  		--table "baixas"		"db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_diane\local\tab_clientes.bak  	--verbose --role "postgres" --format=c --blobs  		--table "clientes"		"db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_diane\local\tab_contas.bak   	--verbose --role "postgres" --format=c --blobs  		--table "contas"		"db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_diane\local\tab_documentos.bak   --verbose --role "postgres" --format=c --blobs  		--table "documentos"	"db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_diane\local\tab_empresas.bak     --verbose --role "postgres" --format=c --blobs  		--table "empresas" 		"db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_diane\local\tab_fornecedores.bak --verbose --role "postgres" --format=c --blobs  		--table "fornecedores"  "db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_diane\local\tab_grupos_user.bak  --verbose --role "postgres" --format=c --blobs  		--table "grupos_user" 	"db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_diane\local\tab_usuarios.bak     --verbose --role "postgres" --format=c --blobs  		--table "usuarios"		"db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_diane\local\tab_os_car.bak     	--verbose --role "postgres" --format=c --blobs  	    --table "os_car"		"db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_diane\local\tab_marcas.bak     	--verbose --role "postgres" --format=c --blobs  	    --table "marcas"		"db_fluxo_de_caixa"
pause

