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
_last    date;
_hoje    date;

BEGIN

    _saldo_f := _saldo_s;
    _qtd     := 0;
    _hoje    := CURRENT_DATE;
    //_data    := Date '2023-01-01';
    _last    := _hoje  - interval '4 years 11 months';
    //Processando as entradas
    FOR entrada in  
       SELECT *
       FROM NFE_DET_E ENT
       WHERE  ENT.id_grupo = _id_grupo and ENT.cod_empresa = _cod_empresa and ENT.local = _local and ENT.material = _material and ( (ENT.operacao = 'E' AND ENT.vlr_cof = 0 AND ENT.saldo > 0) or (ENT.operacao = 'A' and ENT.saldo > 0)) and ( ENT.dtnf <= _data and ENT.dtnf >= _last)
       ORDER BY ENT.cod_empresa,ENT.local,ENT.material,ENT.operacao,ENT.dtnf asc
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
