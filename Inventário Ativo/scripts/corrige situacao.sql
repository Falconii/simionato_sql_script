select * from lancamentos where id_empresa = 1 and id_filial = 14 and id_inventario = 10 and new_cc = ''

//corrige situacao centro custo
/*
update lancamentos 
   set new_cc = (select imobilizados.cod_cc from imobilizados
                        where imobilizados.id_empresa = lancamentos.id_empresa 
				               and imobilizados.id_filial = lancamentos.id_filial 
			                   and imobilizados.codigo = lancamentos.id_imobilizado)
where  lancamentos.id_empresa = 1 and lancamentos.id_filial = 14 and  lancamentos.id_inventario = 10 and lancamentos.new_cc = '' 

*/

select imo.codigo, imo.cod_cc, lan.new_cc, lan.dtlanca, lan.estado
from lancamentos lan
inner join imobilizados imo  on imo.id_empresa = lan.id_empresa 
				               and imo.id_filial = lan.id_filial 
			                   and imo.codigo = lan.id_imobilizado
							   and imo.cod_cc = lan.new_cc
where  lan.id_empresa = 1 and lan.id_filial = 14  and lan.id_inventario = 10 and NOT(lan.estado = 4 or lan.estado = 2)
order by lan.dtlanca


//Corrige situacao

select lancamentos.id_imobilizado,  lancamentos.dtlanca, lancamentos.estado
from lancamentos 
where lancamentos.id_empresa = 1 and lancamentos.id_filial = 14  and lancamentos.id_inventario = 10 and 
exists(select cod_cc from imobilizados 
	   where imobilizados.id_empresa = lancamentos.id_empresa  
	   and imobilizados.id_filial = lancamentos.id_filial
	   AND imobilizados.codigo =  lancamentos.id_imobilizado 
	   and imobilizados.cod_cc = lancamentos.new_cc 
	   and (lancamentos.estado <> 5  AND lancamentos.estado = 4))
/*	   
update  lancamentos 
        SET estado = 2
where lancamentos.id_empresa = 1 and lancamentos.id_filial = 14  and lancamentos.id_inventario = 10 and 
exists(select cod_cc from imobilizados 
	   where imobilizados.id_empresa = lancamentos.id_empresa  
	   and imobilizados.id_filial = lancamentos.id_filial
	   AND imobilizados.codigo =  lancamentos.id_imobilizado 
	   and imobilizados.cod_cc = lancamentos.new_cc 
	   and (lancamentos.estado <> 5  AND lancamentos.estado = 4))

	   */
	   
	   

select sum(fotos) from public.imobilizadosinventarios
where id_empresa = 1 
      and id_filial = 14 
	  and id_inventario = 10 
	   
select * 
from fotos
where id_empresa = 1 and id_local =  14 and id_inventario = 10
	   