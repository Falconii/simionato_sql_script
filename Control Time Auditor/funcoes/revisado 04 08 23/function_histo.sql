CREATE OR REPLACE FUNCTION function_histo(in _id_empresa int4,  in _conta text, in _subconta text, in _versao text, in _nivel int4,out _saida text)
  RETURNS text
  LANGUAGE PLPGSQL    
  AS
$$
DECLARE 
 tempo public.estruturas%ROWTYPE;
 ni int4;
BEGIN
   raise notice '';
   ni = 1;
   _saida = '';
   LOOP
        FOR tempo in  SELECT *  from estruturas 
                       where  id_empresa  = _id_empresa and  
                              conta       = _conta      and
                              versao      = _versao     and 
                              subconta    = left(_subconta,(ni)*2)     
                       order by id_empresa,conta,subconta 
            LOOP 
                _saida = _saida || '/' || tempo.descricao;
                raise notice 'ni %',ni;
            END LOOP;
       ni   = ni + 1;
       EXIT WHEN ni >  _nivel;
   END LOOP; 
END ;
$$
GO

SELECT * FROM function_histo(01,'16','160101','0101',3);

SELECT  
            ativ.id_empresa
            ,ativ.id
            ,ativ.id_projeto
            ,ativ.conta
            ,ativ.versao
            ,ativ.subconta
            ,ativ.nivel
            ,ativ.tipo
            ,ativ.controle
            ,ativ.id_resp
            ,ativ.id_exec
            ,ativ.id_subcliente
            ,ativ.inicial
            ,ativ.final
            ,ativ.horasplan
            ,ativ.horasexec
            ,ativ.horasdir
            ,ativ.obs
            ,ativ.status
            ,ativ.status_pl
            ,ativ.status_ex
            ,ativ.user_insert
            ,ativ.user_update
            ,estr.descricao descricao_estru  
            ,cli.razao as razao_cliente
            from atividades ativ
            inner join estruturas estr on estr.id_empresa = ativ.id_empresa and estr.conta = ativ.conta and estr.versao = ativ.versao and estr.subconta = ativ.subconta
            inner join clientes   cli  on cli.id_empresa  = ativ.id_empresa and cli.id = ativ.id_subcliente
            where  ativ.id_empresa = 1  and  ativ.id = 7669
