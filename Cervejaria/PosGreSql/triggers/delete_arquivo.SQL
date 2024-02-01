CREATE OR REPLACE FUNCTION "public"."delete_arquivo" (in nro int4) RETURNS void AS
'
    BEGIN
    
    DELETE FROM MOVICAB WHERE MOVICAB.ID = nro;
    DELETE FROM MOVIDET WHERE MOVIDET.ID = nro; 

    END
'
LANGUAGE 'plpgsql'