CREATE OR REPLACE FUNCTION "public"."gravaracumulado" (
                           in _empresa text , in _filial text , in _cdcc text,  in _conta text ,in _ano text  ,  in _mes text  , out _saida text)  
AS
$$
DECLARE

 tempo public.saldo%ROWTYPE;

 Comentarios boolean;  

 __conta text;

idx integer;

saldo_mes numeric(15,2);

__saldos numeric(15,2)[12];

_retorno text;
 
BEGIN
        Comentarios = true;
        __conta = '';
        idx = 1;           
       RAISE NOTICE  'Gravação de saldos % % % % % ' ,  _empresa  , _filial  ,  _cdcc , _ano   , _mes   ;
       
        FOR tempo in  SELECT *
                      FROM saldo sld
                      WHERE sld.cdempresa = _empresa and sld.cdfilial = _filial and sld.cdcc = _cdcc and sld.conta = _conta and sld.ano = _ano and sld.mes = _mes  --and (sld.cdempresa = '1001' and sld.cdfilial = 'C104' and sld.conta = '4501130130' and (sld.cdcc = '31240013' OR sld.cdcc = '31240016'))
                      ORDER BY sld.cdempresa,sld.cdfilial,sld.conta,sld.cdcc,sld.ano,sld.mes 
            LOOP            
                idx = tempo.mes as integer;
                saldo_mes = tempo.saldofinal;
               
                RAISE NOTICE  'Selct saldo: % % % % % %', tempo.cdempresa,tempo.cdfilial,tempo.cdCC,tempo.conta,tempo.saldofinal,saldo_mes;
                
                SELECT conta,saldos into __conta,__saldos from  acu_mensal 
                WHERE cdEmpresa = tempo.cdEmpresa and cdFilial = tempo.cdFilial and cdCC = tempo.cdCC  and ano = tempo.ano and conta = tempo.conta and origem = tempo.origem;
                 //RAISE NOTICE  'INSERT - Acumulado: % % ', __conta, __saldos;
                
                IF (__conta is null) THEN
                    __saldos = '{0,0,0,0,0,0,0,0,0,0,0,0}';
                    __saldos[idx] = saldo_mes;
                    //select gravaracumulado_2._saida into _retorno from gravaracumulado_2('insert',idx,tempo.cdempresa,tempo.cdfilial,tempo.cdcc,tempo.ano,tempo.conta,tempo.origem,tempo.estrubal,tempo.saldoinicial,saldo_mes); 
                    
                    //RAISE NOTICE  'INSERT - Acumulado: % % % ', idx, __conta, __saldos;
                    IF (idx = 1) THEN
                        INSERT INTO public.acu_mensal(cdempresa,cdfilial,cdcc,ano,conta,origem,estrubal,saldo_anterior,saldos) 
                        VALUES(tempo.cdempresa, tempo.cdfilial, tempo.cdcc, tempo.ano, tempo.conta, tempo.origem, tempo.estrubal, tempo.saldoinicial,__saldos);
                    ELSE
                        INSERT INTO public.acu_mensal(cdempresa,cdfilial,cdcc,ano,conta,origem,estrubal,saldo_anterior,saldos) 
                        VALUES(tempo.cdempresa, tempo.cdfilial, tempo.cdcc, tempo.ano, tempo.conta,tempo.origem,tempo.estrubal,0,__saldos); 
                    END IF;
                    
                ELSE 
                    //RAISE NOTICE  'UPDATE - Acumulado: % % ', __conta, __saldos;
                    //select gravaracumulado_2._saida into _retorno from gravaracumulado_2('update',idx,tempo.cdempresa,tempo.cdfilial,tempo.cdcc,tempo.ano,tempo.conta,tempo.origem,tempo.estrubal,tempo.saldoinicial,saldo_mes); 
                    
                    IF (idx = 1) THEN
                        __saldos[idx] = saldo_mes;
                        UPDATE public.acu_mensal SET saldo_anterior = tempo.saldoinicial, SALDOS = __saldos
                        WHERE cdEmpresa = tempo.cdEmpresa and cdFilial = tempo.cdFilial and cdcc = tempo.cdcc and ano = tempo.ano and conta = tempo.conta and origem = tempo.origem; 
                    ELSE 
                        __saldos[idx] = saldo_mes;
                        UPDATE public.acu_mensal SET  SALDOS = __saldos
                        WHERE cdEmpresa = tempo.cdEmpresa and cdFilial = tempo.cdFilial and cdcc = tempo.cdcc and ano = tempo.ano and conta = tempo.conta and origem = tempo.origem; 
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