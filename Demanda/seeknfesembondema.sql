CREATE OR REPLACE FUNCTION "public"."seeknfesembondema"(in _id_demanda int4,in _id int4, in _dtnf date, in _nro text, in _serie text, in _material text, in _cnpj text,
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
    INNER JOIN CFOP_SALES   TRAB ON TRAB.ID_DEMANDA = _id_demanda AND TRAB.CFOP = DET.CFOP
    LEFT  JOIN nfe_det_nota_ve_dema VE ON VE.ID_DEMANDA = _id_demanda and VE.id_v = DET.ID AND VE.nro_linha_v = DET.NRO_LINHA
    WHERE det.id = _id AND VE.ID IS NULL AND TO_CHAR(DET.DTNF,'YYYY') = __Ano And to_char(DET.DTNF,'MM') = __Mes and det.material = _material 
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
        INNER JOIN CFOP_SALES   TRAB ON TRAB.ID_DEMANDA = _id_demanda AND TRAB.CFOP = DET.CFOP
        LEFT  JOIN nfe_det_nota_ve_dema VE ON VE.ID_DEMANDA = _id_demanda AND VE.id_v = DET.ID AND VE.nro_linha_v = DET.NRO_LINHA
        WHERE det.id = _id AND VE.ID IS NULL AND TO_CHAR(DET.DTNF,'YYYY') = __Ano And to_char(DET.DTNF,'MM') = __Mes  
        ORDER BY det.dtnf,det.nro_linha LIMIT 1;
       

END;
$$
LANGUAGE 'plpgsql'
go

