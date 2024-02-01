delete from public.lancamentos;

delete from centroscustos;

delete from grupos;

delete from produtos;

delete from principais;

delete from imobilizados;

delete from nfes;

delete from valores;


select 'centroscustos' AS tabela, count(*) as total from centroscustos union all
select 'grupo' AS tabela, count(*) as total from grupos union all
select 'produto' AS tabela, count(*) as total from produtos union all
select 'principais' AS tabela, count(*) as total from principais union all
select 'imobilizados' AS tabela, count(*) as total from imobilizados union all
select 'nfes' AS tabela, count(*) as total from nfes union all
select 'valores' AS tabela, count(*) as total from valores 