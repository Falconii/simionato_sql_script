SELECT * FROM nfe_det_e where operacao in ('E','A') and qtd <> saldo order by id,nro_linha

update nfe_det_e set saldo = qtd 
where operacao in ('E','A') 
go

select * from nfe_det_e where operacao = 'V' and qtd <> saldo order by id,nro

update nfe_det_e set saldo = qtd , status = '0'
where operacao = 'V' 
go

delete from controle_e