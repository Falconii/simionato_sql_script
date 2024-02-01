select 
   imo_inv.status
   ,case 
      when imo_inv.status = 0  then 'Não Inventariado'
      when imo_inv.status = 1  then 'Inventariado'
      when imo_inv.status = 2  then 'Inv. Troca Código'
      when imo_inv.status = 3  then 'Inv. Troca CC'
      when imo_inv.status = 4  then 'Inv. Ambos Alterados'
      when imo_inv.status = 5  then 'Inv. Não Encontrado'
    end as status
    ,count(*) as total
from      imobilizadosinventarios imo_inv
where     id_empresa = 1 and id_filial =1 and id_inventario = 2
group by  
    imo_inv.status,
    case 
      when imo_inv.status = 0  then 'Não Inventariado'
      when imo_inv.status = 1  then 'Inventariado'
      when imo_inv.status = 2  then 'Inv. Troca Código'
      when imo_inv.status = 3  then 'Inv. Troca CC'
      when imo_inv.status = 4  then 'Inv. Ambos Alterados'
      when imo_inv.status = 5  then 'Inv. Não Encontrado'
    end
order by  imo_inv.status

select * from parametros