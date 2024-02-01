CREATE OR REPLACE FUNCTION function_atual_status(in _id_empresa int4, in _id_projeto int4, in _conta text, in _subconta text, in _versao text, in _nivel int4,  in _tipo text,  out _saida text)
  RETURNS text
  LANGUAGE PLPGSQL    
  AS
$$
DECLARE 
 tempo public.atividades%ROWTYPE;
 __subconta text;
 __nivel int4;
 ___subconta text;
 ct0 int4;
 ct1 int4;
 ct2 int4;
 regs      int4;
 _status_ex text;
 _status_pl text;
 _status    text; 
BEGIN
   raise notice '';
   __subconta := trim(_subconta);
   __nivel      := _nivel;
   _saida       := 'OK';
   _status_ex   := '1';
   _status_pl   := '1';
   ct0= 0 ;
   ct1= 0 ;
   ct2= 0 ;
   LOOP
       __subconta = left(__subconta,__nivel*2);
       raise notice 'parametros: _subconta % nivel %',  __subconta, __nivel   ; 
       IF (_tipo = 'P') THEN
          BEGIN
                    ct0= 0 ;
                    ct1= 0 ;
                    ct2= 0 ;
                    FOR tempo in  SELECT *  from atividades 
                                  where id_empresa  = _id_empresa and 
                                  id_projeto  = _id_projeto and 
                                  conta       = _conta      and 
                                  left(subconta,(__nivel-1)*2) = left(__subconta,(__nivel-1)*2) and  tipo = 'O'    
                                  order by id_empresa,id_projeto,conta,subconta   asc 
                     LOOP   
                           raise notice '==>: _id_empresa % _id_projeto % _conta % __subconta1 % - % tipo % statuspl pl % ', tempo.id_empresa , tempo.id_projeto , tempo.conta , left(__subconta,(__nivel-1)*2) , tempo.subconta, tempo.tipo, tempo.status_pl ; 
                           if (tempo.status_pl = '0') then 
                               ct0 = ct0 +1;
                           end if;
                           if (tempo.status_pl = '1') then 
                               ct1 = ct1 +1;
                           end if;
                           if (tempo.status_pl = '2') then 
                               ct2 = ct2 +1;
                           end if;
                     END LOOP;
                     ___subconta = left(__subconta,(__nivel-1)*2);
                     select status_ex into  _status_ex from atividades 
                            where  
                            id_empresa = _id_empresa and 
                            id_projeto = _id_projeto and 
                            conta      = _conta      and 
                            subconta   = ___subconta;

                     raise notice 'parametros: _id_empresa % _id_projeto % _conta % __subconta1 % ___subconta2 % ct0 % ct1 % ct2 % ', _id_empresa , _id_projeto , _conta , __subconta, ___subconta , ct0, ct1, ct2; 
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
                        // define status
                     raise notice 'status finais: _status % _status_pl % _status_ex % ', _status, _status_pl ,_status_ex ; 
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
                     raise notice 'UPDATE: ___subconta1 %  _status %  _status_pl % ', ___subconta  , _status   , _status_pl;
                     update atividades set status = _status, status_pl = _status_pl 
                        where  id_empresa = _id_empresa and 
                               id_projeto = _id_projeto and 
                               conta      = _conta      and 
                               subconta   = ___subconta;
          END;
       ELSE 
          BEGIN   
                    ct0= 0 ;
                    ct1= 0 ;
                    ct2= 0 ;
                    FOR tempo in  SELECT *  from atividades 
                                  where id_empresa  = _id_empresa and 
                                  id_projeto  = _id_projeto and 
                                  conta       = _conta      and 
                                  left(subconta,(__nivel-1)*2) = left(__subconta,(__nivel-1)*2) and  tipo = 'O'    
                                  order by id_empresa,id_projeto,conta,subconta   asc 
                     LOOP   
                           raise notice '==>: _id_empresa % _id_projeto % _conta % __subconta1 % - % tipo % statusex ex % ', tempo.id_empresa , tempo.id_projeto , tempo.conta , left(__subconta,(__nivel-1)*2) , tempo.subconta, tempo.tipo, tempo.status_ex ; 
                           if (tempo.status_ex = '0') then 
                               ct0 = ct0 +1;
                           end if;
                           if (tempo.status_ex = '1') then 
                               ct1 = ct1 +1;
                           end if;
                           if (tempo.status_ex = '2') then 
                               ct2 = ct2 +1;
                           end if;
                     END LOOP;
                     ___subconta = left(__subconta,(__nivel-1)*2);
                     select status_pl into  _status_pl from atividades 
                            where  
                            id_empresa = _id_empresa and 
                            id_projeto = _id_projeto and 
                            conta      = _conta      and 
                            subconta   = ___subconta;

                     raise notice 'parametros: _id_empresa % _id_projeto % _conta % __subconta1 % ___subconta2 % ct0 % ct1 % ct2 % ', _id_empresa , _id_projeto , _conta , __subconta, ___subconta , ct0, ct1, ct2; 
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
                        // define status
                     raise notice 'INICIO status finais: _status % _status_pl % _status_ex % ', _status, _status_pl ,_status_ex ; 
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
                     raise notice 'UPDATE: ___subconta1 %  _status %  _status_pl % _status_ex % ', ___subconta  , _status , _status_pl  , _status_ex;
                     update atividades set status = _status, status_ex = _status_ex 
                        where  id_empresa = _id_empresa and 
                               id_projeto = _id_projeto and 
                               conta      = _conta      and 
                               subconta   = ___subconta;
                                                
          END; 
       END IF;
       __nivel  := __nivel - 1;
       EXIT WHEN __nivel < 2;
   END LOOP; 
END ;
$$
GO
