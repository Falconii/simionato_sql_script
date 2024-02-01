SELECT      estru.*
                  FROM        estruturas estru
                  where estru.id_empresa = 1 and left(estru.subconta,2) = '01' and nivel = 2  order by estru.conta,estru.subconta

//contabil
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
	select 1 as id_empresa, '02' as conta , '02' || substring(subconta,3) as subconta,  descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao 
    from estruturas estru
    where left(estru.subconta,4) = '0101' 
GO
//cabecalho
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
values (1,'02','02','AUDITORIA CONTABIL',1,7,'S','S',1,0,'1','0101')
GO

//Societária
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
	select 1 as id_empresa, '04' as conta , '04' || substring(subconta,3) as subconta,  descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao 
    from estruturas estru
    where left(estru.subconta,4) = '0103' 
GO
//cabecalho
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
values (1,'04','04','AUDITORIA SOCIETÁRIA',1,7,'S','S',1,0,'1','0101')
GO

//Financeiro
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
	select 1 as id_empresa, '05' as conta , '05' || substring(subconta,3) as subconta,  descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao 
    from estruturas estru
    where left(estru.subconta,4) = '0104' 
GO
//cabecalho
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
values (1,'05','05','AUDITORIA FINANCEIRO',1,7,'S','S',1,0,'1','0101')
GO

//RH
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
	select 1 as id_empresa, '06' as conta , '06' || substring(subconta,3) as subconta,  descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao 
    from estruturas estru
    where left(estru.subconta,4) = '0105' 
GO
//cabecalho
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
values (1,'06','06','AUDITORIA RH',1,7,'S','S',1,0,'1','0101')
GO


//Marcas
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
	select 1 as id_empresa, '07' as conta , '07' || substring(subconta,3) as subconta,  descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao 
    from estruturas estru
    where left(estru.subconta,4) = '0106' 
GO
//cabecalho
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
values (1,'07','07','AUDITORIA MARCAS',1,7,'S','S',1,0,'1','0101')
GO

//Ambientais
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
	select 1 as id_empresa, '08' as conta , '08' || substring(subconta,3) as subconta,  descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao 
    from estruturas estru
    where left(estru.subconta,4) = '0107' 
GO
//cabecalho
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
values (1,'08','08','AUDITORIA AMBIENTAL',1,7,'S','S',1,0,'1','0101')
GO


//Segurança
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
	select 1 as id_empresa, '09' as conta , '09' || substring(subconta,3) as subconta,  descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao 
    from estruturas estru
    where left(estru.subconta,4) = '0108' 
GO
//cabecalho
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
values (1,'09','09','AUDITORIA SEGURANÇA',1,7,'S','S',1,0,'1','0101')
GO


//Consumidor
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
	select 1 as id_empresa, '10' as conta , '10' || substring(subconta,3) as subconta,  descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao 
    from estruturas estru
    where left(estru.subconta,4) = '0109' 
GO
//cabecalho
INSERT INTO public.estruturas(id_empresa, conta, subconta, descricao, nivel, nivel_maxi, tipo, controle, user_insert, user_update, acao, versao) 
values (1,'10','10','AUDITORIA CONSUMIDOR',1,7,'S','S',1,0,'1','0101')
GO







SELECT * FROM estruturas ESTRU where conta = '01' and nivel = 2 order by estru.conta,estru.subconta


DELETE FROM estruturas WHERE CONTA >= '06'