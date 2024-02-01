CREATE OR REPLACE FUNCTION public.seekVenda(in _id int4, in _empresa text, in _local text, in _dtnf date, in _nro text, in _serie text,in _material text,in _nr_item text, 
out __empresa text, out __local text, out __dtnf date, out __nro text, out __serie  text, out __nr_item  text, out __material text, out __descricao text, out __qtd numeric(15,4) , out __vlr_contabil numeric(15,4),   out __bas_ipi numeric(15,2) , out __per_ipi numeric(6,2), out __vlr_ipi numeric(15,2) ,  out  __ct int4)

AS
$$
DECLARE

 tempo public.nfe_det%ROWTYPE;

 contador int4;

 achou int4;

BEGIN
 contador := 0;
 achou    := 0;
 __ct     := 0;
  FOR tempo in  SELECT *  FROM public.nfe_det det 
      WHERE det.id = _id and
            det.empresa = _empresa and 
            det.local = _local and 
            det.dtnf = _dtnf and 
            det.nro = _nro and 
            det.serie = _serie and
            det.nr_item <> _nr_item and 
            ((DET.CFOP = '5100') OR 
            (DET.CFOP = '5101') OR 
            (DET.CFOP = '5102') OR 
            (DET.CFOP = '5103') OR 
            (DET.CFOP = '5104') OR 
            (DET.CFOP = '5105') OR 
            (DET.CFOP = '5106') OR 
            (DET.CFOP = '5109') OR 
            (DET.CFOP = '5110') OR 
            (DET.CFOP = '5111') OR 
            (DET.CFOP = '5112') OR 
            (DET.CFOP = '5113') OR 
            (DET.CFOP = '5114') OR 
            (DET.CFOP = '5115') OR 
            (DET.CFOP = '5116') OR 
            (DET.CFOP = '5117') OR 
            (DET.CFOP = '5118') OR 
            (DET.CFOP = '5119') OR 
            (DET.CFOP = '5120') OR 
            (DET.CFOP = '5122') OR 
            (DET.CFOP = '5123') OR 
            (DET.CFOP = '5250') OR 
            (DET.CFOP = '5251') OR 
            (DET.CFOP = '5252') OR 
            (DET.CFOP = '5253') OR 
            (DET.CFOP = '5254') OR 
            (DET.CFOP = '5255') OR 
            (DET.CFOP = '5256') OR 
            (DET.CFOP = '5257') OR 
            (DET.CFOP = '5258') OR 
            (DET.CFOP = '5401') OR 
            (DET.CFOP = '5402') OR 
            (DET.CFOP = '5403') OR 
            (DET.CFOP = '5405') OR 
            (DET.CFOP = '5551') OR 
            (DET.CFOP = '5651') OR 
            (DET.CFOP = '5652') OR 
            (DET.CFOP = '5653') OR 
            (DET.CFOP = '5654') OR 
            (DET.CFOP = '5655') OR 
            (DET.CFOP = '5656') OR 
            (DET.CFOP = '6100') OR 
            (DET.CFOP = '6101') OR 
            (DET.CFOP = '6102') OR 
            (DET.CFOP = '6103') OR 
            (DET.CFOP = '6104') OR 
            (DET.CFOP = '6105') OR 
            (DET.CFOP = '6106') OR 
            (DET.CFOP = '6107') OR 
            (DET.CFOP = '6108') OR 
            (DET.CFOP = '6109') OR 
            (DET.CFOP = '6110') OR 
            (DET.CFOP = '6111') OR 
            (DET.CFOP = '6112') OR 
            (DET.CFOP = '6113') OR 
            (DET.CFOP = '6114') OR 
            (DET.CFOP = '6115') OR 
            (DET.CFOP = '6116') OR 
            (DET.CFOP = '6117') OR 
            (DET.CFOP = '6118') OR 
            (DET.CFOP = '6119') OR 
            (DET.CFOP = '6120') OR 
            (DET.CFOP = '6122') OR 
            (DET.CFOP = '6123') OR 
            (DET.CFOP = '6250') OR 
            (DET.CFOP = '6251') OR 
            (DET.CFOP = '6252') OR 
            (DET.CFOP = '6253') OR 
            (DET.CFOP = '6254') OR 
            (DET.CFOP = '6255') OR 
            (DET.CFOP = '6256') OR 
            (DET.CFOP = '6257') OR 
            (DET.CFOP = '6258') OR 
            (DET.CFOP = '6401') OR 
            (DET.CFOP = '6402') OR 
            (DET.CFOP = '6403') OR 
            (DET.CFOP = '6404') OR 
            (DET.CFOP = '6551') OR 
            (DET.CFOP = '6651') OR 
            (DET.CFOP = '6652') OR 
            (DET.CFOP = '6653') OR 
            (DET.CFOP = '6654') OR 
            (DET.CFOP = '6655') OR 
            (DET.CFOP = '6656') OR 
            (DET.CFOP = '7100') OR 
            (DET.CFOP = '7101') OR 
            (DET.CFOP = '7102') OR 
            (DET.CFOP = '7105') OR 
            (DET.CFOP = '7106') OR 
            (DET.CFOP = '7127') OR 
            (DET.CFOP = '7250') OR 
            (DET.CFOP = '7251') OR 
            (DET.CFOP = '7551') OR 
            (DET.CFOP = '7651') OR 
            (DET.CFOP = '7654'))
      LOOP      
        __empresa := tempo.empresa;
        __local := tempo.local;
        __dtnf  := tempo.dtnf;
        __nro   := tempo.nro;
        __serie := tempo.serie;
        if (tempo.material = _material) then
            __nr_item := tempo.nr_item;
            __material := tempo.material;
            __descricao := tempo.descricao; 
            __qtd       := tempo.qtd;
            __vlr_contabil := tempo.vlr_contabil;
            __bas_ipi      := tempo.bas_ipi;
            __per_ipi      := tempo.per_ipi;
            __vlr_ipi      := tempo.vlr_ipi;
            __ct        :=  1;
            contador    :=  1;
            achou       :=  1;
        else 
            if (achou = 0) then 
                contador    := contador + 1;
            end if;
        end if;
        --RAISE NOTICE '-----------------------------------------------------';
        --RAISE NOTICE 'Empresa % Local % Data % Nota % Serie % Produto % Descrição % Unid % CFOP % Contador %', tempo.empresa,tempo.local,tempo.dtnf,tempo.nro,tempo.serie,tempo.material,tempo.descricao,tempo.unid,tempo.cfop, contador;
      END LOOP;
      IF (contador = 0) THEN
         __empresa := _empresa ;
         __local := _local;
         __dtnf  := _dtnf;
         __nro   := _nro;
         __serie := _serie;
         __nr_item := ' ';
         __material := ' ';
         __descricao := 'SEM VENDA NESTA NOTA'; 
         __qtd       := 0;
         __ct        := contador;
        __vlr_contabil := 0;
        __bas_ipi      := 0;
        __per_ipi      := 0;
        __vlr_ipi      := 0;

      END IF;
      IF ((contador > 1) OR  (contador = 1 AND  achou = 0)) THEN
         __nr_item := ' ';
         __material := ' ';
         __descricao := 'PRODUTO BONIFICADO EM VARIOS ITENS'; 
         __qtd       := 0;
         __ct        := contador;
        __vlr_contabil := 0;
        __bas_ipi      := 0;
        __per_ipi      := 0;
        __vlr_ipi      := 0;

      END IF;
END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM seekVenda(299,'1001','407','04/05/2015','000089227','001','1010939','11384');
GO


SELECT * FROM seekVenda('1001','407','04/05/2015','000089231','001','1073797','42992');
GO

SELECT DET.*, (SELECT __DESCRICAO FROM seekVenda(DET.ID,DET.EMPRESA,DET.LOCAL,DET.DTNF,DET.NRO,DET.SERIE,DET.MATERIAL,DET.NR_ITEM)) PRODUTO_VENDA, COMP.*
FROM       NFE_DET DET
INNER JOIN NFE_VALORES_IPI IPI     ON IPI.ID = DET.ID AND IPI.NRO_LINHA = DET.NRO_LINHA  AND IPI.VLR_IPI > 0
INNER JOIN nfe_det_comp    COMP    ON COMP.ID = DET.ID AND COMP.NRO_LINHA = DET.NRO_LINHA
WHERE  DET.ID = 22;  
go



SELECT DET.CFOP,DET.VLR_IPI,DET.DESCRICAO,COMP.ID,COMP.BEBIDA
FROM       NFE_DET DET
INNER JOIN NFE_VALORES_IPI IPI     ON IPI.ID = DET.ID AND IPI.NRO_LINHA = DET.NRO_LINHA  AND IPI.VLR_IPI > 0
INNER JOIN nfe_det_comp    COMP    ON COMP.ID = DET.ID AND COMP.NRO_LINHA = DET.NRO_LINHA
WHERE (DET.CFOP = '5910' OR DET.CFOP = '6910') AND DET.ID = 299;  
go

SELECT DISTINCT  DET.ID,DET.NRO_LINHA,DET.MATERIAL,DET.DESCRICAO 
--COMP.* , DET.CFOP ,  DET.DESCRICAO , IPI.DTNFE
FROM NFE_DET_COMP COMP
INNER JOIN NFE_VALORES_IPI IPI  ON IPI.ID = COMP.ID AND IPI.NRO_LINHA = COMP.NRO_LINHA AND IPI.VLR_IPI > 0
INNER JOIN NFE_DET DET ON DET.ID = COMP.ID AND DET.NRO_LINHA = COMP.NRO_LINHA 
WHERE BEBIDA IS NULL

SELECT * FROM nfe_det_comp WHERE ID = 116 AND NRO_LINHA = '353669'
GO
SELECT * FROM nfe_det      WHERE ID = 116 AND NRO_LINHA = '353669'
GO
SELECT * FROM NFE_VALORES_IPI      WHERE ID = 166 AND NRO_LINHA = '353669'
GO

UPDATE NFE_DET_COMP SET BEBIDA = 'S' WHERE ID = 116 AND NRO_LINHA = '353669';
GO
UPDATE NFE_DET_COMP SET BEBIDA = 'S' WHERE ID = 299 AND NRO_LINHA = '3481';
GO
UPDATE NFE_DET_COMP SET BEBIDA = 'S' WHERE ID = 322 AND NRO_LINHA = '190426';
GO
UPDATE NFE_DET_COMP SET BEBIDA = 'S' WHERE ID = 797 AND NRO_LINHA = '268383';
GO
UPDATE NFE_DET_COMP SET BEBIDA = 'S' WHERE ID = 800 AND NRO_LINHA = '73452';
GO
UPDATE NFE_DET_COMP SET BEBIDA = 'S' WHERE ID = 913 AND NRO_LINHA = '215304';
GO
UPDATE NFE_DET_COMP SET BEBIDA = 'S' WHERE ID = 991 AND NRO_LINHA = '67878';
GO
UPDATE NFE_DET_COMP SET BEBIDA = 'S' WHERE ID = 991 AND NRO_LINHA = '67880';
GO
UPDATE NFE_DET_COMP SET BEBIDA = 'S' WHERE ID = 991 AND NRO_LINHA = '67884';
GO


SELECT * FROM NFE_DET WHERE ID = 116 AND NRO_LINHA = '353669'
go
SELECT * FROM NFE_VALORES_IPI WHERE ID = 116 AND NRO_LINHA = '353669'
go
SELECT * FROM NFE_DET_COMP WHERE ID = 116 AND NRO_LINHA = '353669'
go

116	353669	CERV PETRA AUR GRF 500ML  KIT C/2 1TC
385	305097	CERV PETRA AUR GRF 500ML  KIT C/2 1TC
797	268383	CERV PETRA AUR GRF 500ML  KIT C/2 1TC
800	73452	CERV PETRA AUR GRF 500ML  KIT C/2 1TC
913	215304	CERV PETRA AUR GRF 500ML  KIT C/2 1TC
991	67878	CERV PETRA AUR GRF 500ML  KIT C/2 1TC
991	67880	CERV PETRA AUR GRF 500ML  KIT C/2 1TC
991	67884	CERV PETRA AUR GRF 500ML  KIT C/2 1TC