//DROP TABLE IF EXISTS CLIENTES;
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
GO

//DROP TABLE IF EXISTS FERIADOS;
CREATE TABLE Public.FERIADOS (
	id_empresa  int4 NOT NULL,
    id_usuario  int4 NOT NULL, 
    id_tipo     int4 NOT NULL,
	data		Date NOT NULL,
    id_nivel    int4 NOT NULL,
	descricao	VARCHAR(50),
	conta       char(02)   NOT NULL  , 
    versao      char(04)   NOT NULL  ,
	subconta    char(14)   NOT NULL  , 
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id_usuario,id_tipo,data)
)
GO
/*
ALTER TABLE FERIADOS (Excluidos"
ADD COLUMN  nlanc_manha int4 NULL,
ADD COLUMN  nlanc_tarde int4 NULL;

ALTER TABLE FERIADOS 
ADD conta       char(02)  default '' NOT NULL  , 
ADD versao      char(04)  default '' NOT NULL  ,
ADD subconta    char(14)  default '' NOT NULL  ; 


*/

//DROP TABLE IF EXISTS PROJETOS;
CREATE TABLE Public.PROJETOS (
    id_empresa      int4 NOT NULL,
	id              serial,
	id_cliente      int4 NOT NULL,
	id_diretor      int4 NOT NULL,
	dataprop        Date NULL,
	dataproj        Date NULL,
	dataenc         Date NULL,
	descricao       VARCHAR(50)  NOT NULL,
	horasve         NUMERIC(7,2) NOT NULL,
	horasplan       NUMERIC(7,2) NOT NULL,
	horasexec       NUMERIC(7,2) NOT NULL,
    horasdir        NUMERIC(7,2) NOT NULL,
	status          char(1) NOT NULL DEFAULT '0',
    status_pl       char(1) NOT NULL DEFAULT '0',
    status_ex       char(1) NOT NULL DEFAULT '0',
    id_tipo         int4  NOT NULL DEFAULT 1,
    objeto          varchar(200) NOT NULL DEFAULT '',
    obs             varchar(250) NOT NULL DEFAULT '',
    reajuste        Date NULL,
    Valor           NUMERIC(15,2) NOT NULL,
    id_cond_pgto    int4 NULL,
    id_contrato     int4 NULL,
    id_parceira     int4 NULL,
    assinatura       Date NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
    PRIMARY KEY(id_empresa,id)
)
GO

/*
ALTER TABLE PROJETOS ADD COLUMN    id_tipo         int4 NOT NULL DEFAULT 1;
GO
ALTER TABLE PROJETOS DROP COLUMN   id_tipo    ;
GO
ALTER TABLE PROJETOS ADD COLUMN    objeto          varchar(200) NOT NULL DEFAULT '';
GO
ALTER TABLE PROJETOS ADD COLUMN    obs             varchar(250) NOT NULL DEFAULT '';
GO
ALTER TABLE PROJETOS ADD COLUMN    reajuste        Date NULL;
GO
ALTER TABLE PROJETOS ADD COLUMN    Valor           NUMERIC(15,2) NOT NULL DEFAULT 0;
GO
ALTER TABLE PROJETOS ADD COLUMN    id_cond_pgto    int4 NULL;
GO
ALTER TABLE PROJETOS ADD COLUMN    id_contrato      int4 NULL;
GO
ALTER TABLE PROJETOS ADD COLUMN    id_parceira      int4 NOT NULL DEFAULT 1;
GO
ALTER TABLE PROJETOS DROP COLUMN  id_dona
GO
ALTER TABLE PROJETOS ADD COLUMN    assinatura      Date NULL;
GO
/*



*/


/*
	0->Em Aberta
	1->Trabalhos OK
	2->Planejamento Trabalhos OK
	3->Em Andamento
	4->Encerrada
	5->Suspensa
	6->Cancelada
	
*/


/*
	0->Em aberto
	1->Planejamento Trabalhos OK
	2->Em Andamento
	3->Encerrada
	4->Suspensa
	5->Cancelada
*/

//DROP TABLE IF EXISTS APONS_PLANEJAMENTO;
CREATE TABLE Public.APONS_PLANEJAMENTO (
    id_empresa      int4   NOT NULL,
    id       		serial NOT NULL,
	id_projeto  	int4 NOT NULL,
	id_conta  		char(02) NOT NULL,
    id_conta_versao char(04) NOT NULL,
	id_subconta		char(14) NOT NULL,
    id_subcliente   int4     NOT NULL,
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
GO

/*
  0-Sim
  1-Não
*/
//DROP TABLE IF EXISTS APONS_EXECUCAO;
CREATE TABLE Public.APONS_EXECUCAO (
    id_empresa      int4 NOT NULL,
    id       		serial NOT NULL,
	id_projeto  	int4 NOT NULL,
	id_conta 		char(02) NOT NULL,
    id_conta_versao char(04) NOT NULL,
	id_subconta		char(14) NOT NULL,
    id_subcliente   int4     NOT NULL,
	id_resp  		int4 NOT NULL,
	id_exec			int4 NOT NULL,
    id_motivo       char(06) NOT NULL,
    produtivo       char(1)  NOT NULL default 'S',
	Inicial			timestamp NOT NULL,
	Final			timestamp NOT NULL,
	obs				char(150),
	horasapon		NUMERIC(5,2) NOT NULL,
	encerramento    char(1) NOT NULL,
    user_insert     int4 NULL,
    user_update     int4 NULL,
   PRIMARY KEY(id_empresa,id)
)
GO
/*
ALTER TABLE APONS_EXECUCAO
ADD COLUMN  nlanc int4 NULL default 0;
*/


//DROP TABLE IF EXISTS estruturas;
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
        id_usuario  int4  NULL,
		PRIMARY KEY(id_empresa,conta,versao,subconta) 
) 
GO 





/*
 TIPO  CONTA       "C"
       SUBCONTA    "S"
       OPERACIONAL "O"
*/


/* TABELA atividades  */
//DROP TABLE IF EXISTS atividades;
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
 GO 

/* TABELA atividades  */
//DROP TABLE IF EXISTS parametros;
CREATE TABLE Public.parametros (
		id_empresa   int4     NOT NULL  , 
		modulo       char(20) NOT NULL  , 
        assinatura   char(20) NOT NULL,
		id_usuario   int4     NOT NULL  , 
        parametro    text     NOT NULL ,
		user_insert  int4     NOT NULL  , 
		user_update  int4     NOT NULL  , 
		PRIMARY KEY(id_empresa,modulo,assinatura,id_usuario) 
)
 GO 


//DROP TABLE IF EXISTS tickets_fechamento;
CREATE TABLE Public.tickets_fechamento (
		id_empresa int4  NOT NULL  , 
		referencia varchar(7)  NOT NULL , 
		data_inicial date  NOT NULL  , 
		data_final date  NOT NULL  , 
		id_resp int4  NOT NULL  , 
		id_usuario int4  NOT NULL  , 
		status varchar(1)  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,referencia) 
)

/* TABELA tickets_libera  */
//DROP TABLE IF EXISTS tickets_libera;
CREATE TABLE Public.tickets_libera (
		id_empresa int4  NOT NULL  , 
		referencia varchar(7)  NOT NULL  , 
		id serial  NOT NULL  , 
		id_resp int4  NOT NULL  , 
		justificativa varchar(100)  NOT NULL  , 
		id_usuario int4  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,referencia) 
)

/* TABELA tickets_movi  */
//DROP TABLE IF EXISTS tickets_movi;
CREATE TABLE Public.tickets_movi (
		id_empresa int4  NOT NULL  , 
		id_usuario int4  NOT NULL  , 
		data_ref date  NOT NULL  , 
		util varchar(1)  NOT NULL  , 
		feriado varchar(1)  NOT NULL  , 
		ponte varchar(1)  NOT NULL  , 
		afastado varchar(1)  NOT NULL  , 
		ferias varchar(1)  NOT NULL  , 
		horas numeric(8,2)  NOT NULL  , 
		total numeric(15,2)  NOT NULL  , 
        tickets_libera int4 NOT NULL DEFAULT 0,
        tickets  int4 NOT NULL default 0,
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  , 
		PRIMARY KEY(id_empresa,id_usuario,data_ref) 
)

/* TABELA titulos_projeto  */
//DROP TABLE IF EXISTS titulos_projeto;
CREATE TABLE Public.titulos_projeto (
		id_empresa int4  NOT NULL  , 
		id_projeto int4  NOT NULL  , 
		data_vencto date  NOT NULL  , 
		data_pagto date  NULL , 
		valor numeric(15,2)  NOT NULL  , 
		obs varchar(100)  NOT NULL  , 
		user_insert int4  NOT NULL  , 
		user_update int4  NOT NULL  ,
		PRIMARY KEY(id_empresa,id_projeto,data_vencto) 
)
 GO 


//DROP TABLE IF EXISTS draft;
CREATE TABLE Public.draft (
		id_empresa int4  NOT NULL  , 
		id         serial NOT NULL ,
		linha      text   NOT NULL ,
		PRIMARY KEY(id_empresa,id) 
)
 GO 

SELECT * FROM PROJETOS WHERE ID = 112
/*

ALTER TABLE ESTRUTURAS ADD CONSTRAINT estruturas_pkey PRIMARY  KEY(id_empresa,conta,versao,subconta)

ALTER TABLE ATIVIDADES ADD COLUMN versao char(04)

ALTER TABLE ESTRUTURAS ADD COLUMN status int4 

/* TRUNCATE TABLES */
/*
TRUNCATE TABLE Public.tickets_fechamento RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.tickets_libera RESTART IDENTITY; 
GO 
TRUNCATE TABLE Public.tickets_movi RESTART IDENTITY; 
GO 
DROP TABLE IF EXISTS Public.tickets_fechamento ; 
GO 
DROP TABLE IF EXISTS Public.tickets_libera ; 
GO 
DROP TABLE IF EXISTS Public.tickets_movi ; 
GO
TRUNCATE TABLE Public.titulos_projeto RESTART IDENTITY; 
GO 
DROP TABLE IF EXISTS Public.titulos_projeto ; 
GO 

*/

