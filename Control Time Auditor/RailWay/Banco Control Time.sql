CREATE DATABASE db_control_time_auditor_homologacao
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = "Producao"
    CONNECTION LIMIT = -1;
GO

DROP TABLE IF EXISTS Public.EMPRESAS;
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
GO

DROP TABLE IF EXISTS Public.GRUPOS_USER;
CREATE TABLE Public.GRUPOS_USER (
	id_empresa      int4        NOT NULL,
	id       		serial      NOT NULL,
	grupo   		varchar(20) NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id)
)
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
	VALUES(1, 905, 'FINANCEIRO', 1, 0)
GO

INSERT INTO public.grupos_user(id_empresa, id, grupo, user_insert, user_update) 
	VALUES(1, 906, 'TI', 1, 0)
GO


DROP TABLE IF EXISTS Public.GRUPOS_ECO;
CREATE TABLE Public.GRUPOS_ECO (
	id_empresa      int4 NOT NULL,
	id       		serial NOT NULL,
	razao   		varchar(20) NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id)
)
GO

DROP TABLE IF EXISTS Public.usuarios;
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
    ativo           char(1)      NOT NULL Default 'S',
    timer           char(1)      NOT NULL Default 'S',
    ticket          char(1)      NOT NULL Default 'S',
    man_hora_entrada char(5)     NOT NULL Default '  :  ',
    man_hora_saida   char(5)     NOT NULL Default '  :  ',
    tar_hora_entrada char(5)     NOT NULL Default '  :  ',
    tard_hora_saida  char(5)     NOT NULL Default '  :  ',
    user_insert     int4         NULL,
    user_update     int4         NULL,
    PRIMARY KEY(id_empresa,id)
)
GO

/*
ALTER TABLE USUARIOS ADD COLUMN    ativo           char(1)      NOT NULL Default 'S';
GO
ALTER TABLE USUARIOS ADD COLUMN    timer           char(1)      NOT NULL Default 'S';
GO
ALTER TABLE USUARIOS ADD COLUMN    ticket           char(1)      NOT NULL Default 'S';
GO
ALTER TABLE USUARIOS ADD COLUMN     man_hora_entrada char(5)       NOT NULL Default '07:45';
GO
ALTER TABLE USUARIOS ADD COLUMN     man_hora_saida   char(5)       NOT NULL Default '12:00';
GO
ALTER TABLE USUARIOS ADD COLUMN     tard_hora_entrada char(5)      NOT NULL Default '13:00';
GO
ALTER TABLE USUARIOS ADD COLUMN     tard_hora_saida   char(5)      NOT NULL Default '17:48';
GO

--ALT TABLE USUARIOS DROP COLUMN horario_entrada;
go
--ALT TABLE USUARIOS DROP COLUMN horario_saida;
go

*/

DROP TABLE IF EXISTS Public.UF;
GO
CREATE TABLE Public.UF (
     sigla   char(2)      NOT NULL,
     estado  varchar(20)  NOT NULL,
     user_insert     int4 NULL,
     user_update     int4 NULL,
     PRIMARY KEY(sigla)
)
GO

SELECT * FROM USUARIOS ORDER BY ID

update usuarios set user_insert = 1,     user_update = 0