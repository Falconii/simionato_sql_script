DROP TABLE IF EXISTS header;
go

CREATE TABLE public.header  ( 
	id           	serial NOT NULL,
	arquivo      	varchar(100) NOT NULL,
    dtgravacao      Date NOT NULL,
    hrgravacao      char(8) NOT NULL,
    seqgravacao     int4    NOT NULL,
    resbanco        varchar(20) NOT NULL,
	nro_linha    	int4 NOT NULL,
	banco        	varchar(3) NULL,
	lote         	varchar(4) NULL,
	tipo         	varchar(1) NULL,
	operacao     	varchar(1) NULL,
	servico      	varchar(2) NULL,
	formalan     	varchar(2) NULL,
	layout       	varchar(3) NULL,
	usobanco     	varchar(1) NULL,
	tipoinscricao	varchar(1) NULL,
	cnpj         	varchar(14) NULL,
	convenio     	varchar(20) NULL,
	agencia      	varchar(5) NULL,
	dvagencia    	varchar(1) NULL,
	contacorrente	varchar(12) NULL,
	dvconta      	varchar(1) NULL,
	dvageconta   	varchar(1) NULL,
	razaoempresa 	varchar(30) NULL,
	mensagem     	varchar(40) NULL,
	endereco     	varchar(30) NULL,
	numero       	varchar(5) NULL,
	complemento  	varchar(15) NULL,
	cidade       	varchar(20) NULL,
	cep          	varchar(5) NULL,
	cepcom       	varchar(3) NULL,
	estado       	varchar(2) NULL,
	cnab         	varchar(8) NULL,
	ocorrencias  	varchar(10) NULL,
	PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE IF EXISTS segmentoa;
go

CREATE TABLE Public.segmentoa (
	    id       		                  serial NOT NULL,
        id_header                         int4   NOT NULL,
        nro_linha                         int4   NOT NULL,
        banco 				              varchar( 3) NULL,
        lote 				              varchar( 4) NULL,
        tipo           		              varchar( 1) NULL,
        seqlote 			              varchar( 5) NULL,
        segmento 			              varchar( 1) NULL,
        movimento 			              varchar( 1) NULL,
        instrucao 			              varchar( 2) NULL,
        centralizadora 		              varchar( 3) NULL,
        bancofavorecido 	              varchar( 3) NULL,
        agenciafavorecido 	              varchar( 5) NULL,
        dvagenciafavorecido	              varchar( 1) NULL,
        contafavorecido 	              varchar(12) NULL,
        dvcontafavorecido 	              varchar( 1) NULL,
        dvagconta 			              varchar( 1) NULL,
        nomefavorecido 		          varchar(30) NULL,
        seunumero 			              varchar(20) NULL,
        datapagamento 		              Date	 NULL,
        moeda 				              varchar( 3) NULL,
        qtdmoeda 			              Numeric(10,5) NULL,
        valorpagamento 		              Numeric(13,2) NULL,
        nossonumero 		              varchar(20) NULL,
        datareal 			              Date NULL,
        valorreal 			              Numeric(13,2) NULL,
        outras                            varchar(40),
        codservico                        char( 2),
        codsed                            char( 5),
        codsupl                           char( 2),
        usobanco                          char( 3),
        aviso                             char( 1),
        ocorrretorno                     varchar( 10),
    PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


DROP TABLE IF EXISTS segmentob;
go

CREATE TABLE Public.segmentob (
	    id       		                  serial NOT NULL,
        id_header                         int4   NOT NULL,
        nro_linha                         int4   NOT NULL,
        banco 				             varchar( 3) NULL,
        lote 					         varchar( 4) NULL,
        tipo 					         varchar( 1) NULL,
        seqlote 				         varchar( 5) NULL,
        segmento 				         varchar( 1) NULL,
        cnabexclu1 			             varchar( 3) NULL,
        tipoinscricao 		             varchar( 1) NULL,
        inscricao 			             varchar(14) NULL,
        endereco 				         varchar(30) NULL,
        nro 					         varchar( 5) NULL,
        complemento 			         varchar(15) NULL,
        bairro 				             varchar(15) NULL,
        cidade 				             varchar(20) NULL,
        cep 					         varchar( 5) NULL,
        cepcom 				             varchar( 3) NULL,
        estado 				             varchar( 2) NULL,
        vencimento 			             Date NULL,
        valor 				             numeric(13,2) NULL,
        abatimento 			             numeric(13,2) NULL,
        desconto 				         numeric(13,2) NULL,
        mora 					         numeric(13,2) NULL,
        multa 				             numeric(13,2) NULL,
        documentofavorecido              varchar(15),
        aviso                            varchar( 1),
        codug                            varchar( 6),
        cnabexclu2                       varchar( 8),
    PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO
