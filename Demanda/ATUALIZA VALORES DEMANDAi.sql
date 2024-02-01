CREATE OR REPLACE FUNCTION public.atualiza_valores_ipi_dema(in id_dema int4, in id_plan int4, in ano int4, in mes int4, out _saida text) RETURNS text AS
$$
DECLARE
 tempo public.nfe_valores_ipi_dema%ROWTYPE;
 _taxa numeric(7,2);
_ano text;
_mes text;
Imposto TimeStamp;
Hoje TimeStamp;
BEGIN
   Hoje = NOW();
   _saida = 'OK';
   _ano = '';
   _mes = '';
  SELECT DTIMPOSTO FROM NFE_CAB_STATUS INTO Imposto WHERE ID_DEMANDA =id_dema AND ID = id_plan;
  IF (Imposto  is  null) THEN
     _saida = 'Não Encontrei O Arquivo De Imposto';
     return;
  end if;
  FOR tempo in  SELECT *  FROM public.nfe_valores_ipi_dema val  WHERE val.id_demanda = id_demanda and val.ID = id_plan  ORDER BY  to_char(val.dtnfe, 'YYYY'),to_char(val.dtnfe, 'MM')  
      LOOP
          IF ( _ano <> to_char(tempo.dtnfe, 'YYYY') OR _mes <>  to_char(tempo.dtnfe, 'MM')) THEN
             _ano = to_char(tempo.dtnfe, 'YYYY');
             _mes = to_char(tempo.dtnfe, 'MM');
             _taxa =  (SELECT get_selic as tax FROM get_selic( cast( to_char(tempo.DTNFE, 'YYYY') AS INT4), cast (to_char(tempo.DTNFE, 'MM') AS INT4),ano,mes) );
          END IF;
          UPDATE nfe_valores_ipi_dema SET
             taxa = _taxa,
             dtfcorrecao=Hoje, 
             vlr_ipi_corrigido    = vlr_ipi  * ( (_taxa / 100) + 1),
             usuarioatualizacao=1             
         	WHERE id_demanda = id_dema and id = tempo.id and nro_linha = tempo.nro_linha;
      END LOOP;
      Update NFE_CAB_STATUS  SET DtSelic = Hoje WHERE ID_DEMANDA =id_dema AND ID = id_plan;
END;
$$
LANGUAGE 'plpgsql'
go

SELECT atualiza_valores_ipi_dema(1,2,2022,08);
go
SELECT * FROM nfe_valores_ipi_dema
go