CREATE OR REPLACE FUNCTION "public"."grava_acu_ipi_dema"(in _id_demanda int4, out _saida text ) 
RETURNS text
AS
$$
DECLARE
Hoje Date;

BEGIN
  
  _saida = 'OK';

  Hoje = NOW();

  DELETE FROM acumulado_cnpj_data_ipi_dema WHERE id_demanda = _id_demanda;

  INSERT INTO 
      acumulado_cnpj_data_ipi_dema(
        id_demanda,
        cnpj, 
        ano, 
        mes, 
        sistema,
        produto,
        origem,
        classificacao, 
        vlr_ipi, 
        vlr_ipi_corrigido
     )
        SELECT 
             ipi.id_demanda                 AS   ID_DEMANDA
            ,CAB.CNPJ                       AS   CNPJ  
            ,to_char(ipi.dtnfe, 'YYYY')     AS   ANO        
            ,to_char(ipi.dtnfe, 'MM')       AS   MES  
            ,CAB.SISTEMA                    AS   SISTEMA
            ,CASE 
                 WHEN VE.MATERIAL  = DET.MATERIAL              THEN 'MESMO PRODUTO'
                 WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'     THEN 'SEM VENDA'
                 ELSE                                              'OUTRO PRODUTO' 
             END AS produto
            ,cfop.descricao  as origem
            ,CASE 
                 WHEN SUBSTR(VE.DESCRICAO,1,1) = '*'        THEN 'VENDA EM OUTRA NOTA' 
                 WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'  THEN 'NAO ENCONTRADO VENDA' 
                 ELSE                                            'VENDA NA NOTA' 
             END AS classificacao
            ,SUM(ipi.vlr_ipi)               AS   VLR_IPI
            ,SUM(ipi.vlr_ipi_corrigido)     AS   VLR_IPI_CORRIGIDO
        FROM   nfe_valores_ipi_dema ipi
        INNER  JOIN nfe_cab      cab               ON cab.id = ipi.id
        INNER  JOIN nfe_det det                    ON det.id = ipi.id   AND det.nro_linha = ipi.nro_linha 
        INNER  JOIN nfe_det_nota_ve_dema ve        ON ve.id_demanda = _id_demanda and ve.id = det.id   AND ve.nro_linha = det.nro_linha 
        INNER  JOIN nfe_det_cfop cfop              ON cfop.id = det.id  AND cfop.nro_linha = det.nro_linha
        WHERE  ipi.id_demanda = _id_demanda 
        GROUP BY 
             ipi.id_demanda                 
            ,CAB.CNPJ                         
            ,to_char(ipi.dtnfe, 'YYYY')             
            ,to_char(ipi.dtnfe, 'MM')         
            ,CAB.SISTEMA          
            ,CASE 
                 WHEN VE.MATERIAL  = DET.MATERIAL              THEN 'MESMO PRODUTO'
                 WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'     THEN 'SEM VENDA'
                 ELSE                                              'OUTRO PRODUTO' 
             END 
           ,cfop.descricao
           ,CASE 
                 WHEN SUBSTR(VE.DESCRICAO,1,1) = '*'        THEN 'VENDA EM OUTRA NOTA' 
                 WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'  THEN 'NAO ENCONTRADO VENDA' 
                 ELSE                                            'VENDA NA NOTA' 
            END;
       
            UPDATE demandas SET dtacumulado = Hoje where id = _id_demanda;

END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM grava_acu_ipi_dema(1);
go

SELECT * FROM DEMANDAS
go