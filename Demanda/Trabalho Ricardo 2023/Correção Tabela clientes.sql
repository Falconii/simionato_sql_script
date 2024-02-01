
SELECT cli.cnpj_cpf,cli.codigo,cli.razao,lo.cod_protheus,lo.cod_protheus,lo.cod_sic,lo.cod_sap
FROM public.clientes cli
INNER JOIN locais lo on lo.id_cliente = cli.codigo
WHERE LENGTH(CNPJ_CPF) = 14 
ORDER BY cnpj_cpf
GO

SELECT * FROM CLIENTES WHERE LENGTH(CNPJ_CPF) < 14 


SELECT CAB.ID AS "CAB.ID",CAB.CNPJ AS "CAB.CNPJ",CAB.EMPRESA AS "CAB.EMPRESAS",CAB.SISTEMA AS "CAB.SISTEMA",CAB.LOCAL AS "CAB.LOCAL",
       CASE 
           WHEN CAB.SISTEMA = 'TOTVS' OR CAB.SISTEMA ='TOTV2'  THEN LO.COD_PROTHEUS
           WHEN CAB.SISTEMA = 'SAP'   OR CAB.SISTEMA = 'SAP2'  THEN LO.COD_SAP
           WHEN CAB.SISTEMA = 'CIC'                            THEN LO.COD_SIC
           ELSE                                                '?????'
       END AS "CLI.LOCAL"
FROM NFE_CAB CAB
LEFT JOIN CLIENTES CLI  ON CLI.CNPJ_CPF = CAB.CNPJ
INNER JOIN LOCAIS  LO   ON LO.ID_CLIENTE = CLI.CODIGO
WHERE CAB.SISTEMA <> 'LIVRO'
ORDER BY CAB.CNPJ  


SELECT DISTINCT cli.cnpj_cpf,cli.razao,cli.empresa,cli.cod_empresa
FROM   CLIENTES CLI
LEFT   JOIN NFE_CAB CAB ON CAB.CNPJ = CLI.CNPJ_CPF
WHERE CAB.ID IS NULL
ORDER  BY CLI.CNPJ_CPF



SELECT * FROM LOCAIS