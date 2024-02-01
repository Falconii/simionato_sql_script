CREATE TABLE public.movicab  ( 
	id                	serial NOT NULL,
	ano               	char(4) NOT NULL,
	mes               	char(2) NOT NULL,
	cnpj              	char(14) NOT NULL,
	seq               	int4 NOT NULL,
	pasta             	varchar(200) NOT NULL,
	arquivo           	varchar(100) NOT NULL,
	nro_linha         	int4 NOT NULL,
	datainicial       	date NOT NULL,
	datafinal         	date NOT NULL,
	k200              	char(1) NOT NULL,
	usuarioinclusao   	int4 NULL,
	usuarioatualizacao	int4 NULL,
	data_criacao      	timestamp NULL,
	data_fechamento   	timestamp NULL,
	status            	int4 NULL,
	PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

/*
GO
CREATE INDEX nfe_Cab_id_planilha
	ON public.nfe_Cab  USING btree (planilha bpchar_ops) TABLESPACE "Producao"
GO
CREATE INDEX nfe_Cab_id_cnpj
	ON public.nfe_Cab  USING btree (cnpj bpchar_ops,ano bpchar_ops, mes bpchar_ops,seq bpchar_ops) TABLESPACE "Producao"
GO
CREATE INDEX nfe_Cab_ano_mes_cnpj_seq
	ON public.nfe_Cab  USING btree (ano bpchar_ops, mes bpchar_ops,seq bpchar_ops) TABLESPACE "Producao"
GO
*/

CREATE TABLE public.movidet  ( 
	id           	int4 NOT NULL,
	nro_linha    	int4 NOT NULL,
	tipo_registro	char(4) NOT NULL,
	es           	char(1) NOT NULL,
	propria      	char(1) NOT NULL,
	dtnf         	date NULL,
	nro          	char(9) NOT NULL,
	serie        	char(3) NOT NULL,
	status_op    	char(1) NOT NULL,
	item         	text NOT NULL,
	cod_part     	varchar(60) NOT NULL,
	cnpj_part    	char(14) NOT NULL,
	razao_part   	varchar(100) NOT NULL,
	id_ref       	int4 NOT NULL,
	nro_linha_ref	int4 NOT NULL,
	qtd          	numeric(15,3) NOT NULL,
	PRIMARY KEY(id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO
CREATE INDEX id_movidet_notaanterior
	ON public.movidet USING btree (id int4_ops, tipo_registro bpchar_ops, es bpchar_ops, propria bpchar_ops, dtnf date_ops, nro bpchar_ops, serie bpchar_ops) TABLESPACE "Producao"
GO
CREATE INDEX id_movidet_id_item
	ON public.movidet USING btree (id int4_ops, item text_ops) TABLESPACE "Producao"
GO
CREATE INDEX id_movidet_id_tipo_registro_cod_part
	ON public.movidet USING btree (id int4_ops, tipo_registro bpchar_ops, cod_part text_ops) TABLESPACE "Producao"
GO

CREATE TABLE public.periodo  ( 
    cnpj                    char(14) NOT NULL,
    ano                     char(04) NOT NULL,
    mes                     char(02) NOT NULL,
    seq                     int4     NOT NULL,
    status                  int4     NOT NULL,
	PRIMARY KEY(cnpj,ano,mes)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


CREATE TABLE public.empresas  ( 
	id   	serial NOT NULL,
	cnpj 	varchar(14) NOT NULL,
	razao	varchar(100) NOT NULL,
	PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

CREATE INDEX empresas_cnpj
	ON public.empresas USING btree (cnpj text_ops)  TABLESPACE "Producao"
GO
