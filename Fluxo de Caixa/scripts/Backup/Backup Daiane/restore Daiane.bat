set PGUSER=postgres
set PGPASSWORD=Otaner
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_fluxo_de_caixa C:\backup_diane\local\tab_baixas.bak   	
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_fluxo_de_caixa C:\backup_diane\local\tab_clientes.bak  	
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_fluxo_de_caixa C:\backup_diane\local\tab_contas.bak   	
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_fluxo_de_caixa C:\backup_diane\local\tab_documentos.bak   
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_fluxo_de_caixa C:\backup_diane\local\tab_empresas.bak     
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_fluxo_de_caixa C:\backup_diane\local\tab_fornecedores.bak 
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_fluxo_de_caixa C:\backup_diane\local\tab_grupos_user.bak  
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_fluxo_de_caixa C:\backup_diane\local\tab_usuarios.bak     
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_fluxo_de_caixa C:\backup_diane\local\tab_uf.bak     		
pause