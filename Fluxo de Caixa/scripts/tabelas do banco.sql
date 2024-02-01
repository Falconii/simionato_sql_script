
GRANT SELECT(user_update), INSERT(user_update), UPDATE(user_update), REFERENCES(user_update) ON public.marcas TO postgres WITH GRANT OPTION
GO
GRANT SELECT(user_insert), INSERT(user_insert), UPDATE(user_insert), REFERENCES(user_insert) ON public.marcas TO postgres WITH GRANT OPTION
GO
GRANT SELECT(id_empresa), INSERT(id_empresa), UPDATE(id_empresa), REFERENCES(id_empresa) ON public.marcas TO postgres WITH GRANT OPTION
GO
GRANT SELECT(id), INSERT(id), UPDATE(id), REFERENCES(id) ON public.marcas TO postgres WITH GRANT OPTION
GO
GRANT SELECT(descricao), INSERT(descricao), UPDATE(descricao), REFERENCES(descricao) ON public.marcas TO postgres WITH GRANT OPTION
GO
DROP TABLE IF EXISTS CLIENTES;
CREATE TABLE Public.CLIENTES (
    id_empresa      int4        NOT NULL,
 	codigo    		serial      NOT NULL,
	razao    		varchar(40) NULL,
    fantasi    		varchar(40) NULL,
	enderecof   	varchar(80) NULL DEFAULT '',
	nrof        	char(10)    NULL DEFAULT '',
	bairrof     	varchar(40) NULL DEFAULT '',
	cidadef     	varchar(40) NULL DEFAULT '',
	uff         	varchar(2)  NULL DEFAULT '',
	cepf        	varchar(8)  NULL DEFAULT '',
	tel1			varchar(23) NULL,
	email   		varchar(100) NULL,
    conta           varchar(06)  NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,codigo)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO
/*

Alteração cadastro de clientes
*/
ALTER TABLE Public.CLIENTES
ADD COLUMN cnpj_cpf     char(18)    NULL DEFAULT '',
ADD COLUMN enderecof   	varchar(80) NULL DEFAULT '',
ADD COLUMN nrof        	char(10) NULL DEFAULT '',
ADD COLUMN bairrof     	varchar(40) NULL DEFAULT '',
ADD COLUMN cidadef     	varchar(40) NULL DEFAULT '',
ADD COLUMN uff         	varchar(2) NULL DEFAULT '',
ADD COLUMN cepf        	varchar(8) NULL DEFAULT '';

DROP TABLE IF EXISTS FORNECEDORES;
CREATE TABLE Public.FORNECEDORES (
    id_empresa      int4 NOT NULL,
 	codigo    		serial NOT NULL,
	razao    		varchar(40) NULL,
    fantasi    		varchar(40) NULL,
	tel1			varchar(23) NULL,
	email   		varchar(100) NULL,
    conta           varchar(06) NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,codigo)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


DROP TABLE IF EXISTS DOCUMENTOS;
CREATE TABLE Public.DOCUMENTOS (
    id_empresa      int4          NOT  NULL,
 	id      		serial        NOT  NULL,
	tipo    		varchar(1)    NOT  NULL,
	doc 		    varchar(9)    NOT  NULL,
    serie           varchar(3)    NOT  NULL,
    parcela         varchar(3)    not  NULL,
    clifor          int4          NOT  NULL,
    razao           varchar(80)   NOT  NULL,
	emissao  		date          NOT  NULL,
	vencimento      date          NOT  NULL,
	valor     	    numeric(12,2) NOT  NULL,
    abatimento      numeric(12,2) NOT  NULL,
    juros           numeric(12,2) NOT  NULL,
    vlr_pago        numeric(12,2) NOT  NULL,
    saldo           numeric(12,2) NOT  NULL,
    obs             varchar(30)   NOT  NULL,
    os              int4          NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id,tipo,doc,serie,parcela,clifor)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO
/*

Alteração documentos
*/
ALTER TABLE Public.DOCUMENTOS
ADD COLUMN os     int4    NULL DEFAULT 0;

DROP TABLE IF EXISTS CONTAS;
CREATE TABLE Public.CONTAS(
    id_empresa      int4          NOT  NULL,
 	codigo     		varchar(06)   NOT  NULL,
	tipo    		varchar(1)    NOT  NULL,
    descricao       varchar(30)   NOT  NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,codigo,tipo)
)
go

DROP TABLE IF EXISTS BAIXAS;
CREATE TABLE Public.BAIXAS(
    id_empresa      int4          NOT  NULL,
 	id      		serial        NOT  NULL,
    id_doc          int4          NOT  NULL,
	emissao  		date          NOT  NULL,
	valor     	    numeric(12,2) NOT  NULL,
    obs             varchar(40)   NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id,id_doc)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS OS_CAB;
CREATE TABLE Public.OS_CAB(
    id_empresa      int4          NOT  NULL,
 	id      		serial        NOT  NULL,
    entrada  		date          NOT  NULL,
	saida   		date          NULL,
	id_cliente      int4          NOT  NULL,
    id_carro        char(08)      NOT  NULL default '',
    id_cond         int4          NULL,
    horas_servico   char(5)       NOT  NULL default '',
    km              int4          NOT  NULL default 0,
    obs             varchar(100)  NULL default '',
    lucro           numeric(15,2) NOT NULL default 0,
    mao_obra        varchar(300)  NOT NULL default '',
    mao_obra_vlr    numeric(15,2) NOT NULL default 0,
    pecas_vlr       numeric(15,2) NOT NULL default 0,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


DROP TABLE IF EXISTS OS_DET;
CREATE TABLE Public.OS_DET(
    id_empresa      int4          NOT  NULL,
 	id_os      		int4          NOT  NULL,
    item            serial        NOT  NULL,
    qtd  		    numeric(15,3) NOT  NULL,
	descricao   	varchar(100)  NOT  null,
    valor           numeric(15,2) NOT NULL default 0,
    user_insert     int4          NULL,
    user_update     int4          NULL,
    PRIMARY KEY(id_empresa,id_os,item)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


DROP TABLE IF EXISTS OS_CAR;
CREATE TABLE Public.OS_CAR(
    id_empresa      int4          NOT  NULL,
 	placa           char(08)      NOT  NULL default '',
    id_marca        int4          NOT NULL,
	modelo        	varchar(20)   NOT  NULL default '',
    cor             varchar(20)   NOT  NULL default 0,
    ano             char(08)      NOT  NULL default '',
    user_insert     int4          NULL,
    user_update     int4          NULL,
    PRIMARY KEY(id_empresa,placa)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


DROP TABLE IF EXISTS CONDICOES;
CREATE TABLE Public.CONDICOES(
    id_empresa      int4          NOT  NULL,
 	id              serial        NOT  NULL,
	descricao      	varchar(30)   NOT  NULL default '',
    nro_parcelas    int4          NOT  NULL default 0,
    inter1          char(36)      NOT  NULL default '',
    inter2          char(36)      NOT  NULL default '',
    user_insert     int4          NULL,
    user_update     int4          NULL,
    PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS marcas;
CREATE TABLE public.marcas  ( 
	id_empresa 	int4 NOT NULL,
	id         	serial NOT NULL,
	descricao  	varchar(30) NOT NULL DEFAULT ''
	user_insert	int4 NULL,
	user_update	int4 NULL,
	PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE pg_default
GO



/*
DROP TABLE IF EXISTS EMPRESAS;
GO

DROP TABLE IF EXISTS GRUPOS_USER;
GO

DROP TABLE IF EXISTS USUARIOS;
GO

DROP TABLE IF EXISTS UF;
GO

DROP TABLE IF EXISTS CLIENTES;
GO

DROP TABLE IF EXISTS FORNECEDORES;
GO

DROP TABLE IF EXISTS DOCUMENTOS;
GO

DROP TABLE IF EXISTS CONTAS;
go

DROP TABLE IF EXISTS BAIXAS;
GO
*/


 SELECT MARCA.ID_EMPRESA,MARCA.ID,MARCA.DESCRICAO,MARCA.USER_INSERT,MARCA.USER_UPDATE 
FROM MARCAS MARCA  
ORDER BY MARCA.ID_EMPRESA  ,  MARCA.ID  


SELECT 	         CAB.ID                                ,CLI.CODIGO     AS CLI_CODIGO		         ,CLI.RAZAO      AS CLI_RAZAO		         ,CLI.TEL1       AS CLI_TEL1                 ,CAB.ENTRADA                   ,CAB.SAIDA                     ,CAB.HORAS_SERVICO             ,CAB.KM                        ,CAB.OBS                       ,CAB.MAO_OBRA_VLR              ,CAB.PECAS_VLR                 ,LEFT(CAR.PLACA,3) || '-' || RIGHT(CAR.PLACA,4)     AS CAR_PLACA                ,MARCA.DESCRICAO AS MARCA_DESCRICAO         ,CAR.MODELO      AS CAR_MODELO               ,CAR.COR         AS CAR_COR                 , LEFT(CAR.ANO,4) || '-' || RIGHT(CAR.ANO,4)       AS CAR_ANO          FROM OS_CAB CAB INNER JOIN CLIENTES  CLI   ON CLI.ID_EMPRESA  = CAB.ID_EMPRESA  AND CLI.CODIGO     = CAB.ID_CLIENTE    INNER JOIN OS_CAR    CAR   ON CAR.ID_EMPRESA  = CAB.ID_EMPRESA  AND CAR.PLACA      = CAB.ID_CARRO      INNER JOIN MARCAS    MARCA ON MARCA.ID_EMPRESA = CAR.ID_EMPRESA AND MARCA.ID       = CAR.ID_MARCA        ORDER BY CAB.ID 

DELETE FROM os_cab
go
DELETE FROM os_det
GO

select * from os_cab
GO
select * from os_det
GO

 SELECT DET.ID_EMPRESA               ,DET.ID_OS                     ,DET.ITEM                      ,DET.QTD                       ,DET.DESCRICAO                 ,DET.VALOR                     ,DET.USER_INSERT               ,DET.USER_UPDATE        FROM OS_DET DET                 WHERE DET.ID_EMPRESA = 1 AND _DET.ID_OS = 14 ORDER BY DET.ID_OS,DET.ITEM 


 INSERT INTO CLIENTES (ID_EMPRESA,RAZAO, CNPJ_CPF, FANTASI, ENDERECOF, NROF, BAIRROF, CIDADEF, UFF, CEPF, TEL1, EMAIL, CONTA, USER_INSERT, USER_UPDATE)  VALUES( 1, 'AJSAJSLAJLK','','AJSJASAJKLSJ','', '','','','','','019999999999','','002001',3,0)  RETURNING CODIGO 