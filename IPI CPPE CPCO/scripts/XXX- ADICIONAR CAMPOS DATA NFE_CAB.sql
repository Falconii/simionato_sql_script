ALTER TABLE NFE_CAB 
ADD COLUMN dtbebida  date,
ADD COLUMN dtimposto date,
ADD COLUMN dtselic   date,
ADD COLUMN dtvenda    date,
ADD COLUMN dtvendames date
go

SELECT * FROM public.produto_bebida 

SELECT * FROM nfe_det_comp where id = 531

TRUNCATE produto_bebida
GO

CREATE TABLE public.produto_bebida  ( 
	cnpj     	char(14) NOT NULL,
	sistema  	char(5) NOT NULL,
	material 	char(15) NOT NULL,
	descricao	varchar(100) NOT NULL,
	ncm      	char(15) NOT NULL,
	bebida   	char(1) NOT NULL,
	PRIMARY KEY(cnpj,sistema,material,descricao,ncm,bebida)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

TRUNCATE PRODUTO_BEBIDA

INSERT INTO PRODUTO_BEBIDA(CNPJ,SISTEMA,MATERIAL,DESCRICAO,NCM,BEBIDA)
        SELECT DISTINCT CAB.CNPJ,CAB.SISTEMA,DET.MATERIAL,DET.DESCRICAO,DET.NCM,COMP.BEBIDA
        FROM   NFE_DET DET
        INNER  JOIN NFE_CAB CAB ON CAB.ID = DET.ID
        INNER  JOIN nfe_det_comp COMP ON COMP.ID = DET.ID AND COMP.nro_linha = DET.NRO_LINHA
        WHERE DET.ID = 531 AND COMP.BEBIDA IS NOT NULL
        ORDER BY CAB.CNPJ,CAB.SISTEMA,DET.MATERIAL,DET.DESCRICAO,DET.NCM

 SELECT * FROM   Produto_Bebida  WHERE cnpj  = '73410326005049'  and  sistema   = 'CIC  ' and   material  = '1010912        ' and   descricao = 'CERVEJA ITAIPAVA MALZBIER LONG NECK 355 ML PCT 12' and   ncm       = '22030000       '