CREATE DATABASE db_demanda_homologacao
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = "PRODUCAO"
    CONNECTION LIMIT = -1;

CREATE TABLE public.acumulado_cnpj_data_ipi_dema  ( 
	id_demanda       	int4 NOT NULL,
	cnpj             	char(14) NOT NULL,
	ano              	char(4) NOT NULL,
	mes              	char(2) NOT NULL,
	sistema          	char(10) NOT NULL,
	produto          	char(20) NOT NULL,
	origem           	varchar(60) NOT NULL,
	classificacao    	varchar(50) NOT NULL,
	vlr_ipi          	numeric(15,4) NULL,
	vlr_ipi_corrigido	numeric(15,4) NULL,
	PRIMARY KEY(cnpj,ano,mes,sistema,produto,origem,classificacao)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.acumulado_data_qtd_nf_dema  ( 
	id_demanda	int4 NOT NULL,
	cnpj      	varchar(14) NOT NULL,
	ano       	varchar(4) NOT NULL,
	mes       	varchar(2) NOT NULL,
	total_nfe 	int4 NULL,
	PRIMARY KEY(id_demanda,cnpj,ano,mes)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.categorias  ( 
	codigo   	serial NOT NULL,
	descricao	varchar(20) NOT NULL,
	PRIMARY KEY(codigo)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.cfop_sales  ( 
	id_demanda	int4 NOT NULL,
	id        	serial NOT NULL,
	cfop      	char(4) NOT NULL,
	PRIMARY KEY(id_demanda,id)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE INDEX cfop_sales_cfop
	ON public.cfop_sales USING btree (id_demanda int4_ops, cfop bpchar_ops)
GO

CREATE TABLE public.cfop_work  ( 
	id_demanda	int4 NOT NULL,
	id        	serial NOT NULL,
	cfop      	char(4) NOT NULL,
	tag       	char(2) NOT NULL,
	PRIMARY KEY(id_demanda,id)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE INDEX cfop_work_cfop
	ON public.cfop_work USING btree (id_demanda int4_ops, cfop bpchar_ops)
GO

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
TABLESPACE "PRODUCAO"
GO
CREATE UNIQUE INDEX clientes_cnpj
	ON public.clientes USING btree (cnpj_cpf text_ops)
GO

CREATE TABLE public.demanda_empresa  ( 
	id_demanda	int4 NOT NULL,
	id        	serial NOT NULL,
	codigo    	char(6) NOT NULL,
	descricao 	char(6) NOT NULL,
	PRIMARY KEY(id_demanda,id)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.demanda_planilha  ( 
	id_demanda 	int4 NOT NULL,
	id_planilha	int4 NOT NULL,
	id_empresa 	char(6) NOT NULL,
	PRIMARY KEY(id_demanda,id_planilha,id_empresa)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.demandas  ( 
	id         	serial NOT NULL,
	descricao  	varchar(60) NOT NULL,
	dtinicial  	date NOT NULL,
	dtfinal    	date NOT NULL,
	calculo    	int4 NULL,
	dtplanilhas	TIMESTAMP NULL,
	dtbebida   	TIMESTAMP NULL,
	dtcalculo  	TIMESTAMP NULL,
	dtnfvenda1 	TIMESTAMP NULL,
	dtnfvenda2 	TIMESTAMP NULL,
	dtencerra  	TIMESTAMP NULL,
	dtacumulado	TIMESTAMP NULL,
	dtfaltantes	TIMESTAMP NULL,
	PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE UNIQUE INDEX demandas_descricao
	ON public.demandas USING btree (descricao text_ops)
GO

CREATE TABLE public.estatistica  ( 
	id_planilha	int4 NOT NULL,
	operacao   	varchar(10) NOT NULL,
	dtinicial  	timestamp NOT NULL,
	dtfinal    	timestamp NOT NULL,
	PRIMARY KEY(id_planilha,operacao)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.locais  ( 
	id_cliente  	int4 NOT NULL,
	id          	serial NOT NULL,
	cod_protheus	char(6) NULL DEFAULT ''::bpchar,
	cod_sic     	char(6) NULL DEFAULT ''::bpchar,
	cod_sap     	char(6) NULL DEFAULT ''::bpchar,
	PRIMARY KEY(id_cliente,id)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE TABLE public.nfe_cab  ( 
	id                	serial NOT NULL,
	planilha          	varchar(200) NOT NULL,
	sistema           	char(5) NOT NULL,
	empresa           	char(6) NOT NULL,
	local             	char(6) NOT NULL,
	cnpj              	char(14) NOT NULL,
	qtd               	numeric(15,4) NULL,
	vlr_contabil      	numeric(15,4) NULL,
	bas_icms          	numeric(15,2) NULL,
	vlr_icms          	numeric(15,2) NULL,
	bas_pis           	numeric(15,2) NULL,
	vlr_pis           	numeric(15,4) NULL,
	bas_cof           	numeric(15,2) NULL,
	vlr_cof           	numeric(15,4) NULL,
	bas_ipi           	numeric(15,2) NULL,
	vlr_ipi           	numeric(15,2) NULL,
	bas_icms_st       	numeric(15,2) NULL,
	vlr_icms_st       	numeric(15,2) NULL,
	nro_linha         	int4 NULL,
	usuarioinclusao   	int4 NULL,
	usuarioatualizacao	int4 NULL,
	data_criacao      	timestamp NULL,
	data_fechamento   	timestamp NULL,
	status            	int4 NULL,
	ultima            	int4 NULL,
	dtbebida          	timestamp NULL,
	dtimposto         	timestamp NULL,
	dtselic           	timestamp NULL,
	dtvenda           	timestamp NULL,
	dtvendames        	timestamp NULL,
	PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE INDEX nfe_cab_id_empresa_local
	ON public.nfe_cab USING btree (empresa bpchar_ops, local bpchar_ops)
GO
CREATE INDEX nfe_cab_id_planilha
	ON public.nfe_cab USING btree (planilha bpchar_ops)
GO
CREATE INDEX nfe_cab_id_cnpj
	ON public.nfe_cab USING btree (cnpj bpchar_ops)
GO

CREATE TABLE public.nfe_cab_status  ( 
	id_demanda	int4 NOT NULL,
	id        	serial NOT NULL,
	dtbebida  	timestamp NULL,
	dtimposto 	timestamp NULL,
	dtselic   	timestamp NULL,
	dtvenda   	timestamp NULL,
	dtvendames	timestamp NULL,
	PRIMARY KEY(id_demanda,id)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.nfe_det  ( 
	id          	int4 NOT NULL,
	nro_linha   	int4 NOT NULL,
	empresa     	char(6) NOT NULL,
	local       	char(6) NOT NULL,
	dtlanc      	date NOT NULL,
	dtnf        	date NOT NULL,
	nro         	char(9) NOT NULL,
	serie       	char(3) NOT NULL,
	uf          	char(2) NOT NULL,
	nr_item     	varchar(10) NOT NULL,
	material    	char(15) NOT NULL,
	descricao   	varchar(100) NULL,
	ncm         	char(15) NULL,
	unid        	char(5) NULL,
	cfop        	char(4) NULL,
	qtd         	numeric(15,4) NULL,
	vlr_contabil	numeric(15,4) NULL,
	sti         	char(2) NULL,
	bas_icms    	numeric(15,2) NULL,
	per_icms    	numeric(6,2) NULL,
	vlr_icms    	numeric(15,2) NULL,
	stp         	char(2) NULL,
	bas_pis     	numeric(15,2) NULL,
	per_pis     	numeric(6,2) NULL,
	vlr_pis     	numeric(15,4) NULL,
	stc         	char(2) NULL,
	bas_cof     	numeric(15,2) NULL,
	per_cof     	numeric(6,2) NULL,
	vlr_cof     	numeric(15,4) NULL,
	stip        	char(2) NULL,
	bas_ipi     	numeric(15,2) NULL,
	per_ipi     	numeric(6,2) NULL,
	vlr_ipi     	numeric(15,2) NULL,
	bas_icms_st 	numeric(15,2) NULL,
	per_icms_st 	numeric(6,2) NULL,
	vlr_icms_st 	numeric(15,2) NULL,
	serie_old   	char(3) NOT NULL,
	PRIMARY KEY(id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE INDEX id_nfe_det_empresa_local_dtnf
	ON public.nfe_det USING btree (empresa bpchar_ops, local bpchar_ops, dtnf date_ops, nro bpchar_ops, serie bpchar_ops, nr_item text_ops)
GO
CREATE INDEX nfe_det_id_empresa_local_nf
	ON public.nfe_det USING btree (empresa bpchar_ops, local bpchar_ops, nro bpchar_ops, serie bpchar_ops, nr_item text_ops)
GO
CREATE INDEX id_nfe_det_nro
	ON public.nfe_det USING btree (nro bpchar_ops)
GO
CREATE INDEX id_nfe_det_material
	ON public.nfe_det USING btree (material bpchar_ops)
GO
CREATE INDEX id_nfe_det_id_cfop
	ON public.nfe_det USING btree (id int4_ops, cfop bpchar_ops)
GO
CREATE INDEX id_nfe_det_data_nro_linha
	ON public.nfe_det USING btree (dtnf date_ops, nro_linha int4_ops)
GO

CREATE TABLE public.nfe_det_cfop  ( 
	id       	int4 NOT NULL,
	nro_linha	int4 NOT NULL,
	cfop     	char(4) NOT NULL,
	descricao	varchar(60) NOT NULL,
	tag      	char(2) NOT NULL,
	PRIMARY KEY(id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.nfe_det_comp  ( 
	id       	int4 NOT NULL,
	nro_linha	int4 NOT NULL,
	cnpj     	varchar(14) NOT NULL,
	nome     	varchar(70) NOT NULL,
	chave    	varchar(44) NOT NULL,
	bebida   	char(1) NULL,
	PRIMARY KEY(id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.nfe_det_basicmsexc  ( 
	id       	 int4 NOT NULL,
	nro_linha	 int4 NOT NULL,
	bas_icms_exc numeric(15,2) NULL,
	PRIMARY KEY(id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO


CREATE TABLE public.nfe_det_nota_ve_dema  ( 
	id_demanda  	int4 NOT NULL,
	id          	int4 NOT NULL,
	nro_linha   	int4 NOT NULL,
	dtnf        	date NOT NULL,
	nro         	char(9) NOT NULL,
	serie       	char(3) NOT NULL,
	nr_item     	varchar(10) NULL,
	material    	char(15) NULL,
	descricao   	varchar(100) NULL,
	qtd         	numeric(15,4) NULL,
	vlr_contabil	numeric(15,4) NULL,
	bas_ipi     	numeric(15,2) NULL,
	per_ipi     	numeric(6,2) NULL,
	vlr_ipi     	numeric(15,2) NULL,
	sem_venda   	varchar(1) NULL,
	id_v        	int4 NULL,
	nro_linha_v 	int4 NULL,
	PRIMARY KEY(id_demanda,id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE INDEX nfe_det_nota_ve_dema_01
	ON public.nfe_det_nota_ve_dema USING btree (id_demanda int4_ops, id_v int4_ops, nro_linha_v int4_ops)
GO

CREATE TABLE public.nfe_det_nota_venda  ( 
	id          	int4 NOT NULL,
	nro_linha   	int4 NOT NULL,
	dtnf        	date NOT NULL,
	nro         	char(9) NOT NULL,
	serie       	char(3) NOT NULL,
	nr_item     	varchar(10) NULL,
	material    	char(15) NULL,
	descricao   	varchar(100) NULL,
	qtd         	numeric(15,4) NULL,
	vlr_contabil	numeric(15,4) NULL,
	bas_ipi     	numeric(15,2) NULL,
	per_ipi     	numeric(6,2) NULL,
	vlr_ipi     	numeric(15,2) NULL,
	sem_venda   	varchar(1) NULL,
	id_v        	int4 NULL,
	nro_linha_v 	int4 NULL,
	PRIMARY KEY(id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE INDEX nota_de_venda_01
	ON public.nfe_det_nota_venda USING btree (id_v int4_ops, nro_linha_v int4_ops)
GO

CREATE TABLE public.nfe_valores  ( 
	id                            	int4 NOT NULL,
	nro_linha                     	int4 NOT NULL,
	dtnfe                         	date NOT NULL,
	dtcredito                     	date NULL,
	vlr_economico_pis             	numeric(18,4) NULL,
	vlr_outro_pis                 	numeric(18,4) NULL,
	vlr_economico_cofins          	numeric(18,4) NULL,
	vlr_outro_cofins              	numeric(18,4) NULL,
	dtfcorrecao                   	date NULL,
	vlr_economico_pis_corrigido   	numeric(18,4) NULL,
	vlr_outro_pis_corrigido       	numeric(18,4) NULL,
	vlr_economico_cofins_corrigido	numeric(18,4) NULL,
	vlr_outro_cofins_corrigido    	numeric(18,4) NULL,
	metodo_pis                    	char(5) NULL,
	metodo_cofins                 	char(5) NULL,
	taxa                          	numeric(7,2) NULL,
	usuarioinclusao               	int4 NULL,
	usuarioatualizacao            	int4 NULL,
	PRIMARY KEY(id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.nfe_valores_ipi  ( 
	id                	int4 NOT NULL,
	nro_linha         	int4 NOT NULL,
	dtnfe             	date NOT NULL,
	dtcredito         	date NULL,
	dtfcorrecao       	date NULL,
	vlr_ipi           	numeric(18,4) NULL,
	vlr_ipi_corrigido 	numeric(18,4) NULL,
	taxa              	numeric(7,2) NULL,
	usuarioinclusao   	int4 NULL,
	usuarioatualizacao	int4 NULL,
	PRIMARY KEY(id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.nfe_valores_ipi_dema  ( 
	id_demanda        	int4 NOT NULL,
	id                	int4 NOT NULL,
	nro_linha         	int4 NOT NULL,
	dtnfe             	date NOT NULL,
	dtcredito         	date NULL,
	dtfcorrecao       	date NULL,
	vlr_ipi           	numeric(18,4) NULL,
	vlr_ipi_corrigido 	numeric(18,4) NULL,
	taxa              	numeric(7,2) NULL,
	usuarioinclusao   	int4 NULL,
	usuarioatualizacao	int4 NULL,
	PRIMARY KEY(id_demanda,id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.produto_bebida  ( 
	cnpj     	char(14) NOT NULL,
	sistema  	char(5) NOT NULL,
	material 	char(15) NOT NULL,
	descricao	varchar(100) NOT NULL,
	ncm      	char(15) NOT NULL,
	bebida   	char(1) NOT NULL,
	PRIMARY KEY(cnpj,sistema,material,descricao,ncm)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.selic  ( 
	ano 	char(4) NOT NULL,
	mes 	char(2) NOT NULL,
	taxa	numeric(6,3) NULL DEFAULT 1,
	PRIMARY KEY(mes,ano)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

CREATE TABLE public.usuarios  ( 
	codigo  	serial NOT NULL,
	razao   	varchar(40) NULL,
	cnpj_cpf	varchar(14) NULL,
	cadastr 	date NULL,
	endereco	varchar(40) NULL,
	bairro  	varchar(40) NULL,
	cidade  	varchar(40) NULL,
	uf      	varchar(2) NULL,
	cep     	varchar(8) NULL,
	tel1    	varchar(23) NULL,
	tel2    	varchar(23) NOT NULL,
	email   	varchar(100) NULL,
	senha   	varchar(10) NULL 
	)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO

