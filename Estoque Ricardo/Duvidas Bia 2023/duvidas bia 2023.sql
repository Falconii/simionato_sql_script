//saida
SELECT * 
FROM controle_e
WHERE id_grupo =1 AND id_s = 10 AND nro_linha_s = 18045

//remanescente

SELECT coalesce(sum(qtd_e),0)
FROM controle_e
WHERE id_grupo =1 AND id_e = 1 AND id_fechamento = 3 AND nro_linha_e = 12473 
go

//entrada
SELECT *
FROM controle_e
WHERE id_grupo =1 AND id_e = 1 AND nro_linha_e = 12473 order by id_fechamento
go
//nota de entrada
select * from nfe_det_e where id = 1 and nro_linha = 12473
go


select * from grupos


copy ( select cli.empresa              as EMPRESA,to_char(ven.dtnf, 'YYYY') as ANO ,ven.id                    as ID ,ven.nro_linha             as NRO_LINHA,'=' || '"' || ven.chave || '"'  AS chave,ven.cod_empresa AS COD_EMPRESA ,'=' || '"' || ven.local || '"'  AS local,'=' || '"' || cli.cnpj_cpf || '"'  AS cnpj,'=' || '"' || ven.id_planilha || '"'  AS ID_PLANILHA ,ven.dtlanc as DT_LANC ,ven.dtnf AS DTNF ,'=' || '"' || ven.nro || '"'  AS NRO_NF,'=' || '"' || ven.serie || '"'  AS SERIE,ven.material AS MATERIAL ,ven.descricao AS DESCRICAO ,ven.cfop AS CFOP ,TO_CHAR(ven.qtd, '999999999999D0000') AS QTD,TO_CHAR(ven.vlr_contabil, '999999999999D0000') AS VALOR_TOTAL ,TO_CHAR(ven.bas_icms, '999999999999D00') AS BASE_ICMS ,TO_CHAR(ven.bas_pis, '999999999999D00') AS BASE_PIS ,TO_CHAR(ven.per_pis, '999999D00') AS PERC_PIS ,TO_CHAR(ven.vlr_pis, '999999D00') AS VLR_PIS ,TO_CHAR(ven.bas_cof, '999999999999D00') AS BASE_COF ,TO_CHAR(ven.per_cof, '999999D00') AS PERC_COFINS ,TO_CHAR(ven.vlr_cof, '999999D00') AS VLR_COF ,TO_CHAR(ven.saldo, '999999999999D0000') AS SALDO_VENDA ,'=' || '"' || ent.chave || '"'  AS chave, ent.cod_empresa ,ent.local ,'=' || '"' || ven.id_planilha || '"'  AS ID_PLANILHA ,ent.dtlanc ,ent.dtnf ,TO_CHAR(AGE('2023-04-06',ent.dtnf), 'YY "ANO(S)" MM "MES(S)" DD "DIA(S)"')  AS idade,'=' || '"' || ent.nro || '"'  AS NRO_NF,'=' || '"' || ent.serie || '"'  AS SERIE,case         when ent.operacao = 'E' then 'ENTRADA'        else 'SALDO ANTERIOR'  end as OPERACAO ,ent.material ,ent.descricao ,ent.cfop ,TO_CHAR(ent.qtd, '999999999999D0000') AS QTD,case         when ent.operacao = 'E' then  TO_CHAR((SELECT coalesce(sum(qtd_e),0) FROM controle_e con_sld WHERE con_sld.id_grupo = 1  AND con_sld.id_e = con.id_e AND con_sld.id_fechamento <> fec.id AND con_sld.nro_linha_e = con.nro_linha_e ) , '999999999999D0000')       else TO_CHAR(ent.qtd-ent.sobra, '999999999999D0000')  end as QTD_REMANESCENTE ,TO_CHAR(ent.vlr_contabil, '999999999999D0000') AS VALOR_TOTAL ,TO_CHAR(ent.bas_icms, '999999999999D00') AS BASE_ICMS ,TO_CHAR(ent.saldo, '999999999999D0000') AS SALDO_ENTRADA ,TO_CHAR(con.qtd_e, '999999999999D0000') AS QTD_USADA ,case         when ent.operacao = 'E' then TO_CHAR(round((ent.bas_icms / ent.qtd), 4), '999999999999D0000')          else TO_CHAR(ent.vlr_unit, '999999999999D0000')  end as P_Unit ,case     when ent.operacao = 'E' then TO_CHAR(round((con.qtd_e* (round((ent.bas_icms/ ent.qtd),4))),4), '999999999999D0000')      else TO_CHAR(round((con.qtd_e * ent.vlr_unit), 4), '999999999999D0000')   end as BASE_PIS ,TO_CHAR(ven.per_pis, '999999999999D0000') AS PER_PIS,case     when ent.operacao = 'E' then TO_CHAR(round((con.qtd_e* (round((ent.bas_icms/ ent.qtd),4)) *(ven.per_pis / 100)),4), '999999999999D0000')      else TO_CHAR(round((con.qtd_e * ent.vlr_unit) * (ven.per_pis / 100), 4), '999999999999D0000')   end as VLR_PIS ,case     when ent.operacao = 'E' then TO_CHAR(round((con.qtd_e* (round((ent.bas_icms/ ent.qtd),4))),4), '999999999999D0000')      else TO_CHAR(round((con.qtd_e * ent.vlr_unit), 4), '999999999999D0000')   end as BASE_COFINS ,TO_CHAR(ven.per_cof, '999999999999D0000') AS PER_COFINS,case     when ent.operacao = 'E' then TO_CHAR(round((con.qtd_e* (round((ent.bas_icms/ ent.qtd),4)) *(ven.per_cof / 100)),4), '999999999999D0000')      else TO_CHAR(round((con.qtd_e * ent.vlr_unit) * (ven.per_cof / 100), 4), '999999999999D0000')   end as VLR_COFINS  from fechamento fec  inner join controle_e con  on con.id_grupo = fec.id_grupo and con.id_fechamento = fec.id  inner join nfe_det_e ven on ven.id = con.id_s and ven.nro_linha = con.nro_linha_s  inner join nfe_det_e ent on ent.id = con.id_e and ent.nro_linha = con.nro_linha_e  inner join clientes cli on cli.cod_empresa = ven.cod_empresa and cli.local = ven.local   where  FEC.ID_GRUPO = 1  and  FEC.STATUS = '1'  and  FEC.ID IN (000003)   order by cli.empresa,to_char(ven.dtnf,'YYYY'),ven.id,ven.nro_linha,ent.operacao,ent.serie,ent.nro  ) To 'C:\TRADE\RELATORIO.csv' With CSV DELIMITER ';' HEADER; 