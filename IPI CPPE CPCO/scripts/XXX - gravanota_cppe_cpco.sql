CREATE OR REPLACE FUNCTION public.gravanota_cppe_cpco(in _id int4 , out resp text)
AS
$$
DECLARE
 tempo public.nfe_det%ROWTYPE;
 empresa text;
 local text;
 dtnf date;
 nro text;
 serie text;
 nr_item text;
 material text;
 descricao text;
 qtd numeric(15,4);
 vlr_contabil numeric(15,4);
 bas_ipi numeric(15,2);
 per_ipi numeric(6,2);
 vlr_ipi numeric(15,2);
 sem_ven text;
 id_v int4;
 nro_linha_v int4;
 _Sistema text;
 __Lixo text;
BEGIN

  FOR tempo in  SELECT det.*  
      FROM public.nfe_det det 
      INNER JOIN nfe_cab         cab   ON cab.id = det.id
      INNER JOIN nfe_valores_ipi ipi   ON ipi.id = det.id   AND ipi.nro_linha = det.nro_linha and ipi.vlr_ipi > 0
      INNER JOIN nfe_det_cfop CFOP     ON CFOP.ID = DET.ID  AND CFOP.nro_linha = DET.NRO_LINHA 
      WHERE det.id = _id and NOT((cab.sistema = 'SAP' OR cab.sistema = 'SAP2') AND (cfop.tag = '02' OR cfop.tag = '03')) 
      LOOP
      SELECT  
            __empresa,
            __local,
            __dtnf,
            __nro,
            __serie,
            __nr_item,
            __material,
            __descricao,
            __qtd,
            __vlr_contabil,
            __bas_ipi,
            __per_ipi,
            __vlr_ipi,
            __sem_venda,
            __id_v,
            __nro_linha_v
      into    
            empresa,
            local,
            dtnf,
            nro,
            serie,
            nr_item,
            material,
            descricao,
            qtd,
            vlr_contabil,
            bas_ipi,
            per_ipi,
            vlr_ipi,
            sem_ven,
            id_v,
            nro_linha_v
      FROM    procuravenda(tempo.id,tempo.empresa,tempo.local,tempo.dtnf,tempo.nro,tempo.serie,tempo.material,tempo.nr_item) ;

      //RAISE NOTICE 'Material % Descricao %', material, descricao;
     
      INSERT INTO public.nfe_det_nota_venda(id, nro_linha,dtnf, nro, serie, nr_item, material, descricao, qtd, vlr_contabil, bas_ipi, per_ipi, vlr_ipi, sem_venda,id_v , nro_linha_v) 
      VALUES(tempo.id, tempo.nro_linha,tempo.dtnf,nro,serie, '', material, descricao, qtd, vlr_contabil,bas_ipi, per_ipi, vlr_ipi, sem_ven, id_v,nro_linha_v );


        --RAISE NOTICE 'Id % Empresa % Nro Linha % Descricao %', tempo.id,tempo.empresa, tempo.nro_linha, descricao;

      END LOOP;

      resp = 'ok';
 
END;
$$
LANGUAGE 'plpgsql'
go
