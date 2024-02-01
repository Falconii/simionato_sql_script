CREATE OR REPLACE FUNCTION public.incluir_nfe_valores_demanda_ipi(id_dema integer,id_plan integer,ano integer, mes integer)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE

 tempo record;

 P1_Data           TimeStamp;
 P2_Data           TimeStamp;
 Hoje              TimeStamp;
 vlr_ipi           numeric(15,4);
 vlr_ipi_corrigido numeric(15,4);

 taxa numeric(6,2);

 Comentarios boolean;  

 Imposto TimeStamp;


BEGIN

        Hoje = NOW();

        SELECT DTINICIAL,DTFINAL FROM demandas INTO P1_Data,P2_Data where id = id_dema;

        SELECT DTIMPOSTO FROM NFE_CAB_STATUS INTO Imposto WHERE ID_DEMANDA =id_dema AND ID = id_plan;

        IF (Imposto is not null) THEN

              DELETE FROM nfe_valores_ipi_dema WHERE ID_DEMANDA =id_dema AND ID = id_plan;

        end if;

        Comentarios = FALSE;  
       
        FOR tempo in  
            SELECT  DET.*
            FROM DEMANDA_PLANILHA DEMA 
            INNER JOIN NFE_CAB CAB ON CAB.ID = DEMA.ID_PLANILHA
            INNER JOIN NFE_DET DET ON DET.ID = DEMA.ID_PLANILHA AND DET.ID = id_plan AND (DET.DTNF >= P1_Data AND DET.DTNF <= P2_Data) AND DET.VLR_IPI > 0
            INNER JOIN NFE_DET_CFOP CFOP ON CFOP.ID = DET.ID AND CFOP.NRO_LINHA = DET.NRO_LINHA
            INNER JOIN CFOP_WORK    TRAB ON TRAB.ID_DEMANDA = DEMA.ID_DEMANDA AND TRAB.CFOP = CFOP.CFOP
            INNER JOIN NFE_DET_COMP COMP ON COMP.ID = DET.ID AND COMP.NRO_LINHA = DET.NRO_LINHA AND COMP.BEBIDA = 'S'
            WHERE DEMA.ID_DEMANDA = id_dema AND 
            NOT((CAB.SISTEMA = 'SAP' OR CAB.SISTEMA = 'SAP2') AND (CFOP.TAG = '02' OR CFOP.TAG = '03'))
            ORDER BY DET.ID,DET.NRO_LINHA 

            LOOP

               taxa = (SELECT get_selic as tax FROM get_selic( cast( to_char(tempo.dtnf, 'YYYY') AS INT4), cast (to_char(tempo.dtnf, 'MM') AS INT4),ano,mes) );

               vlr_ipi           = tempo.vlr_ipi;
               vlr_ipi_corrigido = vlr_ipi  * ( (taxa / 100) + 1);

               IF (Comentarios) THEN 
                        RAISE NOTICE '-----------------------------------------------------';
                        RAISE NOTICE 'NRO % SERIE % VLR IPI % CFOP % TAXA %',tempo.nro,tempo.serie,tempo.vlr_ipi,tempo.cfop,taxa;
                        RAISE NOTICE '-----------------------------------------------------';
                        RAISE NOTICE '';
               END IF;            

               IF (NOT(Comentarios)) THEN
                      INSERT INTO nfe_valores_ipi_dema(id_demanda,id
                                      , nro_linha
                                      , dtnfe
                                      , dtcredito
                                      , dtfcorrecao
                                      , vlr_ipi
                                      , vlr_ipi_corrigido
                                      , taxa
                                      , usuarioinclusao
                                      , usuarioatualizacao) 
                     VALUES(id_dema,tempo.id,tempo.Nro_Linha, tempo.dtnf, Hoje, Hoje, vlr_ipi,vlr_ipi_corrigido,Taxa, 1, 1);
                
               END IF;

            END LOOP;

            UPDATE NFE_CAB_STATUS SET DTIMPOSTO = Hoje, DTSELIC = Hoje WHERE ID_DEMANDA = id_dema AND ID = id_plan;

END;
$BODY$;
GO

--DELETE FROM nfe_valores_ipi where id = 2 and nro_linha = 1482;

SELECT * FROM incluir_nfe_valores_demanda_ipi(1,2,2022,08);
GO
SELECT * FROM nfe_valores_ipi order by id
GO
SELECT * FROM nfe_cab
GO

SELECT * FROM incluir_nfe_valores_demanda_ipi(1,1,2022,9)