/*
DELETE FROM imobilizadosinventarios;
delete from inventarios;
delete from lancamentos;
delete from centroscustos;
delete from grupos;
delete from produtos;
delete from principais;
delete from imobilizados;
delete from nfes;
delete from valores;
delete from fotos;
delete from padroes;
delete from locais;
*/
select * from grupos

/* Limpeza seletiva 

delete from centroscustos where id_empresa = 1 and id_filial = 16;
delete from grupos where id_empresa = 1 and id_filial = 16;
delete from produtos where id_empresa = 1 and id_filial = 16;
delete from principais where id_empresa = 1 and id_filial = 16;
delete from imobilizados where id_empresa = 1 and id_filial = 16;
delete from nfes where id_empresa = 1 and id_filial = 16;
delete from valores where id_empresa = 1 and id_filial = 16;

select * from centroscustos where id_empresa = 1 and id_filial = 16;
select * from grupos where id_empresa = 1 and id_filial = 16;
select * from  produtos where id_filial = 16;
select * from principais where id_empresa = 1 and id_filial = 16;
select * from imobilizados where id_empresa = 1 and id_filial = 16;
select * from nfes where id_empresa = 1 and id_filial = 16;
select * from valores where id_empresa = 1 and id_filial = 16;
*/
//
SELECT * 
FROM imobilizadosinventarios inv
INNER JOIN imobilizados IMO ON IMO.id_empresa = INV.id_empresa AND IMO.ID_FILIAL = id_inventario
WHERE inv.id_empresa = 1 AND inv.id_filial = 14 AND INV.id_inventario = 10 and inv.id_imobilizado < 6000 and   inv.new_codigo > 0

