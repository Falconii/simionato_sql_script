/* Script Tabelas */
/* TABELA cliente  */
DROP TABLE IF EXISTS cliente;
CREATE TABLE Public.cliente (
		codigo serial  NOT NULL  , 
		razao varchar(50)  NOT NULL  , 
		PRIMARY KEY(codigo) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TABELA empresa  */
DROP TABLE IF EXISTS empresa;
CREATE TABLE Public.empresa (
		id serial  NOT NULL  , 
		razao varchar(50)  NOT NULL  , 
		PRIMARY KEY(id) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TABELA feriado  */
DROP TABLE IF EXISTS feriado;
CREATE TABLE Public.feriado (
		datafer date  NOT NULL  , 
		descricao varchar(30)  NOT NULL   
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TRUNCATE TABLES */ 
TRUNCATE TABLE Public.cliente RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.empresa RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.feriado RESTART IDENTITY; 
GO 
/* Drop TABLES */ 
DROP TABLE IF EXISTS Public.cliente ; 
GO 
DROP TABLE IF EXISTS Public.empresa ; 
GO 
DROP TABLE IF EXISTS Public.feriado ; 
GO 
