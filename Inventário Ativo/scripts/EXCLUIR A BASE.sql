/*
DELETE FROM public.centroscustos;
DELETE FROM public.draft;
DELETE FROM public.empresas;
DELETE FROM public.fotos;
DELETE FROM public.grupos;
DELETE FROM public.gruposusuarios;
DELETE FROM public.imobilizados;
DELETE FROM public.imobilizadosinventarios;
DELETE FROM public.inventarios;
DELETE FROM public.lancamentos;
DELETE FROM public.locais;
DELETE FROM public.nfes;
DELETE FROM public.padroes;
DELETE FROM public.parametros;
DELETE FROM public.principais;
DELETE FROM public.produtos;
DELETE FROM public.usuarios;
DELETE FROM public.usuariosinventarios;
DELETE FROM public.valores;
*/

select id_pasta,count(*) 
from public.fotos
group by id_pasta


select * from parametros where id_usuario = 999
