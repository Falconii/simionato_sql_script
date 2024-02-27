CREATE OR REPLACE FUNCTION "public"."percentual" (in _vlrAnterior numeric(15,2) , in _vlrAtual numeric(15,2) , out _saida numeric(16,9) ) 
AS
$$
DECLARE
 
BEGIN
   _saida = 0;

      IF (_vlrAnterior = _vlrAtual ) then
  
           _saida = 0;

          return;
       
      END IF ;  

      IF ((_vlrAnterior = 0) and (_vlrAtual > 0)) then
  
          _saida = 100;

          return ;
       
      END IF   ; 

      IF (  (_vlrAtual = 0) and (_vlrAnterior = 0) )  then

        _saida = 0;

        return ;

      END IF   ;   

      IF (_vlrAnterior > 0) THEN
         _saida =  round((_vlrAtual/_vlrAnterior),9) -1;
      ELSE 
         _saida =  round((_vlrAtual/1),9);
      END IF;
      _saida = _saida * 100
      return;
END;
$$
LANGUAGE 'plpgsql'
go


select * from percentual(94805.32,26701.20);

//select * from gravaracumulado('1001','C100','2023');


// 1001          C100         2023    01      1102010020  117124,59  


/*
SELECT sld.cdempresa,sld.cdfilial,sld.ano,sld.mes,sld.conta,sld.saldofinal
                      FROM saldo sld
                      ORDER BY sld.cdempresa,sld.cdfilial,sld.ano,sld.mes 

select * from acu_mensal

select distinct cdempresa,cdfilial,conta,ano,mes from saldo where ano = '2023' order by cdempresa,cdfilial,conta,ano,mes
*/