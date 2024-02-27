/*

  JAN/2024 - GERADO 18/12 A 19/01

*/
/*

  FEV/2024 - GERADO 22/01 A 22/02

*/
CREATE OR REPLACE FUNCTION "public"."function_gravamovihrs" (in _id_empresa int4,in _id_usuario int4, in _mes int4 , in _ano int4 , out _saida numeric(5,2) ) 
AS
$$
DECLARE

hoje date;
horasApon numeric(6,2);
valor numeric(15,2);
contador  int4;
eFeriado  char(1);
eUtil     char(1);
ePonte    char(1);
eAfastado char(1);
eFerias   char(1);
diaSemana int;
mes int;
ticket int4;
nome text;
dia int;
minHoras int4;

BEGIN
    _saida = 0;
   
    minHoras = 6;

    select usu.razao into nome from usuarios usu where usu.id_empresa = _id_empresa and usu.id = _id_usuario and usu.ativo = 'S' and usu.ticket = 'S';

    if (nome is null) then

       return;

    end if;

    valor = 25.00;

    ePonte = 'N';

    eAfastado = 'N';

    eFerias = 'N';
        
    hoje = cast ( _ano as char(4)) || '-' ||  cast ( _mes as char(2)) || '-22' ;

    select extract(MONTH from hoje) into mes; 

    /* delete from public.tickets_movi where id_empresa = _id_empresa and id_usuario = _id_usuario and to_char(data_ref,'YYYY-MM') = to_char(hoje,'YYYY-MM'); */
    
    select extract(DAY from hoje) into dia; 

    while ( ((mes = 01) AND (dia >= 22)) or((mes = 02) AND (dia <= 21)) ) 

      loop
    
       Raise Notice 'Dia => % ', dia;

      select extract(dow from hoje) into diaSemana; 

      if (diaSemana = 0 or diaSemana = 6) then
         eUtil = 'N';
      else
         eUtil  = 'S';
      end if;


    

      if (to_char(hoje,'YYYY-MM-dd') = '2024-02-12') OR  (to_char(hoje,'YYYY-MM-dd') = '2024-02-13') then 
        ePonte = 'S';
      else 
        ePonte = 'N';
      end if;

      select EXTRACT(MONTH FROM hoje) into mes;

      select coalesce(sum(apo.horasapon),0) from apons_execucao apo 
             where apo.id_empresa = _id_empresa and apo.id_exec = _id_usuario and to_char(apo.inicial,'YYYY-MM-dd') = to_char(hoje,'YYYY-MM-dd') 
             and (trim(apo.id_subconta) != '010954') and (trim(apo.id_subconta) != '010955') into horasApon;

             --and not(apo.id_motivo = '003001' or apo.id_motivo = '003002') into horasApon;

      select coalesce(count(*),0) from feriados fer where fer.id_empresa = _id_empresa and fer.id_usuario = 0 and fer.id_tipo = 1 and to_char(fer.data,'YYYY-MM-dd') = to_char(hoje,'YYYY-MM-dd') into contador;
      
      if (contador = 0) then
         eFeriado = 'N'; 
      else 
         eFeriado  = 'S';
      end if;
     
      --raise notice '_saida % % % % % É Util % É feriado % ', _saida,hoje,diaSemana,mes,horasApon,eUtil,eFeriado;

      if ( (horasApon > 0) OR (eUtil = 'S' and eFeriado = 'N' and ePonte = 'N')) then

         begin
                if (horasApon >= minHoras) then

                    ticket = 1;

                else 
                    ticket = 0;

                end if;

                insert into public.tickets_movi(id_empresa,id_usuario,data_ref,util,feriado,ponte,afastado,ferias,horas,total,tickets_libera,tickets,user_insert,user_update)
                      values(_id_empresa,_id_usuario,hoje,eUtil,eFeriado,ePonte,eAfastado,eFerias,horasApon,(ticket*valor),0,ticket,_id_usuario,0);
         end;

      end if;

	  _saida = _saida + 1;

       SELECT (hoje + interval '1 day') into hoje ;
       select extract(MONTH from hoje) into mes;
       select extract(DAY from hoje) into dia;  

   end loop;

END;
$$
LANGUAGE 'plpgsql'
go


/*
DELETE FROM public.tickets_movi
SELECT * FROM function_gravamovihrs(1,9,9,2023)
*/

SELECT
       MOVI.id_usuario,usu.razao,MOVI.data_ref,Movi.horas,MOVI.tickets
FROM   tickets_movi MOVI
INNER JOIN USUARIOS USU ON USU.ID_EMPRESA = MOVI.ID_EMPRESA AND USU.ID = MOVI.ID_USUARIO
ORDER BY MOVI.id_usuario,MOVI.data_ref
go


SELECT
       MOVI.id_usuario,usu.razao,count(*)as "TOTAL DE DIAS",sum(MOVI.tickets) AS "TOTAL DE TICKETS"
FROM   tickets_movi MOVI
INNER JOIN USUARIOS USU ON USU.ID_EMPRESA = MOVI.ID_EMPRESA AND USU.ID = MOVI.ID_USUARIO
GROUP BY MOVI.id_usuario,usu.razao
ORDER BY usu.razao

