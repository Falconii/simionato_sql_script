

INSERT INTO public.os_cab(id_empresa,entrada, saida, id_cliente, id_carro, id_cond, horas_servico, km, obs, lucro, mao_obra, mao_obra_vlr, pecas_vlr, user_insert, user_update) 
	VALUES(1, '2023-6-24', '2023-6-24', 14, 'EDT4208', 0, '08:30', 140789, 'OS REALIZADA COM SUCESSO', 120, 'TROCA DE AMORTECEDORES', 100, 100, 1, 0)
GO
INSERT INTO public.os_det(id_empresa, id_os, qtd, descricao, valor, user_insert, user_update) 
	VALUES(1, 1, 2, 'AMORTECEDOR DIANTEIRO', 800, 1, 0)
GO
INSERT INTO public.os_det(id_empresa, id_os, qtd, descricao, valor, user_insert, user_update) 
	VALUES(1, 1, 2, 'AMORTECEDOR TRAZEIRO', 1200, 1, 0)
GO
INSERT INTO public.os_det(id_empresa, id_os, qtd, descricao, valor, user_insert, user_update) 
	VALUES(1, 1, 4, 'MOLAS', 700, 1, 0)
GO



SELECT * FROM CLIENTES

UPDATE CLIENTES SET CNPJ_CPF = '02506767884'

SELECT * FROM os_car

SELECT * FROM os_cab
SELECT * FROM os_det


SELECT   CAB.ID_EMPRESA		        
        ,CAB.ID                        
        ,CAB.ENTRADA                   
        ,CAB.SAIDA                     
        ,CAB.ID_CLIENTE                
        ,CAB.ID_CARRO                  
        ,CAB.ID_COND                   
        ,CAB.HORAS_SERVICO             
        ,CAB.KM                        
        ,CAB.OBS                       
        ,CAB.LUCRO                     
        ,CAB.MAO_OBRA                  
        ,CAB.MAO_OBRA_VLR              
        ,CAB.PECAS_VLR                 
        ,CAB.USER_INSERT               
        ,CAB.USER_UPDATE               
        ,CLI.CODIGO     AS CLI_CODIGO	
        ,CLI.RAZAO      AS CLI_RAZAO	        
        ,CLI.CNPJ_CPF   AS CLI_CNPJ_CPF
        ,CLI.ENDERECOF  AS CLI_ENDERECO
        ,CLI.NROF       AS CLI_NRO            
        ,CLI.BAIRROF    AS CLI_BAIRRO
        ,CLI.CIDADEF    AS CLI_CIDADE
        ,CLI.UFF        AS CLI_UF
        ,CLI.CEPF       AS CLI_CEP
        ,CLI.EMAIL      AS CLI_EMAIL               
        ,CAR.PLACA      AS CAR_PLACA               
        ,CAR.ID_MARCA   AS CAR_ID_MARCA  
        ,CAR.MODELO     AS CAR_MODELO             
        ,CAR.COR        AS CAR_COR                 
        ,CAR.ANO        AS CAR_ANO                 
        ,COALESCE(COND.DESCRICAO,'') AS COND_DESCRICAO 
        ,MARCA.DESCRICAO AS MARCA_DESCRICAO
FROM OS_CAB CAB 
INNER JOIN CLIENTES  CLI   ON CLI.ID_EMPRESA  = CAB.ID_EMPRESA  AND CLI.CODIGO     = CAB.ID_CLIENTE  
INNER JOIN OS_CAR    CAR   ON CAR.ID_EMPRESA  = CAB.ID_EMPRESA  AND CAR.PLACA      = CAB.ID_CARRO   
INNER JOIN MARCAS    MARCA ON MARCA.ID_EMPRESA = CAR.ID_EMPRESA AND MARCA.ID       = CAR.ID_MARCA  
LEFT  JOIN CONDICOES COND ON COND.ID_EMPRESA = CAB.ID_EMPRESA  AND COND.ID     = CAB.ID_COND     
WHERE CAB.ID_EMPRESA = 1 and CAB.ID = 1




UPDATE  OS_CAB SET mao_obra =
'mao_obra = Com o objetivo de ter um hub �nico das diferentes fontes de informa��es, de forma a facilitar o acesso e permitir a gest�o e a governan�a desses ativos, a Ourofino Agroci�ncia, empresa que desenvolve solu��es focadas para a prote��o de cultivos na agricultura brasileira'




mamammama


amammamammammammam
