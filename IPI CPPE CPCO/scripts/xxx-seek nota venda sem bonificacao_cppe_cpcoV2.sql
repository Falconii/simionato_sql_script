CREATE OR REPLACE FUNCTION "public"."seekvendasembonificacaov2" (in _id int4, in _dtnf date, in _nro text, in _serie text, in _material text, in _cnpj text,
                        out __empresa text, out __local text, out __dtnf date, out __nro text, out __serie text, out __material text ,
                        out __Descricao text, out __Cfop text, out __Unid text, out __Qtd numeric(15,4), out __Vlr_Contabil numeric(15,4) , out __Base_Ipi numeric(15,2) , out __Perc_Ipi numeric(6,2), out __Vlr_IPI numeric(15,2), out __id_v int4 , out __nro_linha_v int4  ) 
RETURNS record 
AS
$$
DECLARE

 tempo public.nfe_det%ROWTYPE;
 ___Empresa       text;
 ___Local         text;
 ___Nro           text;
 ___Serie         text;
 ___Data          date;		
 ___Material      text;	
 ___Descricao     text;
 ___Cfop          text;
 ___Unid          text;
 ___Qtd           numeric(15,4);
 ___Vlr_Contabil  numeric(15,4);
 ___Base_Ipi      numeric(15,2);
 ___Perc_Ipi      numeric(6,2);
 ___Vlr_IPI       numeric(15,4);
 ___id_v          int4;
 ___nro_linha_v   int4;
 __TemVenda       int4;
 __TemBonificacao int4;
 __NotaExcluida   int4;
 __Linha          int4;
 __Ano text;
 __Mes text;

BEGIN
  ___Empresa        := '';
  ___Local          := '';
  ___Nro            := '' ;
  ___Serie          := '' ;
  ___Data           := null;		
  ___Material       := '';	
  ___Descricao      := '';
  ___Cfop           := '';
  ___Unid           := '';
  ___Qtd            := 0 ;
  ___Vlr_Contabil   := 0 ;
  ___Base_Ipi       := 0 ;
  ___Perc_Ipi       := 0 ;
  ___Vlr_IPI        := 0 ;  
  ___id_v           := 0 ;         
  ___nro_linha_v    := 0 ; 
  __Linha           := 0 ;
  __TemVenda        := 0 ;
  __TemBonificacao  := 0 ;
  __NotaExcluida    := 0 ; 
  __Ano             := to_char(_dtnf,'yyyy'); 
  __Mes             := to_char(_dtnf,'MM');
  
//Venda Do Memso Produto
SELECT 
      det.Empresa,
      det.Local,
      det.dtnf,
      det.nro,
      det.serie,
      det.material,
      det.Descricao,
      det.Cfop,
      det.Unid,
      det.qtd,
      det.Vlr_Contabil,
      det.Bas_IPI,
      det.Per_IPI,
      det.Vlr_IPI,    
      det.id,      
      det.nro_linha   
    INTO
      __empresa       ,
      __local         ,
      __dtnf          ,
      __nro           ,
      __serie         ,
      __material      ,
      __Descricao     ,
      __Cfop          ,
      __Unid          ,
      __Qtd           ,
      __Vlr_Contabil  ,
      __Base_Ipi      ,
      __Perc_Ipi      ,
      __Vlr_IPI       ,
      __id_v          ,
      __nro_linha_v   
    FROM public.nfe_det det 
    INNER JOIN NFE_CAB CAB ON CAB.ID = DET.ID
    INNER  JOIN nfe_det_comp COMP ON comp.id = det.id and comp.nro_linha = det.nro_linha and comp.bebida = 'S' and comp.cnpj = _cnpj
    LEFT  JOIN nfe_det_nota_venda VE ON VE.id_v = DET.ID AND VE.nro_linha_v = DET.NRO_LINHA
    WHERE det.id = _id AND VE.ID IS NULL AND TO_CHAR(DET.DTNF,'YYYY') = __Ano And to_char(DET.DTNF,'MM') = __Mes and det.material = _material and 
       (  (det.CFOP = '5100') OR 
          (det.CFOP = '5101') OR 
          (det.CFOP = '5102') OR 
          (det.CFOP = '5103') OR 
          (det.CFOP = '5104') OR 
          (det.CFOP = '5105') OR 
          (det.CFOP = '5106') OR 
          (det.CFOP = '5109') OR 
          (det.CFOP = '5110') OR 
          (det.CFOP = '5111') OR 
          (det.CFOP = '5112') OR 
          (det.CFOP = '5113') OR 
          (det.CFOP = '5114') OR 
          (det.CFOP = '5115') OR 
          (det.CFOP = '5116') OR 
          (det.CFOP = '5117') OR 
          (det.CFOP = '5118') OR 
          (det.CFOP = '5119') OR 
          (det.CFOP = '5120') OR 
          (det.CFOP = '5122') OR 
          (det.CFOP = '5123') OR 
          (det.CFOP = '5250') OR 
          (det.CFOP = '5251') OR 
          (det.CFOP = '5252') OR 
          (det.CFOP = '5253') OR 
          (det.CFOP = '5254') OR 
          (det.CFOP = '5255') OR 
          (det.CFOP = '5256') OR 
          (det.CFOP = '5257') OR 
          (det.CFOP = '5258') OR 
          (det.CFOP = '5401') OR 
          (det.CFOP = '5402') OR 
          (det.CFOP = '5403') OR 
          (det.CFOP = '5405') OR 
          (det.CFOP = '5551') OR 
          (det.CFOP = '5651') OR 
          (det.CFOP = '5652') OR 
          (det.CFOP = '5653') OR 
          (det.CFOP = '5654') OR 
          (det.CFOP = '5655') OR 
          (det.CFOP = '5656') OR 
          (det.CFOP = '6100') OR 
          (det.CFOP = '6101') OR 
          (det.CFOP = '6102') OR 
          (det.CFOP = '6103') OR 
          (det.CFOP = '6104') OR 
          (det.CFOP = '6105') OR 
          (det.CFOP = '6106') OR 
          (det.CFOP = '6107') OR 
          (det.CFOP = '6108') OR 
          (det.CFOP = '6109') OR 
          (det.CFOP = '6110') OR 
          (det.CFOP = '6111') OR 
          (det.CFOP = '6112') OR 
          (det.CFOP = '6113') OR 
          (det.CFOP = '6114') OR 
          (det.CFOP = '6115') OR 
          (det.CFOP = '6116') OR 
          (det.CFOP = '6117') OR 
          (det.CFOP = '6118') OR 
          (det.CFOP = '6119') OR 
          (det.CFOP = '6120') OR 
          (det.CFOP = '6122') OR 
          (det.CFOP = '6123') OR 
          (det.CFOP = '6250') OR 
          (det.CFOP = '6251') OR 
          (det.CFOP = '6252') OR 
          (det.CFOP = '6253') OR 
          (det.CFOP = '6254') OR 
          (det.CFOP = '6255') OR 
          (det.CFOP = '6256') OR 
          (det.CFOP = '6257') OR 
          (det.CFOP = '6258') OR 
          (det.CFOP = '6401') OR 
          (det.CFOP = '6402') OR 
          (det.CFOP = '6403') OR 
          (det.CFOP = '6404') OR 
          (det.CFOP = '6551') OR 
          (det.CFOP = '6651') OR 
          (det.CFOP = '6652') OR 
          (det.CFOP = '6653') OR 
          (det.CFOP = '6654') OR 
          (det.CFOP = '6655') OR 
          (det.CFOP = '6656') OR 
          (det.CFOP = '7100') OR 
          (det.CFOP = '7101') OR 
          (det.CFOP = '7102') OR 
          (det.CFOP = '7105') OR 
          (det.CFOP = '7106') OR 
          (det.CFOP = '7127') OR 
          (det.CFOP = '7250') OR 
          (det.CFOP = '7251') OR 
          (det.CFOP = '7551') OR 
          (det.CFOP = '7651') OR 
          (det.CFOP = '7654')
    )
    ORDER BY det.dtnf,det.nro_linha LIMIT 1;

    IF (__empresa IS NOT NULL) THEN
       return;
    END IF;

    //EM OUTRO PRODUTO
    SELECT 
          det.Empresa,
          det.Local,
          det.dtnf,
          det.nro,
          det.serie,
          det.material,
          det.Descricao,
          det.Cfop,
          det.Unid,
          det.qtd,
          det.Vlr_Contabil,
          det.Bas_IPI,
          det.Per_IPI,
          det.Vlr_IPI,    
          det.id,      
          det.nro_linha   
        INTO
          __empresa       ,
          __local         ,
          __dtnf          ,
          __nro           ,
          __serie         ,
          __material      ,
          __Descricao     ,
          __Cfop          ,
          __Unid          ,
          __Qtd           ,
          __Vlr_Contabil  ,
          __Base_Ipi      ,
          __Perc_Ipi      ,
          __Vlr_IPI       ,
          __id_v          ,
          __nro_linha_v   
        FROM public.nfe_det det 
        INNER JOIN NFE_CAB CAB ON CAB.ID = DET.ID
        INNER  JOIN nfe_det_comp COMP ON comp.id = det.id and comp.nro_linha = det.nro_linha and comp.bebida = 'S' and comp.cnpj = _cnpj
        LEFT  JOIN nfe_det_nota_venda VE ON VE.id_v = DET.ID AND VE.nro_linha_v = DET.NRO_LINHA
        WHERE det.id = _id AND VE.ID IS NULL AND TO_CHAR(DET.DTNF,'YYYY') = __Ano And to_char(DET.DTNF,'MM') = __Mes  and 
           (  (det.CFOP = '5100') OR 
              (det.CFOP = '5101') OR 
              (det.CFOP = '5102') OR 
              (det.CFOP = '5103') OR 
              (det.CFOP = '5104') OR 
              (det.CFOP = '5105') OR 
              (det.CFOP = '5106') OR 
              (det.CFOP = '5109') OR 
              (det.CFOP = '5110') OR 
              (det.CFOP = '5111') OR 
              (det.CFOP = '5112') OR 
              (det.CFOP = '5113') OR 
              (det.CFOP = '5114') OR 
              (det.CFOP = '5115') OR 
              (det.CFOP = '5116') OR 
              (det.CFOP = '5117') OR 
              (det.CFOP = '5118') OR 
              (det.CFOP = '5119') OR 
              (det.CFOP = '5120') OR 
              (det.CFOP = '5122') OR 
              (det.CFOP = '5123') OR 
              (det.CFOP = '5250') OR 
              (det.CFOP = '5251') OR 
              (det.CFOP = '5252') OR 
              (det.CFOP = '5253') OR 
              (det.CFOP = '5254') OR 
              (det.CFOP = '5255') OR 
              (det.CFOP = '5256') OR 
              (det.CFOP = '5257') OR 
              (det.CFOP = '5258') OR 
              (det.CFOP = '5401') OR 
              (det.CFOP = '5402') OR 
              (det.CFOP = '5403') OR 
              (det.CFOP = '5405') OR 
              (det.CFOP = '5551') OR 
              (det.CFOP = '5651') OR 
              (det.CFOP = '5652') OR 
              (det.CFOP = '5653') OR 
              (det.CFOP = '5654') OR 
              (det.CFOP = '5655') OR 
              (det.CFOP = '5656') OR 
              (det.CFOP = '6100') OR 
              (det.CFOP = '6101') OR 
              (det.CFOP = '6102') OR 
              (det.CFOP = '6103') OR 
              (det.CFOP = '6104') OR 
              (det.CFOP = '6105') OR 
              (det.CFOP = '6106') OR 
              (det.CFOP = '6107') OR 
              (det.CFOP = '6108') OR 
              (det.CFOP = '6109') OR 
              (det.CFOP = '6110') OR 
              (det.CFOP = '6111') OR 
              (det.CFOP = '6112') OR 
              (det.CFOP = '6113') OR 
              (det.CFOP = '6114') OR 
              (det.CFOP = '6115') OR 
              (det.CFOP = '6116') OR 
              (det.CFOP = '6117') OR 
              (det.CFOP = '6118') OR 
              (det.CFOP = '6119') OR 
              (det.CFOP = '6120') OR 
              (det.CFOP = '6122') OR 
              (det.CFOP = '6123') OR 
              (det.CFOP = '6250') OR 
              (det.CFOP = '6251') OR 
              (det.CFOP = '6252') OR 
              (det.CFOP = '6253') OR 
              (det.CFOP = '6254') OR 
              (det.CFOP = '6255') OR 
              (det.CFOP = '6256') OR 
              (det.CFOP = '6257') OR 
              (det.CFOP = '6258') OR 
              (det.CFOP = '6401') OR 
              (det.CFOP = '6402') OR 
              (det.CFOP = '6403') OR 
              (det.CFOP = '6404') OR 
              (det.CFOP = '6551') OR 
              (det.CFOP = '6651') OR 
              (det.CFOP = '6652') OR 
              (det.CFOP = '6653') OR 
              (det.CFOP = '6654') OR 
              (det.CFOP = '6655') OR 
              (det.CFOP = '6656') OR 
              (det.CFOP = '7100') OR 
              (det.CFOP = '7101') OR 
              (det.CFOP = '7102') OR 
              (det.CFOP = '7105') OR 
              (det.CFOP = '7106') OR 
              (det.CFOP = '7127') OR 
              (det.CFOP = '7250') OR 
              (det.CFOP = '7251') OR 
              (det.CFOP = '7551') OR 
              (det.CFOP = '7651') OR 
              (det.CFOP = '7654')
        )
        ORDER BY det.dtnf,det.nro_linha LIMIT 1;
       

END;
$$
LANGUAGE 'plpgsql'
go

