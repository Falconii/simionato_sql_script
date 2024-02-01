SELECT count(*)
      FROM NFE_DET_E DET
--      INNER JOIN NFE_DET_E ENT ON ENT.id_grupo = 1 and ENT.cod_empresa = DET.cod_empresa and ENT.local = DET.local and ENT.material = DET.material and ( (ENT.operacao = 'E' AND ENT.vlr_cof = 0 AND ENT.saldo > 0) or (ENT.operacao = 'A' and ENT.saldo > 0)) and ENT.dtlanc <= DET.DTNF
      WHERE  det.id_grupo = 1  and det.operacao = 'V' and det.status = '1' and (det.dtnf >=  '2019-01-01' and  det.dtnf <= '2021-12-31') and det.saldo > 0 
      ORDER BY DET.id_grupo,DET.cod_empresa,DET.local,DET.DTNF,DET.SERIE,DET.NRO,DET.NR_ITEM 

      limit 1000

SELECT *
      FROM NFE_DET_E DET
      INNER JOIN NFE_DET_E ENT ON ENT.id_grupo = 1 and ENT.cod_empresa = DET.cod_empresa and ENT.local = DET.local and ENT.material = DET.material and ( (ENT.operacao = 'E' AND ENT.vlr_cof = 0 AND ENT.saldo > 0) or (ENT.operacao = 'A' and ENT.saldo > 0)) and ENT.dtlanc <= DET.DTNF
      WHERE  det.id_grupo = 1  and det.operacao = 'V' and det.status = '1' and (det.dtnf >=  '2019-01-01' and  det.dtnf <= '2021-12-31') and det.saldo > 0 
      ORDER BY DET.id_grupo,DET.cod_empresa,DET.local,DET.DTNF,DET.SERIE,DET.NRO,DET.NR_ITEM 


SELECT count(*)
      FROM NFE_DET_E DET
--      INNER JOIN NFE_DET_E ENT ON ENT.id_grupo = 1 and ENT.cod_empresa = DET.cod_empresa and ENT.local = DET.local and ENT.material = DET.material and ( (ENT.operacao = 'E' AND ENT.vlr_cof = 0 AND ENT.saldo > 0) or (ENT.operacao = 'A' and ENT.saldo > 0)) and ENT.dtlanc <= DET.DTNF
      WHERE  det.id_grupo = 1  and det.operacao = 'V' and det.status = '1' and (det.dtnf >=  '2019-01-01' and  det.dtnf <= '2021-12-31') and det.saldo > 0 
      ORDER BY DET.id_grupo,DET.cod_empresa,DET.local,DET.DTNF,DET.SERIE,DET.NRO,DET.NR_ITEM 



id_grupo  = 1
cod_empresa  = 1001
local        = 003
dtlanc       = 11/01/2019
material     = 1106996

//busca entrada
SELECT *
       FROM NFE_DET_E ENT
       WHERE  ENT.id_grupo = 1 and ENT.cod_empresa = '1001' and ENT.local = '003' and ENT.material = '1106996' and ( (ENT.operacao = 'E' AND ENT.vlr_cof = 0 AND ENT.saldo > 0) or (ENT.operacao = 'A' and ENT.saldo > 0)) and ENT.dtlanc <= '2019-11-01'
       ORDER BY ENT.cod_empresa,ENT.local,ENT.material,ENT.dtlanc desc


 SELECT *
      FROM NFE_DET_E DET
      WHERE  det.id_grupo = 1  and det.operacao = 'V' and det.status = '1' and (det.dtnf >=  '2019-01-01' and  det.dtnf <= '2021-12-31')
      ORDER BY DET.id_grupo,DET.cod_empresa,DET.local,DET.DTNF,DET.SERIE,DET.NRO,DET.NR_ITEM 


SELECT DET.*
      FROM   NFE_DET_E DET
      WHERE  ENT.id_grupo = 1 and ( (ENT.operacao = 'E' AND ENT.vlr_cof = 0 ) or (ENT.operacao = 'A' ) and ENT.dtlanc <= DET.DTNF



//Com Base Nas Entradas
select   
         ent.id_grupo
        ,ent.id
        ,ent.operacao
        ,ent.nro_linha
        ,ent.cod_empresa
        ,ent.local
        ,ent.id_planilha
        ,ent.dtlanc
        ,ent.dtnf
        ,ent.nro
        ,ent.serie
        ,ent.uf
        ,ent.nr_item
        ,ent.material
        ,ent.descricao
        ,ent.ncm
        ,ent.unid
        ,ent.cfop
        ,ent.cfop_texto
        ,ent.qtd
        ,con.qtd_e 
        ,'==>'  as vendas
        ,ven.qtd 
        ,ven.saldo
        ,ven.dtlanc
        ,ven.dtnf
        ,ven.nro
        ,ven.serie
        ,ven.uf
        ,ven.nr_item
        ,ven.material
        ,ven.descricao
        ,ven.cfop
        ,ven.qtd  
from     controle_e con 
inner join nfe_det_e ent on ent.id = con.id_e and ent.nro_linha = con.nro_linha_e 
inner join nfe_det_e ven on ven.id = con.id_s and ven.nro_linha = con.nro_linha_s 
inner join clientes cli on cli.cod_empresa = ven.cod_empresa and cli.local = ven.local inner join fechamento fec on fec.id_grupo = con.id_grupo and fec.id = con.id_fechamento   
where  VEN.ID_GRUPO = 1  and  con.id_fechamento = 1  and  VEN.STATUS = '1'  and   VEN.OPERACAO = 'V'     
--LIMIT 500 
--OFFSET 0 
go
//Com Base Nas Saidas
select   ven.id_grupo
        ,ven.id
        ,ven.operacao
        ,ven.nro_linha
        ,ven.cod_empresa
        ,ven.local
        ,ven.id_planilha
        ,ven.dtlanc
        ,ven.dtnf
        ,ven.nro
        ,ven.serie
        ,ven.uf
        ,ven.nr_item
        ,ven.material
        ,ven.descricao
        ,ven.qtd 
        ,ven.cfop
        ,ven.saldo
        ,'==>'  as entradas
        ,ent.qtd as qtd_entrada
        ,con.qtd_e  as qtd_usada
        ,ent.saldo
        ,ent.id_grupo
        ,ent.id
        ,ent.operacao
        ,ent.nro_linha
        ,ent.cod_empresa
        ,ent.local
        ,ent.id_planilha
        ,ent.dtlanc
        ,ent.dtnf
        ,ent.nro
        ,ent.serie
        ,ent.uf
        ,ent.nr_item
        ,ent.material
        ,ent.descricao
        ,ent.ncm
        ,ent.unid
        ,ent.cfop
        ,ent.cfop_texto
from     controle_e con 
inner join nfe_det_e ent on ent.id = con.id_e and ent.nro_linha = con.nro_linha_e 
inner join nfe_det_e ven on ven.id = con.id_s and ven.nro_linha = con.nro_linha_s 
inner join clientes cli on cli.cod_empresa = ven.cod_empresa and cli.local = ven.local inner join fechamento fec on fec.id_grupo = con.id_grupo and fec.id = con.id_fechamento   
where  VEN.ID_GRUPO = 1  and  con.id_fechamento = 1  and  VEN.STATUS = '1'  and   VEN.OPERACAO = 'V'  
order by ven.cod_empresa,ven.local,ven.serie,ven.nro,ven.nr_item  
go
--LIMIT 500 
--OFFSET 0 

select   ven.id_grupo
        ,ven.id
        ,ven.operacao
        ,ven.nro_linha
        ,ven.cod_empresa
        ,ven.local
        ,ven.id_planilha
        ,ven.dtlanc
        ,ven.dtnf
        ,ven.nro
        ,ven.serie
        ,ven.uf
        ,ven.nr_item
        ,ven.material
        ,ven.descricao
        ,ven.qtd 
        ,ven.cfop
        ,ven.saldo
from  nfe_det_e ven  
left  join controle_e con on ven.id = con.id_s and ven.nro_linha = con.nro_linha_s 
inner join clientes cli on cli.cod_empresa = ven.cod_empresa and cli.local = ven.local inner join fechamento fec on fec.id_grupo = con.id_grupo and fec.id = con.id_fechamento   
where  VEN.ID_GRUPO = 1  and  con.id_fechamento = 1  and  VEN.STATUS = '1'  and   VEN.OPERACAO = 'V'  and con.id_s is null
order by ven.cod_empresa,ven.local,ven.serie,ven.nro,ven.nr_item  
LIMIT 500 
OFFSET 0 


SELECT COUNT(*) FROM controle_e 
//148486
SELECT COUNT(*) , SUM((SELECT COUNT(*) FROM controle_e con WHERE ven.id = con.id_s and ven.nro_linha = con.nro_linha_s )) AS controle
FROM  nfe_det_e ven  
WHERE VEN.STATUS = '1'  and   VEN.OPERACAO = 'V'  
//192501

1128466        
1128465        

SELECT * FROM nfe_det_e where operacao in ('V') and nro = '000427727' 
GO
SELECT * FROM nfe_det_e where operacao in ('E','A') and nro = '000037137' AND (MATERIAL = '1128466' OR MATERIAL = '1128465')
GO