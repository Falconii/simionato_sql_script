CREATE OR REPLACE FUNCTION function_apos_execucao_saldos()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE 
 _OLD_PRODUTIVO   CHAR(1);
 _NEW_PRODUTIVO   CHAR(1);
BEGIN
   raise notice 'Estou aqui...';
   
   IF     (TG_OP = 'UPDATE' OR TG_OP = 'DELETE') THEN
          SELECT mot.produtivo into _OLD_PRODUTIVO
          FROM   motivos_apo mot 
          WHERE  mot.id_empresa = OLD.id_empresa and mot.codigo = OLD.id_motivo;
   ELSE 
          _OLD_PRODUTIVO = '';
   END IF;
   

    IF     (TG_OP <> 'DELETE') THEN
            SELECT mot.produtivo into _NEW_PRODUTIVO
            FROM   motivos_apo mot 
            WHERE  mot.id_empresa = NEW.id_empresa and mot.codigo = NEW.id_motivo;
   ELSE 
            _NEW_PRODUTIVO = '';
   END IF ;

   IF     (TG_OP = 'INSERT') THEN
       IF (_NEW_PRODUTIVO = 'S') THEN
           UPDATE ATIVIDADES        SET horasexec = (horasexec + NEW.horasapon)   where id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and  ( ( subconta = NEW.id_subconta ) OR (conta = NEW.id_conta and nivel = 1)) ;
           UPDATE PROJETOS          SET horasexec = (horasexec + NEW.horasapon)   where id_empresa = NEW.id_empresa and id = NEW.id_projeto ;
       END IF ;
       RETURN NEW;
   ELSEIF (TG_OP = 'UPDATE') THEN
       IF (_OLD_PRODUTIVO = 'S') THEN
           UPDATE ATIVIDADES        SET horasexec = (horasexec - OLD.horasapon)  where id_empresa = OLD.id_empresa and id_projeto = OLD.id_projeto and  ( ( subconta = OLD.id_subconta ) OR (conta = OLD.id_conta and nivel = 1)) ;
           UPDATE PROJETOS          SET horasexec = (horasexec - OLD.horasapon)  where id_empresa = OLD.id_empresa and id = OLD.id_projeto ;
       END IF ;
       IF (_NEW_PRODUTIVO = 'S') THEN
            UPDATE ATIVIDADES        SET horasexec = (horasexec + NEW.horasapon)   where id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and  ( ( subconta = NEW.id_subconta ) OR (conta = NEW.id_conta and nivel = 1)) ;
            UPDATE PROJETOS          SET horasexec = (horasexec + NEW.horasapon)   where id_empresa = NEW.id_empresa and id = NEW.id_projeto ;
       END IF;
       RETURN NEW;
   ELSIF (TG_OP = 'DELETE')  THEN
        raise notice '_OLD_PRODUTIVO %',_OLD_PRODUTIVO;
       IF (_OLD_PRODUTIVO = 'S') THEN
           UPDATE ATIVIDADES        SET horasexec = (horasexec - OLD.horasapon)  where id_empresa = OLD.id_empresa and id_projeto = OLD.id_projeto and  ( ( subconta = OLD.id_subconta ) OR (conta = OLD.id_conta and nivel = 1)) ;
           UPDATE PROJETOS          SET horasexec = (horasexec - OLD.horasapon)  where id_empresa = OLD.id_empresa and id = OLD.id_projeto ;
       END IF;
       RETURN OLD;
   END IF;
   RETURN NULL;
END ;
$$
GO


DROP TRIGGER IF EXISTS  trigger_apos_execucao_saldos ON apons_execucao;
GO

CREATE TRIGGER trigger_apos_execucao_saldos
  BEFORE INSERT OR UPDATE OR DELETE
  ON apons_execucao
  FOR EACH ROW
  EXECUTE PROCEDURE function_apos_execucao_saldos();
go

