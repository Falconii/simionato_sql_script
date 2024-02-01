CREATE OR REPLACE FUNCTION "public"."gravarsaldo" (
                           in _empresa text, in _conta text, in _ano text, in _mes text
                          ,out _saldoinicial numeric(15,2), out _debito numeric(15,2), out _credito numeric(15,2), out _saldofinal numeric(15,2), out _saida text)  
AS
$$
DECLARE

 tempo public.movidet%ROWTYPE;

 Comentarios boolean;  
 
 _xempresa text ;
 _xconta   text ;
 _xano     text;
 _xmes     text;
 _xsaldoinicial numeric(15,2);
 _xsaldofinal   numeric(15,2);
 _XDEBITO     numeric(15,2);
 _XCREDITO    numeric(15,2);
 _NIVEL   text;

 GravaSaldoInicial boolean;

BEGIN

        GravaSaldoInicial = false;

        _saldoinicial = 0;
        _debito  = 0;
        _credito = 0;
        _saldofinal = 0;

        Comentarios = TRUE;
 
        SELECT TABELA.EMPRESA as xempresa  
              ,TABELA.CONTA   as xconta   
              ,TABELA.ANO     as xano   
              ,TABELA.MES     as xmes        
              ,COALESCE(SUM(TABELA.SALDOINICIAL),0) AS XSALDOINICIAL  
              ,COALESCE(SUM(TABELA.SALDOFINAL),0)   AS XSALDOFINAL  
        FROM (  
           SELECT  SLD.CDEMPRESA AS EMPRESA    
                  ,SLD.CONTA   AS CONTA        
                  ,SLD.ANO     AS ANO          
                  ,SLD.MES     AS MES          
                  ,COALESCE(SLD.SALDOINICIAL,0) AS SALDOINICIAL
                  ,COALESCE(SLD.SALDOFINAL,0)   AS SALDOFINAL
           FROM   SALDO SLD  
           WHERE  SLD.CONTA = _conta AND SLD.CDEMPRESA = _empresa AND SLD.ANO = _ano AND SLD.MES = _mes  
        ) AS TABELA  
        INTO _xempresa, _xconta  ,  _xano ,  _xmes , _xsaldoinicial, _xsaldofinal 
        GROUP BY TABELA.EMPRESA , TABELA.CONTA  , TABELA.ANO , TABELA.MES ;

        _saldoinicial := _xsaldoinicial;

        IF (Comentarios) THEN 

            RAISE NOTICE  'SALDO INICIAL % SALDO FINAL %', _xsaldoinicial, _xsaldofinal ;
                   

        End If;
     
        FOR tempo in  SELECT DET.* 
              FROM public.movidet DET
              WHERE  DET.BKPF_BUKRS = _empresa AND BSEG_HKONT = _conta AND TO_CHAR(DET.BKPF_BUDAT,'YYYY') = _ano AND TO_CHAR(DET.BKPF_BUDAT,'MM') = _mes  
              ORDER BY DET.BKPF_BUKRS,DET.BSEG_HKONT,DET.BKPF_BUDAT, DET.BKPF_BELNR , DET.BSEG_BUZEI 
            LOOP            
               _XDEBITO  := 0;
               _XCREDITO := 0;

               IF (( TEMPO.BSEG_SHKZG = 'H')) THEN
                   _XCREDITO := tempo.BSEG_DMBTR * -1;
               END IF;
               IF ((TEMPO.BSEG_SHKZG = 'S' )) THEN
                   _XDEBITO := tempo.BSEG_DMBTR ;
               END IF;

              IF true THEN

                       UPDATE movidet SET 
                                 saldo_inicial =  _xsaldoinicial,
                                 saldo         =  _xsaldoinicial +  _XCREDITO + _XDEBITO 
                       WHERE  ID =  tempo.id  AND LINHA = tempo.Linha;

                      _xsaldoinicial := _xsaldoinicial +  _XDEBITO +  _XCREDITO ;

                      _debito  := _debito  + _XDEBITO;
                      _credito := _credito + _XCREDITO;

               END IF;
            
            END LOOP;

            _saldofinal := _xsaldoinicial;

            IF ( NOT(_xsaldoinicial = _xsaldofinal) ) THEN

                _saida := 'Saldo Com Divergência';

                --RAISE NOTICE ''CONTA % COM DIVEREGENCIA Debito % Credito % Saldo Final Acumulado % Saldo Final Calculado % '', _XDEBITO,_XCREDITO, _conta, _xsaldoinicial, _xsaldofinal;
               
            ELSE 

                _saida := 'Saldo OK';

                --RAISE NOTICE ''CONTA % OK'', _conta;

            END IF;
            RETURN; 
END;
$$
LANGUAGE 'plpgsql'


 UPDATE  MOVIDET SET SALDO           =   -453.85 , SALDO_INICIAL  =  0   WHERE ID = 1 AND LINHA = 62925