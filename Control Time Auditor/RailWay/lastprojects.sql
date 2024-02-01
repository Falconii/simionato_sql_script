/*
DROP TYPE  IF EXISTS  LastProjectType;

create type LastProjectType as (
     id_empresa int4     
    ,id_projeto int4    
    ,id_subcliente int4     
    ,cli_fantasia varchar(25)   
    ,proj_descricao varchar(50) 
    ,data text
);
*/

CREATE OR REPLACE FUNCTION "public"."lastproject"(in _id_empresa int4,in _id_usuario int4, in _qtd int4) returns setof public.LastProjectType
AS
$$
DECLARE

registros LastProjectType[];
tempo LastProjectType%ROWTYPE;
idx int;

BEGIN
idx := 0;
 FOR tempo in  
      SELECT distinct
                apo.id_empresa
               ,apo.id_projeto
               ,apo.id_subcliente
               ,cli.fantasi    as cli_fantasia
               ,proj.descricao as proj_descricao
               ,to_char(apo.inicial,'YYYY-MM-DD') as data
             from apons_execucao apo
             inner join clientes cli   on cli.id_empresa = apo.id_empresa and cli.id = apo.id_subcliente
             inner join projetos proj  on proj.id_empresa = apo.id_empresa and proj.id = apo.id_projeto
             where apo.id_empresa = 1 and apo.id_exec = 9
             order by to_char(apo.inicial,'YYYY-MM-DD') desc
      LOOP   
      if (idx = 5) then
          return;
      end if;
      //retorno.id_empresa      := tempo.id_empresa    ; 
      //retorno.id_projeto      := tempo.id_projeto    ;
      //retorno.id_subcliente   := tempo.id_subcliente ;   
      //retorno.cli_fantasia    := tempo.cli_fantasia  ;
      //retorno.proj_descricao  := tempo.proj_descricao ;
      //retorno.data            := tempo.data;
      if (tempo.cli_fantasia = 'SIMIONATO') then
          begin
             idx := idx  + 1;
             registros[idx] := tempo;
             return next tempo;
          end ;
      end if;
      END LOOP;
END;
$$
LANGUAGE 'plpgsql'
go

select * from lastproject(1,9,5);
/*

SELECT distinct
   apo.id_empresa
  ,apo.id_projeto
  ,apo.id_subcliente
  ,cli.fantasi  as cli_fantasia
  ,proj.descricao
  ,apo.id_exec
  ,to_char(apo.inicial,'YYYY-MM-DD') as data
from apons_execucao apo
inner join clientes cli   on cli.id_empresa = apo.id_empresa and cli.id = apo.id_subcliente
inner join projetos proj  on proj.id_empresa = apo.id_empresa and proj.id = apo.id_projeto
where apo.id_empresa = 1 and apo.id_exec = 9
order by to_char(apo.inicial,'YYYY-MM-DD') desc

*/
























SELECT 
     tabela.id_empresa     
    ,tabela.id_projeto     
    ,tabela.id_subcliente     
    ,tabela.cli_fantasia     
    ,tabela.descricao 
    ,tabela.data    
    from
(  SELECT distinct
   apo.id_empresa
  ,apo.id_projeto
  ,apo.id_subcliente
  ,cli.fantasi  as cli_fantasia
  ,proj.descricao
  ,apo.id_exec
  ,to_char(apo.inicial,'YYYY-MM-DD') as data
from apons_execucao apo
inner join clientes cli   on cli.id_empresa = apo.id_empresa and cli.id = apo.id_subcliente
inner join projetos proj  on proj.id_empresa = apo.id_empresa and proj.id = apo.id_projeto
where apo.id_empresa = 1 and apo.id_exec = 9
order by to_char(apo.inicial,'YYYY-MM-DD') desc ) as tabela
group by
      tabela.id_empresa     
    ,tabela.id_projeto     
    ,tabela.id_subcliente     
    ,tabela.cli_fantasia     
    ,tabela.descricao 
    ,tabela.data
order by tabela.data

