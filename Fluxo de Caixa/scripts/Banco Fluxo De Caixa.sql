CREATE DATABASE db_fluxo_de_caixa
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = "Producao"
    CONNECTION LIMIT = -1;
GO
DROP TABLE IF EXISTS EMPRESAS;
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


DROP TABLE IF EXISTS GRUPOS_USER;
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


DROP TABLE usuarios;
GO

DROP TABLE IF EXISTS USUARIOS;
CREATE TABLE Public.USUARIOS (
 	codigo    		serial NOT NULL,
	razao    		varchar(40) NULL,
	cnpj_cpf 		varchar(18) NULL,
	cadastr  		date        NULL,
	endereco   		varchar(100) NULL,
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
    PRIMARY KEY(codigo)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


DROP TABLE IF EXISTS UF;
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

