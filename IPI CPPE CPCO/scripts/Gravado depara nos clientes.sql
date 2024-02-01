DROP TABLE IF EXISTS CLIENTES;
CREATE TABLE public.clientes  ( 
	codigo      	serial NOT NULL,
	cnpj_cpf    	varchar(18) NULL,
	razao       	varchar(60) NULL,
	fantasi     	varchar(60) NULL,
	inscri      	varchar(20) NULL DEFAULT ''::character varying,
	empresa     	char(6) NOT NULL DEFAULT ''::bpchar,
	cod_empresa 	char(6) NOT NULL DEFAULT ''::bpchar,
	cod_protheus	char(6) NULL DEFAULT ''::bpchar,
	cod_sic     	char(6) NULL DEFAULT ''::bpchar,
	cod_sap     	char(6) NULL DEFAULT ''::bpchar,
	cod_soja    	char(6) NULL DEFAULT ''::bpchar,
	cadastr     	date NULL,
	enderecof   	varchar(80) NULL DEFAULT ''::character varying,
	nrof        	char(10) NULL DEFAULT ''::bpchar,
	bairrof     	varchar(40) NULL DEFAULT ''::character varying,
	cidadef     	varchar(40) NULL DEFAULT ''::character varying,
	uff         	varchar(2) NULL DEFAULT ''::character varying,
	cepf        	varchar(8) NULL DEFAULT ''::character varying,
	telf        	varchar(23) NULL DEFAULT ''::character varying,
	celf        	varchar(23) NULL DEFAULT ''::character varying,
	faxf        	varchar(23) NULL DEFAULT ''::character varying,
	emailf      	varchar(100) NULL DEFAULT ''::character varying,
	obs         	varchar(200) NULL DEFAULT ''::character varying,
	PRIMARY KEY(codigo)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO
CREATE UNIQUE INDEX clientes_cnpj
	ON public.clientes USING btree (cnpj_cpf text_ops)
GO


DROP TABLE IF EXISTS LOCAIS;
CREATE TABLE public.locais  ( 
    id_cliente      int4   NOT NUll, 
	id           	serial NOT NULL,
	cod_protheus	char(6) NULL DEFAULT ''::bpchar,
	cod_sic     	char(6) NULL DEFAULT ''::bpchar,
	cod_sap     	char(6) NULL DEFAULT ''::bpchar,
	PRIMARY KEY(id_cliente,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

//populando clientes com base no depara
INSERT INTO clientes(cnpj_cpf, razao, fantasi, inscri, empresa,cod_empresa, cod_protheus, cod_sic, cod_sap,cadastr)
SELECT CNPJ,UNID,'' AS fantasi, '' AS inscri, empresa, codigoempresa,codigoms,codigosic,codigosap,'2022-8-26' 
FROM depara

//populando locais 
INSERT INTO LOCAIS(id_cliente, cod_protheus, cod_sic, cod_sap) 
	SELECT cli.codigo as id_cliente, dp.codigoms as cod_protheus, dp.codigosic as cod_sic, dp.codigosap as cod_sap
    FROM  CLIENTES CLI
    INNER JOIN DEPARA DP ON DP.cnpj = CLI.cnpj_cpf 
    ORDER BY CODIGO
GO


DROP TABLE IF EXISTS DEMANDAS;
CREATE TABLE public.demandas ( 
	id          	serial      NOT NULL,
	descricao      	varchar(60) NOT NULL,
	dtinicial     	date NOT NULL,
	dtfinal      	date NOT NULL,
    calculo         int4,
    dtplanilhas     date,
    dtbebida        date,
    dtcalculo       date,
    dtnfvenda1      date,
    dtnfvenda2      date,
    dtencerra       date,      
	PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO
CREATE UNIQUE INDEX demandas_descricao
	ON public.demandas USING btree (descricao text_ops)
GO


DROP TABLE IF EXISTS CFOP_WORK;
CREATE TABLE public.cfop_work (
    id_demanda  int4        NOT NULL, 
	id          serial      NOT NULL,
	cfop      	char(04)    NOT NULL,
	tag     	char(02)    NOT NULL,
	PRIMARY KEY(id_demanda,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS CFOP_SALES;
CREATE TABLE public.cfop_sales (
    id_demanda  int4        NOT NULL, 
	id          serial      NOT NULL,
	cfop      	char(04)    NOT NULL,
	PRIMARY KEY(id_demanda,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS DEMANDA_EMPRESA;
CREATE TABLE public.demanda_empresa (
    id_demanda  int4        NOT NULL, 
	id          serial      NOT NULL,
	codigo     	char(06)    NOT NULL,
	descricao  	char(06)    NOT NULL,
	PRIMARY KEY(id_demanda,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS DEMANDA_EMPRESA;
CREATE TABLE public.demanda_empresa (
    id_demanda  int4        NOT NULL, 
	id          serial      NOT NULL,
	codigo     	char(06)    NOT NULL,
	descricao  	char(06)    NOT NULL,
	PRIMARY KEY(id_demanda,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


DROP TABLE IF EXISTS DEMANDA_PLANILHA;
CREATE TABLE public.demanda_planilha (
    id_demanda      INT4     NOT NULL, 
	id_planilha     INT4     NOT NULL,
	id_empresa   	char(6)  NOT NULL,
	PRIMARY KEY(id_demanda,id_planilha,id_empresa)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO



SELECT * FROM demanda_empresa 
GO
SELECT * FROM cfop_work
GO
SELECT * FROM cfop_sales
GO
SELECT * FROM NFE_CAB 