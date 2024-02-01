//horas positivas
//entrada
SELECT
 usu.razao 
,cast (to_char(apo.inicial,'yyyy-MM-DD')||' '|| usu.man_hora_entrada as TIMESTAMP) as entrada
,apo.inicial,apo.final
,DATE_PART('hour', AGE(cast (to_char(apo.inicial,'yyyy-MM-DD')||' '|| usu.man_hora_entrada as TIMESTAMP) , apo.inicial)) || ':' ||
DATE_PART('min', AGE(cast (to_char(apo.inicial,'yyyy-MM-DD')||' '|| usu.man_hora_entrada as TIMESTAMP) , apo.inicial)) AS horas
FROM apons_execucao apo
INNER JOIN usuarios usu on usu.id = apo.id_exec
WHERE apo.inicial < cast (to_char(apo.inicial,'yyyy-MM-DD')||' '|| usu.man_hora_entrada as TIMESTAMP) 
order by usu.razao,apo.inicial
go

//select positivo
//saida
SELECT
 usu.razao 
,cast (to_char(apo.final,'yyyy-MM-DD')||' '|| usu.tard_hora_saida as TIMESTAMP) as saida
,apo.inicial,apo.final
,'0' || DATE_PART('hour', AGE(apo.final,cast (to_char(apo.final,'yyyy-MM-DD')||' '|| usu.tard_hora_saida as TIMESTAMP))) || ':' ||
 DATE_PART('min', AGE(apo.final,cast (to_char(apo.final,'yyyy-MM-DD')||' '|| usu.tard_hora_saida as TIMESTAMP))) || ':00' AS HORAS
FROM apons_execucao apo
INNER JOIN usuarios usu on usu.id = apo.id_exec
WHERE apo.final > cast (to_char(apo.final,'yyyy-MM-DD')||' '|| usu.tard_hora_saida as TIMESTAMP) 
order by usu.razao,apo.inicial

SELECT tabela.razao,tabela.data, function_hsrxagenal(tabela.hrs_trab) as hrs_trab, 
       case
          when tabela.hrs_trab >  case 
          when EXTRACT( DOW FROM cast (tabela.data as Date) ) <> 5 then 9.5
          else                                                          7
      end            then function_hsrxagenal(tabela.hrs_trab -  case 
          when EXTRACT( DOW FROM cast (tabela.data as Date) ) <> 5 then 9.5
          else                                                           case 
          when EXTRACT( DOW FROM cast (tabela.data as Date) ) <> 5 then 9.5
          else                                                          7
      end  
      end  )
          else                          '-' || function_hsrxagenal((9.5 - tabela.hrs_trab))
       end as horas
FROM 
(
    SELECT
     usu.razao 
    ,to_char(apo.final,'yyyy-MM-DD') as data
    ,sum(apo.horasapon) as hrs_trab
    FROM apons_execucao apo
    INNER JOIN usuarios usu on usu.id = apo.id_exec
    WHERE usu.timer = 'S'
    GROUP BY  usu.razao 
              ,to_char(apo.final,'yyyy-MM-DD')
    order by usu.razao,to_char(apo.final,'yyyy-MM-DD') ) as tabela
where tabela.hrs_trab <> 
      case 
          when EXTRACT( DOW FROM cast (tabela.data as Date) ) <> 5 then 9.5
          else                                                          7
      end  
go