CREATE OR REPLACE FUNCTION public.get_selic (ano_inicial int4, mes_inicial int4, ano_final int4, mes_final int4) 
RETURNS decimal(6,2)  
AS
$$
DECLARE

  Retorno decimal(6,2);
  DataInicial text;
  DataFinal   text; 
  DataMinima  text;
  DataMaxima  text;

BEGIN

  SELECT MIN(ANO || MES) AS MIN_DATA, MAX(ANO || MES) AS MAX_DATA 
  FROM SELIC INTO DataMinima, DataMaxima;

  //RAISE NOTICE 'Data Minima % Data Máxima % ',  DataMinima,DataMaxima;

  mes_inicial = mes_inicial+1;

  if (mes_inicial > 12) then
 
      mes_inicial = 1;

      ano_inicial = ano_inicial + 1;

  end if;
      
  DataInicial =  cast(ano_inicial as char(4)) ||  right( '00' ||  cast(mes_inicial as char(2)),2) ;

  //RAISE NOTICE 'Data Inicial % ',  DataInicial;
 
  DataFinal   =  cast(ano_final as char(4)) ||  right( '00' ||  cast(mes_final as char(2)),2) ;

  //RAISE NOTICE 'Data Final % ',  DataFinal;

  if (DataInicial < DataMinima) then

    return -1;

  end if;

 if (DataInicial > DataMaxima) then

    return -1;

  end if;

  SELECT SUM(TAXA)
  FROM   SELIC INTO Retorno
  WHERE  ANO || MES >= DataInicial AND ANO || MES <= DataFinal;

  return Retorno; 
  
END;

$$
LANGUAGE 'plpgsql'
GO


SELECT * FROM get_selic(2019,02,2020,07);