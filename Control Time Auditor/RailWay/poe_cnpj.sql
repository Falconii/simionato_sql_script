UPDATE public.clientes SET cnpj_cpf = '65744138000140' WHERE ID_EMPRESA = 1 AND ID = 154;
GO
UPDATE public.clientes SET cnpj_cpf = '00565813000129' WHERE ID_EMPRESA = 1 AND ID = 6;
GO
UPDATE public.clientes SET cnpj_cpf = '54360508000200' WHERE ID_EMPRESA = 1 AND ID = 2;
GO
UPDATE public.clientes SET cnpj_cpf = '11229710000104' WHERE ID_EMPRESA = 1 AND ID = 159;
GO
UPDATE public.clientes SET cnpj_cpf = '17209577000100' WHERE ID_EMPRESA = 1 AND ID = 177;
GO
UPDATE public.clientes SET cnpj_cpf = '01509888853'    WHERE ID_EMPRESA = 1 AND ID = 13;
GO
UPDATE public.clientes SET cnpj_cpf = '46095758000151' WHERE ID_EMPRESA = 1 AND ID = 194;
GO
UPDATE public.clientes SET cnpj_cpf = '02220927000162' WHERE ID_EMPRESA = 1 AND ID = 101;
GO
UPDATE public.clientes SET cnpj_cpf = '73410326005553' WHERE ID_EMPRESA = 1 AND ID = 4;
GO
UPDATE public.clientes SET cnpj_cpf = '13394005000198' WHERE ID_EMPRESA = 1 AND ID = 147;
GO
UPDATE public.clientes SET cnpj_cpf = '03630560000118' WHERE ID_EMPRESA = 1 AND ID = 5;
GO
UPDATE public.clientes SET cnpj_cpf = '49808421000132' WHERE ID_EMPRESA = 1 AND ID = 3;
GO
UPDATE public.clientes SET cnpj_cpf = '03375200000117' WHERE ID_EMPRESA = 1 AND ID = 109;
GO
UPDATE public.clientes SET cnpj_cpf = '05066720000173' WHERE ID_EMPRESA = 1 AND ID = 196;
GO
UPDATE public.clientes SET cnpj_cpf = '67389718000192' WHERE ID_EMPRESA = 1 AND ID = 174;
GO
UPDATE public.clientes SET cnpj_cpf = '60040599000119' WHERE ID_EMPRESA = 1 AND ID = 17;
GO
UPDATE public.clientes SET cnpj_cpf = '04646199000180' WHERE ID_EMPRESA = 1 AND ID = 105;
GO
UPDATE public.clientes SET cnpj_cpf = '12707572000194' WHERE ID_EMPRESA = 1 AND ID = 172;
GO
UPDATE public.clientes SET cnpj_cpf = '46754545000194' WHERE ID_EMPRESA = 1 AND ID = 1;
GO
UPDATE public.clientes SET cnpj_cpf = '10470500000140' WHERE ID_EMPRESA = 1 AND ID = 22;
GO
UPDATE public.clientes SET cnpj_cpf = '28958321000112' WHERE ID_EMPRESA = 1 AND ID = 167;
GO
UPDATE public.clientes SET cnpj_cpf = '51051811000152' WHERE ID_EMPRESA = 1 AND ID = 122;
GO
UPDATE public.clientes SET cnpj_cpf = '51378321000165' WHERE ID_EMPRESA = 1 AND ID = 14;
GO
UPDATE public.clientes SET cnpj_cpf = '60991965000115' WHERE ID_EMPRESA = 1 AND ID = 21;
GO
UPDATE public.clientes SET cnpj_cpf = '03492692000120' WHERE ID_EMPRESA = 1 AND ID = 171;
GO
UPDATE public.clientes SET cnpj_cpf = '00762455000144' WHERE ID_EMPRESA = 1 AND ID = 32;
GO
UPDATE public.clientes SET cnpj_cpf = '63960181000118' WHERE ID_EMPRESA = 1 AND ID = 121;
GO
UPDATE public.clientes SET cnpj_cpf = '149398170000134'WHERE ID_EMPRESA = 1 AND ID = 156;
GO
UPDATE public.clientes SET cnpj_cpf = '05629653000158' WHERE ID_EMPRESA = 1 AND ID = 140;
GO
UPDATE public.clientes SET cnpj_cpf = '92832195000154' WHERE ID_EMPRESA = 1 AND ID = 33;
GO
UPDATE public.clientes SET cnpj_cpf = '08720760000138' WHERE ID_EMPRESA = 1 AND ID = 180;
GO
UPDATE public.clientes SET cnpj_cpf = '01111204000324' WHERE ID_EMPRESA = 1 AND ID = 150;
GO
UPDATE public.clientes SET cnpj_cpf = '05582402000165' WHERE ID_EMPRESA = 1 AND ID = 198;
GO
UPDATE public.clientes SET cnpj_cpf = '04600555000125' WHERE ID_EMPRESA = 1 AND ID = 40;
GO
UPDATE public.clientes SET cnpj_cpf = '43876952000186' WHERE ID_EMPRESA = 1 AND ID = 42;
GO
UPDATE public.clientes SET cnpj_cpf = '29391834000157' WHERE ID_EMPRESA = 1 AND ID = 169;
GO
UPDATE public.clientes SET cnpj_cpf = '00801509000133' WHERE ID_EMPRESA = 1 AND ID = 16;
GO
UPDATE public.clientes SET cnpj_cpf = '00314550000185' WHERE ID_EMPRESA = 1 AND ID = 132;
GO
UPDATE public.clientes SET cnpj_cpf = '07888508000117' WHERE ID_EMPRESA = 1 AND ID = 166;
GO
UPDATE public.clientes SET cnpj_cpf = '29391834000157' WHERE ID_EMPRESA = 1 AND ID = 190;
GO
UPDATE public.clientes SET cnpj_cpf = '12562457000179' WHERE ID_EMPRESA = 1 AND ID = 141;
GO
UPDATE public.clientes SET cnpj_cpf = '09220860000105' WHERE ID_EMPRESA = 1 AND ID = 176;
GO
UPDATE public.clientes SET cnpj_cpf = '73410326005553' WHERE ID_EMPRESA = 1 AND ID = 11;
GO


SELECT        proj.*,usu.razao as diretor_razao,cli.fantasi as cliente_razao,cli.gru_econo as cliente_gru_econo
                                    ,get_cor(proj.dataproj,proj.dataenc,proj.status_pl) as nivelplan
                                    ,get_cor(proj.dataproj,proj.dataenc,proj.status_ex) as nivelexec
                    FROM          projetos proj
                    INNER JOIN    usuarios usu on usu.id_empresa = proj.id_empresa and usu.id = proj.id_diretor
                    INNER JOIN    clientes cli on cli.id_empresa = proj.id_empresa and cli.id = proj.id_cliente
             where proj.id_empresa = 1  order by proj.id_empresa, proj.id