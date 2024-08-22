//etiquetas
SELECT IMOIENV.id_imobilizado as old_codigo,IMOIENV.NEW_CODIGO as novo_codigo,IMO.DESCRICAO as descricao
FROM imobilizadosinventarios IMOIENV
INNER JOIN imobilizados IMO ON IMO.id_empresa = IMOIENV.id_empresa AND IMO.ID_FILIAL = IMOIENV.ID_FILIAL AND IMO.CODIGO = IMOIENV.id_imobilizado
WHERE IMOIENV.id_empresa = 1 AND IMOIENV.id_filial = 14 AND IMOIENV.id_inventario = 10 and IMOIENV.new_codigo > 0  and (IMOIENV.id_imobilizado < 6000 or IMOIENV.id_imobilizado > 6009) and IMOIENV.new_codigo > 0
ORDER BY IMOIENV.NEW_CODIGO


SELECT MAX(IMO.CODIGO) FROM public.imobilizados IMO WHERE IMO.id_empresa = 1 AND IMO.ID_FILIAL = 14 AND IMO.ORIGEM = 'P'

WHERE inv.id_emp


SELECT * FROM IMOBILIZADOS 
WHERE ID_EMPRESA = 1 AND ID_FILIAL = 14 AND CODIGO > 5000
ORDER BY CODIGO

//Evolução
select dtlanca,count(*)
from   lancamentos 
where id_empresa = 1 and id_filial = 14 and id_inventario = 10
group by dtlanca
order by dtlanca desc


SELECT    cc.codigo,cc.descricao,
			(SELECT COUNT(*)
			FROM imobilizadosinventarios inv
			left JOIN imobilizados IMO ON IMO.id_empresa = INV.id_empresa AND IMO.ID_FILIAL = INV.ID_FILIAL AND IMO.COD_CC = CC.CODIGO AND IMO.CODIGO = INV.id_imobilizado
			WHERE inv.id_empresa = 1 AND inv.id_filial = 14 AND INV.id_inventario = 10 and inv.id_imobilizado < 6000 
			) AS TOTAL_ATIVOS,
			(SELECT COUNT(*)
			FROM imobilizadosinventarios inv
			left JOIN imobilizados IMO ON IMO.id_empresa = INV.id_empresa AND IMO.ID_FILIAL = INV.ID_FILIAL AND IMO.COD_CC = CC.CODIGO AND IMO.CODIGO = INV.id_imobilizado AND INV.ID_LANCA > 0
			WHERE inv.id_empresa = 1 AND inv.id_filial = 14 AND INV.id_inventario = 10 and inv.id_imobilizado < 6000 
			) AS TOTAL_INVENTARIADOS
FROM      centroscustos cc
WHERE     cc.id_empresa = 1 and cc.id_filial = 14
ORDER BY  cc.descricao


SELECT IMO.COD_CC,COUNT(*)
FROM imobilizadosinventarios inv
INNER JOIN imobilizados IMO ON IMO.id_empresa = INV.id_empresa AND IMO.ID_FILIAL = INV.ID_FILIAL AND IMO.CODIGO = INV.id_imobilizado
WHERE inv.id_empresa = 1 AND inv.id_filial = 14 AND INV.id_inventario = 10 and inv.id_imobilizado < 6000 
GROUP BY IMO.COD_CC
ORDER BY IMO.COD_CC


SELECT count(*) FROM public.imobilizados IMO WHERE IMO.id_empresa = 1 AND IMO.ID_FILIAL = 14 AND IMO.codigo >= 6000

SELECT count(*) FROM imobilizadosinventarios imo WHERE IMO.id_empresa = 1 AND IMO.ID_FILIAL = 14 


SELECT *
			FROM imobilizadosinventarios inv
			left JOIN imobilizados IMO ON IMO.id_empresa = INV.id_empresa AND IMO.ID_FILIAL = INV.ID_FILIAL  AND IMO.CODIGO = INV.id_imobilizado
			WHERE inv.id_empresa = 1 AND inv.id_filial = 14 AND INV.id_inventario = 10 and inv.id_imobilizado < 6000 
			
// tem foto mas não tem lancamento

select ft.id_empresa
       ,ft.id_local
	   ,ft.id_inventario
	   ,ft.id_imobilizado
       ,lan.id_lanca
from fotos ft
left join public.lancamentos lan on 
         lan.id_empresa = ft.id_empresa 
     and lan.id_filial = ft.id_local  
	 and lan.id_inventario = ft.id_inventario 
	 and lan.id_imobilizado = ft.id_imobilizado
where ft.id_empresa = 1 AND ft.id_local = 14 AND ft.id_inventario = 10 and lan.id_lanca is null
order by ft.id_empresa,ft.id_local,ft.id_inventario,ft.id_imobilizado

select * from fotos where id_pasta ='1eQuwNcfTmpYUWUIvlGBouodico8WrjoD'

//buscar fotos duplicadas
select lan.dtlanca,imo.id_imobilizado,imo.fotos
from public.imobilizadosinventarios imo
inner join lancamentos lan 
           on     lan.id_empresa     = imo.id_empresa 
		      and lan.id_filial      = imo.id_filial 
			  and lan.id_inventario  = imo.id_inventario
			  and lan.id_imobilizado = imo.id_imobilizado
where lan.dtlanca >= '2024-08-12'-- and imo.fotos >= 3 
order by lan.dtlanca,imo.id_imobilizado,imo.fotos