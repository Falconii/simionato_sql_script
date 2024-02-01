SELECT * FROM clientes
go
SELECT * FROM locais
go

SELECT * 
FROM clientes cli
INNER JOIN locais lo on lo.id_cliente = cli.codigo and lo.cod_sap = '1001'
where codigo = 3

/*
RUNCATE nfe_cab RESTART IDENTITY 
GO
RUNCATE nfe_det RESTART IDENTITY 
go
RUNCATE nfe_det_comp RESTART IDENTITY 
go
RUNCATE nfe_det_cfop RESTART IDENTITY 
go
*/

SELECT * FROM nfe_cab
go

SELECT * FROM nfe_det
go

SELECT * FROM nfe_det_comp 
go

SELECT * FROM nfe_det_cfop
go


 UPDATE NFE_CAB SET     PLANILHA                        = 'CO01 - 012020 A 062020.XLSX'      ,SISTEMA                         = 'SAP2'      ,EMPRESA                         = '1002'      ,LOCAL                           = '0001'      ,CNPJ                             = '8415791000122'      ,QTD                              =  109148185.377     ,VLR_CONTABIL                     =  666107177.51    ,BAS_ICMS                         = 326362361.23       ,VLR_ICMS                         = 48356007       ,BAS_PIS                          = 216025647.57        ,VLR_PIS                          = 5031619.21        ,BAS_COF                          = 216025647.57       ,VLR_COF                          = 23162714.42      ,BAS_IPI                          = 389725773.67       ,VLR_IPI                          = 23517058.43      ,BAS_ICMS_ST                      = 370250323.65       ,VLR_ICMS_ST                      = 66237129.17      ,NRO_LINHA                        = 41964      ,USUARIOINCLUSAO                  = 1    ,USUARIOATUALIZACAO               = 0   , DATA_CRIACAO    = '2022-09-14 04:21:43' , DATA_FECHAMENTO = '2022-09-14 04:22:47' , null , null , null , null , null , STATUS             =  1  WHERE ID = '1' 

SELECT *
FROM demandas dema
INNER  JOIN demanda_planilha plan on plan.id = dema.id 
INNER  JOIN nfe_cab          cab  on cab.id  = plan.id_planilha
INNER  
where dema.id = 1

SELECT count(*) AS TOTAL FROM ( SELECT distinct CASE    WHEN prod.cnpj IS NULL then 'I'   ELSE                        'A' END AS operacao, cli.empresa,cab.local,cab.cnpj,cab.sistema,det.material,det.descricao,det.ncm,comp.bebida FROM   demanda_planilha plan INNER JOIN nfe_det det on det.id = plan.id_planilha INNER JOIN nfe_det_comp comp on comp.id = det.id and comp.nro_linha = det.nro_linha  and comp.bebida = ''  INNER JOIN nfe_cab cab  on cab.id = det.id INNER JOIN clientes cli  on cab.cnpj = cli.cnpj_cpf LEFT JOIN produto_bebida prod on prod.cnpj = cab.cnpj and prod.sistema = cab.sistema and prod.material = det.material and prod.descricao = det.descricao and prod.ncm = det.ncm WHERE plan.id_demanda = 1 ) as tabela 

drop table produto_bebida
go
CREATE TABLE public.produto_bebida  ( 
	cnpj     	char(14) NOT NULL,
	sistema  	char(5) NOT NULL,
	material 	char(15) NOT NULL,
	descricao	varchar(100) NOT NULL,
	ncm      	char(15) NOT NULL,
	bebida   	char(1) NOT NULL,
	PRIMARY KEY(cnpj,sistema,material,descricao,ncm)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

SELECT * FROM produto_bebida 

select * from nfe_det where material = '1038378'

SELECT  CASE  WHEN CAB.dtbebida is null   THEN true   ELSE                             false  END AS OK,  dema.id_planilha,cab.empresa as cod_empresa,cli.empresa as empresa,cab.local,cab.cnpj,cab.sistema,cab.planilha,  stat.dtinicial as dtinicial, stat.dtfinal as dtfinal, null as ultimotempo, cab.dtbebida  as dt_processado 
FROM demanda_planilha dema 
inner join nfe_cab cab on cab.id = dema.id_planilha 
inner join clientes cli on cli.cnpj_cpf = cab.cnpj 
left  join estatistica  stat on stat.id_planilha = dema.id_planilha and stat.operacao = 'BEBIDA' 
where dema.id_demanda = 1 order by id_planilha 

SELECT DET.*
                      FROM   NFE_DET DET
                      INNER JOIN NFE_DET_COMP COMP ON COMP.ID = DET.ID AND COMP.NRO_LINHA = DET.NRO_LINHA
                      INNER JOIN nfe_det_cfop CFOP ON CFOP.ID = DET.ID AND CFOP.nro_linha = DET.NRO_LINHA
                      WHERE det.id = 2  and det.dtnf >= '2011-12-15' and (CFOP.cfop = '5910' or CFOP.cfop = '6910')  and det.vlr_ipi > 0 and comp.bebida = 'S' order by det.id,det.nro_linha




SELECT  DET.MATERIAL,DET.VLR_IPI,DET.CFOP,CFOP.TAG,CFOP.DESCRICAO
FROM DEMANDA_PLANILHA DEMA 
INNER JOIN NFE_CAB CAB ON CAB.ID = DEMA.ID_PLANILHA
INNER JOIN NFE_DET DET ON DET.ID = DEMA.ID_PLANILHA AND DET.ID = 2 AND DET.VLR_IPI > 0
INNER JOIN NFE_DET_CFOP CFOP ON CFOP.ID = DET.ID AND CFOP.NRO_LINHA = DET.NRO_LINHA
INNER JOIN CFOP_WORK    TRAB ON TRAB.ID_DEMANDA = DEMA.ID_DEMANDA AND TRAB.CFOP = CFOP.CFOP
INNER JOIN NFE_DET_COMP COMP ON COMP.ID = DET.ID AND COMP.NRO_LINHA = DET.NRO_LINHA AND COMP.BEBIDA = 'S'
WHERE DEMA.ID_DEMANDA = 1 AND 
NOT((CAB.SISTEMA = 'SAP' OR CAB.SISTEMA = 'SAP2') AND (CFOP.TAG = '02' OR CFOP.TAG = '03'))
ORDER BY ID_PLANILHA 

SELECT * FROM nfe_det_cfop where cfop in ('5910','6910')

SELECT DET.* FROM nfe_det DET
INNER JOIN NFE_CAB CAB ON CAB.ID = DET.ID
WHERE DET.ID = 2 AND DET.CFOP IN ('5910','6910') AND DET.vlr_ipi > 0

SELECT  det.material,det.vlr_ipi,det.cfop,cfop.tag,cfop.descricao FROM demanda_planilha dema inner join nfe_cab cab on cab.id = dema.id_planilha inner join nfe_det det on det.id = dema.id_planilha and det.id = 2 and det.vlr_ipi > 0 INNER JOIN nfe_det_cfop CFOP ON CFOP.ID = DET.ID AND CFOP.nro_linha = DET.NRO_LINHA where dema.id_demanda = 1 and  ( ( cfop.cfop = '5403')  OR ( cfop.cfop = '5910')  OR ( cfop.cfop = '6910')  )AND  NOT((cab.sistema = 'SAP' OR cab.sistema = 'SAP2') AND(cfop.tag = '02' OR cfop.tag = '03')) order by id_planilha 