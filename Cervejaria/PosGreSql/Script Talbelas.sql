DROP TABLE IF EXISTS CLIENTES;
CREATE TABLE public.clientes  ( 
	codigo     	serial NOT NULL,
	cnpj_cpf   	varchar(18) NULL,
	razao      	varchar(40) NULL,
	fantasi    	varchar(20) NULL,
	inscri     	varchar(20) NULL,
	empresa    	char(6) NOT NULL,
	codprotheus	char(6) NOT NULL,
	codsic     	char(6) NOT NULL,
	codsap     	char(6) NOT NULL,
	codsoja    	char(6) NOT NULL,
	cadastr    	date NULL,
	enderecof  	varchar(80) NULL,
	bairrof    	varchar(40) NULL,
	cidadef    	varchar(40) NULL,
	uff        	varchar(2) NULL,
	cepf       	varchar(8) NULL,
	telf       	varchar(23) NULL,
	celf       	varchar(23) NULL,
	faxf       	varchar(23) NULL,
	emailf     	varchar(100) NULL,
	obs        	varchar(200) NULL,
	PRIMARY KEY(codigo)
)
WITHOUT OIDS 
TABLESPACE 'PRODUCAO'
GO

DROP TABLE IF EXISTS contacontabil;
CREATE TABLE public.contacontabil  ( 
	conta    	varchar(20) NOT NULL,
	descricao	varchar(100) NOT NULL,
	nivel    	varchar(1) NOT NULL,
	PRIMARY KEY(conta)
)
WITHOUT OIDS 
TABLESPACE 'PRODUCAO'
GO
CREATE INDEX id_contacontabil_descricao
	ON public.contacontabil USING btree (descricao text_ops)
GO
GRANT SELECT(nivel), INSERT(nivel), UPDATE(nivel), REFERENCES(nivel) ON public.contacontabil TO postgres WITH GRANT OPTION
GO
GRANT SELECT(descricao), INSERT(descricao), UPDATE(descricao), REFERENCES(descricao) ON public.contacontabil TO postgres WITH GRANT OPTION
GO
GRANT SELECT(conta), INSERT(conta), UPDATE(conta), REFERENCES(conta) ON public.contacontabil TO postgres WITH GRANT OPTION
GO

DROP TABLE IF EXISTS movicab;
CREATE TABLE public.movicab  ( 
	id                	serial NOT NULL,
	path              	varchar(200) NOT NULL,
	arquivo           	varchar(200) NOT NULL,
	cdempresa         	char(5) NOT NULL,
	vlr_debito        	numeric(15,2) NULL,
	vlr_credito       	numeric(15,2) NULL,
	nro_linha         	int4 NULL,
	usuarioinclusao   	int4 NULL,
	usuarioatualizacao	int4 NULL,
	data_criacao      	timestamp NULL,
	data_fechamento   	timestamp NULL,
	status            	int4 NULL,
	PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE 'PRODUCAO'
GO
CREATE INDEX id_movicab_cdempres
	ON public.movicab USING btree (cdempresa bpchar_ops, arquivo text_ops)
GO
CREATE UNIQUE INDEX id_movicab_arquivo
	ON public.movicab USING btree (arquivo text_ops)
GO
DROP TABLE IF EXISTS movidet;
CREATE TABLE public.movidet  ( 
	id            	int4 NOT NULL,
	linha         	int4 NOT NULL,
	bkpf_bukrs    	char(5) NOT NULL,
	bkpf_belnr    	char(20) NOT NULL,
	bkpf_gjahr    	int4 NOT NULL,
	bkpf_blart    	char(5) NOT NULL,
	bkpf_bldat    	date NOT NULL,
	bkpf_budat    	date NOT NULL,
	bkpf_monat    	int4 NOT NULL,
	bkpf_cpudt    	date NOT NULL,
	bkpf_cputm    	char(20) NOT NULL,
	bkpf_usnam    	char(20) NOT NULL,
	bkpf_bktxt    	varchar(255) NOT NULL,
	bkpf_bstat    	char(5) NOT NULL,
	bseg_buzei    	int4 NOT NULL,
	bseg_koart    	char(1) NOT NULL,
	bseg_shkzg    	char(1) NOT NULL,
	bseg_dmbtr    	numeric(15,2) NOT NULL,
	bseg_sgtxt    	varchar(255) NOT NULL,
	bseg_hkont    	char(10) NOT NULL,
	contra_partida	numeric(15,2) NULL,
	saldo_inicial 	numeric(15,2) NULL,
	saldo         	numeric(15,2) NULL 
	)
WITHOUT OIDS 
TABLESPACE 'PRODUCAO'
GO
CREATE INDEX id_movidet_empresa_conta_data
	ON public.movidet USING btree (bkpf_bukrs bpchar_ops, bseg_hkont bpchar_ops, bkpf_budat date_ops)
GO
CREATE INDEX movi_det_cc
	ON public.movidet USING btree (bkpf_bukrs bpchar_ops, bseg_hkont bpchar_ops, bkpf_budat date_ops)
GO
CREATE INDEX movi_det_pk
	ON public.movidet USING btree (bkpf_bukrs bpchar_ops, bkpf_belnr bpchar_ops, bseg_buzei int4_ops, bkpf_budat date_ops)
GO
CREATE INDEX movi_det_id
	ON public.movidet USING btree (id int4_ops, bkpf_blart bpchar_ops)
GO
CREATE INDEX id_movidet_id_linha
	ON public.movidet USING btree (id int4_ops, linha int4_ops)
GO
DROP TABLE IF EXISTS movidetsaldo;
CREATE TABLE public.movidetsaldo  ( 
	id            	int4 NOT NULL,
	linha         	int4 NOT NULL,
	saldo_inicial 	numeric(15,2) NULL,
	saldo         	numeric(15,2) NULL,
    PRIMARY KEY(id,linha)
	)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS saldo;
CREATE TABLE public.saldo  ( 
	cdempresa   	varchar(6) NOT NULL,
	cdfilial    	varchar(10) NOT NULL,
    cdCC            varchar(10) NOT NULL,
	conta       	varchar(20) NOT NULL,
	ano         	varchar(4) NOT NULL,
	mes         	varchar(2) NOT NULL,
    origem          varchar(50) NOT NULL,
    estrubal        varchar(20) NOT NULL,
	saldoinicial	numeric(15,2) NULL,
	credito     	numeric(15,2) NULL,
	debito      	numeric(15,2) NULL,
	saldofinal  	numeric(15,2) NULL,
	PRIMARY KEY(cdempresa,cdfilial,cdcc,conta,ano,mes,origem)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

//acumualdor mensal
DROP TABLE IF EXISTS acu_mensal;
CREATE TABLE public.acu_mensal( 
	cdempresa   	varchar(6) NOT NULL,
	cdfilial    	varchar(10) NOT NULL,
    cdCC            varchar(10) NOT NULL,
	ano         	varchar(4) NOT NULL,
    conta           varchar(20) NOT NULL,
    origem          varchar(50) NOT NULL,
    estrubal        varchar(20) NOT NULL,
    saldo_anterior  numeric(15,2)  NULL,
    saldos          numeric(15,2)[12] NULL,
	PRIMARY KEY(cdempresa,cdfilial,cdCC,ano,conta,origem)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


INSERT INTO public.acu_mensal(cdempresa, cdfilial, ano, conta, saldos) 
	VALUES('10', '10', '2023', 'ZZZZZ', '{1,2,3,4,5,6,7,8,9,10,11,12}')
GO

update acu_mensal set saldos[10] = 200.30;

SELECT cdempresa,     cdfilial,     ano,     conta, saldos  FROM acu_mensal


/*
	saldo_01    	numeric(15,2) NULL default 0,
    saldo_02    	numeric(15,2) NULL default 0,
    saldo_03    	numeric(15,2) NULL default 0,
    saldo_04    	numeric(15,2) NULL default 0,
    saldo_05    	numeric(15,2) NULL default 0,
    saldo_06    	numeric(15,2) NULL default 0,
    saldo_07    	numeric(15,2) NULL default 0,
    saldo_08    	numeric(15,2) NULL default 0,
    saldo_09    	numeric(15,2) NULL default 0,
    saldo_10    	numeric(15,2) NULL default 0,
    saldo_11    	numeric(15,2) NULL default 0,
    saldo_12    	numeric(15,2) NULL default 0,
*/


