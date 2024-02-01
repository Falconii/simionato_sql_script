
SELECT * FROM public.nfe_det_e
--where id = 1 and nro_linha = 25312
LIMIT 100
GO

SELECT * 
FROM controle_e
WHERE id_grupo =1 and id_fechamento = 2 AND id_s = 8 AND nro_linha_s = 104264
LIMIT 100
       

SELECT * 
FROM controle_e
WHERE id_grupo =1 AND id_e = 1 AND nro_linha_e = 25312

/*
    25315
    25314
    25312
    25313
*/



//entradas
SELECT cli.empresa,cli.cnpj_cpf,ent.qtd,ent.saldo
FROM        nfe_det_e ent
INNER  JOIN clientes cli on cli.cod_empresa = ent.cod_empresa and cli.local = ent.local
WHERE  ent.operacao = 'E' and ent.id = 1 and ent.nro_linha = 25315
GO

//saidas
SELECT cli.empresa,cli.cnpj_cpf,con.qtd_e,saida.id,saida.nro_linha,saida.qtd,saida.saldo
FROM   controle_e con     
INNER  JOIN nfe_det_e saida on saida.id = con.id_s and saida.nro_linha = con.nro_linha_s
INNER  JOIN clientes cli on cli.cod_empresa = saida.cod_empresa and cli.local = saida.local
WHERE  con.id_e = 1 and con.nro_linha_e = 25315
GO

//BAIXAS DE UMA NF
SELECT cli.empresa,cli.cnpj_cpf,con.id_e,con.nro_linha_e,con.qtd_e,ent.id,ent.nro_linha,ent.qtd,ent.saldo,ent.*
FROM   controle_e con     
INNER  JOIN nfe_det_e ent on ent.id = con.id_s and ent.nro_linha = con.nro_linha_s
INNER  JOIN clientes cli on cli.cod_empresa = ent.cod_empresa and cli.local = ent.local
WHERE  con.id_s = 8 and con.nro_linha_s = 104393
GO
