CREATE OR REPLACE FUNCTION function_projetos_status()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE 
 ct0 int4;
 ct1 int4;
 ct2 int4;
 _status    text;
 _status_pl text;
 _status_ex text;
BEGIN
 _status := '';
 _status_pl :='';
 _status_ex := '';
   IF  (TG_OP = 'UPDATE' AND NEW.STATUS <= '2') THEN
      _status = new.status;
      IF (NEW.status_pl <= '2') THEN
          BEGIN
            ct0 := 0;
            ct1 := 0;
            ct2 := 0;
            SELECT COALESCE(COUNT(*),0) into ct0  from atividades 
            where id_empresa  = new.id_empresa and 
                  id_projeto  = new.id         and  
                  tipo = 'C'                   and 
                  status_pl = '0';
            SELECT COALESCE(COUNT(*),0) into ct1  from atividades 
            where id_empresa  = new.id_empresa and 
                  id_projeto  = new.id         and  
                  tipo = 'C'                   and 
                  status_pl = '1';
            SELECT COALESCE(COUNT(*),0) into ct2  from atividades 
            where id_empresa  = new.id_empresa and 
                  id_projeto  = new.id         and  
                  tipo = 'C'                   and 
                  status_pl = '2';
                  if (ct1 > 0)  then
                        _status_pl := '1';
                  else 
                        if (ct0 > 0 and ct1 = 0 and ct2 = 0) then
                          _status_pl := '0';
                        end if;
                        if (ct0 > 0 and ct1 = 0 and ct2 > 0) then
                          _status_pl := '1';
                        end if;
                        if (ct0 = 0 and ct1 = 0 and ct2 > 0) then
                          _status_pl := '2';
                        end if;
                 end if;
          END;
      END IF;
      IF (NEW.status_ex <= '2') THEN
            ct0 = 0;
            ct1 = 0;
            ct2 = 0;
            SELECT COALESCE(COUNT(*),0) into ct0  from atividades 
            where id_empresa  = new.id_empresa and 
                  id_projeto  = new.id         and  
                  tipo = 'C'                   and 
                  status_ex = '0';
            SELECT COALESCE(COUNT(*),0) into ct1  from atividades 
            where id_empresa  = new.id_empresa and 
                  id_projeto  = new.id         and  
                  tipo = 'C'                   and 
                  status_ex = '1';
            SELECT COALESCE(COUNT(*),0) into ct2  from atividades 
            where id_empresa  = new.id_empresa and 
                  id_projeto  = new.id         and  
                  tipo = 'C'                   and 
                  status_ex = '2';
                  if (ct1 > 0)  then
                        _status_ex := '1';
                  else 
                        if (ct0 > 0 and ct1 = 0 and ct2 = 0) then
                          _status_ex := '0';
                        end if;
                        if (ct0 > 0 and ct1 = 0 and ct2 > 0) then
                          _status_ex := '1';
                        end if;
                        if (ct0 = 0 and ct1 = 0 and ct2 > 0) then
                          _status_ex := '2';
                        end if;
                 end if;
      END IF;
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
      new.status    := _status;
      new.status_pl := _status_pl;
      new.status_ex := _status_ex;
      new.status_ex := _status_ex;
   END IF;
   RETURN NEW;
END ;
$$
GO


DROP TRIGGER IF EXISTS  trigger_projetos_status ON projetos;
GO

CREATE TRIGGER trigger_projetos_status
  BEFORE UPDATE
  ON projetos
  FOR EACH ROW
  EXECUTE PROCEDURE function_projetos_status();
go

