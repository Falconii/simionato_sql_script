--create type testetype as (num int, nome char(10));

CREATE OR REPLACE FUNCTION "public"."teste_01"() returns setof testetype
AS
$$
DECLARE

tempo testetype%ROWTYPE;
idx int;

BEGIN
 FOR i in 1 .. 10
 LOOP
        tempo.num := i;
        tempo.nome := 'MARCOS'; 
        return next tempo;
 END LOOP;
END;
$$
LANGUAGE 'plpgsql'
go


select * from teste_01();