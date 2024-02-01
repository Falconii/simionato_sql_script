//AFTER
CREATE OR REPLACE FUNCTION function_feriados_trigger()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL    
  AS
$$
DECLARE 

BEGIN
  
    raise notice 'function_feriados_trigger % ', TG_OP; 

    IF  (TG_OP = 'DELETE' AND OLD.id_tipo > 1) THEN 
         raise notice 'feriado OLD.nlanc_manha %,OLD.nlanc_tarde % => %', OLD.nlanc_manha,OLD.nlanc_tarde,OLD.nlanc_manha != NULL; 
       
       IF (OLD.nlanc_manha > 0) THEN
           BEGIN 
               raise notice 'Vou apagar feriado OLD.id_empresa % OLD.nlanc_manha %',OLD.id_empresa, OLD.nlanc_manha; 
               DELETE FROM public.apons_execucao WHERE ID_EMPRESA = OLD.ID_EMPRESA AND  ID =  OLD.nlanc_manha;
           END ;
       END IF;

       IF (OLD.nlanc_tarde > 0) THEN
           BEGIN 
               raise notice 'Vou apagar feriado OLD.id_empresa % OLD.nlanc_tarde %',OLD.id_empresa, OLD.nlanc_tarde; 
               DELETE FROM public.apons_execucao WHERE ID_EMPRESA = OLD.ID_EMPRESA AND  ID =  OLD.nlanc_tarde;
           END ;
       END IF;
      
       RETURN OLD;
    END IF;
   RETURN NULL;
END ;
$$
GO


DROP TRIGGER IF EXISTS  trigger_feriados ON feriados;
GO

CREATE TRIGGER trigger_feriados
  AFTER DELETE
  ON feriados
  FOR EACH ROW
  EXECUTE PROCEDURE function_feriados_trigger();
go

