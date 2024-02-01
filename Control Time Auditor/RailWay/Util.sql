select proj.id,proj.id_cliente,cli.razao,proj.descricao,
   CASE
     WHEN ATIV.CONTA IS NULL THEN 'NÃO'
     ELSE                         'SIM'
   END AS "TEM ATIVIDADE"         
from projetos proj
inner join clientes cli on cli.id = proj.id_cliente
left join atividades ativ on ativ.tipo = 'C' and ativ.id_projeto = proj.id
order by PROJ.id

select proj.id,proj.id_cliente,cli.razao,proj.descricao,estr.descricao,proj.id_diretor,ativ.id_resp,ativ.horasexec
from projetos proj
inner join clientes cli on cli.id = proj.id_cliente
inner join atividades ativ on ativ.id_empresa = ativ.tipo = 'S' and ativ.id_projeto = proj.id
inner join estruturas estr on estr.id_empresa = proj.id_empresa and estr.conta = ativ.conta  and estr.versao = ativ.versao and estr.subconta = ativ.subconta
inner join usuarios   resp on resp.id_empresa = proj.id_empresa and resp.id = ativ.id_resp
order by proj.id


//avlidacao das horas

SELECT tabela.projeto,sum(tabela.horas) from (
    select  apo.id_projeto   as projeto
           ,apo.id_subconta  as subconta
           ,apo.horasapon    as horas
    from apons_execucao apo
    order by apo.id_projeto ) 
    as TABELA
GROUP BY tabela.projeto
go

SELECT id,SUM(horasexec) 
FROM projetos
where horasexec > 0
group by id
order by id
go


//APONTAMENTOS
SELECT tabela.projeto,tabela.subconta,sum(tabela.horas) from (
    select  apo.id_projeto   as projeto
           ,apo.id_subconta  as subconta
           ,apo.horasapon    as horas
    from apons_execucao apo
    where apo.id_projeto = 187
    order by apo.id_projeto,apo.id_subconta ) 
    as TABELA
GROUP BY tabela.projeto,tabela.subconta
go

//ATIVADADES
SELECT ID_PROJETO,SUBCONTA,HORASEXEC 
FROM ATIVIDADES 
WHERE TIPO = 'C' AND HORASEXEC > 0 AND ID_PROJETO = 187
ORDER BY ID_PROJETO
GO

//PROJETOS
SELECT id,SUM(horasexec) 
FROM projetos
where id = 187 and horasexec > 0
group by id
order by id
go

SELECT
     
    ( SELECT tabela.projeto,tabela.subconta,sum(tabela.horas) from (
      select  apo.id_projeto   as projeto
           ,apo.id_subconta  as subconta
           ,apo.horasapon    as horas
      from apons_execucao apo
      where apo.id_projeto = 204
      order by apo.id_projeto,apo.id_subconta LIMIT 1 ) 
      as TABELA
      GROUP BY tabela.projeto,tabela.subconta LIMIT 1) AS  APONTAMENTOS
FROM PROJETOS PROJ
WHERE PROJ.ID = 204 





//resumo dos projetos
SELECT PROJ.ID,PROJ.ID_CLIENTE
       ,CLI.RAZAO
       ,PROJ.DESCRICAO
       ,PROJ.ID_DIRETOR
       ,DIR.RAZAO
       ,PROJ.OBJETO
       ,PROJ.OBS
       ,PROJ.HORASVE
       ,PROJ.horasexec
       ,CASE
           WHEN COALESCE((SELECT COUNT(*) FROM ATIVIDADES ATIV WHERE ATIV.ID_EMPRESA  = PROJ.ID_EMPRESA  AND ATIV.ID_PROJETO = PROJ.ID AND ATIV.TIPO = 'S'),0) > 0 THEN 'SIM'
           ELSE 'NÃO'
        END AS TEM_ATIVIDADE
FROM PROJETOS PROJ
INNER JOIN CLIENTES CLI ON CLI.ID_EMPRESA = PROJ.ID_EMPRESA AND CLI.ID = PROJ.ID_CLIENTE
INNER JOIN USUARIOS DIR ON DIR.ID_EMPRESA = PROJ.ID_EMPRESA AND DIR.ID = PROJ.ID_DIRETOR
ORDER BY PROJ.ID
GO

//projetos x atividades
SELECT PROJ.ID,PROJ.ID_CLIENTE,CLI.RAZAO,PROJ.DESCRICAO,PROJ.ID_DIRETOR,DIR.RAZAO,PROJ.HORASVE,PROJ.horasexec,
       ESTRU.DESCRICAO as ATIVIDADE,ATIV.ID_RESP,RESP.RAZAO AS RESPONSAVEL,ATIV.horasexec
FROM PROJETOS PROJ
INNER JOIN CLIENTES      CLI   ON CLI.ID_EMPRESA   = PROJ.ID_EMPRESA  AND CLI.ID = PROJ.ID_CLIENTE
INNER JOIN USUARIOS      DIR   ON DIR.ID_EMPRESA   = PROJ.ID_EMPRESA  AND DIR.ID = PROJ.ID_DIRETOR
INNER JOIN ATIVIDADES    ATIV  ON ATIV.ID_EMPRESA  = PROJ.ID_EMPRESA  AND ATIV.ID_PROJETO = PROJ.ID AND ATIV.TIPO = 'S'
INNER JOIN ESTRUTURAS    ESTRU ON ESTRU.ID_EMPRESA = PROJ.ID_EMPRESA  AND ESTRU.conta = ATIV.CONTA  AND ESTRU.versao = ATIV.VERSAO AND ESTRU.subconta = ATIV.SUBCONTA
INNER JOIN USUARIOS      RESP   ON RESP.ID_EMPRESA  =PROJ.ID_EMPRESA  AND RESP.ID = ATIV.ID_RESP 
ORDER BY PROJ.ID
GO
//lançamentos
SELECT PROJ.ID,PROJ.ID_CLIENTE
       ,CLI.RAZAO
       ,PROJ.DESCRICAO
       ,PROJ.ID_DIRETOR
       ,DIR.RAZAO
       ,PROJ.HORASVE
       ,PROJ.horasexec
       ,function_HSrxagenal(PROJ.horasexec) AS HORAS_ACUMULADAS
       ,APO.id AS NRO_LANC   
       ,LEFT(APO.id_subconta,4) AS CONTA_PAI
       ,PAI.DESCRICAO           AS CONTA_PAI_DESCRICAO  
       ,APO.id_subconta  
       ,ESTRU.TIPO
       ,ESTRU.DESCRICAO     
       ,APO.id_resp
       ,RESP.RAZAO AS REPONSAVEL
       ,APO.id_exec     
       ,EXEC.RAZAO AS EXECUTOR
       ,APO.inicial              
       ,APO.final  
       ,APO.horasapon   
       ,function_HSrxagenal(APO.horasapon)    AS HORAS_APONTADAS            
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


//Cruza cliente projeto x atividade cliente
SELECT PROJ.ID,PROJ.ID_CLIENTE,CLI.RAZAO,
       ATIV.ID_subcliente
FROM PROJETOS PROJ
INNER JOIN CLIENTES      CLI   ON CLI.ID_EMPRESA   = PROJ.ID_EMPRESA  AND CLI.ID = PROJ.ID_CLIENTE
INNER JOIN ATIVIDADES    ATIV  ON ATIV.ID_EMPRESA  = PROJ.ID_EMPRESA  AND ATIV.ID_PROJETO = PROJ.ID AND ATIV.TIPO = 'S'
ORDER BY PROJ.ID
GO

SELECT * FROM ATIVIDADES WHERE ID_PROJETO = 110 ORDER BY CONTA,SUBCONTA

SELECT * FROM apons_execucao WHERE ID_PROJETO = 110

SELECT * FROM PROJETOS WHERE ID = 110  //13,69

SELECT ID_SUBCLIENTE FROM ATIVIDADES WHERE ID_PROJETO = 110

UPDATE ATIVIDADES SET ID_SUBCLIENTE = 147 WHERE  ID_PROJETO = 110

SELECT * FROM grupos_user


//verfica cliente atividade com apontamento cliente  

SELECT TABELA.ID_PROJETO,TABELA.ID_SUBCLIENTE,COUNT(*) FROM 
(SELECT ATIV.ID_PROJETO,ATIV.ID_SUBCLIENTE
   FROM   ATIVIDADES ATIV
   GROUP BY ATIV.ID_PROJETO,ATIV.ID_SUBCLIENTE
   ORDER BY ATIV.ID_PROJETO,ATIV.ID_SUBCLIENTE ) AS TABELA
GROUP BY TABELA.ID_PROJETO,TABELA.ID_SUBCLIENTE


SELECT ATIV.ID_PROJETO,ATIV.SUBCONTA,ATIV.ID_SUBCLIENTE,APO.ID_SUBCLIENTE,APO.ID_EXEC,APO.ID
   FROM   ATIVIDADES ATIV
   INNER JOIN apons_execucao APO on APO.ID_PROJETO = ATIV.ID_PROJETO AND APO.ID_SUBCONTA = ATIV.SUBCONTA
   WHERE ATIV.TIPO = 'O'
   ORDER BY ATIV.ID_PROJETO,ATIV.ID_SUBCLIENTE


select * from usuarios 