CREATE DATABASE db_inventario_homologacao
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = "Producao"
    CONNECTION LIMIT = -1;
GO

CREATE TABLE Public.EMPRESAS (
	id      		serial NOT NULL,
	cnpj_cpf 		varchar(18) NULL,
	razao    		varchar(40) NULL,
	fantasi  		varchar(20) NULL,
	inscri   		varchar(20) NULL,
	cadastr  		date        NULL,
	ruaf    		varchar(80) NULL,
	nrof			varchar(10) NULL,
    complementof 	varchar(30) NULL,
	bairrof  		varchar(40) NULL,
	cidadef  		varchar(40) NULL,
	uff      		varchar(2) NULL,
	cepf     		varchar(8) NULL,
	tel1			varchar(23) NULL,
	tel2			varchar(23) NULL,
	emailf   		varchar(100) NULL,
	obs      		varchar(200) NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

CREATE TABLE Public.GRUPOS_USER (
	id_empresa      int4        NOT NULL,
	id       		serial      NOT NULL,
	grupo   		varchar(20) NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


INSERT INTO public.grupos_user(id_empresa, id, grupo, user_insert, user_update) 
	VALUES(1, 900, 'DIRETORIA', 1, 0)
GO

INSERT INTO public.grupos_user(id_empresa, id, grupo, user_insert, user_update) 
	VALUES(1, 901, 'COORDENADOR', 1, 0)
GO

INSERT INTO public.grupos_user(id_empresa, id, grupo, user_insert, user_update) 
	VALUES(1, 902, 'AUDITOR', 1, 0)
GO

INSERT INTO public.grupos_user(id_empresa, id, grupo, user_insert, user_update) 
	VALUES(1, 903, 'TRAINEE', 1, 0)
GO

INSERT INTO public.grupos_user(id_empresa, id, grupo, user_insert, user_update) 
	VALUES(1, 904, 'ADM', 1, 0)
GO

INSERT INTO public.grupos_user(id_empresa, id, grupo, user_insert, user_update) 
	VALUES(1, 905, 'TI', 1, 0)
GO





CREATE TABLE Public.GRUPOS_ECO (
	id_empresa      int4 NOT NULL,
	id       		serial NOT NULL,
	razao   		varchar(20) NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE usuarios;
GO
CREATE TABLE Public.USUARIOS (
    id_empresa      int4 NOT NULL,
 	id      		serial NOT NULL,
	razao    		varchar(40) NULL,
	cnpj_cpf 		varchar(18) NULL,
	cadastr  		date        NULL,
	rua     		varchar(80) NULL,
	nro 			varchar(10) NULL,
	complemento 	varchar(30) NULL,
	bairro   		varchar(40) NULL,
	cidade   		varchar(40) NULL,
	uf       		varchar(2) NULL,
	cep      		varchar(8) NULL,
	tel1			varchar(23) NULL,
	tel2			varchar(23) NULL,
	email   		varchar(100) NULL,
    senha           varchar(255) NULL,
    pasta           varchar(100) NULL, 
    grupo           int4         NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


CREATE TABLE Public.UF (
     sigla   char(2)      NOT NULL,
     estado  varchar(20)  NOT NULL,
     user_insert     int4 NULL,
     user_update     int4 NULL,
     PRIMARY KEY(sigla)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


	
