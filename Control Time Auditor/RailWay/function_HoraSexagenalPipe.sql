CREATE OR REPLACE FUNCTION function_HSrxagenal(in  _hora numeric , out _horasSexagenal text ) 
AS
$$
DECLARE
posicao int4;
minutos int4;
_minutos text;


BEGIN
     _horasSexagenal = '00:00';
     if (_hora > 0) then
        begin
            posicao = POSITION('.' in to_char(_hora,'0009.00'));
           _minutos = substr(to_char(_hora,'0009.99'),posicao+1);
            RAISE NOTICE '_minutos %', _minutos;
           minutos = (SELECT CAST (_minutos AS INTEGER))/1.67;
           _horasSexagenal = substr(to_char(_hora,'0009.99'),0,6) || ':' || trim(to_char(minutos,'09')) ;
       end ;   
     end if;
END;
$$
LANGUAGE 'plpgsql'
go


select * from function_HSrxagenal(999.90)