CREATE OR REPLACE FUNCTION "public"."gravaracumulado" (
                           in _empresa text , in _filial text , in _cdcc text,  in _ano text  ,  in _mes text  , out _saida text)  
AS
$$
DECLARE

 tempo public.saldo%ROWTYPE;

 Comentarios boolean;  

 __conta text;

idx integer;

saldo_mes numeric(15,2);

__saldos numeric(15,2)[12];
 
BEGIN
        Comentarios = FALSE;
        __conta = '';
        idx = 1;
        IF (Comentarios) THEN 
            RAISE NOTICE  'Gravação de saldos % % % % % ' ,  _empresa  , _filial  ,  _cdcc , _ano   , _mes   ;
        END IF;
        FOR tempo in  SELECT *
                      FROM saldo sld
                      WHERE sld.cdempresa = _empresa and sld.cdfilial = _filial and sld.cdcc = _cdcc and sld.ano = _ano and sld.mes = _mes
                      ORDER BY sld.cdempresa,sld.cdfilial,sld.conta,sld.cdcc,sld.ano,sld.mes 
            LOOP            
                idx = tempo.mes as integer;
                saldo_mes = tempo.saldofinal;
                //RAISE NOTICE  'Saldo Do Mês: % % % % ', tempo.cdempresa,tempo.cdfilial,tempo.saldofinal,saldo_mes;
                SELECT conta,saldos into __conta,__saldos from  acu_mensal 
                WHERE cdEmpresa = tempo.cdEmpresa and cdFilial = tempo.cdFilial and tempo.cdCC = _cdcc and ano = tempo.ano and conta = tempo.conta and origem = tempo.origem;
                IF (__conta is null) THEN
                    __saldos = '{0,0,0,0,0,0,0,0,0,0,0,0}';
                    __saldos[idx] = saldo_mes;
                    //RAISE NOTICE  'INSERT - Acumulado: % % ', __conta, __saldos;
                    IF (idx = 1) THEN
                        INSERT INTO public.acu_mensal(cdempresa,cdfilial,cdcc,ano,conta,origem,estrubal,saldo_anterior,saldos) 
                        VALUES(tempo.cdempresa, tempo.cdfilial, tempo.cdcc, tempo.ano, tempo.conta, tempo.origem, tempo.estrubal, tempo.saldoinicial,__saldos);
                    ELSE
                        INSERT INTO public.acu_mensal(cdempresa,cdfilial,cdcc,ano,conta,origem,estrubal,saldo_anterior,saldos) 
                        VALUES(tempo.cdempresa, tempo.cdfilial, tempo.cdcc, tempo.ano, tempo.conta,tempo.origem,tempo.estrubal,0,__saldos); 
                    END IF;
                ELSE 
                    //RAISE NOTICE  'UPDATE - Acumulado: % % ', __conta, __saldos;
                    IF (idx = 1) THEN
                        __saldos[idx] = saldo_mes;
                        UPDATE public.acu_mensal SET saldo_anterior = tempo.saldoinicial, SALDOS = __saldos
                        WHERE cdEmpresa = tempo.cdEmpresa and cdFilial = tempo.cdFilial and cdcc = tempo.cdcc and ano = tempo.ano and conta = tempo.conta and origem = tempo.origem; 
                    ELSE 
                        __saldos[idx] = saldo_mes;
                        UPDATE public.acu_mensal SET  SALDOS = __saldos
                        WHERE cdEmpresa = tempo.cdEmpresa and cdFilial = tempo.cdFilial and ano = tempo.ano and conta = tempo.conta and origem = tempo.origem; 
                    END IF; 
                END IF;
            END LOOP;
            _saida := 'Saldo OK';
            RETURN; 
END;
$$
LANGUAGE 'plpgsql'
go

//select * from gravaracumulado('1001','C100','2023');


// 1001          C100         2023    01      1102010020  117124,59  


/*
SELECT sld.cdempresa,sld.cdfilial,sld.cdcc,sld.ano,sld.mes,sld.conta,sld.saldofinal
                      FROM saldo sld
                      ORDER BY sld.cdempresa,sld.cdfilial,sld.cdcc,sld.ano,sld.mes 

select * from acu_mensal

select distinct cdempresa,cdfilial,conta,ano,mes from saldo where ano = '2023' order by cdempresa,cdfilial,conta,ano,mes
*/