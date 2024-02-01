CREATE DATABASE db_inventario_imobilizado 
		WITH 
		OWNER = postgres 
		ENCODING = 'UTF8' 
		LC_COLLATE = 'Portuguese_Brazil.1252' 
		LC_CTYPE = 'Portuguese_Brazil.1252' 
		TABLESPACE = "Producao" 
		CONNECTION LIMIT = -1; 
GO 
/* Script Tabelas */
/* TABELA inventarios  */
DROP TABLE IF EXISTS inventarios;
CREATE TABLE Public.inventarios (
		id_empresa int4  NOT NULL  , 
		id serial  NOT NULL  , 
		id_cliente int4  NOT NULL  , 
		id_responsavel int4  NOT NULL  , 
		data_inicial date  NOT NULL  , 
		data_final date  NOT NULL  , 
		data_encerra date  NOT NULL  , 
		descricao varchar(100)  NOT NULL  , 
		laudo text  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TABELA produtos  */
DROP TABLE IF EXISTS produtos;
CREATE TABLE Public.produtos (
		id_empresa int4  NOT NULL  , 
		id_inventario int4  NOT NULL  , 
		id serial  NOT NULL  , 
		codigo varchar(9)  NOT NULL  , 
		descricao varchar(100)  NOT NULL  , 
		cod_grupo varchar(9)  NOT NULL  , 
		cnpj char(14)  NOT NULL  , 
		nro_nfe char(9)  NOT NULL  , 
		dt_aquisicao date   , 
		valor_aquisicao numeric(15,4)  NOT NULL  , 
		valor_depreciacao numeric(15,4)  NOT NULL  , 
		valor_residual numeric(15,4)  NOT NULL  , 
		reav_mapa2 numeric(15,4)  NOT NULL  , 
		deemed_cost numeric(15,4)  NOT NULL  , 
		valor_contabil numeric(15,4)  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id_inventario,id) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TABELA clientes  */
DROP TABLE IF EXISTS clientes;
CREATE TABLE Public.clientes (
		id_empresa int4  NOT NULL  , 
		id_inventario int4  NOT NULL  , 
		id int4  NOT NULL  , 
		cnpj varchar(14)  NOT NULL  , 
		razao varchar(100)  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id_inventario,id) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TABELA lancamentos  */
DROP TABLE IF EXISTS lancamentos;
CREATE TABLE Public.lancamentos (
		id_empresa int4  NOT NULL  , 
		id_inventario int4  NOT NULL  , 
		id int4  NOT NULL  , 
		codigo varchar(9)  NOT NULL  , 
		local varchar(10)  NOT NULL  , 
		data date  NOT NULL  , 
		id_resp int4  NOT NULL  , 
		placa_imobilizado varchar(9)  NOT NULL  , 
		obs varchar(100)   , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id,codigo) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TABELA localizacoes  */
DROP TABLE IF EXISTS localizacoes;
CREATE TABLE Public.localizacoes (
		id_empresa int4  NOT NULL  , 
		id_inventario int4  NOT NULL  , 
		local char(2)  NOT NULL  , 
		sublocal char(15)  NOT NULL  , 
		descricao varchar(50)  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id_inventario,local,sublocal) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TRUNCATE TABLES */ 
TRUNCATE TABLE Public.inventarios RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.produtos RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.clientes RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.lancamentos RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.localizacoes RESTART IDENTITY; 
GO 
/* Drop TABLES */ 
DROP TABLE IF EXISTS Public.inventarios ; 
GO 
DROP TABLE IF EXISTS Public.produtos ; 
GO 
DROP TABLE IF EXISTS Public.clientes ; 
GO 
DROP TABLE IF EXISTS Public.lancamentos ; 
GO 
DROP TABLE IF EXISTS Public.localizacoes ; 
GO 
