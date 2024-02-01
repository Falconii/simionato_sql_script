SELECT 
   MOVI.ID                          AS ID                        
  ,MOVI.BKPF_BUKRS                  AS CDEMPRESA                 
  ,MOVI.BKPF_BELNR                  AS NRO                       
  ,MOVI.BSEG_BUZEI                  AS SEQ                       
  ,MOVI.BKPF_BUDAT                  AS DATA                      
  ,MOVI.BSEG_HKONT                  AS CONTA             
  ,MOVI.BKPF_BKTXT AS CABECALHO                                  
  ,MOVI.BSEG_SGTXT AS HISTORICO ,                                
  CASE 
     WHEN((CC.NIVEL = '1') OR(CC.NIVEL = '4'))  AND(MOVI.BSEG_SHKZG = 'H') THEN MOVI.BSEG_DMBTR
     WHEN((CC.NIVEL = '2') OR(CC.NIVEL = '3'))  AND(MOVI.BSEG_SHKZG = 'H') THEN MOVI.BSEG_DMBTR 
  ELSE                        0 
  END AS CREDITO, 
  CASE 
    WHEN((CC.NIVEL = '2') OR(CC.NIVEL = '3'))  AND(MOVI.BSEG_SHKZG = 'S')  THEN MOVI.BSEG_DMBTR 
    WHEN((CC.NIVEL = '1') OR(CC.NIVEL = '4'))  AND(MOVI.BSEG_SHKZG = 'S')  THEN MOVI.BSEG_DMBTR 
  ELSE                        0 
  END AS DEBITO 
  ,CC.NIVEL
  ,MOVI.BSEG_SHKZG   
  ,MOVI.BSEG_DMBTR
   FROM MOVIDET MOVI                                                 
   INNER JOIN CONTACONTABIL CC ON CC.CONTA = MOVI.BSEG_HKONT
   WHERE  MOVI.ID = 20 
   AND MOVI.BKPF_BELNR  = '0100001444'   
   ORDER BY MOVI.BKPF_BUKRS  ,  MOVI.BKPF_BELNR , MOVI.BSEG_BUZEI
LIMIT 5000

SELECT tabela.cdempresa,tabela.nro,sum(credito) as credito, sum(debito) as debito from
(SELECT 
   MOVI.BKPF_BUKRS                  AS CDEMPRESA                 
  ,MOVI.BKPF_BELNR                  AS NRO               
  ,CASE 
     WHEN((CC.NIVEL = '1') OR(CC.NIVEL = '4'))  AND(MOVI.BSEG_SHKZG = 'H') THEN MOVI.BSEG_DMBTR
     WHEN((CC.NIVEL = '2') OR(CC.NIVEL = '3'))  AND(MOVI.BSEG_SHKZG = 'H') THEN MOVI.BSEG_DMBTR 
     ELSE                        0 
   END AS CREDITO 
  ,CASE 
    WHEN((CC.NIVEL = '2') OR(CC.NIVEL = '3'))  AND(MOVI.BSEG_SHKZG = 'S')  THEN MOVI.BSEG_DMBTR 
    WHEN((CC.NIVEL = '1') OR(CC.NIVEL = '4'))  AND(MOVI.BSEG_SHKZG = 'S')  THEN MOVI.BSEG_DMBTR 
    ELSE                        0 
    END AS DEBITO 
   FROM MOVIDET MOVI                                                 
   INNER JOIN CONTACONTABIL CC ON CC.CONTA = MOVI.BSEG_HKONT
   WHERE  MOVI.ID = 20  
   ORDER BY MOVI.BKPF_BUKRS  ,  MOVI.BKPF_BELNR 
 ) as tabela
   GROUP BY tabela.cdempresa,tabela.nro
   LIMIT 5000


SELECT * FROM USUARIOS ORDER BY ID