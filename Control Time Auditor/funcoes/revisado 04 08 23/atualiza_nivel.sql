CREATE OR REPLACE FUNCTION atualiza_nivel(in _id_empresa int4,in _id_projeto int4, in _conta text, in _versao text,  out _saida text)
  RETURNS text
  LANGUAGE PLPGSQL
  AS
$$
DECLARE 
 hoje Date ;
BEGIN
 hoje := CURRENT_DATE;
 _saida := 'OK';
 RAISE NOTICE 'hoje % ', hoje;

    IF (_conta <> '') THEN
  
        BEGIN

              DELETE FROM niveis WHERE id_empresa = _id_empresa AND id_projeto = _id_projeto AND conta = _conta AND versao = _versao;

              INSERT INTO niveis( id_empresa, 
                                  id_projeto, 
                                  conta, 
                                  versao, 
                                  subconta, 
                                  geracao, 
                                  nivel, 
                                  tipo, 
                                  nivelplan, 
                                  nivelexec, 
                                  user_insert, 
                                  user_update)                  
                        (SELECT 
                                  id_empresa,
                                  id_projeto,
                                  conta,
                                  versao,
                                  subconta,
                                  hoje as geracao,
                                  nivel, 
                                  tipo,
                                  get_cor(inicial,final,status_pl) as nivelplan, 
                                  get_cor(inicial,final,status_ex) as nivelexec, 
                                  user_insert, 
                                  user_update 
                         from atividades
                         WHERE  id_empresa = _id_empresa and id_projeto = _id_projeto and conta = _conta and versao = _versao and tipo = 'O' ) 
                         ORDER BY id_empresa,id_projeto,conta,subconta;
        END;
    ELSE 
          BEGIN
              DELETE FROM niveis WHERE id_empresa = _id_empresa AND id_projeto = _id_projeto ;

              INSERT INTO niveis( id_empresa, 
                                  id_projeto, 
                                  conta, 
                                  versao, 
                                  subconta, 
                                  geracao, 
                                  nivel, 
                                  tipo, 
                                  nivelplan, 
                                  nivelexec, 
                                  user_insert, 
                                  user_update)                  
                        (SELECT 
                                  id_empresa,
                                  id_projeto,
                                  conta,
                                  versao,
                                  subconta,
                                  hoje as geracao,
                                  nivel, 
                                  tipo,
                                  get_cor(inicial,final,status_pl) as nivelplan, 
                                  get_cor(inicial,final,status_ex) as nivelexec, 
                                  user_insert, 
                                  user_update 
                         from atividades
                         WHERE  id_empresa = _id_empresa and id_projeto = _id_projeto  and tipo = 'O' ) 
                         ORDER BY id_empresa,id_projeto,conta,subconta;

          END;
    END IF;
END ;
$$
GO
