DROP TABLE IF EXISTS Nfe_Det_Trade;
CREATE TABLE public.Nfe_Det_Trade  ( 
            id_grupo  int4 NOT NULL,
            id_planilha  int4 NOT NULL,
            id_operacao char(1) NOT NULL, 
            nro_linha  int4 NOT NULL,
            cod_emp varchar(6) NOT NULL, 
            local varchar(6) NOT NULL, 
            id_parc varchar(15) NOT NULL, 
            cnpj_cpf varchar(14) NOT NULL, 
            uf char(2) NOT NULL, 
            chave_acesso varchar(44) NOT NULL, 
            nro_doc varchar(20) NOT NULL, 
            nro_item varchar(10) NOT NULL, 
            nro_posicao varchar(9) NOT NULL, 
            dt_doc date NOT NULL,
            dt_lanc date NOT NULL,
            cfop char(6) NOT NULL, 
            origem char(2) NOT NULL, 
            sit_trib char(2) NOT NULL, 
            material varchar(20) NOT NULL, 
            tp_aval varchar(15) NOT NULL, 
            cod_controle varchar(15) NOT NULL, 
            denom varchar(120) NOT NULL, 
            unid char(5) NOT NULL, 
            quantidade_1 numeric(15,4) NOT NULL ,
            quantidade_2 numeric(15,4) NOT NULL ,
            qtd_conv numeric(15,4) NOT NULL ,
            preco_liq numeric(15,2) NOT NULL ,
            liquido numeric(15,2) NOT NULL ,
            valor numeric(15,2) NOT NULL ,
            vlr_contb numeric(15,2) NOT NULL ,
            pis_base numeric(15,2) NOT NULL ,
            stpis char(2) NOT NULL, 
            pis_taxa numeric(6,2) NOT NULL ,
            pis_vlr numeric(15,2) NOT NULL ,
            stcof char(2) NOT NULL, 
            cof_base numeric(15,2) NOT NULL ,
            cof_taxa numeric(6,2) NOT NULL ,
            cof_vlr numeric(15,2) NOT NULL ,
            ipi_base numeric(15,2) NOT NULL ,
            ipi_taxa numeric(6,2) NOT NULL ,
            ipi_vlr numeric(15,2) NOT NULL ,
            icms_base numeric(15,2) NOT NULL ,
            icms_taxa numeric(6,2) NOT NULL ,
            icms_vlr numeric(15,2) NOT NULL ,
            fecp_vlr numeric(15,2) NOT NULL ,
            icst_base numeric(15,2) NOT NULL ,
            icst_taxa numeric(6,2) NOT NULL ,
            icst_valor numeric(15,2) NOT NULL ,
            fest_valor numeric(15,2) NOT NULL ,
            bc_icms_rt numeric(15,2) NOT NULL ,
            vlr_icms_str numeric(15,2) NOT NULL ,
            vlr_fcps_st_rt numeric(15,2) NOT NULL ,
            doc_origem varchar(20) NOT NULL, 
            item_ref varchar(10) NOT NULL, 
            saldo numeric(15,4) NOT NULL ,
            sobra numeric(15,4) NOT NULL ,
            status char(1) NOT NULL, 
 	PRIMARY KEY(id_grupo,id_planilha,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS nfe_cab_trade;
CREATE TABLE public.nfe_cab_trade  ( 
	id_grupo          	int4 NOT NULL,
	id                	serial NOT NULL,
	arquivo          	varchar(200) NOT NULL,
    cnpj                char(14)     NOT NULL,
    cod_emp             varchar(6)   NOT NULL,
    local               varchar(6)    NOT NULL,
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
TABLESPACE "Producao"
GO
CREATE INDEX nfe_cab_trade_arquivo
	ON public.nfe_cab_trade USING btree (id_grupo int4_ops, arquivo bpchar_ops)
GO


CREATE TABLE public.fechamento  ( 
	id_grupo   	int4 NOT NULL,
	id         	serial NOT NULL,
	pinicial   	date NOT NULL,
	pfinal     	date NOT NULL,
	descricao  	varchar(30) NOT NULL,
	user_insert	int4 NOT NULL,
	dtinicial  	timestamp NOT NULL,
	dtfinal    	timestamp NOT NULL,
	status     	char(1) NOT NULL,
	PRIMARY KEY(id_grupo,id)
)
WITHOUT OIDS 
TABLESPACE pg_default
GO


SELECT * FROM USUARIOS


SELECT * FROM CLIENTES  order by codigo

UPDATE CLIENTES SET cadastr = '2024-04-25' WHERE cadastr is null 

UPDATE clientes
SET cnpj_cpf = REPLACE(REPLACE(REPLACE(cnpj_cpf, '.', ''), '-', ''), '/', '');

16.622.166/0022-04  