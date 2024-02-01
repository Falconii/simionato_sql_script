DROP TABLE IF EXISTS CLIENTES;
CREATE TABLE public.clientes  ( 
    id_grupo        int4   NOT NULL,
	codigo      	serial NOT NULL,
	cnpj_cpf    	varchar(18) NULL,
	razao       	varchar(60) NULL,
	fantasi     	varchar(60) NULL,
	inscri      	varchar(20) NULL DEFAULT ''::character varying,
	empresa     	char(6) NOT NULL DEFAULT ''::bpchar,
    local           char(6) NOT NULL DEFAULT '',
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
	PRIMARY KEY(id_grupo,codigo)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE UNIQUE INDEX clientes_cnpj
	ON public.clientes USING btree (id_grupo,cnpj_cpf text_ops)
GO
CREATE UNIQUE INDEX clientes_codempres_local
	ON public.clientes USING btree (id_grupo,cod_empresa bpchar_ops, local bpchar_ops)
GO

DROP TABLE IF EXISTS USUARIOS;
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
TABLESPACE "PRODUCAO"
GO

INSERT INTO public.usuarios(razao, cnpj_cpf, cadastr, endereco, bairro, cidade, uf, cep, tel1, tel2, email, senha, pasta) 
	VALUES('ADM', '', '2022-08-01', '', '', '', '', '', '', '', '', '123456','C:\RICARDO')
GO

DROP TABLE IF EXISTS nfe_cab_e;
CREATE TABLE public.nfe_cab_e  ( 
    id_grupo            int4   NOT NULL,
	id                	serial NOT NULL,
	planilha          	varchar(200) NOT NULL,
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
	PRIMARY KEY(id_grupo,id)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE INDEX nfe_cab_e_id_planilha
	ON public.nfe_cab_e USING btree (id_grupo int4_ops,planilha bpchar_ops)
GO

DROP TABLE IF EXISTS nfe_det_e;
CREATE TABLE public.nfe_det_e( 
    id_grupo        int4 NOT NULL,
	id          	int4 NOT NULL,
    operacao        char(1) NOT NULL,
	nro_linha   	int4 NOT NULL,
	cod_empresa    	char(6) NOT NULL,
	local       	char(6) NOT NULL,
    id_planilha     char(10) NOT NULL,
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
    cfop_texto      varchar(10) NULL,
	qtd         	numeric(15,4) NULL,
	vlr_contabil	numeric(15,4) NULL,
    vlr_unit    	numeric(15,2) NULL,
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
    cnpj_destinatario varchar(14) NOT NULL,
    chave             varchar(44) NOT NULL,
    nome              varchar(70) NOT NULL,
    saldo             numeric(15,4) NULL,
    sobra             numeric(15,4) NULL,
    status            char(1) NULL DEFAULT 0,
	PRIMARY KEY(id_grupo,id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE INDEX id_processamento
	ON public.nfe_det_e USING btree (id_grupo int4_ops, cod_empresa bpchar_ops, local bpchar_ops, material bpchar_ops, operacao bpchar_ops, dtlanc date_ops, saldo numeric_ops)
GO
CREATE INDEX id_select_vendas
	ON public.nfe_det_e USING btree (id_grupo int4_ops, operacao bpchar_ops, status bpchar_ops, dtnf date_ops)
GO
CREATE INDEX id_nfe_det_e_empresa_local_dtnf
	ON public.nfe_det_e USING btree (id_grupo int4_ops,cod_empresa bpchar_ops, local bpchar_ops, dtnf date_ops, nro bpchar_ops, serie bpchar_ops, nr_item text_ops)
GO
CREATE INDEX nfe_det_e_id_empresa_local_nf
	ON public.nfe_det_e USING btree (id_grupo int4_ops,cod_empresa bpchar_ops, local bpchar_ops, nro bpchar_ops, serie bpchar_ops, nr_item text_ops)
GO
CREATE INDEX id_nfe_e_det_nro
	ON public.nfe_det_e USING btree (id_grupo int4_ops,nro bpchar_ops)
GO
CREATE INDEX id_nfe_e_det_material
	ON public.nfe_det_e USING btree (id_grupo int4_ops,material bpchar_ops)
GO
CREATE INDEX id_nfe_det_e_id_cfop
	ON public.nfe_det_e USING btree (id_grupo int4_ops,id int4_ops, cfop bpchar_ops)
GO
CREATE INDEX id_nfe_det_e_data_nro_linha
	ON public.nfe_det_e USING btree (id_grupo int4_ops,dtnf date_ops, nro_linha int4_ops)
GO


DROP TABLE IF EXISTS controle_e;
CREATE TABLE public.controle_e  ( 
    id_grupo        int4 NOT NULL,
    id_fechamento   int4 NOT NULL,
	id_s          	int4 NOT NULL,
    nro_linha_s     int4 NOT NULL,
	id_e          	int4 NOT NULL,
    nro_linha_e     int4 NOT NULL,
    qtd_s           numeric(15,4) NULL,
	qtd_e   	    numeric(15,4) NULL,
	PRIMARY KEY(id_grupo,id_fechamento,id_s,nro_linha_s,id_e,nro_linha_e)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"
GO
CREATE INDEX controle_e_id_grupo_id_fec_id_e_nro_e
	ON public.controle_e USING btree (id_grupo int4_ops, id_fechamento int4_ops, id_e int4_ops, nro_linha_e int4_ops)
GO

DROP TABLE IF EXISTS fechamento;
CREATE TABLE public.fechamento  ( 
	id_grupo        int4 NOT NULL,
    id              serial NOT NULL,
	pinicial       	Date NOT NULL,
    pfinal       	Date NOT NULL,
    descricao       varchar(30) NOT NULL,
	user_insert    	int4 NOT NULL,
    dtinicial       timestamp NOT NULL,
    dtfinal         timestamp NOT NULL,
	status          char(1) NOT NULL,
	PRIMARY KEY(id_grupo,id)
)
WITHOUT OIDS 
TABLESPACE "PRODUCAO"

