set PGUSER=postgres
set PGPASSWORD=123456
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_cervejaria_homologacao C:\backup_contabilidade\local\tab_clientes.bak   	
--"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_cervejaria_homologacao C:\backup_contabilidade\local\tab_contacontabil.bak
--"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_cervejaria_homologacao C:\backup_contabilidade\local\tab_movicab.bak   	
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_cervejaria_homologacao C:\backup_contabilidade\local\tab_movidet.bak      
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_cervejaria_homologacao C:\backup_contabilidade\local\tab_saldo.bak        
"C:\Program Files\PostgreSQL\10\bin\"pg_restore -h localhost  -U postgres -p 5432  --verbose -d db_cervejaria_homologacao C:\backup_contabilidade\local\tab_usuarios.bak   
pause
