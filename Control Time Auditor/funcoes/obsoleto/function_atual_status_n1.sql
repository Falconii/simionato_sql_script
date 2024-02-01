CREATE OR REPLACE FUNCTION function_atual_status_n1(in _id_empresa int4, in _id_projeto int4, in _conta text, in _subconta text, in _versao text,  in _tipo text , out _saida text)
  RETURNS text
  LANGUAGE PLPGSQL    
  AS
$$
DECLARE 
 _status_pl text;
 _status_ex text;
 _status    text;
 ct0 int4; 
 ct1 int4; 
 ct2 int4; 
BEGIN
   raise notice '';
   _saida       := 'OK';
   _status_pl   := '1';
   _status_ex   := '';
   _status      := '';
   IF (_tipo = 'P') THEN
       BEGIN
          select status, status_ex into _status, _status_ex from atividades 
            where  id_empresa = _id_empresa and 
            id_projeto = _id_projeto and 
            conta      = _conta      and 
            nivel      = 1;
         SELECT COALESCE(COUNT(*),0) into ct0  from atividades 
          where id_empresa  = _id_empresa and 
            id_projeto  = _id_projeto and 
            conta       = _conta      and 
            left(subconta,2) = left(_subconta,2)  and 
            tipo = 'S'                and 
            status_pl = '0';
          SELECT COALESCE(COUNT(*),0) into ct1  from atividades 
          where id_empresa  = _id_empresa and 
            id_projeto  = _id_projeto and 
            conta       = _conta      and 
            left(subconta,2) = left(_subconta,2)  and 
            tipo = 'S'                and 
            status_pl = '1';
          SELECT COALESCE(COUNT(*),0) into ct2  from atividades 
          where id_empresa  = _id_empresa and 
            id_projeto  = _id_projeto and 
            conta       = _conta      and 
            left(subconta,2) = left(_subconta,2)  and 
            tipo = 'S'                and 
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
            update atividades set status_pl = _status_pl, status  = _status
            where  id_empresa = _id_empresa and 
            id_projeto = _id_projeto        and 
            conta      = _conta             and 
            nivel      = 1;
       END;
   ELSE 
       BEGIN
       END;
   END IF;
END ;
$$
GO

//SELECT * FROM function_atual_status(1, 11, '14','14030201', '', 4,  'P', 'U');
