DROP TABLE IF EXISTS nfe_det_cfop
GO
CREATE TABLE public.nfe_det_cfop  ( 
	id       	int4 NOT NULL,
	nro_linha	int4 NOT NULL,
    cfop        char(4) NOT NULL,
    descricao   varchar(60) NOT NULL, 
	tag      	char(2) NOT NULL,
	PRIMARY KEY(id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO



INSERT INTO public.nfe_det_cfop(id, nro_linha, cfop, descricao, tag) 
	VALUES(0, 0, '', '', '')
GO


SELECT count(*) AS TOTAL FROM NFE_DET_E DET  where  ( DET.DTNF >= '2020-01-01' AND  DET.DTNF <= '2020-12-31')  and  DET.OPERACAO = 'V'  and  DET.STATUS = '0'
