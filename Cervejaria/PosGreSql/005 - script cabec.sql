CREATE TABLE public.MoviCab  ( 
    id                      serial NOT NULL,
	path                	varchar(200) NOT NULL,
    arquivo                 varchar(200) NOT NULL,
	empresa                	char(6) NOT NULL,
	vlr_debito           	numeric(15,2) NULL,
	vlr_credito            	numeric(15,2) NULL,
    nro_linha               int4          NULL,
	usuarioinclusao        	int4 NULL,
	usuarioatualizacao     	int4 NULL,
    data_criacao            TIMESTAMP  NULL,
    data_fechamento         TIMESTAMP  null,
    status                  int NULL,
	PRIMARY KEY(id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

CREATE UNIQUE INDEX id_movicab _arquivo
	ON public.movicab USING btree (arquivo text_ops)
GO

SELECT    ID, PATH, ARQUIVO, EMPRESA, VLR_DEBITO, VLR_CREDITO, NRO_LINHA, USUARIOINCLUSAO, USUARIOATUALIZACAO, DATA_CRIACAO, DATA_FECHAMENTO, STATUS  FROM MOVICAB   ORDER BY ID 