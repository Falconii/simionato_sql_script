CREATE OR REPLACE FUNCTION "public"."calculo_saldo" (in _inicial date,in _final date, in _id_grupo int, in _id_fechamento int, out _saida text) 
RETURNS text
AS
$$
DECLARE

tempo    public.nfe_det_e%ROWTYPE;

__saldo_f     numeric(15,4);


BEGIN

  FOR tempo in  
      SELECT *
      FROM NFE_DET_E DET
      WHERE  DET.id_grupo = _id_grupo  and det.operacao = 'V' and det.status = '0' and (det.dtnf >=  _inicial and  det.dtnf <= _final)  
      --and  (DET.cod_empresa = '1003' and DET.local = '0003' and DET.material = '1009007')
      --ORDER BY DET.id_grupo,DET.cod_empresa,DET.local,DET.material,DET.dtnf limit 1000
      ORDER BY DET.id_grupo,DET.cod_empresa,DET.local,DET.DTNF,DET.SERIE,DET.NRO,DET.NR_ITEM limit 1000
      LOOP      
            
             //Processando as entradas
            
             select _saldo_f from seek_entrada(tempo.id_grupo,tempo.id,tempo.nro_linha,tempo.cod_empresa,tempo.local,tempo.material,tempo.dtnf,tempo.saldo,_id_fechamento) into __saldo_f ;
            
             update nfe_det_e set saldo = __saldo_f , status = '1' where id_grupo = tempo.id_grupo and id = tempo.id and nro_linha = tempo.nro_linha;
            
      END LOOP;

     _saida = 'OK';

END;
$$
LANGUAGE 'plpgsql'
go
