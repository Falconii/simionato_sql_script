SELECT REG.ID,REG.PASTA,REG.NOME,CLI.EMPRESA 
                                FROM REGISTROS REG 
                                INNER JOIN NFE_CAB         CAB ON CAB.ID = REG.ID_CAB
                                INNER JOIN PLAN_DEMANDA DEMA   ON DEMA.ID_PLANILHA = REG.ID 
                                INNER JOIN CLIENTES        CLI ON CLI.CNPJ_CPF = CAB.CNPJ 
                                WHERE DEMA.ID_DEMANDA = 1
                                ORDER BY REG.PASTA,REG.NOME 


select * from (
select id,nro_linha,(select count(*) from nfe_det_basicmsexc where id = cab.id) as total
from   nfe_cab cab
where  cab.sistema = 'SAP' or cab.sistema = 'SAP2' 
group by id ) as tabela
where tabela.total > 0


SELECT CAB.PLANILHA,CAB.DATA_CRIACAO,CAB.ID,CAB.SISTEMA
      ,COALESCE(REG.ID,0) as reg_id
      ,COALESCE(REG.pasta,'') as reg_pasta,REG.nome,REG.ID_CAB
FROM   NFE_CAB CAB
LEFT JOIN registros reg on reg.nome = cab.planilha 
ORDER BY CAB.ID


SELECT * FROM nfe_cab where planilha ='CPPE mês 01 Garanhus.XLSX'

go

select * from nfe_cab  where ( id =209 or id = 246  or id = 276)
go

SELECT DET.*,EXC.*
FROM NFE_DET DET
INNER JOIN nfe_det_basicmsexc EXC ON EXC.ID = DET.ID AND EXC.NRO_LINHA = DET.NRO_LINHA
WHERE DET.ID = 276 ORDER BY DET.NRO_LINHA


SELECT  
  CASE  
     WHEN status.dtimposto is null  
     THEN true   
     ELSE                             false  
     END AS OK,  
dema.id_planilha,cab.empresa as cod_empresa,cli.empresa as empresa,cab.sistema,cab.local,cab.cnpj,cab.sistema,cab.planilha,  stat.dtinicial as dtinicial, stat.dtfinal as dtfinal, null as ultimotempo, status.dtimposto  as dt_processado 
FROM demanda_planilha dema 
inner join nfe_cab cab on cab.id = dema.id_planilha 
inner join nfe_cab_status status on status.id = dema.id_planilha 
inner join clientes cli on cli.cnpj_cpf = cab.cnpj 
left  join estatistica  stat on stat.id_planilha = dema.id_planilha and stat.operacao = '' 
where dema.id_demanda = 1 order by id_planilha 

SELECT * FROM demandas WHERE dtencerra IS NULL ORDER BY ID

/*
INSERT INTO NFE_CAB_STATUS(id_demanda,id,dtbebida,dtimposto,dtselic,dtvenda,dtvendames)
 SELECT 1 AS ID_DEMANDA,CAB.ID AS ID,NULL,NULL,NULL,NULL,NULL
    FROM   NFE_CAB CAB
    LEFT JOIN registros reg on reg.nome = cab.planilha 
    WHERE  CAB.SISTEMA = 'SAP' OR CAB.SISTEMA = 'SAP2'
    AND REG.ID > 0
    ORDER BY CAB.ID
*/

SELECT ID,COUNT(*) FROM nfe_det_basicmsexc GROUP BY ID ORDER BY ID

 SELECT  CAB.planilha,DET.*,EXC.bas_icms_exc
            FROM DEMANDA_PLANILHA DEMA 
            INNER JOIN NFE_CAB CAB              ON CAB.ID = DEMA.ID_PLANILHA
            INNER JOIN NFE_DET DET              ON DET.ID = CAB.ID AND  (DET.DTNF >= '2008-01-01' AND DET.DTNF <= '2022-12-31')
            INNER JOIN CFOP_WORK    TRAB        ON TRAB.ID_DEMANDA = DEMA.ID_DEMANDA AND TRAB.CFOP = DET.CFOP
            INNER JOIN NFE_DET_BASICMSEXC EXC   ON EXC.ID = DET.ID AND EXC.NRO_LINHA = DET.NRO_LINHA  AND EXC.BAS_ICMS_EXC > 0
            WHERE DEMA.ID_DEMANDA = 1  AND CAB.ID = 10   ORDER BY DET.ID,DET.NRO_LINHA 

SELECT * FROM NFE_DET_BASICMSEXC WHERE ID = 37

SELECT ID,CNPJ,LENGTH(CNPJ) FROM NFE_CAB ORDER BY LENGTH(CNPJ) 
GO
SELECT CODIGO,CNPJ_CPF,RAZAO,LENGTH(CNPJ_CPF)  FROM CLIENTES ORDER BY LENGTH(CNPJ_CPF) 
GO


SELECT * FROM CLIENTES WHERE CNPJ_CPF = '08415791000122'
GO
SELECT * FROM CLIENTES  WHERE CNPJ_CPF = '08415791001013'
GO
SELECT * FROM CLIENTES  WHERE CNPJ_CPF = '08415791000718'
GO

SELECT * FROM NFE_CAB WHERE 
//
SELECT CAB.ID,STATUS.*
FROM NFE_CAB CAB
INNER JOIN nfe_cab_status STATUS  ON STATUS.ID = CAB.ID 
--INNER JOIN NFE_DET DET ON DET.ID = CAB.ID
--INNER JOIN nfe_det_basicmsexc EXC ON EXC.ID = DET.ID AND EXC.NRO_LINHA = DET.NRO_LINHA
WHERE CAB.CNPJ IN ('8415791000122','8415791001013','8415791000718') AND SISTEMA IN ('SAP','SAP2')
--GROUP BY DET.ID
1603   1              1603   (null)       20/01/2023 09:02:49  20/01/2023 09:02:49  (null)      (null)        
 1601   1              1601   (null)       20/01/2023 09:02:23  20/01/2023 09:02:23  (null)      (null)        
 1602   1              1602   (null)       20/01/2023 09:02:36  20/01/2023 09:02:36  (null)      (null)        
 1604   1              1604   (null)       20/01/2023 09:03:01  20/01/2023 09:03:01  (null)      (null)        
 1605  

