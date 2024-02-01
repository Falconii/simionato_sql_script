CREATE OR REPLACE FUNCTION "public"."get_saldo" (in tampage int4, in pag int4) RETURNS TABLE(page int4, cred numeric, deb numeric) AS
'
    BEGIN
      RETURN QUERY 
      SELECT Pag AS SALDO, SUM(DEBITO) AS DEB,SUM(CREDITO) AS CRED 
       FROM
       (
        SELECT  CASE
                   WHEN MOVI.BSEG_SHKZG = ''S'' THEN  MOVI.BSEG_DMBTR 
                   ELSE                             0
                END  AS  CREDITO
               ,CASE
                   WHEN MOVI.BSEG_SHKZG = ''H'' THEN  MOVI.BSEG_DMBTR 
                   ELSE                             0
                END  AS  DEBITO
        FROM MOVIDET MOVI
        WHERE ID = 65
        ORDER BY MOVI.bkpf_belnr,MOVI.bseg_buzei 
        LIMIT TamPage OFFSET ((Pag - 1) * TamPage)
       ) AS TABELA;

END
'
LANGUAGE 'plpgsql'