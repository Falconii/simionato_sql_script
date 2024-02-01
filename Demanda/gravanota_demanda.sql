CREATE OR REPLACE FUNCTION public.gravanota_demanda(in _id_demanda int4, in _id int4 , out resp text)
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

Hoje TimeStamp;
Venda TimeStamp;

BEGIN

  Hoje = NOW();

  SELECT DTVENDA FROM NFE_CAB_STATUS INTO Venda WHERE ID_DEMANDA = _id_demanda AND ID = _id;

  IF (Venda is not null) THEN

     DELETE FROM nfe_det_nota_ve_dema where ID_DEMANDA = _id_demanda AND ID = _id; 

  end if;

  FOR tempo in  SELECT det.*  
      FROM public.nfe_det det  
      INNER JOIN nfe_valores_ipi_dema ipi   ON ipi.id_demanda = _id_demanda and ipi.id = det.id   AND ipi.nro_linha = det.nro_linha
      WHERE DET.ID = _id 
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
      FROM  procuravenda(_id_demanda,tempo.id,tempo.empresa,tempo.local,tempo.dtnf,tempo.nro,tempo.serie,tempo.material,tempo.nr_item) ;

      //RAISE NOTICE 'Material % Descricao %', material, descricao;
     
      INSERT INTO public.nfe_det_nota_ve_dema(id_demanda,id, nro_linha,dtnf, nro, serie, nr_item, material, descricao, qtd, vlr_contabil, bas_ipi, per_ipi, vlr_ipi, sem_venda,id_v , nro_linha_v) 
      VALUES(_id_demanda,tempo.id, tempo.nro_linha,tempo.dtnf,nro,serie, '', material, descricao, qtd, vlr_contabil,bas_ipi, per_ipi, vlr_ipi, sem_ven, id_v,nro_linha_v );


        --RAISE NOTICE 'Id % Empresa % Nro Linha % Descricao %', tempo.id,tempo.empresa, tempo.nro_linha, descricao;

      END LOOP;

      UPDATE nfe_cab_status SET dtvenda    = Hoje , dtvendames = null  WHERE ID_DEMANDA = _id_demanda and ID = _id ;

      
      resp = 'ok';
 
END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM gravanota_demanda(1,3);
GO
SELECT * FROM nfe_det_nota_venda
SELECT * FROM NFE_CAB
WHERE DET.ID = 2

SELECT  dema.id_planilha,cab.empresa as cod_empresa,cli.empresa as empresa,cab.local,cab.cnpj,cab.sistema,cab.planilha,  stat.dtinicial as dtinicial, stat.dtfinal as dtfinal, null as ultimotempo, FROM demanda_planilha dema inner join nfe_cab cab on cab.id = dema.id_planilha inner join clientes cli on cli.cnpj_cpf = cab.cnpj left  join estatistica  stat on stat.id_planilha = dema.id_planilha and stat.operacao = 'BEBIDA' where dema.id_demanda = 1 order by id_planilha 
