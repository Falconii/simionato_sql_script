CREATE  TABLE dates(
  date_col DATE,
  timestamp_col TIMESTAMP,
  timestamptz_col TIMESTAMPTZ 
);

select   date_col        ,
         timestamp_col   AT TIME ZONE 'UTC' as horas,
         timestamptz_col::timestamp::timestamptz AT TIME ZONE 'UTC'
from dates

SELECT '2018-10-22T00:00:00Z'::timestamp::timestamptz AT TIME ZONE 'UTC';


select  apo.id_empresa
                ,apo.id
                ,apo.id_projeto
                ,apo.id_tarefa
                ,apo.id_trabalho
                ,apo.id_resp
                ,apo.id_exec
                ,to_char(apo.inicial,'YYYY-MM-DD') as datainicial
                ,to_char(apo.inicial,'HH24:MI')    as horainicial
                ,to_char(apo.final,'YYYY-MM-DD')   as datafinal
                ,to_char(apo.final,'HH24:MI')      as horafinal
                ,apo.horasapon
                ,apo.obs
                ,apo.encerra
                ,apo.user_insert
                ,apo.user_update
          from   apons_planejamento apo
          where apo.id_empresa = 1 and apo.id_projeto = '6' and apo.id_tarefa = '008000' and apo.id_trabalho = '008004' and (( to_char(apo.inicial,'YYYY-MM-DD') = '2022-03-08')  or  ( to_char(apo.inicial,'YYYY-MM-DD') = '2022-03-09')  or  ( to_char(apo.inicial,'YYYY-MM-DD') = '2022-03-10')  or  ( to_char(apo.inicial,'YYYY-MM-DD') = '2022-03-11')  or  ( to_char(apo.inicial,'YYYY-MM-DD') = '2022-03-14')  or  ( to_char(apo.inicial,'YYYY-MM-DD') = '2022-03-15')  or  ( to_char(apo.inicial,'YYYY-MM-DD') = '2022-03-16')  
or  ( to_char(apo.inicial,'YYYY-MM-DD') = '2022-03-17')  or  ( to_char(apo.inicial,'YYYY-MM-DD') = '2022-03-18')  or  ( to_char(apo.inicial,'YYYY-MM-DD') = '2022-03-21') )
