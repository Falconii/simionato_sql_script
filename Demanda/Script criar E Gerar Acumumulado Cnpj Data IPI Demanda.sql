/*

*/

DROP TABLE acumulado_cnpj_data_ipi_dema;
GO

--
CREATE TABLE public.acumulado_cnpj_data_ipi_dema  (
    id_demanda          int4     NOT NULL, 
	cnpj             	char(14) NOT NULL,
	ano              	char(4) NOT NULL,
	mes              	char(2) NOT NULL,
    sistema             char(10) NOT NULL,
    produto             char(20) NOT NULL,
	origem              varchar(60) NOT NULL,
    classificacao    	varchar(50) NOT NULL,
    vlr_ipi          	numeric(15,4) NULL,
	vlr_ipi_corrigido	numeric(15,4) NULL,
	PRIMARY KEY(cnpj,ano,mes,sistema,produto,origem,classificacao)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO


INSERT INTO 
      acumulado_cnpj_data_ipi_dema(
        id_demanda,
        cnpj, 
        ano, 
        mes, 
        sistema,
        produto,
        origem,
        classificacao, 
        vlr_ipi, 
        vlr_ipi_corrigido
     )
        SELECT 
             ipi.id_demanda                 AS   ID_DEMANDA
            ,CAB.CNPJ                       AS   CNPJ  
            ,to_char(ipi.dtnfe, 'YYYY')     AS   ANO        
            ,to_char(ipi.dtnfe, 'MM')       AS   MES  
            ,CAB.SISTEMA                    AS   SISTEMA
            ,CASE 
                 WHEN VE.MATERIAL  = DET.MATERIAL              THEN 'MESMO PRODUTO'
                 WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'     THEN 'SEM VENDA'
                 ELSE                                              'OUTRO PRODUTO' 
             END AS produto
            ,cfop.descricao  as origem
            ,CASE 
                 WHEN SUBSTR(VE.DESCRICAO,1,1) = '*'        THEN 'VENDA EM OUTRA NOTA' 
                 WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'  THEN 'NAO ENCONTRADO VENDA' 
                 ELSE                                            'VENDA NA NOTA' 
             END AS classificacao
            ,SUM(ipi.vlr_ipi)               AS   VLR_IPI
            ,SUM(ipi.vlr_ipi_corrigido)     AS   VLR_IPI_CORRIGIDO
        FROM   nfe_valores_ipi_dema ipi
        INNER  JOIN nfe_cab      cab               ON cab.id = ipi.id
        INNER  JOIN nfe_det det                    ON det.id = ipi.id   AND det.nro_linha = ipi.nro_linha 
        INNER  JOIN nfe_det_nota_ve_dema ve        ON ve.id_demanda = 1 and ve.id = det.id   AND ve.nro_linha = det.nro_linha 
        INNER  JOIN nfe_det_cfop cfop              ON cfop.id = det.id  AND cfop.nro_linha = det.nro_linha
        WHERE  ipi.id_demanda = 1 
        GROUP BY 
             ipi.id_demanda                 
            ,CAB.CNPJ                         
            ,to_char(ipi.dtnfe, 'YYYY')             
            ,to_char(ipi.dtnfe, 'MM')         
            ,CAB.SISTEMA          
            ,CASE 
                 WHEN VE.MATERIAL  = DET.MATERIAL              THEN 'MESMO PRODUTO'
                 WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'     THEN 'SEM VENDA'
                 ELSE                                              'OUTRO PRODUTO' 
             END 
           ,cfop.descricao
           ,CASE 
                 WHEN SUBSTR(VE.DESCRICAO,1,1) = '*'        THEN 'VENDA EM OUTRA NOTA' 
                 WHEN VE.DESCRICAO = 'SEM VENDA DE BEBIDA'  THEN 'NAO ENCONTRADO VENDA' 
                 ELSE                                            'VENDA NA NOTA' 
            END
GO


//RELATORIO RESUMO GERAL
SELECT cli.empresa
       ,cli.razao
       ,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao,acu.vlr_ipi,acu.vlr_ipi_corrigido
  FROM   acumulado_cnpj_data_ipi_dema ACU
  LEFT   JOIN clientes cli on cli.cnpj_cpf = acu.cnpj
  WHERE ACU.ID_DEMANDA = 1
  ORDER BY cli.empresa,cli.razao,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao
  GO



//iNCLUCÃO DE 3 COLUNAS  bonificação na mesma NF  -  bonificação na mesma NF + bonificação em Outra NF - bonificação de produto diferente.

SELECT  cli.empresa
       ,cli.razao
       ,acu.cnpj
       ,acu.ano
       ,acu.mes
       ,acu.sistema
       ,acu.origem
       ,acu.vlr_ipi
       ,case
          when acu.classificacao = 'VENDA NA NOTA' then acu.vlr_ipi
          else                                     0
        end as  "IPI - Venda Na Mesma Nota"
       ,case
          when acu.classificacao = 'VENDA NA NOTA' then acu.vlr_ipi_corrigido
          else                                     0
        end as  "IPI CORRIGIDO - Venda Na Mesma Nota"
       ,case
          when acu.classificacao = 'VENDA EM OUTRA NOTA' then acu.vlr_ipi
          else                                     0
        end as  "IPI - Venda Em Outra Nota"
       ,case
          when acu.classificacao = 'VENDA EM OUTRA NOTA' then acu.vlr_ipi_corrigido
          else                                     0
        end as  "IPI CORRIGIDO - Venda Em Outra Nota"
       ,case
          when ((acu.classificacao = 'VENDA NA NOTA') OR (acu.classificacao = 'VENDA EM OUTRA NOTA')) then acu.vlr_ipi
          else                                     0
       end as  "IPI - Venda Na Mesma Nota + Venda Em Outra Nota"
      ,case
        when ((acu.classificacao = 'VENDA NA NOTA') OR (acu.classificacao = 'VENDA EM OUTRA NOTA')) then acu.vlr_ipi_corrigido
        else                                     0
      end as  "IPI CORRIGIDO - Venda Na Mesma Nota  + Venda Em Outra Nota"
     ,case
        when ((acu.produto = 'OUTRO PRODUTO')) then acu.vlr_ipi
        else                                     0
     end as  "IPI - bonificação de produto diferente"
    ,case
        when ((acu.produto = 'OUTRO PRODUTO')) then acu.vlr_ipi_corrigido
        else                                     0
    end as  "IPI CORRIGIDO - bonificação de produto diferente"
   ,case
        when ((acu.produto = 'SEM VENDA')) then acu.vlr_ipi
        else                                     0
    end as  "IPI - bonificação sem venda"
   ,case
        when ((acu.produto = 'SEM VENDA')) then acu.vlr_ipi_corrigido
        else                                     0
   end as  "IPI CORRIGIDO - bonificação sem venda"
FROM   acumulado_cnpj_data_ipi_dema ACU
LEFT   JOIN clientes cli on cli.cnpj_cpf = acu.cnpj
WHERE  acu.id_demanda = 1 and acu.origem = 'REMESSA DE BONIFICACAO'
ORDER BY cli.empresa,cli.razao,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao
GO




//SOMENTE BONIFICACAO
SELECT dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao,acu.vlr_ipi,acu.vlr_ipi_corrigido
  FROM   acumulado_cnpj_data_ipi_cppe_cpco ACU
  LEFT   JOIN depara dp on dp.cnpj = acu.cnpj
  WHERE  acu.origem = 'REMESSA DE BONIFICACAO'
  ORDER BY dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao
  GO


//TUDO DIFERENTE DE  BONIFICACAO
SELECT dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao,acu.vlr_ipi,acu.vlr_ipi_corrigido
  FROM   acumulado_cnpj_data_ipi_cppe_cpco ACU
  LEFT   JOIN depara dp on dp.cnpj = acu.cnpj
  WHERE  acu.origem <> 'REMESSA DE BONIFICACAO'
  ORDER BY dp.empresa,dp.unid,acu.cnpj,acu.ano,acu.mes,acu.sistema,acu.produto,acu.origem,acu.classificacao
  GO


SELECT * from nfe_det where id = 3 order by nro_linha