//projetos
SELECT PROJ.ID,PROJ.ID_CLIENTE
       ,CLI.RAZAO
       ,PROJ.DESCRICAO
       ,PROJ.ID_DIRETOR
       ,DIR.RAZAO
       ,PROJ.HORASVE
       ,PROJ.horasexec
       ,CASE
           WHEN COALESCE((SELECT COUNT(*) FROM ATIVIDADES ATIV WHERE ATIV.ID_EMPRESA  = PROJ.ID_EMPRESA  AND ATIV.ID_PROJETO = PROJ.ID AND ATIV.TIPO = 'S'),0) > 0 THEN 'SIM'
           ELSE 'N�O'
        END AS TEM_ATIVIDADE
FROM PROJETOS PROJ
INNER JOIN CLIENTES CLI ON CLI.ID_EMPRESA = PROJ.ID_EMPRESA AND CLI.ID = PROJ.ID_CLIENTE
INNER JOIN USUARIOS DIR ON DIR.ID_EMPRESA = PROJ.ID_EMPRESA AND DIR.ID = PROJ.ID_DIRETOR
ORDER BY PROJ.ID
GO

//projetos x atividades
SELECT PROJ.ID AS ID_PROJETO,PROJ.ID_CLIENTE,CLI.RAZAO,ATIV.CONTA,ATIV.SUBCONTA,ESTRU.DESCRICAO as ATIVIDADE,ATIV.TIPO,ATIV.NIVEL,ATIV.ID_RESP,RESP.RAZAO AS RESPONSAVEL,ATIV.HORASEXEC
FROM PROJETOS PROJ
INNER JOIN CLIENTES      CLI   ON CLI.ID_EMPRESA   = PROJ.ID_EMPRESA  AND CLI.ID = PROJ.ID_CLIENTE
INNER JOIN USUARIOS      DIR   ON DIR.ID_EMPRESA   = PROJ.ID_EMPRESA  AND DIR.ID = PROJ.ID_DIRETOR
INNER JOIN ATIVIDADES    ATIV  ON ATIV.ID_EMPRESA  = PROJ.ID_EMPRESA  AND ATIV.ID_PROJETO = PROJ.ID 
INNER JOIN ESTRUTURAS    ESTRU ON ESTRU.ID_EMPRESA = PROJ.ID_EMPRESA  AND ESTRU.conta = ATIV.CONTA  AND ESTRU.versao = ATIV.VERSAO AND ESTRU.subconta = ATIV.SUBCONTA
INNER JOIN USUARIOS      RESP   ON RESP.ID_EMPRESA  =PROJ.ID_EMPRESA  AND RESP.ID = ATIV.ID_RESP 
ORDER BY PROJ.ID,ATIV.CONTA,ATIV.SUBCONTA
GO

//lan�amentos
SELECT PROJ.ID,PROJ.ID_CLIENTE
       ,CLI.RAZAO       
       ,APO.id AS NRO_LANC   
       ,APO.ID_CONTA  
       ,LEFT(APO.ID_SUBCONTA,4) AS CONTA_PAI
       ,APO.id_subconta     
       ,APO.id_resp
       ,RESP.RAZAO AS REPONSAVEL
       ,APO.id_exec     
       ,EXEC.RAZAO AS EXECUTOR
       ,APO.inicial              
       ,APO.final  
       ,APO.horasapon            
       ,APO.obs
FROM PROJETOS PROJ
INNER JOIN CLIENTES       CLI ON CLI.ID_EMPRESA = PROJ.ID_EMPRESA AND CLI.ID = PROJ.ID_CLIENTE
INNER JOIN USUARIOS       DIR ON DIR.ID_EMPRESA = PROJ.ID_EMPRESA AND DIR.ID = PROJ.ID_DIRETOR
INNER JOIN apons_execucao APO ON APO.ID_EMPRESA = PROJ.ID_EMPRESA AND APO.ID_PROJETO = PROJ.ID
INNER JOIN ESTRUTURAS     ESTRU  ON ESTRU.ID_EMPRESA = PROJ.ID_EMPRESA  AND ESTRU.conta = APO.ID_CONTA  AND ESTRU.versao = APO.ID_CONTA_VERSAO AND ESTRU.subconta = ID_SUBCONTA
INNER JOIN ESTRUTURAS     PAI    ON PAI.ID_EMPRESA = PROJ.ID_EMPRESA  AND PAI.conta = APO.ID_CONTA  AND PAI.versao = APO.ID_CONTA_VERSAO AND PAI.subconta = LEFT(ID_SUBCONTA,4)
INNER JOIN USUARIOS       RESP   ON RESP.ID_EMPRESA  =PROJ.ID_EMPRESA  AND RESP.ID = APO.ID_RESP 
INNER JOIN USUARIOS       EXEC   ON EXEC.ID_EMPRESA  =PROJ.ID_EMPRESA  AND EXEC.ID = APO.ID_EXEC
ORDER BY PROJ.ID
        ,APO.id_subconta  
        ,ESTRU.DESCRICAO  
        ,RESP.RAZAO
        ,EXEC.RAZAO
        ,APO.inicial      
GO


//ESTRUTURA NIVEL 1
SELECT CONTA,DESCRICAO FROM ESTRUTURAS
WHERE TIPO = 'C'
ORDER BY CONTA
GO

//atividades nivel 2
SELECT DISTINCT ESTRU.CONTA,ESTRU.DESCRICAO as ATIVIDADE
FROM ATIVIDADES ATIV
INNER JOIN CLIENTES      CLI   ON CLI.ID_EMPRESA   = ATIV.ID_EMPRESA  AND CLI.ID = ATIV.ID_SUBCLIENTE
INNER JOIN ESTRUTURAS    ESTRU ON ESTRU.ID_EMPRESA = ATIV.ID_EMPRESA  AND ESTRU.conta = ATIV.CONTA  AND ESTRU.versao = ATIV.VERSAO AND ESTRU.subconta = ATIV.SUBCONTA
INNER JOIN USUARIOS      RESP   ON RESP.ID_EMPRESA  =ATIV.ID_EMPRESA  AND RESP.ID = ATIV.ID_RESP 
WHERE ATIV.NIVEL = 2
ORDER BY ESTRU.CONTA,ESTRU.DESCRICAO
GO


//ATIVIDADES TIPO 'S' X PROJETOS
SELECT PROJ.ID AS ID_PROJETO,ATIV.CONTA,ATIV.SUBCONTA,ESTRU.DESCRICAO as ATIVIDADE,COUNT(*)
FROM PROJETOS PROJ
INNER JOIN CLIENTES      CLI   ON CLI.ID_EMPRESA   = PROJ.ID_EMPRESA  AND CLI.ID = PROJ.ID_CLIENTE
INNER JOIN USUARIOS      DIR   ON DIR.ID_EMPRESA   = PROJ.ID_EMPRESA  AND DIR.ID = PROJ.ID_DIRETOR
INNER JOIN ATIVIDADES    ATIV  ON ATIV.ID_EMPRESA  = PROJ.ID_EMPRESA  AND ATIV.ID_PROJETO = PROJ.ID 
INNER JOIN ESTRUTURAS    ESTRU ON ESTRU.ID_EMPRESA = PROJ.ID_EMPRESA  AND ESTRU.conta = ATIV.CONTA  AND ESTRU.versao = ATIV.VERSAO AND ESTRU.subconta = ATIV.SUBCONTA
INNER JOIN USUARIOS      RESP   ON RESP.ID_EMPRESA  =PROJ.ID_EMPRESA  AND RESP.ID = ATIV.ID_RESP 
WHERE ATIV.TIPO ='S'
GROUP BY PROJ.ID,ATIV.CONTA ,ATIV.SUBCONTA,ESTRU.DESCRICAO
ORDER BY PROJ.ID,ATIV.CONTA,ATIV.SUBCONTA,ESTRU.DESCRICAO

GO

SELECT *  from estruturas WHERE LEFT(SUBCONTA,2) = 'XX'

UPDATE estruturas SET SUBCONTA = '0401', NIVEL = 2 WHERE LEFT(SUBCONTA,2) = 'XX'
