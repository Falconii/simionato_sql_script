CREATE OR REPLACE FUNCTION function_atividades_saldo_dir()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE 
BEGIN
   IF  (TG_OP = 'INSERT' AND NEW.NIVEL = 1) THEN
       UPDATE PROJETOS          SET horasdir = horasdir +   new.horasdir                  where id_empresa = new.id_empresa and id = new.id_projeto ;
       RETURN NEW;
   END IF;
   IF  (TG_OP = 'UPDATE' AND NEW.NIVEL = 1) THEN
       UPDATE PROJETOS          SET horasdir = (horasdir - OLD.horasdir) + new.horasdir   where id_empresa = new.id_empresa and id = new.id_projeto ;
       RETURN NEW;
   END IF;
   IF  (TG_OP = 'DELETE') THEN
       IF (OLD.NIVEL = 1) THEN
           UPDATE PROJETOS          SET horasdir = horasdir - OLD.horasdir                    where id_empresa = OLD.id_empresa and id = OLD.id_projeto ;
       END IF;
       RETURN OLD;
   END IF;
   RETURN NEW;
END ;
$$
GO


DROP TRIGGER IF EXISTS  trigger_ativ_saldo_dir ON atividades;
GO

CREATE TRIGGER trigger_ativ_saldo_dir
  BEFORE INSERT OR UPDATE OR DELETE
  ON atividades
  FOR EACH ROW
  EXECUTE PROCEDURE function_atividades_saldo_dir()
go


/*
SELECT 
ID, HORASPLAN,HORASEXEC,HORASDIR 
FROM PROJETOS ORDER BY ID

SELECT A.*,E.DESCRICAO
FROM ATIVIDADES A 
INNER JOIN ESTRUTURAS E ON E.CONTA = A.CONTA AND E.SUBCONTA = A.SUBCONTA  
WHERE A.ID_PROJETO = 9 AND A.NIVEL = 1

UPDATE ATIVIDADES SET HORASDIR = 100 WHERE ID = 4682

UPDATE PROJETOS SET HORASDIR = 0 WHERE ID = 9

*/