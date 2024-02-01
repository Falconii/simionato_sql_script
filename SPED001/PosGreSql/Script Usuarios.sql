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
     PASTA   varchar(255) NULL,
     PRIMARY KEY(codigo)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

INSERT INTO public.usuarios(codigo, razao, cnpj_cpf, cadastr, endereco, bairro, cidade, uf, cep, tel1, tel2, email, senha, pasta) 
	VALUES(1, 'ADM', '', '2021-9-11', '', '', '', '', '', '', '', '', '123456','C:\CONTABILIDADE')
GO
