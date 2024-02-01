SELECT det.*,comp.*,ve.*,det_ven.*,comp_ven.*
FROM   nfe_det det
inner  join nfe_cab         cab        on cab.id = det.id
inner  join nfe_det_comp    comp       on comp.id = det.id and comp.nro_linha = det.nro_linha
inner  join nfe_valores_ipi val        on val.id  = det.id and val.nro_linha = det.nro_linha 
INNER  JOIN NFE_DET_NOTA_VENDA VE ON VE.ID = DET.ID    AND VE.NRO_LINHA = DET.NRO_LINHA 
inner  join nfe_det_cfop cfop on cfop.id = det.id and cfop.nro_linha = det.nro_linha 
LEFT JOIN nfe_det         det_ven on det_ven.id = ve.id     and det_ven.nro_linha = ve.nro_linha_v 
LEFT JOIN nfe_det_comp    comp_ven on comp_ven.id = det_ven.id  and comp_ven.nro_linha = det_ven.nro_linha
where  (det.id = 1160 and det.nro_linha =   23575)-- and NOT((cab.sistema = 'SAP' OR cab.sistema = 'SAP2') AND (cfop.tag = '02' OR cfop.tag = '03'))

SELECT det.*,comp.*
FROM   nfe_det det
inner  join nfe_cab         cab        on cab.id = det.id
inner  join nfe_det_comp    comp       on comp.id = det.id and comp.nro_linha = det.nro_linha
where  (det.id = 1594 and det.nro_linha = 43150)

SELECT * FROM nfe_det_cfop where cfop = '5910' and tag = '02' limit 1000

SELECT * FROM nfe_det_nota_venda WHERE id >=  1590

SELECT 

SELECT * FROM NFE_CAB order by id 

SELECT * FROM NFE_CAB where id = 1159


SELECT det.id,det.nro,det.serie,det.material,det.cfop
FROM   nfe_det det
inner  join nfe_cab         cab        on cab.id = det.id
inner  join nfe_det_comp    comp       on comp.id = det.id and comp.nro_linha = det.nro_linha
inner  join nfe_valores_ipi val        on val.id  = det.id and val.nro_linha = det.nro_linha 
WHERE det.id >=  1590  and det.empresa = '1002' 
group by det.id,det.nro,det.serie,det.material,det.cfop
order by det.id,det.nro,det.serie,det.material,det.cfop