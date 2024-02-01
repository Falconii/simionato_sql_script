CREATE OR REPLACE FUNCTION "public"."define_id_operador" (in _id_empresa int4, in _conta text, in _subconta text, in _versao text, in _id_operador int4, in _tipo text, out _id_usuario int4) RETURNS int4 AS
'
DECLARE 
  _controle text;
BEGIN
     
   SELECT COALESCE(id_usuario,0),controle INTO _id_usuario,_controle FROM estruturas where id_empresa = _id_empresa and conta = _conta and subconta = _subconta and versao = _versao;
     
   IF (_controle = ''N'') THEN

      IF (_tipo = ''R'') THEN 

            IF (_id_operador != 0) THEN 

               _id_usuario = _id_operador;

            END IF;               

      END IF ;

   ELSE 

      _id_usuario = _id_operador;

   END IF; 

   RETURN;
 
END;
'
LANGUAGE 'plpgsql'