SELECT * FROM NFE_CAB where cnpj = '8415791002095' ORDER BY ID

SELECT * FROM NFE_DET WHERE ID = 1680 and cfop in ('5910','6910') and vlr_ipi > 0

SELECT * FROM nfe_det_comp WHERE ID = 1680

SELECT * FROM nfe_valores_ipi where id = 1680

SELECT * FROM nfe_det_cfop where id = 1680

SELECT det.empresa,det.local,cab.sistema,det.material,det.descricao,det.ncm,comp.bebida
FROM   nfe_det det
INNER JOIN nfe_cab cab on cab.id = det.id
INNER JOIN nfe_det_comp comp on comp.id = det.id and comp.nro_linha = det.nro_linha
WHERE  (( det.id = 1680 ) 
         ) and ((comp.bebida <> 'S') AND (comp.bebida <> 'N'))
group by det.empresa,det.local,cab.sistema,det.material,det.descricao,det.ncm
order by det.empresa,det.local,cab.sistema,det.material,det.descricao,det.ncm


SELECT * FROM gravanota_cppe_cpco(  1680     ) ;
GO
SELECT * FROM poenotavendames_cppe_cpco(  1680   ) ;
GO