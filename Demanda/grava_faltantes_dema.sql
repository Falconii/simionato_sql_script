CREATE OR REPLACE FUNCTION "public"."grava_faltantes_dema"(in _id_demanda int4, out _saida text ) 
RETURNS text
AS
$$
DECLARE
Hoje Date;

BEGIN
  
  _saida = 'OK';

  Hoje = NOW();

  DELETE FROM ACUMULADO_DATA_QTD_NF_DEMA WHERE id_demanda = _id_demanda;

  INSERT INTO ACUMULADO_DATA_QTD_NF_DEMA(
    ID_DEMANDA,
    CNPJ, 
    ANO,  
    MES,
    TOTAL_NFE
    ) SELECT TABELA.ID_DEMANDA, 
       TABELA.CNPJ,
       to_char(TABELA.dtnf,'YYYY') AS ANO, 
       to_char(TABELA.dtnf,'MM')   AS MES,
       COUNT(*)                    AS TOTAL_NFE
       FROM (
            SELECT
            PLAN.ID_DEMANDA  AS ID_DEMANDA, 
            CAB.CNPJ AS CNPJ,
            DET.DTNF AS DTNF,
            DET.SERIE AS SERIE,
            DET.NRO   AS NRO
            FROM NFE_DET DET
            INNER JOIN NFE_CAB          CAB    ON DET.ID = CAB.ID 
            INNER JOIN DEMANDA_PLANILHA PLAN   ON PLAN.ID_DEMANDA = _id_demanda AND PLAN.ID_PLANILHA = DET.ID 
            GROUP BY PLAN.ID_DEMANDA,CAB.CNPJ,DET.DTNF,DET.SERIE,DET.NRO
            ORDER BY PLAN.ID_DEMANDA,CAB.CNPJ,DET.DTNF,DET.SERIE,DET.NRO
       ) AS TABELA
    GROUP BY TABELA.ID_DEMANDA
    ,TABELA.CNPJ
    ,to_char(TABELA.dtnf,'YYYY')
    ,to_char(TABELA.dtnf,'MM') ;

     
  UPDATE demandas SET dtfaltantes = Hoje where id = _id_demanda;

END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM grava_faltantes_dema(1);
go

SELECT * FROM DEMANDAS
go

SELECT * FROM ACUMULADO_DATA_QTD_NF_DEMA

UPDATE demandas SET dtacumulado = null, dtfaltantes = null where id = 1;