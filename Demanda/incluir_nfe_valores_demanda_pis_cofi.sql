CREATE OR REPLACE FUNCTION public.incluir_nfe_valores_demanda_pis_cof(id_dema integer,id_plan integer,ano integer, mes integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE

 tempo record;

 P1_Data                TimeStamp;
 P2_Data                TimeStamp;
 Hoje                   TimeStamp;
 _1                     numeric(15,4);
 _2                     numeric(15,4);
 _3                     numeric(15,4);
 vlr_economico_pis                  numeric(15,4);
 vlr_economico_cofins               numeric(15,4);
 vlr_economico_pis_corrigido        numeric(15,4);
 vlr_economico_cofins_corrigido     numeric(15,4);
 
taxa numeric(6,2);

 Comentarios boolean;  

 Imposto TimeStamp;


BEGIN

        Hoje = NOW();

        SELECT DTINICIAL,DTFINAL FROM demandas INTO P1_Data,P2_Data where id = id_dema;

        SELECT DTIMPOSTO FROM NFE_CAB_STATUS INTO Imposto WHERE ID_DEMANDA =id_dema AND ID = id_plan;

        IF (Imposto is not null) THEN

              DELETE FROM nfe_valores_icms_dema WHERE ID_DEMANDA =id_dema AND ID = id_plan;

        end if;

        Comentarios = FALSE;  
       
        FOR tempo in  

            SELECT  CAB.planilha,DET.*,EXC.bas_icms_exc
            FROM DEMANDA_PLANILHA DEMA 
            INNER JOIN NFE_CAB CAB              ON CAB.ID = DEMA.ID_PLANILHA
            INNER JOIN NFE_DET DET              ON DET.ID = CAB.ID AND  (DET.DTNF >= P1_Data AND DET.DTNF <= P2_Data) AND (DET.PER_ICMS > 0) AND (DET.PER_PIS > 0 OR DET.PER_COF > 0) AND (DET.VLR_PIS > 0 OR DET.VLR_COF > 0)
            INNER JOIN CFOP_WORK    TRAB        ON TRAB.ID_DEMANDA = DEMA.ID_DEMANDA AND TRAB.CFOP = DET.CFOP
            INNER JOIN NFE_DET_BASICMSEXC EXC   ON EXC.ID = DET.ID AND EXC.NRO_LINHA = DET.NRO_LINHA  AND EXC.BAS_ICMS_EXC > 0
            WHERE DEMA.ID_DEMANDA = id_dema  AND CAB.ID = id_plan   ORDER BY DET.ID,DET.NRO_LINHA 


            LOOP

               taxa = (SELECT get_selic as tax FROM get_selic( cast( to_char(tempo.dtnf, 'YYYY') AS INT4), cast (to_char(tempo.dtnf, 'MM') AS INT4),ano,mes) );

               _1 = tempo.BAS_ICMS_EXC;

               _2 = (tempo.PER_ICMS/100);

               _3 = ROUND((_1 * _2),2);

               vlr_economico_pis     = round (_3  * (tempo.PER_PIS/100),4) ;

               vlr_economico_cofins  = round (_3  * (tempo.PER_COF/100),4) ;

               vlr_economico_pis_corrigido      = vlr_economico_pis     * ( (taxa / 100) + 1);

               vlr_economico_cofins_corrigido   = vlr_economico_cofins  * ( (taxa / 100) + 1);

               IF (Comentarios) THEN 
                        RAISE NOTICE '-----------------------------------------------------';
                        RAISE NOTICE 'NRO % SERIE % tempo.BAS_ICMS_EXC % CFOP % TAXA %',tempo.nro,tempo.serie,tempo.BAS_ICMS_EXC,tempo.cfop,taxa;
                        RAISE NOTICE '-----------------------------------------------------';
                        RAISE NOTICE '';
               END IF;            

               IF (NOT(Comentarios) AND ((vlr_economico_pis + vlr_economico_cofins) > 0 )) THEN
                      INSERT INTO nfe_valores_icms_dema(
                         id_demanda, 
                         id, 
                         nro_linha, 
                         dtnfe, 
                         dtcredito, 
                         vlr_economico_pis, 
                         vlr_outro_pis, 
                         vlr_economico_cofins, 
                         vlr_outro_cofins, 
                         dtfcorrecao, 
                         vlr_economico_pis_corrigido, 
                         vlr_outro_pis_corrigido, 
                         vlr_economico_cofins_corrigido, 
                         vlr_outro_cofins_corrigido, 
                         metodo_pis, 
                         metodo_cofins, 
                         taxa, 
                         usuarioinclusao, 
                         usuarioatualizacao) 
                     VALUES(
                         id_dema, 
                         tempo.id,
                         tempo.nro_linha, 
                         tempo.dtnf, 
                         hoje,
                         vlr_economico_pis, 
                         0,
                         vlr_economico_cofins, 
                         0,
                         hoje,
                         vlr_economico_pis_corrigido, 
                         0,
                         vlr_economico_cofins_corrigido, 
                         0,
                         '',
                         '',
                         taxa, 
                         1,
                         1
                        );
                
               END IF;

            END LOOP;

            UPDATE NFE_CAB_STATUS SET DTIMPOSTO = Hoje, DTSELIC = Hoje WHERE ID_DEMANDA = id_dema AND ID = id_plan;

END;
$BODY$;
GO

 SELECT  DET.*
            FROM DEMANDA_PLANILHA DEMA 
            INNER JOIN NFE_CAB CAB ON CAB.ID = DEMA.ID_PLANILHA
            INNER JOIN NFE_DET DET ON DET.ID = DEMA.ID_PLANILHA AND DET.ID = id_plan AND (DET.DTNF >= P1_Data AND DET.DTNF <= P2_Data) AND DET.VLR_IPI > 0
            INNER JOIN CFOP_WORK    TRAB ON TRAB.ID_DEMANDA = DEMA.ID_DEMANDA AND TRAB.CFOP = DET.CFOP
            INNER JOIN NFE_DET_BASICMSEXC EXC ON EXC.ID = DET.ID AND COMP.NRO_LINHA = DET.NRO_LINHA AND COMP.BEBIDA = 'S'
            WHERE DEMA.ID_DEMANDA = id_dema AND             ORDER BY DET.ID,DET.NRO_LINHA 





SELECT * FROM incluir_nfe_valores_demanda_pis_cof(1,1311,2023,1)
go



1680
1309
1311

SELECT 
     *
 FROM SELIC ORDER BY ANO,MES



SELECT * FROM nfe_valores_icms_dema ORDER BY ID,NRO_LINHA

SELECT * FROM DEMANDA_EMPRESA