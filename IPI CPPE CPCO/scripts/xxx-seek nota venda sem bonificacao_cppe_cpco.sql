CREATE OR REPLACE FUNCTION "public"."seekvendasembonificacao_cppe_cpco" (in _id int4, in _dtnf date, in _nro text, in _serie text, in _material text, in _cnpj text,
                        out __empresa text, out __local text, out __dtnf date, out __nro text, out __serie text, out __material text ,
                        out __Descricao text, out __Cfop text, out __Unid text, out __Qtd numeric(15,4), out __Vlr_Contabil numeric(15,4) , out __Base_Ipi numeric(15,2) , out __Perc_Ipi numeric(6,2), out __Vlr_IPI numeric(15,2), out __id_v int4 , out __nro_linha_v int4  ) 
RETURNS record 
AS
$$
DECLARE

 tempo public.nfe_det%ROWTYPE;
 ___Empresa text;
 ___Local text;
 ___Nro text;
 ___Serie text;
 ___Data  date;		
 ___Material  text;	
 ___Descricao text;
 ___Cfop      text;
 ___Unid      text;
 ___Qtd           numeric(15,4);
 ___Vlr_Contabil  numeric(15,4);
 ___Base_Ipi      numeric(15,2);
 ___Perc_Ipi      numeric(6,2);
 ___Vlr_IPI       numeric(15,4);
 ___id_v           int4;
 ___nro_linha_v    int4;
 __TemVenda int4;
 __TemBonificacao int4;
 __NotaExcluida int4;
 __Linha int4;
 __Ano text;
 __Mes text;
 lixo int4;

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
  
  FOR tempo in  SELECT *  
      FROM public.nfe_det det 
      INNER JOIN NFE_CAB CAB ON CAB.ID = DET.ID
      INNER  JOIN nfe_det_comp COMP ON comp.id = det.id and comp.nro_linha = det.nro_linha and comp.bebida = 'S' and comp.cnpj = _cnpj
      WHERE det.id = _id AND DET.NRO_LINHA > CAB.ULTIMA AND TO_CHAR(DET.DTNF,'YYYY') = __Ano And to_char(DET.DTNF,'MM') = __Mes 
      ORDER BY det.detnf,det.nro_linha 
      LOOP      
       
         //RAISE NOTICE 'Cnpj % ', _cnpj;  

        if ( not(___Nro = tempo.nro) OR not(___Serie = tempo.serie) ) then

           if (___Nro = '') then 

               // RAISE NOTICE 'Iniciando';   

           else
             
               //RAISE NOTICE 'Registro A Nota';   


               if (__TemVenda = 1) then 

                  //RAISE NOTICE 'Tem Venda';
 
               end if;

               if (__TemBonificacao = 1) then 

                  //RAISE NOTICE 'Tem TemBonificacao';
 
               end if;

               if (__NotaExcluida = 1) then 

                  //RAISE NOTICE 'Nota Excluida';
 
               end if;

              if ( (__TemVenda = 1) AND (__TemBonificacao = 0)) then 

                    //RAISE NOTICE 'Achou...Nota % Serie % Material % ',___Nro,___Serie,___Material;
                    __empresa := ___Empresa;
                    __local :=   ___Local; 
                    __dtnf  :=   ___Data;
                    __nro   :=   ___Nro;
                    __serie :=   ___Serie;
                    __material := ___Material;
                    __Descricao      := ___Descricao;
                    __Cfop           := ___Cfop;
                    __Unid           := ___Unid;
                    __Qtd            := ___Qtd ;
                    __Vlr_Contabil   := ___Vlr_Contabil;
                    __Base_Ipi       := ___Base_IPI ;
                    __Perc_Ipi       := ___Perc_IPI ;
                    __Vlr_IPI        := ___Vlr_IPI ;    
                    __id_v           :=  ___id_v  ;         
                    __nro_linha_v    :=  ___nro_linha_v ;    

                    update nfe_cab set ultima = __Linha where id = _id;

                    //RAISE NOTICE 'Gravei Ultima Linha id % ultima linha % ' , _id, __Linha; 


                    __TemVenda = 0;
                    __TemBonificacao = 0;

                    exit;
                   
              end if;

           end if;
           
           ___Nro            := tempo.nro;
           ___Serie          := tempo.Serie;
           __TemVenda       := 0  ;
           __TemBonificacao := 0  ;
           __NotaExcluida   := 0  ;

        end if;

        if ((tempo.nro = _nro) and (tempo.serie = _serie)) then
             __NotaExcluida := 1;
        end if;  

        if (tempo.cfop = '5910' or tempo.cfop = '6910') then
           __TemBonificacao := 1;
        end if ;

        if (( (tempo.CFOP = '5100') OR 
            (tempo.CFOP = '5101') OR 
            (tempo.CFOP = '5102') OR 
            (tempo.CFOP = '5103') OR 
            (tempo.CFOP = '5104') OR 
            (tempo.CFOP = '5105') OR 
            (tempo.CFOP = '5106') OR 
            (tempo.CFOP = '5109') OR 
            (tempo.CFOP = '5110') OR 
            (tempo.CFOP = '5111') OR 
            (tempo.CFOP = '5112') OR 
            (tempo.CFOP = '5113') OR 
            (tempo.CFOP = '5114') OR 
            (tempo.CFOP = '5115') OR 
            (tempo.CFOP = '5116') OR 
            (tempo.CFOP = '5117') OR 
            (tempo.CFOP = '5118') OR 
            (tempo.CFOP = '5119') OR 
            (tempo.CFOP = '5120') OR 
            (tempo.CFOP = '5122') OR 
            (tempo.CFOP = '5123') OR 
            (tempo.CFOP = '5250') OR 
            (tempo.CFOP = '5251') OR 
            (tempo.CFOP = '5252') OR 
            (tempo.CFOP = '5253') OR 
            (tempo.CFOP = '5254') OR 
            (tempo.CFOP = '5255') OR 
            (tempo.CFOP = '5256') OR 
            (tempo.CFOP = '5257') OR 
            (tempo.CFOP = '5258') OR 
            (tempo.CFOP = '5401') OR 
            (tempo.CFOP = '5402') OR 
            (tempo.CFOP = '5403') OR 
            (tempo.CFOP = '5405') OR 
            (tempo.CFOP = '5551') OR 
            (tempo.CFOP = '5651') OR 
            (tempo.CFOP = '5652') OR 
            (tempo.CFOP = '5653') OR 
            (tempo.CFOP = '5654') OR 
            (tempo.CFOP = '5655') OR 
            (tempo.CFOP = '5656') OR 
            (tempo.CFOP = '6100') OR 
            (tempo.CFOP = '6101') OR 
            (tempo.CFOP = '6102') OR 
            (tempo.CFOP = '6103') OR 
            (tempo.CFOP = '6104') OR 
            (tempo.CFOP = '6105') OR 
            (tempo.CFOP = '6106') OR 
            (tempo.CFOP = '6107') OR 
            (tempo.CFOP = '6108') OR 
            (tempo.CFOP = '6109') OR 
            (tempo.CFOP = '6110') OR 
            (tempo.CFOP = '6111') OR 
            (tempo.CFOP = '6112') OR 
            (tempo.CFOP = '6113') OR 
            (tempo.CFOP = '6114') OR 
            (tempo.CFOP = '6115') OR 
            (tempo.CFOP = '6116') OR 
            (tempo.CFOP = '6117') OR 
            (tempo.CFOP = '6118') OR 
            (tempo.CFOP = '6119') OR 
            (tempo.CFOP = '6120') OR 
            (tempo.CFOP = '6122') OR 
            (tempo.CFOP = '6123') OR 
            (tempo.CFOP = '6250') OR 
            (tempo.CFOP = '6251') OR 
            (tempo.CFOP = '6252') OR 
            (tempo.CFOP = '6253') OR 
            (tempo.CFOP = '6254') OR 
            (tempo.CFOP = '6255') OR 
            (tempo.CFOP = '6256') OR 
            (tempo.CFOP = '6257') OR 
            (tempo.CFOP = '6258') OR 
            (tempo.CFOP = '6401') OR 
            (tempo.CFOP = '6402') OR 
            (tempo.CFOP = '6403') OR 
            (tempo.CFOP = '6404') OR 
            (tempo.CFOP = '6551') OR 
            (tempo.CFOP = '6651') OR 
            (tempo.CFOP = '6652') OR 
            (tempo.CFOP = '6653') OR 
            (tempo.CFOP = '6654') OR 
            (tempo.CFOP = '6655') OR 
            (tempo.CFOP = '6656') OR 
            (tempo.CFOP = '7100') OR 
            (tempo.CFOP = '7101') OR 
            (tempo.CFOP = '7102') OR 
            (tempo.CFOP = '7105') OR 
            (tempo.CFOP = '7106') OR 
            (tempo.CFOP = '7127') OR 
            (tempo.CFOP = '7250') OR 
            (tempo.CFOP = '7251') OR 
            (tempo.CFOP = '7551') OR 
            (tempo.CFOP = '7651') OR 
            (tempo.CFOP = '7654')
        )) then 

          __TemVenda := 1;

        end if;

        ___Empresa        := tempo.empresa;
        ___Local          := tempo.local;
        ___Material       := tempo.material;
        ___Data           := tempo.dtnf;
        ___Descricao      := tempo.descricao;
        ___Cfop           := tempo.cfop;
        ___Unid           := tempo.unid;
        ___Qtd            := tempo.qtd;
        ___Vlr_Contabil   := tempo.vlr_contabil;
        ___Base_Ipi       := tempo.bas_ipi;
        ___Perc_Ipi       := tempo.per_ipi;
        ___Vlr_IPI        := tempo.vlr_ipi;
        ___id_v           := tempo.id;         
        ___nro_linha_v    := tempo.nro_linha;    
        __Linha           := tempo.nro_linha;
 
      

       //RAISE NOTICE 'ID % Nro LInha % Empresa % Local % Data % Nota % Serie % Produto % Descrição % Unid % CFOP % ', tempo.id, tempo.nro_linha, tempo.empresa,tempo.local,tempo.dtnf,tempo.nro,tempo.serie,tempo.material,tempo.descricao,tempo.unid,tempo.cfop;

      END LOOP;

      
      if ( (__TemVenda = 1) AND (__TemBonificacao = 0)) then 
           
           //RAISE NOTICE 'UTIMA NOTA';

/*
            INSERT INTO public.warning(id, nro_linha, mensagem) 
                VALUES(tempo.id, tempo.nro_linha, 'Ultima Nota');
*/
                           __empresa := ___Empresa;
                           __local :=   ___Local; 
                           __dtnf  :=   ___Data;
                           __nro   :=   ___Nro;
                           __serie :=   ___Serie;
                           __material := ___Material;
                           __Descricao      := ___Descricao;
                           __Cfop           := ___Cfop;
                           __Unid           := ___Unid;
                           __Qtd            := ___Qtd ;
                           __Vlr_Contabil   := ___Vlr_Contabil;
                           __Base_Ipi       := ___Base_IPI ;
                           __Perc_Ipi       := ___Perc_IPI ;
                           __Vlr_IPI        := ___Vlr_IPI ;  
                           __id_v           :=  ___id_v  ;         
                           __nro_linha_v    :=  ___nro_linha_v ;     


                           update nfe_cab set ultima = __Linha where id = _id;

      ELSE 
                            RAISE NOTICE '__TemVenda % __TemBonificacao % ', __TemVenda ,  __TemBonificacao;

      end if;

END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM WARNING

//SELECT * FROM seekvendasembonificacao(1057,'31/01/2017','000330307','001','1010947');



/*
SELECT * FROM NFE_DET det WHERE det.ID = 1057 
AND 
(           (det.CFOP = '5100') OR 
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
order by  det.nro, det.serie, det.nr_item
*/

/*

SELECT ID,COUNT(*) 
FROM nfe_det_nota_venda 
where descricao = 'SEM VENDA NESTA NOTA'
GROUP BY ID

SELECT * FROM NFE_DET WHERE ID = 1057 AND NRO_LINHA = '35503'

*/