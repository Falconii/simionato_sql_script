CREATE OR REPLACE FUNCTION "public"."savebebidacomp" (in _id_planilha int4 , out _saida text) 
RETURNS text 
AS
$$
DECLARE
BEGIN
    _saida := 'OK';

    UPDATE nfe_det_comp COMP SET(BEBIDA) =
    ( SELECT  bebida.BEBIDA 
       FROM produto_bebida bebida 
       INNER JOIN nfe_det DET ON DET.ID = COMP.ID AND DET.NRO_LINHA = COMP.NRO_LINHA
       INNER JOIN NFE_CAB CAB ON CAB.ID = DET.ID 
       WHERE BEBIDA.CNPJ = CAB.CNPJ AND  BEBIDA.SISTEMA = CAB.SISTEMA AND BEBIDA.MATERIAL = DET.MATERIAL AND BEBIDA.DESCRICAO = DET.DESCRICAO AND BEBIDA.NCM = DET.NCM)
    WHERE ID = _id_planilha;

    UPDATE NFE_CAB_STATUS SET DTBEBIDA = NOW() WHERE ID = _id_planilha;
 
END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM savebebidacomp(2);

SELECT * FROM nfe_cab_status 