/*
CREATE FUNCTION ROUND(
  input float,     -- the input number
  accuracy float   -- accuracy, the "counting unit"
) RETURNS float AS $f$
   SELECT ROUND($1/accuracy)*accuracy
$f$ language SQL IMMUTABLE;
go
*/
CREATE OR REPLACE FUNCTION get_cor(in  _inicio date,in  _fim date,  in _status text, out _nivel int4)
  RETURNS int4
  LANGUAGE PLPGSQL
  AS
$$
DECLARE 
 hoje Date ;
 perc float;
 totDias float;
 pasDias float;
BEGIN
 hoje := CURRENT_DATE;
 totDias := 0; 
 pasDias := 0;
 _nivel  := -1;
 IF (_status > '1') THEN
    BEGIN
       return;
    END ;
 END IF;
 //
 //RAISE NOTICE 'hoje % _fim %', hoje,_fim;
if  ( (hoje >= _inicio) and (hoje <= _fim)) then
   begin
      totDias = (_fim - _inicio) + 1;
      pasDias = (hoje - _inicio) + 1;
      perc =    (pasDias/totDias)*100;
      //RAISE NOTICE 'Contrato No Intervalo totDias % pasDias % perc % ',totDias,pasDias,perc;
      if (perc <= 50) then
         begin
           _nivel = 1;
         end;
      end if;
      if (perc > 50 and perc <= 70) then
         begin
           _nivel = 2;
         end;
      end if;
      if (perc > 70 and perc <= 100) then
         begin
          _nivel = 3;
         end;
      end if;
      return;
   end;
end if;
 if (hoje < _inicio) then
    begin
      //RAISE NOTICE 'Contrato Para O Futuro..';
      _nivel := 1;
      return;
    end;
 end if; 
 if (hoje > _fim) then
    begin
      //RAISE NOTICE 'Contrato Atrasado...';
      _nivel := 4;
      return;
    end;
 end if; 
END ;
$$
GO


CREATE OR REPLACE FUNCTION get_cor_niveis(in _id_empresa int4, in _id_projeto int4, in _subconta text, in _nivel int4, in _status text,  out __nivel int4)
  RETURNS int4
  LANGUAGE PLPGSQL
  AS
$$
DECLARE 
 hoje Date ;
BEGIN
 hoje := CURRENT_DATE; 
 if (_status = 'P' ) then
    begin
       SELECT max(nivelplan) INTO __nivel FROM niveis where id_empresa = _id_empresa and id_projeto = _id_projeto and left(subconta,(_nivel*2)) =  left(_subconta,(_nivel*2));
    end;
 else  
   begin
       SELECT max(nivelexec) INTO __nivel FROM niveis where id_empresa = _id_empresa and id_projeto = _id_projeto and left(subconta,(_nivel*2)) =  left(_subconta,(_nivel*2)) ;
    end;
 end if;
END ;
$$
GO




