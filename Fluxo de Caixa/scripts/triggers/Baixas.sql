CREATE OR REPLACE FUNCTION function_baixas()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL    
  AS
$$
DECLARE 
 _OK TEXT;
BEGIN
   //raise notice 'Estou aqui...';
   raise notice 'before baixas % ', TG_OP;
   IF     (TG_OP = 'INSERT') THEN
       UPDATE DOCUMENTOS  SET 
             vlr_pago = (vlr_pago + NEW.valor) ,
             saldo = (valor-abatimento+juros) -  (vlr_pago + NEW.valor)  
       WHERE id_empresa = NEW.id_empresa and id = NEW.id_doc;
       RETURN NEW;
   ELSEIF (TG_OP = 'UPDATE') THEN
       UPDATE DOCUMENTOS  SET 
              vlr_pago = (vlr_pago - OLD.valor) + NEW.valor  , 
              saldo = (valor-abatimento+juros) -  ((vlr_pago - OLD.valor) + NEW.valor)  
       WHERE  id_empresa = NEW.id_empresa and id = NEW.id_doc;
       RETURN NEW;
   ELSIF  (TG_OP = 'DELETE') THEN
       UPDATE DOCUMENTOS  SET 
              vlr_pago = (vlr_pago - OLD.valor)  , 
              saldo    = (valor-abatimento+juros) - (vlr_pago - OLD.valor) 
       WHERE  id_empresa = OLD.id_empresa and id = OLD.id_doc;
       RETURN OLD;
   END IF;
   RETURN NULL;
END ;
$$
GO


DROP TRIGGER IF EXISTS  trigger_baixas ON baixas;
GO

CREATE TRIGGER trigger_baixas
  BEFORE INSERT OR UPDATE OR DELETE
  ON baixas
  FOR EACH ROW
  EXECUTE PROCEDURE function_baixas();
go
