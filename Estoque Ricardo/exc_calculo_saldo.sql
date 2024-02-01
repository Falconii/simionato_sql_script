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

SELECT  FROM exc_calculo_saldo(1,1)
GO

 

SELECT DISTINCT 
       case 
          when operacao = 'A'  THEN 'SALDO ANTERIROR'
          when operacao = 'X'  THEN 'ENTRADA - DISP.'
          when operacao = 'V'  THEN 'VENDA'
          when operacao = 'S'  THEN 'SAIDA - DISP.'
          when operacao = 'E'  THEN 'ENTRADA'
          else                      'NÃO DEF.'
       end as OPERACAO 
FROM nfe_det_e


SELECT * FROM nfe_cab_e