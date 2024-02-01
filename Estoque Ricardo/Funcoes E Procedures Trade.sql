/*

   FUNCOES E PROCEDURE DO BANCO TRADE 19/10/2022

*/
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
      WHERE  id_grupo = _id_grupo  and det.operacao = 'V' and det.status = '0' and (det.dtnf >=  _inicial and  det.dtnf <= _final)  
      ORDER BY DET.id_grupo,DET.cod_empresa,DET.local,DET.material,DET.dtnf limit 1000
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
CREATE OR REPLACE FUNCTION "public"."seek_entrada" (
in  _id_grupo     int4,
in  _id_s         int4,
in  _nro_linha_s  int4,
in  _cod_empresa  text,
in  _local        text,
in  _material     text,
in  _data         date,
in  _saldo_s      numeric(15,4),
in  _id_fechamento int4,
out _saldo_f      numeric(15,4)
) 
RETURNS numeric(15,4)
AS
$$
DECLARE

entrada  public.nfe_det_e%ROWTYPE;
_saldo_e numeric(15,4);
_qtd     numeric(15,4);

BEGIN

    _saldo_f := _saldo_s;
    _qtd     := 0;

    //Processando as entradas
    FOR entrada in  
       SELECT *
       FROM NFE_DET_E ENT
       WHERE  ENT.id_grupo = _id_grupo and ENT.cod_empresa = _cod_empresa and ENT.local = _local and ENT.material = _material and ( (ENT.operacao = 'E' AND ENT.vlr_cof = 0 AND ENT.saldo > 0) or (ENT.operacao = 'A' and ENT.saldo > 0)) and ENT.dtlanc <= _data
       ORDER BY ENT.cod_empresa,ENT.local,ENT.material,ENT.dtlanc desc
    LOOP     
           
           //RAISE NOTICE 'ENTRADA.cod_empresa % ENTRADA.local % ENTRADA.material % ENTRADA.dtlanc % ENTRADA.qtd % ENTRADA.saldo % ENTRADA.status %', entrada.cod_empresa,entrada.local,entrada.material,entrada.dtlanc,entrada.qtd, entrada.saldo, entrada.status;

           //RAISE NOTICE '_id_grupo % _id_s  % _nro_linha_s % _cod_empresa % _local % _material  % _data  % _saldo_s % ', _id_grupo,_id_s,_nro_linha_s,_cod_empresa,_local,_material,_data,_saldo_s;

           _saldo_e := entrada.saldo;

           //Tratamento
           IF (_saldo_s >= _saldo_e) THEN

               _qtd     := _saldo_e;

               _saldo_s := _saldo_s - _saldo_e;

               _saldo_e :=  0;

           ELSE 

              _qtd      := _saldo_s;

              _saldo_e  := _saldo_e - _saldo_s;

              _saldo_s  := 0; 

           END IF;

           _saldo_f := _saldo_s;

          //Atualiza nota e

          update nfe_det_e set saldo = _saldo_e where id_grupo = entrada.id_grupo and id = entrada.id and nro_linha = entrada.nro_linha;
          
          INSERT INTO controle_e(id_grupo,id_fechamento,id_s, nro_linha_s, id_e, nro_linha_e, qtd_s, qtd_e) 	VALUES(_id_grupo,_id_fechamento,_id_s, _nro_linha_s,entrada.id , entrada.nro_linha, _saldo_f, _qtd);


          IF (_saldo_f = 0) THEN

              return;

          END IF;

    END LOOP;

END;
$$
LANGUAGE 'plpgsql'
go
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
      WHERE  id_grupo = _id_grupo  and det.operacao = 'V' and det.status = '0' and (det.dtnf >=  _inicial and  det.dtnf <= _final)  
      ORDER BY DET.id_grupo,DET.cod_empresa,DET.local,DET.material,DET.dtnf limit 1000
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
CREATE OR REPLACE FUNCTION "public"."exc_calculo_saldo" (in _id_grupo int, in _id_fechamento int, out _saida text) 
RETURNS text
AS
$$
DECLARE

tempo    public.controle_e%ROWTYPE;


BEGIN

  FOR tempo in  
      SELECT *
      FROM     controle_e
      WHERE    id_grupo = _id_grupo  and id_fechamento =  _id_fechamento
      ORDER BY id_grupo,id_fechamento,id_s,nro_linha_s
      limit 1000
      LOOP      
            
             RAISE NOTICE 'Movimento: id_grupo % id_fechamento % id_s  %  nro_linha_s  %  id_e  %  nro_linha_e  %  qtd_s  %  qtd_e % ', tempo.id_grupo,tempo.id_fechamento,tempo.id_s,tempo.nro_linha_s,tempo.id_e,tempo.nro_linha_e,tempo.qtd_s,tempo.qtd_e;  
            
             //Retorna Saida
             UPDATE NFE_DET_E set saldo = saldo + tempo.qtd_e, status = 0 WHERE ID_GRUPO = tempo.id_grupo AND ID = tempo.id_s AND NRO_LINHA = tempo.nro_linha_s;

             //Retorna Entrada
             UPDATE NFE_DET_E set saldo = saldo + tempo.qtd_e             WHERE ID_GRUPO = tempo.id_grupo AND ID = tempo.id_e AND NRO_LINHA = tempo.nro_linha_e;

             //Excluir Controle
             DELETE FROM CONTROLE_E WHERE ID_GRUPO = tempo.id_grupo and id_fechamento = tempo.id_fechamento AND   id_s = tempo.id_s   AND  nro_linha_s = tempo.nro_linha_s AND  id_e =  tempo.id_e AND  nro_linha_e =  tempo.nro_linha_e;

            
      END LOOP;

     _saida = 'OK';

END;
$$
LANGUAGE 'plpgsql'
go
