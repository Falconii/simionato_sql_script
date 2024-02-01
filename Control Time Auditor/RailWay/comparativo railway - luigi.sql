SELECT 'apons_execucao' 	    as tabela, count(*) as total    FROM public.apons_execucao		union all
SELECT 'apons_planejamento'  	as tabela, count(*) as total 	FROM public.apons_planejamento	union all
SELECT 'atividades' 		 	as tabela, count(*) as total    FROM public.atividades          union all
SELECT 'clientes' 			 	as tabela, count(*) as total    FROM public.clientes            union all
SELECT 'dias_uteis' 		 	as tabela, count(*) as total    FROM public.dias_uteis          union all
SELECT 'empresas' 			 	as tabela, count(*) as total    FROM public.empresas            union all
SELECT 'estruturas' 		 	as tabela, count(*) as total    FROM public.estruturas          union all
SELECT 'feriados' 			 	as tabela, count(*) as total    FROM public.feriados            union all
SELECT 'grupos_eco' 		 	as tabela, count(*) as total    FROM public.grupos_eco          union all
SELECT 'grupos_user' 		 	as tabela, count(*) as total    FROM public.grupos_user         union all
SELECT 'motivos_apo' 		 	as tabela, count(*) as total    FROM public.motivos_apo         union all
SELECT 'parametros' 		 	as tabela, count(*) as total    FROM public.parametros          union all
SELECT 'projetos' 			 	as tabela, count(*) as total    FROM public.projetos            union all
SELECT 'tickets_fechamento'  	as tabela, count(*) as total    FROM public.tickets_fechamento  union all
SELECT 'tickets_libera' 	 	as tabela, count(*) as total    FROM public.tickets_libera      union all
SELECT 'tickets_movi' 		 	as tabela, count(*) as total    FROM public.tickets_movi        union all
SELECT 'uf' 				 	as tabela, count(*) as total    FROM public.uf                  union all
SELECT 'usuarios' 			 	as tabela, count(*) as total    FROM public.usuarios            