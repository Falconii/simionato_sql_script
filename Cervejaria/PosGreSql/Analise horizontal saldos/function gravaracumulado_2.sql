CREATE OR REPLACE FUNCTION "public"."gravaracumulado_2" (
                            in _operacao  text
                           ,in _idx int
                           ,in _cdempresa text
                           ,in _cdfilial  text
                           ,in _cdcc text
                           ,in _ano text
                           ,in _conta text
                           ,in _origem text
                           ,in _estrubal text
                           ,in _saldoinicial numeric(15,2)
                           ,in _saldo_mes numeric(15,2)
                           ,out _saida text
                           )  
AS
$$
DECLARE

    saldo_mes numeric(15,2);

    __saldos numeric(15,2)[12];

BEGIN
                IF (_operacao = 'insert') THEN
                    __saldos = '{0,0,0,0,0,0,0,0,0,0,0,0}';
                    __saldos[_idx] = _saldo_mes;
                    //RAISE NOTICE  'INSERT - Acumulado: % % % ', _idx, __conta, __saldos;
                    IF (_idx = 1) THEN
                        INSERT INTO public.acu_mensal(cdempresa,cdfilial,cdcc,ano,conta,origem,estrubal,saldo_anterior,saldos) 
                        VALUES(_cdempresa, _cdfilial, _cdcc, _ano, _conta, _origem, _estrubal, _saldoinicial,__saldos);
                    ELSE
                        INSERT INTO public.acu_mensal(cdempresa,cdfilial,cdcc,ano,conta,origem,estrubal,saldo_anterior,saldos) 
                        VALUES(_cdempresa, _cdfilial, _cdcc, _ano, _conta,_origem,_estrubal,0,__saldos); 
                    END IF;
                ELSE 
                    //RAISE NOTICE  'UPDATE - Acumulado: % % ', __conta, __saldos;
                    IF (_idx = 1) THEN
                        __saldos[_idx] = _saldo_mes;
                        UPDATE public.acu_mensal SET saldo_anterior = _saldoinicial, SALDOS = __saldos
                        WHERE cdEmpresa = _cdEmpresa and cdFilial = _cdFilial and cdcc = _cdcc and ano = _ano and conta = _conta and origem = _origem; 
                    ELSE 
                        __saldos[_idx] = _saldo_mes;
                        UPDATE public.acu_mensal SET  SALDOS = __saldos
                        WHERE cdEmpresa = _cdEmpresa and cdFilial = _cdFilial and ano = _ano and conta = _conta and origem = _origem; 
                    END IF; 
                END IF;
                
            _saida := 'Saldo OK';
            RETURN; 
END;
$$
LANGUAGE 'plpgsql'
go