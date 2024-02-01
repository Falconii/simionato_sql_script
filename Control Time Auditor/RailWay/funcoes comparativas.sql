CREATE OR REPLACE FUNCTION "public"."apontamentos" (in _id_projeto int4, out _saida numeric(5,2) ) 
AS
$$
DECLARE

BEGIN

    _saida = 0;

    select  sum(horasapon) into _saida
    from apons_execucao 
    where id_projeto = _id_projeto;

   if (_saida is NULL) then

      _saida = 0;

   end if;

    return;

END;
$$
LANGUAGE 'plpgsql'
go

CREATE OR REPLACE FUNCTION "public"."atividades" (in _id_projeto int4, out _saida numeric(5,2) ) 
AS
$$
DECLARE

BEGIN

    _saida = 0;

   SELECT SUM(HORASEXEC) INTO _saida
   FROM ATIVIDADES  
   WHERE TIPO = 'C' AND HORASEXEC > 0 AND ID_PROJETO = _ID_PROJETO;
   
   if (_saida is NULL) then

      _saida = 0;

   end if;

    return;

END;
$$
LANGUAGE 'plpgsql'
go


CREATE OR REPLACE FUNCTION "public"."projetos" (in _id_projeto int4, out _saida numeric(5,2) ) 
AS
$$
DECLARE

BEGIN

    _saida = 0;

   SELECT horasexec INTO _saida
   FROM projetos  
   WHERE  ID = _ID_PROJETO;
   
   if (_saida is NULL) then

      _saida = 0;

   end if;

    return;

END;
$$
LANGUAGE 'plpgsql'
go

