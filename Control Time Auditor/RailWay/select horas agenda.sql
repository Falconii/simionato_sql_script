   SELECT TABELA.DIA, SUM(TABELA.horas_plan) AS horas_plan, SUM(horas_exec) as horas_exec, SUM(horas_pontes)  as horas_pontes
            FROM (

            SELECT TO_CHAR(apo.inicial,'dd') as dia ,apo.horasapon as horas_plan, 0 as horas_exec , 0 as horas_pontes
            FROM   apons_planejamento apo
            inner join projetos proj on proj.id_empresa = apo.id_empresa and proj.id = apo.id_projeto
             where apo.id_empresa = 1 and id_projeto < 900000 and apo.id_exec = 16 and TO_CHAR(apo.inicial,'mm') = '11' and TO_CHAR(apo.inicial,'yyyy') = '2023' union all

            SELECT TO_CHAR(apo.inicial,'dd') as dia, 0 as horas_plan, apo.horasapon as horas_exec , 0 as horas_pontes
            FROM   apons_execucao apo
            inner join projetos proj on proj.id_empresa = apo.id_empresa and proj.id = apo.id_projeto
            where apo.id_empresa = 1 and id_projeto < 900000 and apo.id_exec = 16 and TO_CHAR(apo.inicial,'mm') = '11' and TO_CHAR(apo.inicial,'yyyy') = '2023'   union all

            SELECT TO_CHAR(apo.inicial,'dd') as dia, 0 as horas_plan,0  as horas_exec ,  apo.horasapon as horas_pontes
            FROM   apons_execucao apo
            inner join projetos proj on proj.id_empresa = apo.id_empresa and proj.id = apo.id_projeto
            where apo.id_empresa = 1 and id_projeto = 900000 and apo.id_exec = 16 and TO_CHAR(apo.inicial,'mm') = '11' and TO_CHAR(apo.inicial,'yyyy') = '2023' 
            ) AS TABELA
            GROUP BY TABELA.DIA
            ORDER BY TABELA.DIA
