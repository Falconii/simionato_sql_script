CREATE OR REPLACE FUNCTION function_tarefas_projeto_saldos()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE 
 _TOTAIS numeric(10,2);
BEGIN
   IF  (TG_OP = 'UPDATE') THEN
       IF (NEW.status = '3') THEN
           SELECT COALESCE(COUNT(*),0) INTO _TOTAIS FROM trabalhos_projeto WHERE id_empresa = NEW.id_empresa and id_tarefa = NEW.id_tarefa and status = '2';
           IF (_TOTAIS = 0 ) THEN
              NEW.status = '4';         
           END IF;
       END IF;
      IF (NEW.status = '4') THEN
           SELECT COALESCE(COUNT(*),0) INTO _TOTAIS FROM trabalhos_projeto WHERE id_empresa = NEW.id_empresa and id_tarefa = NEW.id_tarefa and status = '2';
           IF (_TOTAIS > 0 ) THEN
              NEW.status = '3';         
           END IF;
       END IF;
 
       RETURN NEW;
   END IF;
   RETURN NULL;
END ;
$$
GO


DROP TRIGGER IF EXISTS  trigger_tarefas_projeto_saldos ON tarefas_projeto;
GO

CREATE TRIGGER trigger_tarefas_projeto_saldos
  BEFORE UPDATE
  ON tarefas_projeto
  FOR EACH ROW
  EXECUTE PROCEDURE function_tarefas_projeto_saldos();
go

