DROP TABLE IF EXISTS Public.CLIENTES;
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

DROP TABLE IF EXISTS INVENTARIOS;
CREATE TABLE Public.INVENTARIOS (
    id_empresa    int4 NOT NULL,
	id			  serial,
	id_cliente	  int4 NOT NULL,
	id_resp  	  int4 NOT NULL,
	datainicial   Date NULL,
	datafinal 	  Date NULL,
	dataenc		  Date NULL,
	descricao	  VARCHAR(50)  NOT NULL,
    laudo         varchar(200) NULL,
    user_insert   int4 NULL,
    user_update   int4 NULL,
    status        char(1) NOT NULL,
    PRIMARY KEY(id_empresa,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS LOCAIS_INVENT;
CREATE TABLE Public.LOCAIS_INVENT (
    id_empresa    int4 NOT NULL,
	id			  serial,
	id_cliente	  int4 NOT NULL,
    user_insert   int4 NULL,
    user_update   int4 NULL,
    status        char(1) NOT NULL,
    PRIMARY KEY(id_empresa,id,id_cliente)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS USERS_INVENT;
CREATE TABLE Public.USERS_INVENT (
	id_empresa      int4         NOT NULL,
	id_invent       int4         NOT NULL,
    id_user         int4         NOT NULL,
    user_insert     int4         NULL,
    user_update     int4         NULL,
    PRIMARY KEY(id_empresa,id_invent,id_user)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS PRODUTOS;
CREATE TABLE Public.PRODUTOS (
	id_empresa      int4            NOT NULL,
	Id_inventario   INT4            NOT NULL,
    codigo          varchar(15)     NOT NULL,
    descricao       varchar(100)    NOT NULL,  
    unid            varchar(05)     NOT NULL,
    partnumber      varchar(10)     NOT NULL,
    tipo            varchar(05)     NOT NULL,
    dun             varchar(13)     NOT NULL,
    dun14           varchar(14)     NOT NULL,
    user_insert     int4            NULL,
    user_update     int4            NULL,
    PRIMARY KEY(id_empresa,Id_inventario,codigo)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO



DROP TABLE IF EXISTS SALDOS;
CREATE TABLE Public.SALDOS (
	id_empresa      int4            NOT NULL,
	Id_inventario   INT4            NOT NULL,
    codigo          varchar(15)     NOT NULL,
    local           varchar(15)     NOT NULL,
    lote            varchar(5)      NOT NULL,
    unid            varchar(5)      NOT NULL,
    saldo           numeric(15,4)   NOT NULL,
    vlr_medio       numeric(15,4)   NOT NULL,
    inventario      varchar(1)      NOT NULL default 'N',
    invent_st       char(1)         NULL DEFAULT 'S',
    contagem        int4            NOT NULL default 0,
    qtd_cont        numeric(15,4)   NOT NULL,
    ajuste          numeric(15,4)   NOT NULL,
    encerramento_ct varchar(1)      NULL DEFAULT '0',
    id_user_enc     int4            NULL,
    user_insert     int4            NULL,
    user_update     int4            NULL,
    PRIMARY KEY(id_empresa,Id_inventario,codigo,local,lote)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO
/*

 inventario  Nro do inventário
 invent_st   Sim  ou Não 

 encerramento_ct ->  0 Não Definida 
                     1 Definitiva
                     2 Não Dedinitiva

*/

DROP TABLE IF EXISTS PALLETS;
CREATE TABLE Public.PALLETS (
	id_empresa      int4            NOT NULL,
	id_inventario   int4            NOT NULL,
    id              serial          NOT NULL,
    codigo          varchar(15)     NOT NULL,
    local           varchar(15)     NOT NULL,
    lote            varchar(5)      NOT NULL,
    unid            varchar(5)      NOT NULL,
    qtd_pallet      numeric(15,4)   NOT NULL,
    qtd             numeric(15,4)   NOT NULL,
    vlr_medio       numeric(15,4)   NOT NULL,
    inventario      varchar(1)      NOT NULL,
    contagem        int4            NOT NULL,
    status          char(1)         NULL default '0', 
    id_user_enc     int4            NULL,
    user_insert     int4            NULL,
    user_update     int4            NULL,
    PRIMARY KEY(id_empresa,Id_inventario,codigo,local,lote)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


DROP TABLE IF EXISTS CONTAGEMS;
CREATE TABLE Public.CONTAGEMS (
	id_empresa      int4            NOT NULL,
	id_inventario   INT4            NOT NULL,
    id              serial          NOT NULL,
    produto         varchar(15)     NOT NULL,
    local           varchar(15)     NOT NULL,
    lote            varchar(5)      NOT NULL,
    contagem        int4            NOT NULL,
    unid            varchar(5)      NOT NULL,
    qtd             numeric(15,4)   NOT NULL,
    ajuste          numeric(15,4)   NOT NULL,
    id_user         int4            NOT NULL,
    status          char(1)         NULL      default '0', 
    encerrado_ct    char(1)         NOT NULL  default '0',
    id_user_enc     int4            NULL,
    user_insert     int4            NULL,
    user_update     int4            NULL,
    PRIMARY KEY(id_empresa,Id_inventario,produto,local,lote,contagem)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

/*
  status -> 0 Não contado
            1 Contado
  encerrado ->  0 Não Definida
                1 Definitiva
                2 Não Dedinitiva
*/


DROP TABLE IF EXISTS LAUDOS_CONTAGEM;
CREATE TABLE Public.LAUDOS_CONTAGEM (
	id_empresa      int4            NOT NULL,
	id_inventario   int4            NOT NULL,
    id_contagem     int4            NOT NULL,
    id              serial          NOT NULL,
    descricao       varchar(200)    NOT NULL,
    id_user         int4            NOT NULL, 
    user_insert     int4            NULL,
    user_update     int4            NULL,
    PRIMARY KEY(id_empresa,id_inventario,id_contagem,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO



