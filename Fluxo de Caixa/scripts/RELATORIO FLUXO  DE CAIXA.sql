 SELECT 
       DOC.VENCIMENTO     AS DOC_VENCIMENT   		
     , DOC.DOC            AS DOC_DOC               
     , DOC.SERIE          AS DOC_SERIE             
     , DOC.PARCELA        AS DOC_PARCELA  
     , DOC.EMISSAO        AS DOC_EMISSAO          
     , DOC.CLIFOR         AS DOC_CLIFOR            
     , CASE                                        
        WHEN DOC.TIPO = 'R'  THEN CLI.RAZAO        
        WHEN DOC.TIPO = 'P'  THEN FORNE.RAZAO      
       END  AS  DOC_RAZAO    
     , CASE                                         
        WHEN DOC.TIPO = 'R' THEN CT_CLI.DESCRICAO  
        WHEN DOC.TIPO = 'P' THEN CT_FOR.DESCRICAO  
        ELSE ''                                    
       END AS _CONTA  
     , DOC.OBS            AS DOC_OBS       
     , CASE                                        
        WHEN DOC.TIPO = 'R'  THEN  0        
        WHEN DOC.TIPO = 'P'  THEN  DOC.SALDO       
       END  AS  DEBITO  
     , CASE                                        
        WHEN DOC.TIPO = 'R'  THEN  DOC.SALDO         
        WHEN DOC.TIPO = 'P'  THEN  0   
       END  AS  CREDITO    
      , 0 AS SALDO
 FROM  DOCUMENTOS DOC           
 LEFT JOIN CLIENTES     CLI   ON CLI.ID_EMPRESA = DOC.ID_EMPRESA AND CLI.CODIGO = DOC.CLIFOR        
 LEFT JOIN FORNECEDORES FORNE ON FORNE.ID_EMPRESA = DOC.ID_EMPRESA AND FORNE.CODIGO = DOC.CLIFOR    
 LEFT JOIN CONTAS CT_CLI ON CT_CLI.ID_EMPRESA = DOC.ID_EMPRESA    AND CT_CLI.CODIGO = CLI.CONTA     
 LEFT JOIN CONTAS CT_FOR ON CT_FOR.ID_EMPRESA = DOC.ID_EMPRESA    AND CT_FOR.CODIGO = FORNE.CONTA   
GO

//CALCULA SALDO
SELECT COALESCE(SUM(TABELA.CREDITO-TABELA.DEBITO),0) AS SALDO_ANTERIOR FROM
(  SELECT 
       CASE                                        
        WHEN DOC.TIPO = 'R'  THEN  0        
        WHEN DOC.TIPO = 'P'  THEN  DOC.SALDO       
       END  AS  DEBITO  
     , CASE                                        
        WHEN DOC.TIPO = 'R'  THEN  DOC.SALDO         
        WHEN DOC.TIPO = 'P'  THEN  0   
       END  AS  CREDITO  
   FROM DOCUMENTOS DOC
   WHERE DOC.VENCIMENTO < '2022-04-05'  
) AS TABELA


//Meses Ativos
SELECT TO_CHAR(VENCIMENTO,'mm/YYYY'),VENCIMENTO
FROM   DOCUMENTOS
ORDER  BY ID_EMPRESA,VENCIMENTO


//Pagar Receber
SELECT 
       DOC.VENCIMENTO     AS DOC_VENCIMENT   		
     , DOC.DOC            AS DOC_DOC               
     , DOC.SERIE          AS DOC_SERIE             
     , DOC.PARCELA        AS DOC_PARCELA  
     , DOC.EMISSAO        AS DOC_EMISSAO          
     , DOC.CLIFOR         AS DOC_CLIFOR            
     , CASE                                        
        WHEN DOC.TIPO = 'R'  THEN CLI.RAZAO        
        WHEN DOC.TIPO = 'P'  THEN FORNE.RAZAO      
       END  AS  DOC_RAZAO    
     , CASE                                         
        WHEN DOC.TIPO = 'R' THEN CT_CLI.DESCRICAO  
        WHEN DOC.TIPO = 'P' THEN CT_FOR.DESCRICAO  
        ELSE ''                                    
       END AS _CONTA  
     , DOC.OBS            AS DOC_OBS       
     , DOC.VALOR
     , DOC.ABATIMENTO
     , DOC.JUROS  
     , DOC.SALDO
 FROM  DOCUMENTOS DOC           
 LEFT JOIN CLIENTES     CLI   ON CLI.ID_EMPRESA = DOC.ID_EMPRESA AND CLI.CODIGO = DOC.CLIFOR        
 LEFT JOIN FORNECEDORES FORNE ON FORNE.ID_EMPRESA = DOC.ID_EMPRESA AND FORNE.CODIGO = DOC.CLIFOR    
 LEFT JOIN CONTAS CT_CLI ON CT_CLI.ID_EMPRESA = DOC.ID_EMPRESA    AND CT_CLI.CODIGO = CLI.CONTA     
 LEFT JOIN CONTAS CT_FOR ON CT_FOR.ID_EMPRESA = DOC.ID_EMPRESA    AND CT_FOR.CODIGO = FORNE.CONTA   
GO


 SELECT 				      doc.id              ,  doc.tipo            ,  doc.doc             ,  doc.serie           ,  doc.parcela         ,  doc.clifor          ,  case                      when doc.tipo = 'R' and doc.clifor != 999999 then cli.razao          when doc.tipo = 'P' and doc.clifor != 999999 then forne.razao          else                                              ''       end  as  razao      ,  case          when doc.tipo = 'R' then ct_cli.codigo          when doc.tipo = 'P' then ct_for.codigo          else ''       end as _Cod_Conta    ,  case          when doc.tipo = 'R' then ct_cli.descricao          when doc.tipo = 'P' then ct_for.descricao          else ''       end as _Conta    ,  doc.emissao         ,  doc.vencimento      ,  doc.valor           ,  doc.abatimento      ,  doc.juros           ,  doc.vlr_pago        ,  doc.saldo           ,  doc.obs           	FROM documentos doc LEFT  JOIN clientes     cli on cli.id_empresa = doc.id_empresa    and cli.codigo = doc.clifor LEFT  JOIN fornecedores forne  on forne.id_empresa = doc.id_empresa    and forne.codigo = doc.clifor LEFT  JOIN contas ct_cli on ct_cli.id_empresa = doc.id_empresa    and ct_cli.codigo = cli.conta  LEFT  JOIN contas ct_for on ct_for.id_empresa = doc.id_empresa    and ct_for.codigo = forne.conta    ORDER BY DOC.DOC,DOC.SERIE,DOC.PARCELA 

SELECT DOC FROM documentos ORDER BY DOC

UPDATE DOCUMENTOS SET DOC =  RIGHT('000000000' || TRIM(DOC),9)

 SELECT 				      doc.id              ,  doc.tipo            ,  doc.doc             ,  doc.serie           ,  doc.parcela         ,  doc.clifor          ,  case                      when doc.tipo = 'R' and doc.clifor != 999999 then cli.razao          when doc.tipo = 'P' and doc.clifor != 999999 then forne.razao          else                                              ''       end  as  razao      ,  case          when doc.tipo = 'R' then ct_cli.codigo          when doc.tipo = 'P' then ct_for.codigo          else ''       end as _Cod_Conta    ,  case          when doc.tipo = 'R' then ct_cli.descricao          when doc.tipo = 'P' then ct_for.descricao          else ''       end as _Conta    ,  doc.emissao         ,  doc.vencimento      ,  doc.valor           ,  doc.abatimento      ,  doc.juros           ,  doc.vlr_pago        ,  doc.saldo           ,  doc.obs           	FROM documentos doc LEFT  JOIN clientes     cli on cli.id_empresa = doc.id_empresa    and cli.codigo = doc.clifor LEFT  JOIN fornecedores forne  on forne.id_empresa = doc.id_empresa    and forne.codigo = doc.clifor LEFT  JOIN contas ct_cli on ct_cli.id_empresa = doc.id_empresa    and ct_cli.codigo = cli.conta  LEFT  JOIN contas ct_for on ct_for.id_empresa = doc.id_empresa    and ct_for.codigo = forne.conta   WHERE  AND  DOC.EMISSAO    = '2023-04-13'  ORDER BY DOC.EMISSAO,DOC.DOC,DOC.SERIE,DOC.PARCELA 

SELECT * FROM baixas
GO

SELECT COALESCE(count(*),0) AS TOTAL 
FROM   DOCUMENTOS
WHERE  ID_EMPRESA = 1 AND TIPO = 'R' AND CLIFOR = 2