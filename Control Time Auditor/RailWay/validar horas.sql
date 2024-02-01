//VALIDACAO CONTRATO
SELECT TABELA.CONTRATO ,TABELA.APONTAMENTOS,TABELA.ATIVIDADES,TABELA.PROJETOS
       ,CASE
          WHEN ((TABELA.APONTAMENTOS = TABELA.ATIVIDADES) AND (TABELA.ATIVIDADES = TABELA.PROJETOS)) THEN 'OK'
          ELSE                                                                                            'ERRO'
        END  SITUACAO
FROM (
select proj.id AS CONTRATO
       ,(select _saida from apontamentos(proj.id))  as apontamentos
       ,(select _saida from atividades(proj.id))    as atividades
       ,(select _saida from projetos(proj.id))      as projetos
from projetos proj
order by proj.id) 
AS TABELA
WHERE ((TABELA.apontamentos + TABELA.atividades + TABELA.projetos) != 0)

//CONTRATO X APON
SELECT TABELA.PROJETO,TABELA.SUBCONTA,TABELA.HORAS_ATIV,TABELA.HORAS_APO 
         ,CASE
             WHEN TABELA.HORAS_ATIV = TABELA.HORAS_APO   THEN 'OK'
             ELSE                                             'ERRO'
          END AS STATUS
FROM
        (
        SELECT  ATIV.ID_PROJETO AS PROJETO
               ,ATIV.SUBCONTA   AS SUBCONTA
               ,ATIV.horasexec  AS HORAS_ATIV
               ,(SELECT  COALESCE(SUM(horasapon),0) FROM apons_execucao apo where apo.id_projeto = ativ.id_projeto and LEFT(apo.id_subconta,4) = LEFT(ativ.subconta,4)) AS HORAS_APO
        FROM    ATIVIDADES ATIV
        WHERE   ATIV.TIPO = 'S'
        ORDER   BY ATIV.ID_PROJETO,ATIV.SUBCONTA
        ) AS TABELA
WHERE ( (TABELA.HORAS_ATIV != 0) OR (TABELA.HORAS_APO != 0))

//atividade x apontamentos
SELECT TABELA.PROJETO,TABELA.SUBCONTA,TABELA.HORAS_ATIV,TABELA.HORAS_APO 
         ,CASE
             WHEN TABELA.HORAS_ATIV = TABELA.HORAS_APO   THEN 'OK'
             ELSE                                             'ERRO'
          END AS STATUS
FROM
        (
        SELECT  ATIV.ID_PROJETO AS PROJETO
               ,ATIV.SUBCONTA   AS SUBCONTA
               ,ATIV.horasexec  AS HORAS_ATIV
               ,(SELECT  COALESCE(SUM(horasapon),0) FROM apons_execucao apo where apo.id_projeto = ativ.id_projeto and apo.id_subconta = ativ.subconta) AS HORAS_APO
        FROM    ATIVIDADES ATIV
        WHERE   ATIV.TIPO = 'O'
        ORDER   BY ATIV.ID_PROJETO,ATIV.SUBCONTA
        ) AS TABELA
WHERE ( (TABELA.HORAS_ATIV != 0) OR (TABELA.HORAS_APO != 0))

//total de horas
SELECT SUM(horasapon) FROM apons_execucao

SELECT * FROM USUARIOS ORDER BY ID