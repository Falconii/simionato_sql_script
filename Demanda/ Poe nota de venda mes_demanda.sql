CREATE OR REPLACE FUNCTION "public"."poenotavendames_demanda" (in _id_demanda int4, in _id int4 , out _saida text) 
RETURNS text 
AS
$$
DECLARE

 tempo public.nfe_det%ROWTYPE;
 _empresa text;
 _local text;
 _dtnf date;
 _nro text;
 _Serie text;
 _material text;
 _Descricao text;
 _Cfop text;
 _Unid text;
 _Qtd numeric(15,4);
 _Vlr_Contabil numeric(15,4); 
 _Base_Ipi numeric(15,2);
 _Perc_Ipi numeric(6,2);
 _Vlr_IPI numeric(15,4);
 _id_v  int4;
 _nro_linha_v int4;
 __Ano text;
 __Mes text;
 _Sistema text;
 _Origem text;
 Hoje TimeStamp;
 Venda TimeStamp;
 VendaMes TimeStamp;

 
BEGIN
 
  Hoje = NOW();

  SELECT dtvenda,dtvendames FROM NFE_CAB_STATUS INTO Venda,VendaMes WHERE ID_DEMANDA = _id_demanda AND ID = _id;

  IF (Venda  is  null) THEN

     _saida = 'Não Encontrei As Notas De Venda';

     return;

  end if;

   IF (VendaMes is  not null) THEN

     _saida = 'Notas De Venda Mês, Já Processadas';

     return;

  end if;

  FOR tempo in  SELECT DET.*
      FROM NFE_DET DET
      INNER JOIN NFE_DET_COMP       COMP ON COMP.ID = DET.ID AND COMP.NRO_LINHA = DET.NRO_LINHA
      INNER JOIN NFE_DET_NOTA_VENDA VE   ON VE.ID   = DET.ID AND VE.NRO_LINHA   = DET.NRO_LINHA AND VE.sem_venda = 'S'
      WHERE DET.ID = _id 
      ORDER BY COMP.CNPJ,DET.DTNF,DET.NRO_LINHA

      
      LOOP      

        select cnpj from nfe_det_comp into _Origem where id = tempo.id and nro_linha = tempo.nro_linha;

        //RAISE NOTICE 'ORIGEM: %', _Origem; 

        select    __empresa , __local, __dtnf ,  __nro ,  __serie ,  __material ,  __descricao ,  __cfop , __unid , __qtd ,  __vlr_contabil , __base_ipi , __perc_ipi ,  __vlr_ipi   , __id_v, __nro_linha_v 
        from seeknfesembondema(_id_demanda,tempo.id,tempo.dtnf,tempo.nro,tempo.serie,tempo.material,_Origem)
        into _empresa, _local, _dtnf, _nro , _serie , _material, _Descricao, _Cfop, _Unid,
             _Qtd,_Vlr_Contabil, _Base_Ipi , _Perc_Ipi , _Vlr_IPI, _id_v, _nro_linha_v ;

         IF ( not(_material IS  null)) then

               //RAISE NOTICE 'GRAVEI...ID % NRO_LINHA % ', tempo.ID , tempo.Nro_Linha ;
                
               UPDATE nfe_det_nota_ve_dema SET 
               dtnf = _dtnf, 
               nro  = _nro, 
               serie = _serie,
               material = _material,
               descricao = '*' || SUBSTRING(_Descricao,1,99), 
               qtd = _Qtd, 
               vlr_contabil = _Vlr_Contabil, 
               bas_ipi = _Base_Ipi,
               per_ipi = _Perc_Ipi, 
               vlr_ipi = _Vlr_IPI,
               id_v    = _id_v,
               nro_linha_v = _nro_linha_v
               WHERE ID_DEMANDA = _id_demanda AND ID = tempo.ID AND NRO_LINHA = tempo.Nro_Linha;  
         ELSE
              //RAISE NOTICE 'NÃO FIZ NADA...ID % NRO_LINHA % ', tempo.ID , tempo.Nro_Linha ;
         END IF;

      END LOOP;

      UPDATE nfe_cab_status  SET dtvendames = Hoje  WHERE ID_DEMANDA = _id_demanda AND ID = _id ;

     _saida = 'OK';

END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM poenotavendames_demanda(1,3)