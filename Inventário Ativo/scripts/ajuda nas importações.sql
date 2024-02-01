DELETE FROM imobilizadosinventarios
GO
INSERT INTO public.imobilizadosinventarios(id_empresa, id_filial, id_inventario, id_imobilizado, id_lanca, status, new_codigo, new_cc, user_insert, user_update) 
SELECT id_empresa, id_filial, 2, codigo, 0, 0 ,0, '',1,0
	FROM public.imobilizados
    ORDER BY CODIGO
GO

delete from public.lancamentos
go
delete from centroscustos
go
delete from grupos
go
delete from produtos
go
delete from principais
go
delete from imobilizados
go
delete from fornecedores
go
delete from nfes
go
delete from valores
go


select * from centroscustos
go
select * from grupos
go
select * from produtos
go
select * from principais
go
select * from imobilizados
go
select * from fornecedores
go
select * from nfes order by id_imobilizado
go
select * from valores
go



select 'centroscustos' AS tabela, count(*) as total from centroscustos union all
select 'grupo' AS tabela, count(*) as total from grupos union all
select 'produto' AS tabela, count(*) as total from produtos union all
select 'principais' AS tabela, count(*) as total from principais union all
select 'imobilizados' AS tabela, count(*) as total from imobilizados union all
select 'nfes' AS tabela, count(*) as total from nfes union all
select 'valores' AS tabela, count(*) as total from valores 

go
select * from grupos
go
select * from produtos
go
select * from principais
go
select * from imobilizados
go
select * from nfes order by id_imobilizado
go
select * from valores
go

select * from inventarios


select 
    usu.id as id_usuario
   ,usu.razao
   ,coalesce(inv.descricao,'USUÁRIO NÃO ESTÁ NESTE INVENTÁRIO') as inventario
  ,case 
     when inv.codigo is null then 0 
     else                               inv.codigo
   end as codigo_inventario
from   usuarios usu
left   join usuariosinventarios usu_inv on usu_inv.id_empresa = usu.id_empresa and usu_inv.id_filial =  1 and usu_inv.id_inventario = 2 and usu_inv.id_usuario = usu.id
left   join inventarios inv on inv.id_empresa = usu.id_empresa and inv.id_filial = usu_inv.id_filial and inv.codigo = usu_inv.id_filial and inv.codigo = usu_inv.id_inventario 

SELECT * FROM LOCAIS

SELECT * FROM imobilizadosinventarios where id_imobilizado = 1




delete from public.lancamentos;

delete from centroscustos;

delete from grupos;

delete from produtos;

delete from principais;

delete from imobilizados;

delete from nfes;

delete from valores;


