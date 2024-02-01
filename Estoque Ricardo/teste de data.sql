CREATE OR REPLACE FUNCTION "public"."teste_data" ()
RETURNS void
AS
$$
DECLARE

_last    date;
_data    date;

BEGIN
    //_data    := CURRENT_DATE;           
    _data := Date '2023-01-01';
    _last    := _data - interval '4 years 11 months';
    RAISE NOTICE '_data % _last % Age % ',_data,_last, AGE(_last,_data); 
END;
$$
LANGUAGE 'plpgsql'
go

SELECT * FROM teste_data();