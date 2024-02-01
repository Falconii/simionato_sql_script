CREATE OR REPLACE FUNCTION function_atual_horas(in _id_empresa int4, in _id_projeto int4, in _conta text, in _subconta text, in _versao text, in _nivel int4, in _oldhoras numeric(5,2), in _newhoras numeric(5,2), in _tipo text, in _acao text,  out _saida text)
  RETURNS text
  LANGUAGE PLPGSQL    
  AS
$$
DECLARE 
 __subconta text;
 nivel int4;
BEGIN
   raise notice '';
   __subconta := trim(_subconta);
   nivel    := _nivel;
   _saida   := 'OK';
   LOOP
       __subconta = left(__subconta,nivel*2);
       raise notice 'parametros: _id_empresa % _id_projeto % _conta % _subconta % _versao %  _nivel % _oldhoras % _newhoras % _tipo % _acao % ', _id_empresa , _id_projeto , _conta , _subconta , _versao ,  _nivel , _oldhoras , _newhoras , _tipo , _acao ; 
       IF (_TIPO = 'P') THEN
        BEGIN
            IF (_ACAO = 'D') THEN 
                BEGIN 
                    UPDATE ATIVIDADES        
                    SET    horasplan =  horasplan - _oldhoras 
                    WHERE  id_empresa = _id_empresa and id_projeto = _id_projeto and 
                           conta = _conta and subconta = __subconta ;            
                END;
            ELSE
                BEGIN 
                    UPDATE ATIVIDADES        
                    SET    horasplan = (horasplan - _oldhoras) + _newhoras
                    WHERE  id_empresa = _id_empresa and id_projeto = _id_projeto and 
                           conta = _conta and subconta = __subconta ;            
                END;
            END IF;
        END;
       ELSE 
          BEGIN
            IF (_ACAO = 'D') THEN 
                BEGIN 
                    UPDATE ATIVIDADES        
                    SET    horasexec =  horasexec - _oldhoras
                    WHERE  id_empresa = _id_empresa and id_projeto = _id_projeto and 
                           conta = _conta and subconta = __subconta ;            
                END;
            ELSE
                BEGIN 
                    UPDATE ATIVIDADES        
                    SET    horasexec = (horasexec - _oldhoras) + _newhoras
                    WHERE  id_empresa = _id_empresa and id_projeto = _id_projeto and 
                           conta = _conta and subconta = __subconta ;            
                END;
            END IF;                                                    
          END;
       END IF;
       nivel  := nivel - 1;
       EXIT WHEN nivel < 2;
   END LOOP; 
END ;
$$
GO

//SELECT function_atual_horas(1,11,'14','14030201','',4,10,12);