CREATE OR REPLACE FUNCTION "public"."chama_gravamovihrs" (in _id_empresa int4, in _id_inicial int4, in _id_final int4, in _mes int4 , in _ano int4 , out _retorno text ) 
AS
$$
DECLARE

tempo    public.usuarios%ROWTYPE;
_ret numeric(5,2);

BEGIN
 FOR tempo in  
      SELECT *
      FROM usuarios 
      WHERE id_empresa = _id_empresa and ativo = 'S' and ticket = 'S'  
      ORDER BY id_empresa,id
      LOOP  
          raise notice 'Nome  % ', tempo.razao;
          select _saida into _ret from function_gravamovihrs(_id_empresa,tempo.id,_mes,_ano);
 END LOOP;
END;
$$
LANGUAGE 'plpgsql'
go

select * from chama_gravamovihrs(1,1,20,12,2023) 


//CREATE TABLE tickets_movi_12 AS  SELECT * FROM tickets_movi;

//delete  FROM tickets_movi

//SELECT * FROM tickets_movi_12