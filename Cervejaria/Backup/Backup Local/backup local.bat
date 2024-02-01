set PGUSER=postgres
set PGPASSWORD=123456
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_contabilidade\local\tab_clientes.bak   	  --verbose --role "postgres" --format=c --blobs  		--table "clientes"		"db_cervejaria_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_contabilidade\local\tab_contacontabil.bak  --verbose --role "postgres" --format=c --blobs  		--table "contacontabil"	"db_cervejaria_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_contabilidade\local\tab_movicab.bak   	  --verbose --role "postgres" --format=c --blobs  		--table "movicab"		"db_cervejaria_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_contabilidade\local\tab_movidet.bak        --verbose --role "postgres" --format=c --blobs  		--table "movidet"   	"db_cervejaria_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_contabilidade\local\tab_saldo.bak          --verbose --role "postgres" --format=c --blobs  		--table "saldo" 		"db_cervejaria_homologacao"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f C:\backup_contabilidade\local\tab_usuarios.bak       --verbose --role "postgres" --format=c --blobs  		--table "usuarios"      "db_cervejaria_homologacao"
pause
