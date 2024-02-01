/*

Planilha Rondonópolis Fábrica A-XLSX, foi alterada para a plnilha

1161   Rondonópolis Fábrica A.xlsx  

//UPDATE nfe_cab set planilha = 'CO01 - 042017.xlsx' where id = 1161

*/

SELECT * FROM NFE_CAB WHERE ID = 1161

SELECT * FROM nfe_det_basicmsexc where id = 1161

SELECT * FROM nfe_valores_icms_dema where id = 1161

  SELECT  CAB.planilha,cab.cnpj,DET.*,EXC.bas_icms_exc
            FROM DEMANDA_PLANILHA DEMA 
            INNER JOIN NFE_CAB CAB              ON CAB.ID = DEMA.ID_PLANILHA
            INNER JOIN NFE_DET DET              ON DET.ID = CAB.ID  AND (DET.PER_ICMS > 0) AND (DET.PER_PIS > 0 OR DET.PER_COF > 0) AND (DET.VLR_PIS > 0 OR DET.VLR_COF > 0)
            INNER JOIN CFOP_WORK    TRAB        ON TRAB.ID_DEMANDA = DEMA.ID_DEMANDA AND TRAB.CFOP = DET.CFOP
            INNER JOIN NFE_DET_BASICMSEXC EXC   ON EXC.ID = DET.ID AND EXC.NRO_LINHA = DET.NRO_LINHA  AND EXC.BAS_ICMS_EXC > 0
            WHERE DEMA.ID_DEMANDA = 1  AND CAB.ID = 1161   ORDER BY DET.ID,DET.NRO_LINHA 


select * from acumulado_cnpj_data_icms_dema where cnpj ='08415791000122' order by ano,mes

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





