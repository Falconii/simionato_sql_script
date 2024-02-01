CREATE OR REPLACE FUNCTION public.atualiza_nfe_valores_ipi(plan_id integer) RETURNS void AS
$$
DECLARE
 tempo public.nfe_valores_ipi%ROWTYPE;
 _taxa numeric(7,2);
_ano text;
_mes text;
BEGIN

   _ano = '';
   _mes = '';
      
  FOR tempo in  SELECT *  FROM public.nfe_valores_ipi val  WHERE val.ID = plan_id  ORDER BY  to_char(val.dtnfe, 'YYYY'),to_char(val.dtnfe, 'MM')  
     
      LOOP

          IF ( _ano <> to_char(tempo.dtnfe, 'YYYY') OR _mes <>  to_char(tempo.dtnfe, 'MM')) THEN

             _ano = to_char(tempo.dtnfe, 'YYYY');
             _mes = to_char(tempo.dtnfe, 'MM');
           
             _taxa =  (SELECT get_selic as tax FROM get_selic( cast( to_char(tempo.DTNFE, 'YYYY') AS INT4), cast (to_char(tempo.DTNFE, 'MM') AS INT4),2022,08) );

             RAISE NOTICE '-----------------------------------------------------';
             RAISE NOTICE 'ANO % MES % TAXA % ',_ano,_mes,_taxa;

          END IF;

          UPDATE nfe_valores_ipi SET
             taxa = _taxa,
             dtfcorrecao='2022-08-04', 
             vlr_ipi_corrigido    = vlr_ipi  * ( (_taxa / 100) + 1),
             usuarioatualizacao=1             
         	WHERE id = tempo.id and nro_linha = tempo.nro_linha;

      END LOOP;

END;

$$
LANGUAGE 'plpgsql'
go

SELECT atualiza_nfe_valores_ipi(184);


SELECT DET.ID ,COUNT(*)
FROM   NFE_DET DET
INNER JOIN nfe_valores_ipi val on val.id = det.id and val.nro_linha = det.nro_linha and val.vlr_ipi > 0
GROUP BY DET.ID
ORDER BY DET.ID

SELECT * FROM SELIC ORDER BY ANO,MES

SELECT * FROM SELIC ORDER BY ANO , MES

UPDATE SELIC SET TAXA = 1.02 WHERE ANO = '2022' AND MES = '07'
GO
UPDATE SELIC SET TAXA = 1.03 WHERE ANO = '2022' AND MES = '08'
GO

INSERT INTO SELIC VALUES('2021','12',0.77)
GO
INSERT INTO SELIC VALUES('2022','01',1)
GO