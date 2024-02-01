set PGUSER=postgres
set PGPASSWORD=123456
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f"C:\APP_BACKUP\tab_usuarios.sql"     --verbose --role "postgres" --format=c --blobs  --table "public.usuarios"           "db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f"C:\APP_BACKUP\tab_empresas.sql"     --verbose --role "postgres" --format=c --blobs  --table "public.empresas"           "db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f"C:\APP_BACKUP\tab_clientes.sql"     --verbose --role "postgres" --format=c --blobs  --table "public.clientes"           "db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f"C:\APP_BACKUP\tab_fornecedores.sql" --verbose --role "postgres" --format=c --blobs  --table "public.fornecedores"       "db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f"C:\APP_BACKUP\tab_contas.sql"       --verbose --role "postgres" --format=c --blobs  --table "public.contas"    		 "db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f"C:\APP_BACKUP\tab_documentos.sql"   --verbose --role "postgres" --format=c --blobs  --table "public.documentos"         "db_fluxo_de_caixa"
"C:\Program Files\PostgreSQL\10\bin\"pg_dump.exe -h localhost -U postgres -p 5432 -f"C:\APP_BACKUP\tab_baixas.sql"       --verbose --role "postgres" --format=c --blobs  --table "public.baixas"             "db_fluxo_de_caixa"
pause "Fim..."
