CREATE TABLE Public.CLIENTES (
	id_empresa      int4 NOT NULL,
	id       		serial NOT NULL,
	cnpj_cpf 		varchar(18) NULL,
	razao    		varchar(65) NULL,
	fantasi  		varchar(25) NULL,
	inscri   		varchar(20) NULL,
	cadastr  		date NULL,
	ruaf    		varchar(80) NULL,
	nrof			varchar(10) NULL,
	complementof	varchar(30) NULL,
	bairrof  		varchar(40) NULL,
	cidadef  		varchar(40) NULL,
	uff      		varchar(2) NULL,
	cepf     		varchar(8) NULL,
	tel1			varchar(23) NULL,
	tel2			varchar(23) NULL,
	emailf   		varchar(100) NULL,
	obs      		varchar(200) NULL,
	gru_econo	    int4 NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


CREATE TABLE Public.MOTIVOS_APO (
    id_empresa      int4        NOT NULL,
	codigo    		varchar(06) NOT NULL,
	motivo   		varchar(20) NOT NULL,
    produtivo       char(1)     NOT NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,codigo)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


CREATE TABLE Public.FERIADOS (
	id_empresa  int4 NOT NULL,
	datafer		Date NOT NULL,
	descricao	VARCHAR(40),
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,datafer)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

CREATE TABLE Public.TAREFAS (
	id_empresa  int4 NOT NULL,
	codigo	    char(06),
    descricao	VARCHAR(40),
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,codigo)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS PROJETOS;
CREATE TABLE Public.PROJETOS (
    id_empresa  int4 NOT NULL,
	id			serial,
	id_cliente	int4 NOT NULL,
	id_diretor	int4 NOT NULL,
	dataprop	Date NULL,
	dataproj	Date NULL,
	dataenc		Date NULL,
	descricao	VARCHAR(50)  NOT NULL,
	horasve		NUMERIC(7,2) NOT NULL,
	horasplan	NUMERIC(7,2) NOT NULL,
	horasexec	NUMERIC(7,2) NOT NULL,
    horasdir    NUMERIC(7,2) NOT NULL,
	status		char(1) NOT NULL DEFAULT '0',
    status_pl   char(1) NOT NULL DEFAULT '0',
    status_ex   char(1) NOT NULL DEFAULT '0',
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

CREATE TABLE Public.TAREFAS_PROJETO (
    id_empresa      int4 NOT NULL,
	id       		serial NOT NULL,
	id_projeto  	int4 NOT NULL,
	id_tarefa  		char(06) NOT NULL,
    id_resp  		int4 NOT NULL,
	seq				int4 NOT NULL,
	Inicial			Date NOT NULL,
	Final			Date NOT NULL,
	obs				char(50),
	horasplan		NUMERIC(7,2) NOT NULL,
	horasexec		NUMERIC(7,2) NOT NULL,
	status	        char(1)  NOT NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
   PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

/*
	0->Em Aberta
	1->Trabalhos OK
	2->Planejamento Trabalhos OK
	3->Em Andamento
	4->Encerrada
	5->Suspensa
	6->Cancelada
	
*/

CREATE TABLE Public.TRABALHOS_PROJETO (
    id_empresa      int4 NOT NULL,
    id       		serial NOT NULL,
	id_projeto  	int4 NOT NULL,
	id_tarefa  		char(06) NOT NULL,
	id_trabalho		char(06) NOT NULL,
	seq				int4 NOT NULL,
	id_resp  		int4 NOT NULL,
	id_exec			int4 NOT NULL,
	Inicial			Date NOT NULL,
	Final			Date NOT NULL,
	obs				char(50),
	horasplan		NUMERIC(7,2) NOT NULL,
	horasexec		NUMERIC(7,2) NOT NULL,
	status          char(1),
    user_insert     int4 NULL,
    user_update     int4 NULL,
   PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

/*
	0->Em aberto
	1->Planejamento Trabalhos OK
	2->Em Andamento
	3->Encerrada
	4->Suspensa
	5->Cancelada
*/

DROP TABLE IF EXISTS APONS_PLANEJAMENTO;
CREATE TABLE Public.APONS_PLANEJAMENTO (
    id_empresa      int4   NOT NULL,
    id       		serial NOT NULL,
	id_projeto  	int4 NOT NULL,
	id_conta  		char(02) NOT NULL,
    id_conta_versao char(04) NOT NULL
	id_subconta		char(14) NOT NULL,
	id_resp  		int4 NOT NULL,
	id_exec			int4 NOT NULL,
	Inicial			timestamp NOT NULL,
	Final			timestamp NOT NULL,
	horasapon		NUMERIC(5,2) NOT NULL,
	obs				char(50),
	encerra         char(1),
    user_insert     int4 NULL,
    user_update     int4 NULL,
   PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

/*
  0-Sim
  1-Não
*/
DROP TABLE IF EXISTS APONS_EXECUCAO;
CREATE TABLE Public.APONS_EXECUCAO (
    id_empresa      int4 NOT NULL,
    id       		serial NOT NULL,
	id_projeto  	int4 NOT NULL,
	id_conta 		char(02) NOT NULL,
    id_conta_versao char(04) NOT NULL,
	id_subconta		char(14) NOT NULL,
	id_resp  		int4 NOT NULL,
	id_exec			int4 NOT NULL,
    id_motivo       char(06) NOT NULL,
	Inicial			timestamp NOT NULL,
	Final			timestamp NOT NULL,
	obs				char(50),
	horasapon		NUMERIC(5,2) NOT NULL,
	encerramento    char(1) NOT NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
   PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


DROP TABLE IF EXISTS estruturas;
CREATE TABLE Public.estruturas (
		id_empresa int4  NOT NULL  , 
		conta char(02)  NOT NULL   ,
        versao char(04) NOT NULL   ,
		subconta char(14) NOT NULL , 
		descricao varchar(300)  NOT NULL  , 
		nivel int4  NOT NULL  , 
		nivel_maxi int4  NOT NULL  , 
		tipo char(1)  NOT NULL  , 
		controle char(1)  NOT NULL,
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
        status      int4  NOT NULL  ,
        id_usuario  int4  NULL
		PRIMARY KEY(id_empresa,conta,versao,subconta) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 





/*
 TIPO  CONTA       "C"
       SUBCONTA    "S"
       OPERACIONAL "O"
*/


/* TABELA atividades  */
DROP TABLE IF EXISTS atividades;
CREATE TABLE Public.atividades (
		id_empresa int4     NOT NULL  , 
		id serial           NOT NULL  , 
		id_projeto int4     NOT NULL  , 
		conta    char(02)   NOT NULL  , 
        versao   char(04)   NOT NULL  ,
		subconta char(14)   NOT NULL  , 
		nivel int4          NOT NULL  , 
		tipo char(1)        NOT NULL  , 
		controle char(1)    NOT NULL  ,
		id_resp int4        NOT NULL  , 
		id_exec int4        NOT NULL  , 
		id_subcliente int4  NOT NULL  , 
		inicial Date        NOT NULL  , 
		final Date          NOT NULL  , 
		horasplan numeric(7,2)  NOT NULL  , 
		horasexec numeric(7,2)  NOT NULL  , 
        horasdir    NUMERIC(7,2) NOT NULL ,
		obs varchar(60)         NOT NULL  , 
        status char(1)          NOT NULL DEFAULT '0',
        status_pl   char(1)     NOT NULL DEFAULT '0',
        status_ex   char(1)     NOT NULL DEFAULT '0',
		user_insert int4        NOT NULL  , 
		user_update int4        NOT NULL  , 
		PRIMARY KEY(id_empresa,id) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 


/* TABELA niveis  */
DROP TABLE IF EXISTS niveis;
CREATE TABLE Public.niveis (
		id_empresa int4     NOT NULL  , 
		id_projeto int4     NOT NULL  , 
		conta    char(02)   NOT NULL  , 
        versao   char(04)   NOT NULL  ,
		subconta char(14)   NOT NULL  , 
		geracao Date        NOT NULL  , 
		nivel int4          NOT NULL  , 
		tipo char(1)        NOT NULL  , 
		nivelplan int4  NOT NULL  , 
		nivelexec int4  NOT NULL  ,
		user_insert int4        NOT NULL  , 
		user_update int4        NOT NULL  , 
		PRIMARY KEY(id_empresa,id_projeto,conta,subconta) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 


/* TABELA projeto_valores  */
DROP TABLE IF EXISTS projeto_valores;
CREATE TABLE Public.projeto_valores (
		id_empresa int4  NOT NULL  , 
		id serial  NOT NULL  , 
		id_projeto int4  NOT NULL  , 
		id_diretor int4  NOT NULL  , 
		id_cond_pgto int4  NOT NULL  , 
		descricao varchar(150)  NOT NULL  , 
		emissao Date  NOT NULL  , 
		valor numeric(15,2)  NOT NULL  , 
		saldo numeric(15,2)  NOT NULL  , 
		status char(1)  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO 


/* TABELA condicoes_pagto  */
DROP TABLE IF EXISTS condicoes_pagto;
CREATE TABLE Public.condicoes_pagto (
		id_empresa int4  NOT NULL  , 
		id serial  NOT NULL  , 
		descricao varchar(50)  NOT NULL  , 
        np        int4         NOT NULL,
		parcelas char(72)  NOT NULL  , 
		dia int4  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id) 
)
 WITHOUT OIDS 
 TABLESPACE "Producao" 
 GO

/*

ALTER TABLE ESTRUTURAS ADD CONSTRAINT estruturas_pkey PRIMARY  KEY(id_empresa,conta,versao,subconta)

ALTER TABLE ATIVIDADES ADD COLUMN versao char(04)

ALTER TABLE ESTRUTURAS ADD COLUMN status int4 

status      int4  NOT NULL  ,


*/
