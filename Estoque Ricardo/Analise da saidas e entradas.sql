SELECT cli.cnpj_cpf,det.cod_empresa,det.local,det.material,det.dtnf
FROM   nfe_det_e det
inner  join clientes cli on cli.cod_empresa = det.cod_empresa and cli.local = det.local
WHERE  det.operacao = 'S' and (
   if (     (det.CFOP = '5100') OR 
            (det.CFOP = '5101') OR 
            (det.CFOP = '5102') OR 
            (det.CFOP = '5103') OR 
            (det.CFOP = '5104') OR 
            (det.CFOP = '5105') OR 
            (det.CFOP = '5106') OR 
            (det.CFOP = '5109') OR 
            (det.CFOP = '5110') OR 
            (det.CFOP = '5111') OR 
            (det.CFOP = '5112') OR 
            (det.CFOP = '5113') OR 
            (det.CFOP = '5114') OR 
            (det.CFOP = '5115') OR 
            (det.CFOP = '5116') OR 
            (det.CFOP = '5117') OR 
            (det.CFOP = '5118') OR 
            (det.CFOP = '5119') OR 
            (det.CFOP = '5120') OR 
            (det.CFOP = '5122') OR 
            (det.CFOP = '5123') OR 
            (det.CFOP = '5250') OR 
            (det.CFOP = '5251') OR 
            (det.CFOP = '5252') OR 
            (det.CFOP = '5253') OR 
            (det.CFOP = '5254') OR 
            (det.CFOP = '5255') OR 
            (det.CFOP = '5256') OR 
            (det.CFOP = '5257') OR 
            (det.CFOP = '5258') OR 
            (det.CFOP = '5401') OR 
            (det.CFOP = '5402') OR 
            (det.CFOP = '5403') OR 
            (det.CFOP = '5405') OR 
            (det.CFOP = '5551') OR 
            (det.CFOP = '5651') OR 
            (det.CFOP = '5652') OR 
            (det.CFOP = '5653') OR 
            (det.CFOP = '5654') OR 
            (det.CFOP = '5655') OR 
            (det.CFOP = '5656') OR 
            (det.CFOP = '6100') OR 
            (det.CFOP = '6101') OR 
            (det.CFOP = '6102') OR 
            (det.CFOP = '6103') OR 
            (det.CFOP = '6104') OR 
            (det.CFOP = '6105') OR 
            (det.CFOP = '6106') OR 
            (det.CFOP = '6107') OR 
            (det.CFOP = '6108') OR 
            (det.CFOP = '6109') OR 
            (det.CFOP = '6110') OR 
            (det.CFOP = '6111') OR 
            (det.CFOP = '6112') OR 
            (det.CFOP = '6113') OR 
            (det.CFOP = '6114') OR 
            (det.CFOP = '6115') OR 
            (det.CFOP = '6116') OR 
            (det.CFOP = '6117') OR 
            (det.CFOP = '6118') OR 
            (det.CFOP = '6119') OR 
            (det.CFOP = '6120') OR 
            (det.CFOP = '6122') OR 
            (det.CFOP = '6123') OR 
            (det.CFOP = '6250') OR 
            (det.CFOP = '6251') OR 
            (det.CFOP = '6252') OR 
            (det.CFOP = '6253') OR 
            (det.CFOP = '6254') OR 
            (det.CFOP = '6255') OR 
            (det.CFOP = '6256') OR 
            (det.CFOP = '6257') OR 
            (det.CFOP = '6258') OR 
            (det.CFOP = '6401') OR 
            (det.CFOP = '6402') OR 
            (det.CFOP = '6403') OR 
            (det.CFOP = '6404') OR 
            (det.CFOP = '6551') OR 
            (det.CFOP = '6651') OR 
            (det.CFOP = '6652') OR 
            (det.CFOP = '6653') OR 
            (det.CFOP = '6654') OR 
            (det.CFOP = '6655') OR 
            (det.CFOP = '6656') OR 
            (det.CFOP = '7100') OR 
            (det.CFOP = '7101') OR 
            (det.CFOP = '7102') OR 
            (det.CFOP = '7105') OR 
            (det.CFOP = '7106') OR 
            (det.CFOP = '7127') OR 
            (det.CFOP = '7250') OR 
            (det.CFOP = '7251') OR 
            (det.CFOP = '7551') OR 
            (det.CFOP = '7651') OR 
            (det.CFOP = '7654') )
GROUP BY cli.cnpj_cpf,det.cod_empresa,det.local,det.material

SELECT tabela.cnpj_cpf,tabela.cod_empresa,tabela.local,tabela.operacao,tabela.material,tabela.primeira,tabela.qtd, entrada.saldo,entrada.dtlanc FROM 
(
SELECT cli.cnpj_cpf ,det.cod_empresa,det.local,det.operacao,det.material,sum(det.qtd) as qtd,min(det.dtnf) as primeira
FROM   nfe_det_e det
inner  join clientes cli on cli.cod_empresa = det.cod_empresa and cli.local = det.local
WHERE  det.id_grupo = 1 and to_char(det.dtnf,'YYYY') = '2019'  and det.operacao = 'V'
GROUP BY cli.cnpj_cpf,det.cod_empresa,det.local,det.operacao,det.material 
) AS TABELA
INNER  JOIN nfe_det_e entrada on entrada.id_grupo = 1 and ( entrada.operacao = 'E' or entrada.operacao = 'A' ) and entrada.cod_empresa = tabela.cod_empresa and entrada.local = tabela.local and entrada.material = tabela.material and entrada.dtlanc <= '2018-12-31'



//Lista de produtos do saldos
SELECT cli.cnpj_cpf ,det.cod_empresa,det.local,det.operacao,det.material,sum(det.qtd) as qtd,min(det.dtnf) as primeira
FROM   nfe_det_e det
inner  join clientes cli on cli.cod_empresa = det.cod_empresa and cli.local = det.local
WHERE  det.id_grupo = 1 and to_char(det.dtlanc,'YYYY') = '2018'  and det.operacao = 'A' and det.cod_empresa = '1003' and 
(
  (det.material = '1009005' ) or 
  (det.material = '1009007' ) or
  (det.material = '1029343' ) or
  (det.material = '1029345' ) or 
  (det.material = '1081420' ) or
  (det.material = '1088277' ) or
  (det.material = '1089783' ) or
  (det.material = '1093448' ) or
  (det.material = '1093451' ) or
  (det.material = '1093455' ) or
  (det.material = '1107001' ) 
)
GROUP BY cli.cnpj_cpf,det.cod_empresa,det.local,det.operacao,det.material 


SELECT DET.STATUS,COUNT(*)
FROM nfe_det_e DET
WHERE det.id_grupo = 1 and to_char(det.dtlanc,'YYYY') = '2020' and det.operacao = 'V'
GROUP BY DET.STATUS

//

SELECT TO_CHAR(DTMF,'YYYY') AS ANO 
FROM 

//Aglutina por cnpj, empresa,  



SELECT * FROM CLIENTES WHERE cod_empresa = '1001' and local = '0003'


select cli.cnpj_cpf,det.empresa,det.local,det.material,det.descricao
from   nfe_det_e det
inner  join clientes cli on cli.cod_empresa = det.empresa and cli.local = det.local
where  det.id = 21

SELECT * FROM nfe_cab_e
GO
SELECT id_grupo FROM nfe_det_e where (operacao = 'E' or operacao = 'A') and dtlanc <= '2019-12-16'  group by id_grupo
GO

SELECT * FROM NFE_DET_E ORDER BY ID_GRUPO,ID,NRO_LINHA

update nfe_det_e set id_grupo = 1 

delete from  clientes
go

--DELETE FROM nfe_cab_e
--GO
--DELETE FROM nfe_det_e
--GO

SELECT * FROM CLIENTES 

SELECT TO_CHAR(DTNF,'YYYY') AS ANO,COUNT(*) FROM NFE_DET_E WHERE TO_CHAR(DTNF,'YYYY') = '2020' AND OPERACAO = 'V' AND STATUS = '0' GROUP BY TO_CHAR(DTNF,'YYYY')

SELECT TO_CHAR(DTNF,'YYYY') AS ANO,COUNT(*) FROM NFE_DET_E WHERE OPERACAO = 'E' GROUP BY TO_CHAR(DTNF,'YYYY')

SELECT * FROM NFE_DET_E WHERE TO_CHAR(DTNF,'YYYY') = '2020' AND OPERACAO = 'V' and status =  


SELECT * FROM controle_e

select id_e,nro_linha_e,count(*)
from controle_e
group by id_e,nro_linha_e

//Notas de entrada
select con.qtd_e,det.*
from nfe_det_e det
inner join controle_e con on con.id_e = det.id and con.nro_linha_e = det.nro_linha
order by con.id_e,con.nro_linha_e

//saida x entrada
select con.qtd_s,con.qtd_e,det.*
from nfe_det_e det
inner join controle_e con on con.id_s = det.id and con.nro_linha_s = det.nro_linha
order by con.id_s,con.nro_linha_s


select to_char(dtnf,'YYYY'),count(*) 
from nfe_det_e
where to_char(dtnf,'YYYY') = '2020' and operacao = 'V' and status = '0'
group by to_char(dtnf,'YYYY')

//relatorio nota saida x nota entrada
select  ven.id_grupo             as "ven_id_grupo"
       ,cli.empresa              as "ven_empresa"
       ,to_char(ven.dtnf,'YYYY') as "ven_ano"
       ,ven.id                   as "ven_id"
       ,ven.nro_linha            as "ven_nro_linha"
       ,ven.chave                as "ven_chave"
       ,ven.cod_empresa          as "ven_cod_empresa"
       ,ven.local                as "ven_local"
       ,ven.id_planilha          as "ven_id_planilha"
       ,ven.dtlanc               as "ven_dtlanc"
       ,ven.dtnf                 as "ven_dtnf"
       ,ven.nro                  as "ven_nro"
       ,ven.serie                as "ven_serie"
       ,ven.material             as "ven_material"
       ,ven.descricao            as "ven_descricao"
       ,ven.cfop                 as "ven_cfop"
       ,ven.qtd                  as "ven_qtd"
       ,ven.vlr_contabil         as "ven_valor"
       ,ven.per_pis              as "ven_per_pis"
       ,ven.per_cof              as "ven_per_cof"
       ,ven.saldo                as "saldo_venda"
       ,ent.chave                as "ent_chave"
       ,ent.cod_empresa          as "ent_cod_empresa"
       ,ent.local                as "ent_local"
       ,ent.id_planilha          as "ent_id_planilha"
       ,ent.dtlanc               as "ent_dtlanc"
       ,ent.dtnf                 as "ent_dtnf"
       ,ent.nro                  as "ent_nro"
       ,ent.serie                as "ent_serie"
       ,ent.operacao             as "ent_operacao"
       ,ent.material             as "ent_material"
       ,ent.descricao            as "ent_descricao"
       ,ent.cfop                 as "ent_cfop"
       ,ent.qtd                  as "ent_qtd"
       ,ent.vlr_contabil         as "ent_valor"
       ,ent.saldo                as "ent_saldo"
       ,con.qtd_e                as "ent_qtd_usada"
       ,case 
          when ent.operacao = 'E' then  round((ent.vlr_contabil/ent.qtd),4) 
          else                    ent.vlr_contabil                     
        end as "calc_p_unit"
       ,case 
          when ent.operacao = 'E' then round((con.qtd_e * (round((ent.vlr_contabil/ent.qtd),4))),4) 
          else                         round((con.qtd_e *  ent.vlr_contabil),4) 
        end as "calc_base_pis"
       ,ven.per_pis
       ,case
          when ent.operacao = 'E' then round((con.qtd_e * (round((ent.vlr_contabil/ent.qtd),4)) * (ven.per_pis/100)),4)
          else                         round((con.qtd_e * ent.vlr_contabil) * (ven.per_pis/100),4)
        end  as "calc_vlr_pis"
       ,case
          when ent.operacao = 'E' then round((con.qtd_e * (round((ent.vlr_contabil/ent.qtd),4))),4)
          else                         round((con.qtd_e *  ent.vlr_contabil),4) 
       end as "calc_base_cofins"
      ,ven.per_cof 
      ,case
          when ent.operacao = 'E' then round((con.qtd_e * (round((ent.vlr_contabil/ent.qtd),4)) * (ven.per_cof/100)),4)
          else                         round((con.qtd_e * ent.vlr_contabil) * (ven.per_cof/100),4)
       end  as "calc_vlr_cofins"
from controle_e con
inner join nfe_det_e ven on ven.id = con.id_s and ven.nro_linha = con.nro_linha_s
inner join nfe_det_e ent on ent.id = con.id_e and ent.nro_linha = con.nro_linha_e
inner join clientes  cli on cli.cod_empresa = ven.cod_empresa and cli.local = ven.local
where ven.operacao = 'V' and ven.status = '1'  
order by cli.empresa,to_char(ven.dtnf,'YYYY'),ven.id,ven.nro_linha
go
//
//resumo por empresa
select to_char(ven.dtnf,'YYYY'),cli.empresa,sum(con.qtd_e) as "Qtd Usada"
from controle_e con
inner join nfe_det_e ven on ven.id = con.id_s and ven.nro_linha = con.nro_linha_s
inner join nfe_det_e ent on ent.id = con.id_e and ent.nro_linha = con.nro_linha_e
inner join clientes  cli on cli.cod_empresa = ven.cod_empresa and cli.local = ven.local
where ven.operacao = 'V' and ven.status = '1'  
group by to_char(ven.dtnf,'YYYY'),cli.empresa
order by to_char(ven.dtnf,'YYYY'),cli.empresa
go
//
SELECT id_s,nro_linha_s,count(*) 
FROM controle_e 
group by id_s,nro_linha_s


//saldo
select to_char(dtnf,'YYYY'),count(*) 
from nfe_det_e
where to_char(dtnf,'YYYY') = '2018' and operacao = 'E' 
group by to_char(dtnf,'YYYY')

select cfop
from nfe_det_e
where operacao = 'E' 
group by cfop


SELECT ent.cod_empresa,ent.local,ent.id_planilha,ent.dtlanc,ent.dtnf,ent.nro,ent.serie,ent.material,ent.descricao,ent.cfop,ent.qtd,ent.saldo    
FROM   nfe_det_e ent
WHERE  ent.operacao = 'E' and ent.saldo > 0
order by ent.id,ent.nro_linha

SELECT * FROM NFE_DET_E WHERE OPERACAO = 'A' order by id,nro_linha


update nfe_det_e set STATUS = '1' where to_char(dtnf,'YYYY') = '2019' and operacao = 'V' and status = '0'

SELECT * FROM nfe_det_e where to_char(dtnf,'YYYY') = '2020' and operacao = 'V' and status = '1'


SELECT to_char(det.dtlanc,'YYYY'),DET.STATUS,COUNT(*)
FROM     nfe_det_e DET
WHERE    det.operacao = 'V'
GROUP BY to_char(det.dtlanc,'YYYY'),DET.STATUS

SELECT to_char(det.dtlanc,'YYYY'),STATUS,COUNT(*)
FROM     nfe_det_e DET
WHERE    det.operacao = 'E' and to_char(det.dtlanc,'YYYY') = '2019'
GROUP BY to_char(det.dtlanc,'YYYY'),STATUS

SELECT det.cod_empresa,COUNT(*)
FROM     nfe_det_e DET
WHERE    det.operacao = 'V' and to_char(det.dtlanc,'YYYY') = '2019' and det.saldo <> det.qtd
GROUP BY det.cod_empresa

SELECT * FROM CLIENTES WHERE COD_EMPRESA = '1003' OR COD_EMPRESA = '1004'

SELECT COUNT(*) FROM controle_e 

SELECT * FROM nfe_det_e WHERE nro = '000019639'


select  ven.id_grupo as "ven_id_grupo" ,cli.empresa as "ven_empresa" ,to_char(ven.dtnf, 'YYYY') as "ven_ano" ,ven.id as "ven_id" ,ven.nro_linha as "ven_nro_linha" ,ven.chave as "ven_chave" ,ven.cod_empresa as "ven_cod_empresa" ,ven.local as "ven_local"  ,ven.id_planilha as "ven_id_planilha" ,ven.dtlanc as "ven_dtlanc" ,ven.dtnf as "ven_dtnf" ,ven.nro as "ven_nro" ,ven.serie as "ven_serie" ,ven.material as "ven_material" ,ven.descricao as "ven_descricao" ,ven.cfop as "ven_cfop" ,ven.qtd as "ven_qtd" ,ven.vlr_contabil as "ven_valor" ,ven.per_pis as "ven_per_pis" ,ven.per_cof as "ven_per_cof" ,ven.saldo as "saldo_venda" ,ent.chave as "ent_chave" ,ent.cod_empresa as "ent_cod_empresa" ,ent.local as "ent_local" ,ent.id_planilha as "ent_id_planilha" ,ent.dtlanc as "ent_dtlanc" ,ent.dtnf as "ent_dtnf" ,ent.nro as "ent_nro" ,ent.serie as "ent_serie" ,ent.operacao as "ent_operacao" ,ent.material as "ent_material" ,ent.descricao as "ent_descricao" ,ent.cfop as "ent_cfop" ,ent.qtd as "ent_qtd" ,ent.vlr_contabil as "ent_valor" ,ent.saldo as "ent_saldo" ,con.qtd_e as "ent_qtd_usada" ,case    when ent.operacao = 'E' then round((ent.vlr_contabil/ ent.qtd),4)    else ent.vlr_contabil  end as "calc_p_unit" ,case    when ent.operacao = 'E' then round((con.qtd_e* (round((ent.vlr_contabil/ ent.qtd),4))),4)    else round((con.qtd_e * ent.vlr_contabil), 4)  end as "calc_base_pis" ,ven.per_pis ,case    when ent.operacao = 'E' then round((con.qtd_e* (round((ent.vlr_contabil/ ent.qtd),4)) *(ven.per_pis / 100)),4)    else round((con.qtd_e * ent.vlr_contabil) * (ven.per_pis / 100), 4)  end as "calc_vlr_pis" ,case    when ent.operacao = 'E' then round((con.qtd_e* (round((ent.vlr_contabil/ ent.qtd),4))),4)    else round((con.qtd_e * ent.vlr_contabil), 4)  end as "calc_base_cofins" ,ven.per_cof ,case    when ent.operacao = 'E' then round((con.qtd_e* (round((ent.vlr_contabil/ ent.qtd),4)) *(ven.per_cof / 100)),4)    else round((con.qtd_e * ent.vlr_contabil) * (ven.per_cof / 100), 4)  end as "calc_vlr_cofins" from controle_e con inner join nfe_det_e ven on ven.id = con.id_s and ven.nro_linha = con.nro_linha_s inner join nfe_det_e ent on ent.id = con.id_e and ent.nro_linha = con.nro_linha_e inner join clientes cli on cli.cod_empresa = ven.cod_empresa and cli.local = ven.local   where  VEN.STATUS = '1'  and   VEN.OPERACAO = 'V'     LIMIT 1000 OFFSET 0 