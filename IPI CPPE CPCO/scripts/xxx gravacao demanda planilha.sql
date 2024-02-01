SELECT DISTINCT CLI.EMPRESA,CAB.ID 
FROM   NFE_CAB CAB
INNER  JOIN CLIENTES CLI ON CLI.cnpj_cpf = CAB.CNPJ
INNER  JOIN NFE_DET  DET ON DET.ID = CAB.ID AND DET.CFOP IN ('5910','6910') AND (DET.DTNF >= '2019-01-01' AND DET.DTNF <= '2019-12-31') 
WHERE  CLI.EMPRESA = 'CPSA'
ORDER  BY CLI.EMPRESA,CAB.ID

INSERT INTO DEMANDA_PLANILHA(ID_DEMANDA, ID_PLANILHA,ID_EMPRESA)
SELECT DISTINCT 2 AS ID_DEMANDA, CAB.ID AS ID_PLANILHA, CAB.EMPRESA AS ID_EMPRESA   FROM NFE_CAB CAB INNER  JOIN CLIENTES CLI ON CLI.cnpj_cpf = CAB.CNPJ INNER JOIN NFE_DET DET ON DET.ID = CAB.ID AND (( det.cfop = '5910')  OR ( det.cfop = '6910') ) AND ( DET.DTNF >= '2019-01-01' AND DET.DTNF <= '2019-12-31' ) WHERE (( cli.empresa = 'CPCO' ) OR ( cli.empresa = 'CPSA' ))   

DELETE FROM  DEMANDA_PLANILHA  WHERE ID_DEMANDA = 2 
GO
INSERT INTO DEMANDA_PLANILHA(ID_DEMANDA, ID_PLANILHA,ID_EMPRESA) SELECT DISTINCT 2 AS ID_DEMANDA, CAB.ID AS ID_PLANILHA, CAB.EMPRESA AS ID_EMPRESA   FROM NFE_CAB CAB INNER  JOIN CLIENTES CLI ON CLI.cnpj_cpf = CAB.CNPJ INNER JOIN NFE_DET DET ON DET.ID = CAB.ID AND (( det.cfop = '5910')  OR ( det.cfop = '6910') ) AND ( DET.DTNF >= '2019-06-01' AND DET.DTNF <= '2019-06-30' ) WHERE (( cli.empresa = 'CPCO' ) OR ( cli.empresa = 'CPSA' )) 
GO
SELECT * FROM  DEMANDA_PLANILHA
SELECT * FROM DEMANDAS