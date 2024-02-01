CREATE OR REPLACE FUNCTION public.incluir_nfe_valores_ipi_cpco_cpce(plan_id integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE

 tempo record;

 P1_Data           date;
 vlr_ipi           numeric(15,4);
 vlr_ipi_corrigido numeric(15,4);

 taxa numeric(6,2);

 Comentarios boolean;  


BEGIN

        P1_Data = TO_DATE('2011-12-15','YYYY-MM-DD');

        Comentarios = FALSE;  

        FOR tempo in  SELECT DET.*
                      FROM   NFE_DET DET
                      INNER JOIN NFE_DET_COMP COMP ON COMP.ID = DET.ID AND COMP.NRO_LINHA = DET.NRO_LINHA
                      WHERE det.id = plan_id  and det.dtnf >= '2011-12-15' and (det.cfop = '5910' or det.cfop = '6910')  and det.vlr_ipi > 0 and comp.bebida = 'S' order by det.id,det.nro_linha

            LOOP

               taxa = (SELECT get_selic as tax FROM get_selic( cast( to_char(tempo.dtnf, 'YYYY') AS INT4), cast (to_char(tempo.dtnf, 'MM') AS INT4),2022,08) );

               vlr_ipi           = tempo.vlr_ipi;
               vlr_ipi_corrigido = vlr_ipi  * ( (taxa / 100) + 1);

               IF (Comentarios) THEN 
                        RAISE NOTICE '-----------------------------------------------------';
                        RAISE NOTICE 'NRO % SERIE % VLR IPI % CFOP % TAXA %',tempo.nro,tempo.serie,tempo.vlr_ipi,tempo.cfop,taxa;
                        RAISE NOTICE '-----------------------------------------------------';
                        RAISE NOTICE '';
               END IF;            

               IF (NOT(Comentarios)) THEN
                      INSERT INTO nfe_valores_ipi(id
                                      , nro_linha
                                      , dtnfe
                                      , dtcredito
                                      , dtfcorrecao
                                      , vlr_ipi
                                      , vlr_ipi_corrigido
                                      , taxa
                                      , usuarioinclusao
                                      , usuarioatualizacao) 
                     VALUES(tempo.id,tempo.Nro_Linha, tempo.dtnf, '2022-08-04', '2022-08-04', vlr_ipi,vlr_ipi_corrigido,Taxa, 1, 1);
                
               END IF;

            END LOOP;

END;
$BODY$;
GO

--DELETE FROM nfe_valores_ipi where id = 190 and nro_linha = 1482;

SELECT * FROM incluir_nfe_valores_ipi_cpco_cpce(1680)



 SELECT DET.*,VAL.*
                      FROM   NFE_DET DET
                      INNER JOIN NFE_DET_COMP COMP ON COMP.ID = DET.ID AND COMP.NRO_LINHA = DET.NRO_LINHA
                      INNER JOIN nfe_valores_ipi VAL ON DET.ID = VAL.ID AND DET.NRO_LINHA = VAL.NRO_LINHA 
                      WHERE det.id = 190  and det.dtnf >= '2011-12-15' and (det.cfop = '5910' or det.cfop = '6910')  and det.vlr_ipi > 0  order by det.id,det.nro_linha


select * from nfe_valores_ipi where id = 190

SELECT * FROM SELIC ORDER BY ANO,MES