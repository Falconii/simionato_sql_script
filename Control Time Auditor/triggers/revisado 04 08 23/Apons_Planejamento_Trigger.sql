CREATE OR REPLACE FUNCTION function_apos_planejamento_saldos()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL    
  AS
$$
DECLARE 
 _OK TEXT;
BEGIN
   //raise notice 'Estou aqui...';
   raise notice 'before apon_planejamento % ', TG_OP;
   IF     (TG_OP = 'INSERT') THEN
       UPDATE ATIVIDADES        SET horasplan = horasplan + NEW.horasapon                                                      where id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and (conta = NEW.id_conta and nivel = 1);
       SELECT _saida INTO _OK FROM function_atual_horas(new.id_empresa,new.id_projeto,new.id_conta,new.id_subconta,'',(length(trim(NEW.id_subconta))/2),0,new.horasapon,'P','I');
       UPDATE PROJETOS          SET horasplan = horasplan + NEW.horasapon                                                      where id_empresa = NEW.id_empresa and id = NEW.id_projeto ;
       RETURN NEW;
   ELSEIF (TG_OP = 'UPDATE') THEN
       UPDATE ATIVIDADES        SET horasplan = (horasplan - OLD.horasapon) + NEW.horasapon                                     where id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto  and (conta = NEW.id_conta and nivel = 1);
       SELECT _saida INTO _OK FROM function_atual_horas(new.id_empresa,new.id_projeto,new.id_conta,new.id_subconta,'',(length(trim(NEW.id_subconta))/2),old.horasapon,new.horasapon,'P','U');
       UPDATE PROJETOS          SET horasplan = (horasplan - OLD.horasapon) + NEW.horasapon                                     where id_empresa = NEW.id_empresa and id = NEW.id_projeto ;
       RETURN NEW;
   ELSIF  (TG_OP = 'DELETE') THEN
       UPDATE ATIVIDADES        SET horasplan = horasplan - OLD.horasapon                                                        where id_empresa = OLD.id_empresa and id_projeto = OLD.id_projeto and (conta = old.id_conta and nivel = 1);
       SELECT _saida INTO _OK FROM function_atual_horas(OLD.id_empresa,OLD.id_projeto,OLD.id_conta,OLD.id_subconta,'',(length(trim(OLD.id_subconta))/2),OLD.horasapon,0,'P','D');
       UPDATE PROJETOS          SET horasplan = horasplan - OLD.horasapon                                                        where id_empresa = OLD.id_empresa and id = OLD.id_projeto ;
       RETURN OLD;
   END IF;
   RETURN NULL;
END ;
$$
GO


DROP TRIGGER IF EXISTS  trigger_apos_planejamento_saldos ON apons_planejamento;
GO

CREATE TRIGGER trigger_apos_planejamento_saldos
  BEFORE INSERT OR UPDATE OR DELETE
  ON apons_planejamento
  FOR EACH ROW
  EXECUTE PROCEDURE function_apos_planejamento_saldos();
go


//AFTER
CREATE OR REPLACE FUNCTION function_apos_planejamento_status()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL    
  AS
$$
DECLARE 
 _status_pl CHAR(1);
 _HORASPLAN numeric(7,2);
 _OK text;
 _status_ex text;
 _status    text;
 _descricao text;
BEGIN
    raise notice 'after apon_planejamento % ', TG_OP; 
    _descricao = '';
    IF     (TG_OP = 'INSERT') THEN
       select descricao from projetos into _descricao where id_empresa = new.id_empresa and id = new.id_projeto;
       SELECT status, status_ex INTO _status, _status_ex from atividades 
       WHERE id_empresa  = new.id_empresa and 
             id_projeto  = new.id_projeto and 
             conta       = new.id_conta   and
             subconta    = new.id_subconta;
       IF (new.encerra = 'S') THEN
          _status_pl := '2';
       ELSE 
          _status_pl := '1';
       END IF; 
       if (_status_pl = '0' and _status_ex = '0') then
           _status := '0';
       end if;
       if (_status_pl = '1' and _status_ex = '1') then
          _status := '2';
       end if;
       if (_status_pl  <>  _status_ex ) then
          _status := '1';
       end if;
       UPDATE ATIVIDADES  SET status = _status, status_pl = _status_pl   where id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and conta = new.id_conta and subconta = NEW.id_subconta  ;
       SELECT _SAIDA INTO _OK FROM function_atual_status(new.id_empresa, new.id_projeto,new.id_conta,new.id_subconta,'',(length(trim(new.id_subconta))/2), 'P');
       UPDATE PROJETOS SET descricao = _descricao where id_empresa = new.id_empresa and id = new.id_projeto; 
       RETURN NEW;
   ELSEIF (TG_OP = 'UPDATE') THEN
       select descricao from projetos into _descricao where id_empresa = new.id_empresa and id = new.id_projeto;
       SELECT status, status_ex INTO _status, _status_ex from atividades 
       WHERE id_empresa  = new.id_empresa and 
             id_projeto  = new.id_projeto and 
             conta       = new.id_conta   and
             subconta    = new.id_subconta;
       IF (new.encerra = 'S') THEN
          _status_pl := '2';
       ELSE 
          _status_pl := '1';
       END IF; 
       if (_status_pl = '0' and _status_ex = '0') then
           _status := '0';
       end if;
       if (_status_pl = '1' and _status_ex = '1') then
          _status := '2';
       end if;
       if (_status_pl  <>  _status_ex ) then
          _status := '1';
       end if;
       UPDATE ATIVIDADES      SET status = _status, status_pl = _status_pl  where id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and conta = new.id_conta and  subconta = NEW.id_subconta  ;
       SELECT _SAIDA INTO _OK FROM function_atual_status(new.id_empresa, new.id_projeto,new.id_conta,new.id_subconta,'',(length(trim(new.id_subconta))/2), 'P');
       UPDATE PROJETOS SET descricao = _descricao where id_empresa = new.id_empresa and id = new.id_projeto;
       RETURN NEW;

   ELSIF  (TG_OP = 'DELETE') THEN 
       select descricao from projetos into _descricao where id_empresa = old.id_empresa and id = old.id_projeto;
       SELECT coalesce(horasplan,0), status, status_pl, status_ex INTO _HORASPLAN, _status, _status_pl, _status_ex from atividades 
       WHERE id_empresa  = old.id_empresa and 
             id_projeto  = old.id_projeto and 
             conta       = old.id_conta   and
             subconta    = old.id_subconta;

       IF  (_HORASPLAN = 0) THEN
            _status_pl := '0';
       ELSE
            IF (OLD.encerra = 'S') THEN
               _status_pl := '1';
            END IF; 
       END IF ; 
       if (_status_pl = '0' and _status_ex = '0') then
          _status := '0';
       end if;
       if (_status_pl = '1' and _status_ex = '1') then
          _status := '1';
       end if;
       if (_status_pl = '2' and _status_ex = '2') then
          _status := '2';
       end if;
       if (_status_pl  <>  _status_ex ) then
          _status := '1';
       end if;
       UPDATE ATIVIDADES      SET status = _status, status_pl = _status_pl        where id_empresa = old.id_empresa and id_projeto = old.id_projeto and conta = old.id_conta and subconta = old.id_subconta  ;
       SELECT _SAIDA INTO _OK FROM function_atual_status(old.id_empresa, old.id_projeto, old.id_conta, old.id_subconta,'',(length(trim(old.id_subconta))/2), 'P');
       UPDATE PROJETOS SET descricao = _descricao where id_empresa = old.id_empresa and id = old.id_projeto;
       RETURN OLD;

   END IF;
   RETURN NULL;
END ;
$$
GO


DROP TRIGGER IF EXISTS  trigger_apos_planejamento_status ON apons_planejamento;
GO

CREATE TRIGGER trigger_apos_planejamento_status
  AFTER INSERT OR UPDATE OR DELETE
  ON apons_planejamento
  FOR EACH ROW
  EXECUTE PROCEDURE function_apos_planejamento_status();
go

