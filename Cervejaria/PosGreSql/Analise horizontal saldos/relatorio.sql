select  acu.cdempresa
       ,acu.cdfilial
       ,acu.cdcc
       ,acu.conta 
       ,conta.descricao
       ,estrubal         as "ESTRU. BALANÇO"
       ,saldo_anterior   as "SALDO ANTERIOR" 
       ,saldos[1]        as "JANEIRO" 
       ,percentual(saldo_anterior,saldos[1])  as "var %"
       ,saldos[2]        as "FEVEREIRO"
       ,percentual(saldos[1],saldos[2]) as "var %"
       ,saldos[3]        as "MARÇO"
       ,percentual(saldos[2],saldos[3]) as "var %"
       ,saldos[4]        as "ABRIL"
       ,percentual(saldos[3],saldos[4]) as "var %"
       ,saldos[5]        as "MAIO"
       ,percentual(saldos[4],saldos[5]) as "var %"
       ,saldos[6]        as "JUNHO"
       ,percentual(saldos[5],saldos[6]) as "var %"
       ,saldos[7]        as "JULHO"
       ,percentual(saldos[6],saldos[7]) as "var %"
       ,saldos[8]         as "AGOSTO"
       ,percentual(saldos[7],saldos[8]) as "var %"
       ,saldos[9]         as "SETEMBRO"
       ,percentual(saldos[8],saldos[9]) as "var %"
       ,saldos[10]        as "OUTUBRO"
       ,percentual(saldos[9],saldos[10]) as "var %"
       ,saldos[11]        as "NOVEMBRO"
       ,percentual(saldos[10],saldos[11]) as "var %"
       ,saldos[12]        as "DEZEMBRO"
       ,percentual(saldos[11],saldos[12]) as "var %"
from acu_mensal acu where ano = '2023'
inner join contacontabil conta on acu.conta = conta.conta
order by acu.cdempresa,acu.cdfilial,acu.cdcc,acu.conta



select  acu.cdempresa
       ,acu.cdfilial
       ,acu.cdcc
       ,acu.conta 
       ,conta.descricao
       ,estrubal         as "ESTRU. BALANÇO"
       ,saldo_anterior   as "SALDO ANTERIOR" 
       ,saldos[1]        as "JANEIRO" 
       ,percentual(saldo_anterior,saldos[1])  as "var %"
       ,saldos[2]        as "FEVEREIRO"
       ,percentual(saldos[1],saldos[2]) as "var %"
       ,saldos[3]        as "MARÇO"
       ,percentual(saldos[2],saldos[3]) as "var %"
       ,saldos[4]        as "ABRIL"
       ,percentual(saldos[3],saldos[4]) as "var %"
       ,saldos[5]        as "MAIO"
       ,percentual(saldos[4],saldos[5]) as "var %"
from acu_mensal acu
inner join contacontabil conta on acu.conta = conta.conta
where ano = '2024'
order by acu.cdempresa,acu.cdfilial,acu.cdcc,acu.conta

