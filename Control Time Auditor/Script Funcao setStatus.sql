CREATE OR REPLACE FUNCTION public.setStatus(_id_empresa int4, _id_projeto int4 , _id_subconta text) RETURNS void AS
$$
DECLARE
 _id        int  = 0;
 _horasplan numeric(7,2);
 _horasexec numeric(7,2);
 _id_conta  text = '';
 _status_pl text = '';
 _status_ex text = '';
 _status_pl_original text = '';
 _status_ex_original text = '';
 _status    text = '';
 _NLANC     int4 = 0;
 _NLANC_E   int4 = 0;

BEGIN

     _id_conta = substring(_id_subconta,1,2);

     RAISE NOTICE 'Processando SUBCONTA PLANEJAMENTO % % ', _id_subconta, _id_conta;

     //Busca a atividade operacional
     SELECT  ID_EMPRESA, ID, ID_PROJETO ,  STATUS_PL   , STATUS_EX  ,  STATUS
     INTO  
            _ID_EMPRESA,_ID,_ID_PROJETO , _STATUS_PL   , _STATUS_EX , _STATUS
     FROM ATIVIDADES 
     WHERE ID_EMPRESA = _id_empresa AND ID_PROJETO = _ID_PROJETO AND SUBCONTA = _ID_SUBCONTA;

     RAISE NOTICE '0601 _ID_EMPRESA,_ID,_ID_PROJETO , _STATUS_PL , _STATUS_EX % % % % % ', _ID_EMPRESA,_ID,_ID_PROJETO , _STATUS_PL , _STATUS_EX;

     IF (_STATUS_PL <= '2') THEN
            RAISE NOTICE 'Processando subconta 0601 status_pl %', _status_ex_original;
           SELECT COALESCE(COUNT(*),0) INTO _NLANC FROM apons_planejamento 
                                                   WHERE id_empresa = _id_empresa and id_projeto = _id_projeto and id_subconta = _id_subconta  ;
           raise notice '_NLANC % ',_NLANC;
           IF (_NLANC = 0 ) THEN
              _STATUS_PL = '0';
           ELSE     
              SELECT COALESCE(COUNT(*),0) INTO _NLANC_E FROM apons_planejamento 
                                                        WHERE id_empresa = _id_empresa and id_projeto = id_projeto and id_subconta = id_subconta  and encerra = 'S' ;
              raise notice '_NLANC_E % ', _NLANC_E;
              IF (_NLANC_E = 0) THEN
                 _STATUS_PL = '1';
              ELSE 
                 _STATUS_PL = '2';
              END IF;
           END IF;
           raise notice 'NOVO _STATUS_PL 0601 % ',_STATUS_PL;
     END IF;
     

     RAISE NOTICE 'Processando SUBCONTA EXECUCAO % % ', _id_subconta, _id_conta;

     IF (_STATUS_EX <= '2') THEN
           SELECT COALESCE(COUNT(*),0) INTO _NLANC FROM apons_execucao apo
                                                   INNER JOIN motivos_apo mot on mot.id_empresa = apo.id_empresa and mot.codigo = apo.id_motivo and mot.produtivo = 'S'
                                                   WHERE apo.id_empresa = _id_empresa and apo.id_projeto = _id_projeto and apo.id_subconta = _id_subconta ;
           raise notice '_NLANC % ',_NLANC;
           IF (_NLANC = 0 ) THEN
              _STATUS_EX = '0';
           ELSE     
              SELECT COALESCE(COUNT(*),0) INTO _NLANC_E FROM apons_execucao apo
                                                        INNER JOIN motivos_apo mot on mot.id_empresa = apo.id_empresa and mot.codigo = apo.id_motivo and mot.produtivo = 'S'
                                                        WHERE apo.id_empresa = _id_empresa and apo.id_projeto = id_projeto and apo.id_subconta = id_subconta  and encerramento = 'S' ;
              raise notice '_NLANC_E % ', _NLANC_E;
              IF (_NLANC_E = 0) THEN
                 _STATUS_EX = '1';
              ELSE 
                 _STATUS_EX = '2';
              END IF;
           END IF;
           raise notice 'Novo _STATUS_EX 0601 % ',_STATUS_EX;
     END IF;

     //define status subconta
     if (_status_pl_original <= '2'AND  _status_ex_original <= '2') THEN

        //status
        IF (_status <= '2') THEN
            IF ( (_status_pl = '2') AND (_status_ex = '2') ) THEN
               _status = '2';
            ELSE 
                IF ( (_status_pl = '0') AND (_status_ex = '0')) THEN
                   _status = '0';
                ELSE 
                   _status = '1';
                END IF;
            END IF;
            raise notice 'Novo _STATUS 0601 % ',_STATUS_EX;
        END IF;

        UPDATE ATIVIDADES SET STATUS_PL = _STATUS_PL  , STATUS_EX = _STATUS_EX   ,  STATUS = _STATUS WHERE ID_EMPRESA = _ID_EMPRESA AND ID = _ID;


     END IF; 

     //Busca atividade nivel 1

     SELECT  ID_EMPRESA, ID, ID_PROJETO , STATUS_PL   , STATUS_EX ,   STATUS
     INTO  
            _ID_EMPRESA,_ID,_ID_PROJETO , _STATUS_PL , _STATUS_EX , _STATUS
     FROM ATIVIDADES 
     WHERE ID_EMPRESA = _ID_EMPRESA AND ID_PROJETO = _ID_PROJETO AND CONTA = _ID_CONTA;

     RAISE NOTICE '06 _ID_EMPRESA,_ID,_ID_PROJETO , _STATUS_PL , _STATUS_EX % % % % % ', _ID_EMPRESA,_ID,_ID_PROJETO , _STATUS_PL , _STATUS_EX;
     
     _status_pl_original = _status_pl;
     _status_ex_original = _status_ex;

     IF (_STATUS_PL <= '2') THEN
           SELECT COALESCE(COUNT(*),0) INTO _NLANC FROM atividades      WHERE id_empresa = _id_empresa   and id_projeto  = _id_projeto and conta = _id_conta and nivel > 1 and (status_pl <> '2');
           raise notice '_NLANC % ',_NLANC;
           IF (_NLANC = 0 ) THEN
              _STATUS_PL = '2';
           ELSE     
              SELECT COALESCE(COUNT(*),0) INTO _NLANC_E FROM atividades WHERE id_empresa = _id_empresa and id_projeto = _id_projeto and conta = _id_conta and nivel > 1 and (status_pl <> '1');
              raise notice '_NLANC_E % ', _NLANC_E;
              IF (_NLANC_E = 0) THEN
                 _STATUS_PL = '1';
              ELSE 
                 _STATUS_PL = '0';
              END IF;
           END IF;
           raise notice 'NOVO STATUS 06 _STATUS_PL % ',_STATUS_PL;
     END IF;

     IF (_STATUS_EX <= '2') THEN
           SELECT COALESCE(COUNT(*),0) INTO _NLANC FROM atividades      WHERE id_empresa = _id_empresa   and id_projeto  = _id_projeto and conta = _id_conta and nivel > 1 and (status_ex <> '2');
           raise notice '_NLANC % ',_NLANC;
           IF (_NLANC = 0 ) THEN
              _STATUS_EX = '2';
           ELSE     
              SELECT COALESCE(COUNT(*),0) INTO _NLANC_E FROM atividades WHERE id_empresa = _id_empresa and id_projeto = _id_projeto and conta = _id_conta and nivel > 1 and (status_ex <> '1');
              raise notice '_NLANC_E % ', _NLANC_E;
              IF (_NLANC_E = 0) THEN
                 _STATUS_EX = '1';
              ELSE 
                 _STATUS_EX = '0';
              END IF;
           END IF;
           raise notice 'NOVO STATUS 06 _STATUS_EX % ',_STATUS_EX;
        
     END IF;
    //define status subconta
     if (_status_pl_original <= '2'AND  _status_ex_original <= '2') THEN

         //status
         IF (_status <= '2') THEN
             IF ( (_status_pl = '2') AND (_status_ex = '2') ) THEN
                _status = '2';
             ELSE 
                 IF ( (_status_pl = '0') AND (_status_ex = '0')) THEN
                    _status = '0';
                 ELSE 
                    _status = '1';
                 END IF;
             END IF;
         END IF;

         
         UPDATE ATIVIDADES SET STATUS_PL = _STATUS_PL  , STATUS_EX = _STATUS_EX   ,  STATUS = _STATUS WHERE ID_EMPRESA = _ID_EMPRESA AND ID = _ID;

     END IF; 

END;
$$
LANGUAGE 'plpgsql'
GO

select from setStatus(1,1,TRIM('0601'));