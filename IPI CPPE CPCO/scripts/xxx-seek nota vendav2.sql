CREATE OR REPLACE FUNCTION public.procuravenda(in _id int4, in _empresa text, in _local text, in _dtnf date, in _nro text, in _serie text,in _material text,in _nr_item text
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
      LEFT  JOIN nfe_det_nota_venda VE ON VE.id_v = DET.ID AND VE.nro_linha_v = DET.NRO_LINHA 
      WHERE det.id = _id AND VE.ID IS NULL and
            det.empresa = _empresa and 
            det.local = _local and 
            det.dtnf = _dtnf and 
            det.nro = _nro and 
            det.serie = _serie and
            det.nr_item <> _nr_item and det.material = _material and 
            ((DET.CFOP = '5100') OR 
            (DET.CFOP = '5101') OR 
            (DET.CFOP = '5102') OR 
            (DET.CFOP = '5103') OR 
            (DET.CFOP = '5104') OR 
            (DET.CFOP = '5105') OR 
            (DET.CFOP = '5106') OR 
            (DET.CFOP = '5109') OR 
            (DET.CFOP = '5110') OR 
            (DET.CFOP = '5111') OR 
            (DET.CFOP = '5112') OR 
            (DET.CFOP = '5113') OR 
            (DET.CFOP = '5114') OR 
            (DET.CFOP = '5115') OR 
            (DET.CFOP = '5116') OR 
            (DET.CFOP = '5117') OR 
            (DET.CFOP = '5118') OR 
            (DET.CFOP = '5119') OR 
            (DET.CFOP = '5120') OR 
            (DET.CFOP = '5122') OR 
            (DET.CFOP = '5123') OR 
            (DET.CFOP = '5250') OR 
            (DET.CFOP = '5251') OR 
            (DET.CFOP = '5252') OR 
            (DET.CFOP = '5253') OR 
            (DET.CFOP = '5254') OR 
            (DET.CFOP = '5255') OR 
            (DET.CFOP = '5256') OR 
            (DET.CFOP = '5257') OR 
            (DET.CFOP = '5258') OR 
            (DET.CFOP = '5401') OR 
            (DET.CFOP = '5402') OR 
            (DET.CFOP = '5403') OR 
            (DET.CFOP = '5405') OR 
            (DET.CFOP = '5551') OR 
            (DET.CFOP = '5651') OR 
            (DET.CFOP = '5652') OR 
            (DET.CFOP = '5653') OR 
            (DET.CFOP = '5654') OR 
            (DET.CFOP = '5655') OR 
            (DET.CFOP = '5656') OR 
            (DET.CFOP = '6100') OR 
            (DET.CFOP = '6101') OR 
            (DET.CFOP = '6102') OR 
            (DET.CFOP = '6103') OR 
            (DET.CFOP = '6104') OR 
            (DET.CFOP = '6105') OR 
            (DET.CFOP = '6106') OR 
            (DET.CFOP = '6107') OR 
            (DET.CFOP = '6108') OR 
            (DET.CFOP = '6109') OR 
            (DET.CFOP = '6110') OR 
            (DET.CFOP = '6111') OR 
            (DET.CFOP = '6112') OR 
            (DET.CFOP = '6113') OR 
            (DET.CFOP = '6114') OR 
            (DET.CFOP = '6115') OR 
            (DET.CFOP = '6116') OR 
            (DET.CFOP = '6117') OR 
            (DET.CFOP = '6118') OR 
            (DET.CFOP = '6119') OR 
            (DET.CFOP = '6120') OR 
            (DET.CFOP = '6122') OR 
            (DET.CFOP = '6123') OR 
            (DET.CFOP = '6250') OR 
            (DET.CFOP = '6251') OR 
            (DET.CFOP = '6252') OR 
            (DET.CFOP = '6253') OR 
            (DET.CFOP = '6254') OR 
            (DET.CFOP = '6255') OR 
            (DET.CFOP = '6256') OR 
            (DET.CFOP = '6257') OR 
            (DET.CFOP = '6258') OR 
            (DET.CFOP = '6401') OR 
            (DET.CFOP = '6402') OR 
            (DET.CFOP = '6403') OR 
            (DET.CFOP = '6404') OR 
            (DET.CFOP = '6551') OR 
            (DET.CFOP = '6651') OR 
            (DET.CFOP = '6652') OR 
            (DET.CFOP = '6653') OR 
            (DET.CFOP = '6654') OR 
            (DET.CFOP = '6655') OR 
            (DET.CFOP = '6656') OR 
            (DET.CFOP = '7100') OR 
            (DET.CFOP = '7101') OR 
            (DET.CFOP = '7102') OR 
            (DET.CFOP = '7105') OR 
            (DET.CFOP = '7106') OR 
            (DET.CFOP = '7127') OR 
            (DET.CFOP = '7250') OR 
            (DET.CFOP = '7251') OR 
            (DET.CFOP = '7551') OR 
            (DET.CFOP = '7651') OR 
            (DET.CFOP = '7654'))  limit 1;
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
      LEFT  JOIN nfe_det_nota_venda VE ON VE.id_v = DET.ID AND VE.nro_linha_v = DET.NRO_LINHA 
      WHERE det.id = _id AND VE.ID IS NULL and
            det.empresa = _empresa and 
            det.local = _local and 
            det.dtnf = _dtnf and 
            det.nro = _nro and 
            det.serie = _serie and
            det.nr_item <> _nr_item and 
            ((DET.CFOP = '5100') OR 
            (DET.CFOP = '5101') OR 
            (DET.CFOP = '5102') OR 
            (DET.CFOP = '5103') OR 
            (DET.CFOP = '5104') OR 
            (DET.CFOP = '5105') OR 
            (DET.CFOP = '5106') OR 
            (DET.CFOP = '5109') OR 
            (DET.CFOP = '5110') OR 
            (DET.CFOP = '5111') OR 
            (DET.CFOP = '5112') OR 
            (DET.CFOP = '5113') OR 
            (DET.CFOP = '5114') OR 
            (DET.CFOP = '5115') OR 
            (DET.CFOP = '5116') OR 
            (DET.CFOP = '5117') OR 
            (DET.CFOP = '5118') OR 
            (DET.CFOP = '5119') OR 
            (DET.CFOP = '5120') OR 
            (DET.CFOP = '5122') OR 
            (DET.CFOP = '5123') OR 
            (DET.CFOP = '5250') OR 
            (DET.CFOP = '5251') OR 
            (DET.CFOP = '5252') OR 
            (DET.CFOP = '5253') OR 
            (DET.CFOP = '5254') OR 
            (DET.CFOP = '5255') OR 
            (DET.CFOP = '5256') OR 
            (DET.CFOP = '5257') OR 
            (DET.CFOP = '5258') OR 
            (DET.CFOP = '5401') OR 
            (DET.CFOP = '5402') OR 
            (DET.CFOP = '5403') OR 
            (DET.CFOP = '5405') OR 
            (DET.CFOP = '5551') OR 
            (DET.CFOP = '5651') OR 
            (DET.CFOP = '5652') OR 
            (DET.CFOP = '5653') OR 
            (DET.CFOP = '5654') OR 
            (DET.CFOP = '5655') OR 
            (DET.CFOP = '5656') OR 
            (DET.CFOP = '6100') OR 
            (DET.CFOP = '6101') OR 
            (DET.CFOP = '6102') OR 
            (DET.CFOP = '6103') OR 
            (DET.CFOP = '6104') OR 
            (DET.CFOP = '6105') OR 
            (DET.CFOP = '6106') OR 
            (DET.CFOP = '6107') OR 
            (DET.CFOP = '6108') OR 
            (DET.CFOP = '6109') OR 
            (DET.CFOP = '6110') OR 
            (DET.CFOP = '6111') OR 
            (DET.CFOP = '6112') OR 
            (DET.CFOP = '6113') OR 
            (DET.CFOP = '6114') OR 
            (DET.CFOP = '6115') OR 
            (DET.CFOP = '6116') OR 
            (DET.CFOP = '6117') OR 
            (DET.CFOP = '6118') OR 
            (DET.CFOP = '6119') OR 
            (DET.CFOP = '6120') OR 
            (DET.CFOP = '6122') OR 
            (DET.CFOP = '6123') OR 
            (DET.CFOP = '6250') OR 
            (DET.CFOP = '6251') OR 
            (DET.CFOP = '6252') OR 
            (DET.CFOP = '6253') OR 
            (DET.CFOP = '6254') OR 
            (DET.CFOP = '6255') OR 
            (DET.CFOP = '6256') OR 
            (DET.CFOP = '6257') OR 
            (DET.CFOP = '6258') OR 
            (DET.CFOP = '6401') OR 
            (DET.CFOP = '6402') OR 
            (DET.CFOP = '6403') OR 
            (DET.CFOP = '6404') OR 
            (DET.CFOP = '6551') OR 
            (DET.CFOP = '6651') OR 
            (DET.CFOP = '6652') OR 
            (DET.CFOP = '6653') OR 
            (DET.CFOP = '6654') OR 
            (DET.CFOP = '6655') OR 
            (DET.CFOP = '6656') OR 
            (DET.CFOP = '7100') OR 
            (DET.CFOP = '7101') OR 
            (DET.CFOP = '7102') OR 
            (DET.CFOP = '7105') OR 
            (DET.CFOP = '7106') OR 
            (DET.CFOP = '7127') OR 
            (DET.CFOP = '7250') OR 
            (DET.CFOP = '7251') OR 
            (DET.CFOP = '7551') OR 
            (DET.CFOP = '7651') OR 
            (DET.CFOP = '7654')) limit 1;
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
