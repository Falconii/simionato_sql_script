CREATE OR REPLACE FUNCTION function_atividades_saldos2()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
DECLARE 
 _NLANC   INT4;
 _NLANC_E INT4;
 _STATUS_PL CHAR(1);
 _STATUS_EX CHAR(1);
BEGIN
   raise notice 'ATIVIDADES conta % %  ',TG_OP, NEW.subconta;
   IF  (TG_OP = 'UPDATE' AND NEW.tipo = 'O') THEN
       raise notice 'ATIVIDADES After planejamento status_pl %  % ',TG_OP, NEW.status_pl;
       IF (NEW.status_pl <= '2') THEN
           SELECT COALESCE(COUNT(*),0) INTO _NLANC FROM apons_planejamento WHERE id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and id_subconta = NEW.subconta ;
           raise notice '_NLANC % ',_NLANC;
           IF (_NLANC = 0 ) THEN
              _STATUS_PL = '0';
           ELSE     
              SELECT COALESCE(COUNT(*),0) INTO _NLANC_E FROM apons_planejamento WHERE id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and id_subconta = NEW.subconta  and encerra = 'S' ;
              raise notice '_NLANC_E % ', _NLANC_E;
              IF (_NLANC_E = 0) THEN
                 _STATUS_PL = '1';
              ELSE 
                 _STATUS_PL = '2';
              END IF;
           END IF;
           NEW.status_pl = _STATUS_PL;
       END IF;
       //EXECUCAO
       raise notice 'ATIVIDADES After planejamento status_ex %  % ',TG_OP, NEW.status_ex;
       IF (NEW.status_ex <= '2') THEN
           raise notice 'Vou manipular o status da atividade.. status_ex % ', NEW.status_ex;
           SELECT COALESCE(COUNT(*),0) INTO _NLANC FROM apons_execucao WHERE id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and id_subconta = NEW.subconta ;
           raise notice '_NLANC % ',_NLANC;
           IF (_NLANC = 0 ) THEN
              _STATUS_EX = '0';
           ELSE     
              SELECT COALESCE(COUNT(*),0) INTO _NLANC_E FROM apons_execucao WHERE id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and id_subconta = NEW.subconta  and encerra = 'S' ;
              raise notice '_NLANC_E % ', _NLANC_E;
              IF (_NLANC_E = 0) THEN
                 _STATUS_EX = '1';
              ELSE 
                 _STATUS_EX = '2';
              END IF;
           END IF;
           NEW.status_ex = _STATUS_EX;
       END IF;
       //status
       raise notice 'ATIVIDADES After planejamento status %  % ',TG_OP, NEW.status;
       IF (NEW.status <= '2') THEN
           IF ( (NEW.status_pl = '2') AND (NEW.status_ex = '2') ) THEN
              NEW.status = '2';
           ELSE 
               IF ( (NEW.status_pl = '0') AND (NEW.status_ex = '0')) THEN
                  NEW.status = '0';
               ELSE 
                  NEW.status = '1';
               END IF;
           END IF;
       END IF;
       RETURN NEW;
   END IF;
   //CONTA
   IF  (TG_OP = 'UPDATE' AND NEW.nivel  = 1) THEN
       //PLANEJAMENTO
        IF (NEW.status_pl <= '2') THEN
           SELECT COALESCE(COUNT(*),0) INTO _NLANC FROM atividades WHERE id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and conta = NEW.conta and nivel > 1 and (status_pl <> '2');
           raise notice '_NLANC % ',_NLANC;
           IF (_NLANC = 0 ) THEN
               _STATUS_PL = '2';
           ELSE 
              SELECT COALESCE(COUNT(*),0) INTO _NLANC_E FROM atividades WHERE id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and conta = NEW.conta and nivel > 1 and (status_pl <> '1');
              IF ( _NLANC_E = 0) THEN 
                 _STATUS_PL = '1';
              ELSE 
                 _STATUS_PL = '0';
              END IF;
           END IF;
           NEW.status_pl = _STATUS_PL;
        END IF;
        //EXECUTADO
        IF (NEW.status_ex <= '2') THEN
           SELECT COALESCE(COUNT(*),0) INTO _NLANC FROM atividades WHERE id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and conta = NEW.conta and nivel > 1 and (status_ex <> '2');
           raise notice '_NLANC % ',_NLANC;
           IF (_NLANC = 0 ) THEN
               _STATUS_EX = '2';
           ELSE 
              SELECT COALESCE(COUNT(*),0) INTO _NLANC_E FROM atividades WHERE id_empresa = NEW.id_empresa and id_projeto = NEW.id_projeto and conta = NEW.conta and nivel > 1 and (status_ex <> '1');
              IF ( _NLANC_E = 0) THEN 
                 _STATUS_EX = '1';
              ELSE 
                 _STATUS_EX = '0';
              END IF;
           END IF;
           NEW.status_ex = _STATUS_EX;
        END IF;
        //status
        IF (NEW.status <= '2') THEN
            IF ( (NEW.status_pl = '2') AND (NEW.status_ex = '2') ) THEN
               NEW.status = '2';
            ELSE 
                IF ( (NEW.status_pl = '0') AND (NEW.status_ex = '0')) THEN
                   NEW.status = '0';
                ELSE 
                   NEW.status = '1';
                END IF;
            END IF;
        END IF;
       //horas diretoria                                                                                                       
        UPDATE PROJETOS SET horasdir = (horasdir - OLD.horasdir) + NEW.horasdir  where id_empresa = NEW.id_empresa and id = NEW.id_projeto ;
        RETURN NEW;
   END IF;
   IF  (TG_OP = 'DELETE' AND OLD.nivel  = 1) THEN
       UPDATE PROJETOS          SET horasplan = horasplan - OLD.horasapon        where id_empresa = OLD.id_empresa and id = OLD.id_projeto ;
       RETURN OLD;
   END IF;
   RETURN NEW;
END ;
$$
GO


DROP TRIGGER IF EXISTS  trigger_atividades_saldos ON atividades;
GO

CREATE TRIGGER trigger_ativ_status_pl()
  BEFORE UPDATE
  ON atividades
  FOR EACH ROW
  EXECUTE PROCEDURE function_atividades_saldos2();
go


/*
SELECT 
ID, HORASPLAN,HORASEXEC,HORASDIR 
FROM PROJETOS ORDER BY ID

SELECT A.*,E.DESCRICAO
FROM ATIVIDADES A 
INNER JOIN ESTRUTURAS E ON E.CONTA = A.CONTA AND E.SUBCONTA = A.SUBCONTA  
WHERE A.ID_PROJETO = 9 AND A.NIVEL = 1

UPDATE ATIVIDADES SET HORASDIR = 100 WHERE ID = 4682

UPDATE PROJETOS SET HORASDIR = 0 WHERE ID = 9

*/