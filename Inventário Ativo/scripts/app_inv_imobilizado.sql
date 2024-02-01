CREATE DATABASE db_invetario_web 
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
        contagem_ativa int4 NOT NULL,
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
		codigo varchar(15)  NOT NULL  , 
		descricao varchar(100)  NOT NULL  , 
        unid      varchar(10)   NOT NULL ,
		partnumber char(15)  NOT NULL  , 
		controlado char(1)  NOT NULL  , 
		dun char(13)  NOT NULL  , 
		dun_14 varchar(14)  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id_inventario,codigo) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TABELA complementos  */
DROP TABLE IF EXISTS complementos;
CREATE TABLE Public.complementos (
		id_empresa int4  NOT NULL  , 
		id_inventario int4  NOT NULL  , 
        codigo varchar(15)  NOT NULL  , 
        id            serial NOT NULL,
		local varchar(10)  NOT NULL  , 
		lote char(10)  NOT NULL  , 
		saldo numeric(15,4)  NOT NULL  , 
		valor_medio numeric(15,4)  NOT NULL  , 
		status_inventario char(1)  NOT NULL  , 
		id_contagem int4  NOT NULL  , 
		qtd_contagem numeric(10,4)  NOT NULL  , 
		qtd_ajuste numeric(10,4)  NOT NULL  , 
		taxa_juros numeric(5,2)  NOT NULL  , 
		encerramento_ct char(1)  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id_inventario,codigo,id) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TABELA contagens  */
DROP TABLE IF EXISTS contagens;
CREATE TABLE Public.contagens (
		id_empresa int4  NOT NULL  , 
		codigo varchar(15)  NOT NULL  , 
		id_complemento int4  NOT NULL  , 
        id_contagem serial  NOT NULL,
		data date  NOT NULL  , 
		nro_contagem int4  NOT NULL  , 
		qtd numeric(15,4)   , 
		qtd_ajuste numeric(15,4)  NOT NULL  , 
		id_usuario int4  NOT NULL  , 
		status char(1)  NOT NULL  , 
		encerramento_st char(1)  NOT NULL  , 
		laudo text   , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,codigo,id_complemento,id_contagem) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TABELA users_inventario  */
DROP TABLE IF EXISTS users_inventario;
CREATE TABLE Public.users_inventario (
		id_empresa int4  NOT NULL  , 
		id_inventario int4  NOT NULL  , 
		id_usuario int4  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id_inventario,id_usuario) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 
/* TRUNCATE TABLES */ 
TRUNCATE TABLE Public.inventarios RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.produtos RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.complementos RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.contagens RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.users_inventario RESTART IDENTITY; 
GO 
/* Drop TABLES */ 
DROP TABLE IF EXISTS Public.inventarios ; 
GO 
DROP TABLE IF EXISTS Public.produtos ; 
GO 
DROP TABLE IF EXISTS Public.complementos ; 
GO 
DROP TABLE IF EXISTS Public.contagens ; 
GO 
DROP TABLE IF EXISTS Public.users_inventario ; 
GO 
