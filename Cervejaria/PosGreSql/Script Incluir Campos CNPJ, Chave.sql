
SELECT  TABSISTEMA,COUNT(*)
FROM 
(
SELECT DISTINCT CAB.ID AS TABID,
                CAB.planilha AS TABPLANILHA,
                CAB.sistema AS TABSISTEMA, 
                CAB.empresa AS TABEMPRESA
FROM nfe_valores_ipi VAL
INNER JOIN nfe_cab CAB ON CAB.ID = VAL.ID
WHERE VAL.vlr_ipi > 0 
ORDER BY CAB.ID
) AS TABELA
GROUP BY TABSISTEMA


SELECT  DISTINCT CAB.ID AS TABID,
                 CAB.planilha AS TABPLANILHA,
                 CAB.sistema AS TABSISTEMA, 
                 CAB.empresa AS TABEMPRESA
FROM nfe_valores_ipi VAL
INNER JOIN nfe_cab CAB ON CAB.ID = VAL.ID AND CAB.sistema IN ('SAP2','CIC')
WHERE VAL.vlr_ipi > 0 
ORDER BY CAB.ID

--DROP TABLE NFE_DET_BAK
--GO

//COPIA DA TABELA
--SELECT * INTO NFE_DET_BAK FROM NFE_DET
--GO
SELECT COUNT(*) FROM NFE_DET_BAK
GO
SELECT COUNT(*) FROM NFE_DET
GO
//433540