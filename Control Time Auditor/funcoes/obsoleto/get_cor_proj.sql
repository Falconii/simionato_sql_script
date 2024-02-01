CREATE OR REPLACE FUNCTION get_cor_proj(in id_empresa , in id_projeto , in _status , out _nivel int4)
  RETURNS int4
  LANGUAGE PLPGSQL
  AS
$$
DECLARE
BEGIN
 _nivel  := -1;
 IF (_status > '1') THEN
    BEGIN
       return;
    END ;
 END IF; 
 return;
END ;
$$
GO

                    get_cor(ativ.inicial,ativ.final,ativ.status_pl) as nivelplan, 
                    get_cor(ativ.inicial,ativ.final,ativ.status_ex) as nivelexec

SELECT get_cor(ativ.inicial,ativ.final,ativ.status_pl) as nivelplan, 
       get_cor(ativ.inicial,ativ.final,ativ.status_ex) as nivelexec
from   atividades ativ
where  ativ.id_empresa = 1 and ativ.id_projeto = 11 and ativ.tipo = 'C'



