CREATE OR REPLACE FUNCTION public.procuravenda( in _id_demanda int4, _id int4, in _empresa text, in _local text, in _dtnf date, in _nro text, in _serie text,in _material text,in _nr_item text
                                               ,out __empresa text, out __local text, out __dtnf date, out __nro text, out __serie  text, out __nr_item  text, out __material text
                                               , out __descricao text, out __qtd numeric(15,4) , out __vlr_contabil numeric(15,4),   out __bas_ipi numeric(15,2) , out __per_ipi numeric(6,2), out __vlr_ipi numeric(15,2) 
                                               , out __id_v int4, out __nro_linha_v int4, out __sem_venda text 
)
AS
$$
DECLARE


BEGIN
      //mesmo produto
      SELECT 
         det.empresa
        ,det.local
        ,det.dtnf
        ,det.nro
        ,det.serie
        ,det.nr_item
        ,det.material
        ,det.descricao 
        ,det.qtd
        ,det.vlr_contabil
        ,det.bas_ipi
        ,det.per_ipi
        ,det.vlr_ipi
        ,det.id
        ,det.nro_linha
        ,'N' as sem_venda
      INTO 
         __empresa  
        ,__local 
        ,__dtnf   
        ,__nro    
        ,__serie  
        ,__nr_item 
        ,__material 
        ,__descricao 
        ,__qtd       
        ,__vlr_contabil 
        ,__bas_ipi      
        ,__per_ipi      
        ,__vlr_ipi      
        ,__id_v         
        ,__nro_linha_v   
        ,__sem_venda    
      FROM public.nfe_det det
      inner join nfe_det_comp comp on comp.id = det.id and comp.nro_linha = det.nro_linha and comp.bebida = 'S'
      INNER JOIN CFOP_SALES   TRAB ON TRAB.ID_DEMANDA = _id_demanda AND TRAB.CFOP = DET.CFOP
      LEFT  JOIN nfe_det_nota_ve_dema VE ON VE.ID_DEMANDA = _id_demanda and VE.id_v = DET.ID AND VE.nro_linha_v = DET.NRO_LINHA 
      WHERE det.id = _id AND VE.ID IS NULL and
            det.empresa = _empresa and 
            det.local = _local and 
            det.dtnf = _dtnf and 
            det.nro = _nro and 
            det.serie = _serie and
            det.nr_item <> _nr_item and det.material = _material 
            limit 1;
      if (__empresa is not null) then 

          return;

      end if;

      // venda em outro produto
      SELECT 
        det.empresa
        ,det.local
        ,det.dtnf
        ,det.nro
        ,det.serie
        ,det.nr_item
        ,det.material
        ,'PRODUTO BONIFICADO EM VARIOS ITENS' as descricao
        ,det.qtd
        ,det.vlr_contabil
        ,det.bas_ipi
        ,det.per_ipi
        ,det.vlr_ipi
        ,det.id
        ,det.nro_linha
        ,'N' as sem_venda
      INTO 
         __empresa  
        ,__local 
        ,__dtnf   
        ,__nro    
        ,__serie  
        ,__nr_item 
        ,__material 
        ,__descricao 
        ,__qtd       
        ,__vlr_contabil 
        ,__bas_ipi      
        ,__per_ipi      
        ,__vlr_ipi      
        ,__id_v         
        ,__nro_linha_v   
        ,__sem_venda    
      FROM public.nfe_det det
      inner join nfe_det_comp comp on comp.id = det.id and comp.nro_linha = det.nro_linha and comp.bebida = 'S'
      INNER JOIN CFOP_SALES   TRAB ON TRAB.ID_DEMANDA = _id_demanda AND TRAB.CFOP = DET.CFOP
      LEFT  JOIN nfe_det_nota_ve_dema VE ON VE.ID_DEMANDA = _id_demanda AND VE.id_v = DET.ID AND VE.nro_linha_v = DET.NRO_LINHA 
      WHERE det.id = _id AND VE.ID IS NULL and
            det.empresa = _empresa and 
            det.local = _local and 
            det.dtnf = _dtnf and 
            det.nro = _nro and 
            det.serie = _serie and
            det.nr_item <> _nr_item  limit 1;
      if (__empresa is not null) then 

          return;

      end if;

      //se venda na nota
      __local := _local;
      __dtnf  := _dtnf;
      __nro   := _nro;
      __serie := _serie;
      __nr_item := ' ';
      __material := ' ';
      __descricao := 'SEM VENDA DE BEBIDA'; 
      __qtd       := 0;
      __vlr_contabil := 0;
      __bas_ipi      := 0;
      __per_ipi      := 0;
      __vlr_ipi      := 0;
      __id_v         := 0;
      __nro_linha_v  := 0;
      __sem_venda    := 'S';


END;
$$
LANGUAGE 'plpgsql'
go
