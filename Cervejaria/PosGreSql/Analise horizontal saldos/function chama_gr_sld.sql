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
              SELECT  sld.cdempresa,sld.cdfilial,sld.cdCC,sld.ano,sld.mes,sld.conta
              from saldo sld
              where  sld.ano = _ano and  sld.mes = _mes   --and (sld.cdempresa = '1001' and sld.cdfilial = 'C104' and sld.conta = '4501130130' and (sld.cdcc = '31240013' OR sld.cdcc = '31240016'))
              group by  sld.cdempresa, sld.cdfilial, sld.cdCC, sld.ano, sld.mes , sld.conta
              order by  sld.cdempresa, sld.cdfilial, sld.cdCC, sld.ano, sld.mes , sld.conta 
            LOOP            
               RAISE NOTICE  'Chama de saldos % % % % % => Conta %' ,  tempo.cdempresa,tempo.cdfilial,tempo.cdcc,tempo.ano,tempo.mes , tempo.conta ;
               select gravaracumulado._saida into _retorno from gravaracumulado(tempo.cdempresa,tempo.cdfilial,tempo.cdcc,tempo.conta,tempo.ano,tempo.mes); 
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
SELECT * FROM chama_gr_sld('2023','09')
go
SELECT * FROM chama_gr_sld('2023','10')
go
SELECT * FROM chama_gr_sld('2023','11')
go
SELECT * FROM chama_gr_sld('2023','12')
go

//
SELECT distinct ano,mes 
                from saldo 
                order by ano,mes



SELECT * FROM chama_gr_sld('2024','01')
go
SELECT * FROM chama_gr_sld('2024','02')
go
SELECT * FROM chama_gr_sld('2024','03')
go
SELECT * FROM chama_gr_sld('2024','04')
go
SELECT * FROM chama_gr_sld('2024','05')
go



SELECT origem
from   saldo 
where  mes = '06' limit 100

SELECT distinct origem
from saldo 

//deletar um ano 
--DELETE  FROM acu_mensal where ano = '2024'

//deletar um ano 
--DELETE  FROM acu_mensal where ano = '2024'
//SALDOS
--DELETE FROM SALDOS WHERE ANO = '2024'