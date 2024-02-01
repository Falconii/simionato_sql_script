CREATE DATABASE db_Giuliana_Flores
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
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


DROP TABLE usuarios;
GO

DROP TABLE IF EXISTS USUARIOS;
CREATE TABLE Public.USUARIOS (
 	codigo    		serial NOT NULL,
	razao    		varchar(40) NULL,
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


