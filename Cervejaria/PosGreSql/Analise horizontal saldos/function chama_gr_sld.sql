CREATE OR REPLACE FUNCTION "public"."chama_gr_sld" (in _ano text, in _mes text, out _saida text)  
AS
$$
DECLARE
 tempo record;
 _retorno text;
 Comentarios boolean;  
BEGIN
        Comentarios = FALSE;
        IF (Comentarios) THEN
            RAISE NOTICE  'CHAMANDO SALDOS %', _ano ;
        End If;
        FOR tempo in  
              SELECT  sld.cdempresa,sld.cdfilial,sld.cdCC,sld.ano,sld.mes 
              from saldo sld
              where  sld.ano = _ano and  sld.mes = _mes
              group by  sld.cdempresa, sld.cdfilial, sld.cdCC, sld.ano, sld.mes
              order by  sld.cdempresa, sld.cdfilial, sld.cdCC, sld.ano, sld.mes
            LOOP            
               //RAISE NOTICE  'Chama de saldos % % % % % ' ,  tempo.cdempresa,tempo.cdfilial,tempo.cdcc,tempo.ano,tempo.mes  ;
                select gravaracumulado._saida into _retorno from gravaracumulado(tempo.cdempresa,tempo.cdfilial,tempo.cdcc,tempo.ano,tempo.mes); 
            END LOOP;
            _saida := 'OK';
            RETURN; 
END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM chama_gr_sld('2023','01')
go
SELECT * FROM chama_gr_sld('2023','02')
go
SELECT * FROM chama_gr_sld('2023','03')
go
SELECT * FROM chama_gr_sld('2023','04')
go
SELECT * FROM chama_gr_sld('2023','05')
go
SELECT * FROM chama_gr_sld('2023','06')
go
SELECT * FROM chama_gr_sld('2023','07')
go
SELECT * FROM chama_gr_sld('2023','08')
go
SELECT distinct ano,mes 
              from saldo 
              order by ano,mes



SELECT origem
from   saldo 
where  mes = '06' limit 100

SELECT distinct origem
from saldo 

DELETE  FROM acu_mensal