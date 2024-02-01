CREATE OR REPLACE FUNCTION "public"."atualiza_status_dema"(in _id_demanda int4, out _saida text ) 
RETURNS text
AS
$$
DECLARE
tempo public.nfe_cab_status%ROWTYPE;
_dema_calculo      TimeStamp;
_dema_dtbebida     TimeStamp;
_dema_dtcalculo    TimeStamp;
_dema_dtnfvenda1   TimeStamp;
_dema_dtnfvenda2   TimeStamp;

BEGIN
    _saida = 'OK';
    _dema_calculo      = now();
    _dema_dtbebida     = now();
    _dema_dtcalculo    = now();
    _dema_dtnfvenda1   = now();
    _dema_dtnfvenda2   = now();
   FOR tempo in  
      SELECT CAB.*
      FROM        NFE_CAB_STATUS CAB
      INNER JOIN  DEMANDA_PLANILHA DEMA ON DEMA.ID_DEMANDA = 1 AND CAB.ID = DEMA.ID_PLANILHA
      ORDER BY CAB.ID
      LOOP      
          IF (tempo.dtbebida is null) THEN
             _dema_dtbebida = null;
          END IF;
          IF (tempo.dtimposto is null) THEN
             _dema_dtcalculo = null;
          END IF;
          IF (tempo.dtvenda is null) THEN
              _dema_dtnfvenda1 = null;
          END IF;
         IF (tempo.dtvendames is null) THEN
             _dema_dtnfvenda2 = null;
          END IF;
      END LOOP;
   UPDATE demandas SET dtcalculo =  _dema_dtcalculo,  dtbebida  = _dema_dtbebida,  dtnfvenda1 = _dema_dtnfvenda1 , dtnfvenda2 = _dema_dtnfvenda2 where id = _id_demanda;
END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM atualiza_status_dema(1);
GO


SELECT CAB.*
FROM        NFE_CAB_STATUS CAB
INNER JOIN  DEMANDA_PLANILHA DEMA ON DEMA.ID_DEMANDA = 1 AND CAB.ID = DEMA.ID_PLANILHA


SELECT CAB.*
FROM        NFE_CAB_STATUS CAB
INNER JOIN  DEMANDA_PLANILHA DEMA ON DEMA.ID_DEMANDA = 1 AND CAB.ID = DEMA.ID_PLANILHA
ORDER BY CAB.ID



SELECT DEMA.* FROM   DEMANDAS DEMA
go
SELECT * FROM   NFE_CAB_STATUS 
go

UPDATE DEMANDAS  SET dtnfvenda1 = now()

TRUNCATE nfe_det_nota_ve_dema