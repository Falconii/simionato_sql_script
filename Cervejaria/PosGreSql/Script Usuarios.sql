CREATE TABLE Public.USUARIOS (
	 CODIGO   serial NOT  NULL,
	 RAZAO   varchar(40) NULL,
	 CNPJ_CPF   varchar(14) NULL,
	 CADASTR   date  NULL,
	 ENDERECO   varchar(40) NULL,
	 BAIRRO   varchar(40) NULL,
	 CIDADE   varchar(40) NULL,
	 UF   varchar(2) NULL,
	 CEP   varchar(8) NULL,
	 TEL1   varchar(23) NULL,
	 TEL2   varchar(23) NOT NULL,
	 EMAIL   varchar(100) NULL,
	 SENHA   varchar(10) NULL,
     PRIMARY KEY(codigo)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO
