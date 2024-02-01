CREATE OR REPLACE FUNCTION "public"."gera_tick_tempo"(in _id_empresa int4,in _id_usuario int4, in _mes int4 , in _ano int4) returns setof public.tickets_movi
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

tempo  public.tickets_movi%ROWTYPE;

BEGIN

    select usu.razao into nome from usuarios usu where usu.id_empresa = _id_empresa and usu.id = _id_usuario and usu.ativo = 'S' and usu.ticket = 'S';

    if (nome is null) then

       return;

    end if;

    valor = 25.00;

    ePonte = 'N';

    eAfastado = 'N';

    eFerias = 'N';
        
    hoje = cast ( _ano as char(4)) || '-' ||  cast ( _mes as char(2)) || '-23' ;

    select extract(MONTH from hoje) into mes; 

    //delete from public.tickets_movi where id_empresa = _id_empresa and id_usuario = _id_usuario and to_char(data_ref,'YYYY-MM') = to_char(hoje,'YYYY-MM');
    
    select extract(DAY from hoje) into dia; 

    while ( ((mes = 09) AND (dia >= 23)) or((mes = 10) AND (dia <= 22)) ) 

      loop
    
      select extract(dow from hoje) into diaSemana; 

      if (diaSemana = 0 or diaSemana = 6) then
         eUtil = 'N';
      else
         eUtil  = 'S';
      end if;


//      if (to_char(hoje,'YYYY-MM-dd') = '2023-10-13') then 
//        ePonte = 'S';
//      else 
//        ePonte = 'N';
//      end if;

      select EXTRACT(MONTH FROM hoje) into mes;

      select coalesce(sum(apo.horasapon),0) from apons_execucao apo where apo.id_empresa = _id_empresa and apo.id_exec = _id_usuario and to_char(apo.inicial,'YYYY-MM-dd') = to_char(hoje,'YYYY-MM-dd') and trim(apo.id_subconta) != '010955' into horasApon;

      select coalesce(count(*),0) from feriados fer where fer.id_empresa = _id_empresa and fer.id_usuario = 0 and fer.id_tipo = 1 and to_char(fer.data,'YYYY-MM-dd') = to_char(hoje,'YYYY-MM-dd') into contador;
      
      if (contador = 0) then
         eFeriado = 'N'; 
      else 
         eFeriado  = 'S';
      end if;
     
      if ( (horasApon > 0) OR (eUtil = 'S' and eFeriado = 'N' and ePonte = 'N')) then

         begin
                if (horasApon >= 6) then

                    ticket = 1;

                else 
                    ticket = 0;

                end if;
                
               tempo.id_empresa		   := _id_empresa		;
               tempo.id_usuario        := _id_usuario      ;
               tempo.data_ref          := hoje             ;
               tempo.util              := eUtil            ;
               tempo.feriado           := eFeriado         ;
               tempo.ponte             := ePonte           ;
               tempo.afastado          := eAfastado        ;
               tempo.ferias            := eFerias          ;
               tempo.horas             := horasApon        ;
               tempo.total             := (ticket*valor)   ;
               tempo.tickets_libera    := 0                ;
               tempo.tickets           := ticket           ;
               tempo.user_insert       := _id_usuario      ;
               tempo.user_update       := 0                ;

               return next tempo;
         end;

      end if;

       SELECT (hoje + interval '1 day') into hoje ;
       select extract(MONTH from hoje) into mes;
       select extract(DAY from hoje) into dia;  

   end loop;

END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM gera_tick_tempo(1,9,9 , 2023 );
