CREATE OR REPLACE FUNCTION "public"."grava_acu_icms_dema"(in _id_demanda int4, out _saida text ) 
RETURNS text
AS
$$
DECLARE
Hoje Date;

BEGIN
  
  _saida = 'OK';

  Hoje = NOW();

  DELETE FROM acumulado_cnpj_data_icms_dema WHERE id_demanda = _id_demanda;

  INSERT INTO 
          acumulado_cnpj_data_icms_dema(
          id_demanda	            ,
          cnpj                   	,
          ano                   	,
          mes                   	,
          qtd                    	,
          vlr_contabil           	,
          bas_icms_exc              ,
          bas_icms               	,
          vlr_icms               	,
          bas_pis                	,
          vlr_pis                	,
          bas_cof                	,
          vlr_cof                	,
          bas_ipi                	,
          vlr_ipi                	,
          bas_icms_st            	,
          vlr_icms_st            	,	
          vlr_economico_pis           , 
          vlr_economico_pis_corrigido ,
	      vlr_economico_cof           , 
	      vlr_economico_cof_corrigido    
        )
        SELECT 
             val.id_demanda                  AS   ID_DEMANDA
            ,CAB.CNPJ                        AS   CNPJ  
            ,to_char(val.dtnfe, 'YYYY')      AS   ANO        
            ,to_char(val.dtnfe, 'MM')        AS   MES
            ,SUM(det.qtd) AS QTD                    	
            ,SUM(det.vlr_contabil)                           AS vlr_contabil         	
            ,SUM(exc.bas_icms_exc)                           AS bas_icms_exc         
            ,SUM(det.bas_icms)               				 AS bas_icms               	
            ,SUM(det.vlr_icms)               	             AS vlr_icms               	
            ,SUM(det.bas_pis)                	             AS bas_pis                	
            ,SUM(det.vlr_pis)                	             AS vlr_pis                	
            ,SUM(det.bas_cof)                	             AS bas_cof                	
            ,SUM(det.vlr_cof)                	             AS vlr_cof                	
            ,SUM(det.bas_ipi)                	             AS bas_ipi                	
            ,SUM(det.vlr_ipi)                	             AS vlr_ipi                	
            ,SUM(det.bas_icms_st)            	             AS bas_icms_st            	
            ,SUM(det.vlr_icms_st)            	             AS vlr_icms_st            	
            ,SUM(val.vlr_economico_pis)                      AS vlr_economico_pis           
            ,SUM(val.vlr_economico_pis_corrigido)            AS vlr_economico_pis_corrigido 
	        ,SUM(val.vlr_economico_cofins)                   AS vlr_economico_cofins           
	        ,SUM(val.vlr_economico_cofins_corrigido)         AS vlr_economico_cofins_corrigido 
        FROM   nfe_valores_icms_dema val
        INNER  JOIN nfe_cab            cab      ON cab.id = val.id   
        INNER  JOIN nfe_det            det      ON det.id = val.id    AND det.nro_linha = val.nro_linha
        INNER  JOIN nfe_det_basicmsexc exc      ON exc.id = det.id    AND exc.nro_linha = det.nro_linha
        WHERE  val.id_demanda = _id_demanda
        GROUP BY 
             val.id_demanda   
            ,CAB.CNPJ                 
            ,to_char(val.dtnfe, 'YYYY') 
            ,to_char(val.dtnfe, 'MM') ;
    
        UPDATE demandas SET dtacumulado = Hoje where id = _id_demanda;

END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM grava_acu_icms_dema(1);
go


