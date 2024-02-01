SELECT * FROM nfe_det_nota_venda WHERE ID = 1680

SELECT det.*,val.vlr_ipi,val.vlr_ipi_corrigido,ve.*,
       det_ven.nro_linha
       ,det_ven.dtnf
       ,coalesce(det_ven.nro,'')
       ,coalesce(det_ven.serie,'')
       ,coalesce(det_ven.cfop,'')
       ,coalesce(det_ven.material,'')
       ,coalesce(det_ven.descricao,'')
       ,coalesce(det_ven.qtd,0)
       ,coalesce(comp_ven.chave,'')
       ,coalesce(comp_ven.nome,'')
FROM   nfe_det DET
INNER JOIN nfe_valores_ipi val      on val.id = det.id     and val.nro_linha = det.nro_linha 
INNER JOIN nfe_det_nota_venda  ve   on ve.id = det.id      and ve.nro_linha  = det.nro_linha 
LEFT JOIN nfe_det         det_ven  on det_ven.id = ve.id     and det_ven.nro_linha = ve.nro_linha_v 
LEFT JOIN nfe_det_comp    comp_ven on comp_ven.id = det_ven.id  and comp_ven.nro_linha = det_ven.nro_linha
WHERE  DET.ID = 1680

SELECT * FROM nfe_det DET
inner join nfe_det_comp cp on cp.id = det.id and cp.nro_linha = det.nro_linha 
WHERE det.ID = 1680 and det.nro_linha = 110
ORDER BY det.NRO_LINHA