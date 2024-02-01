Select                     ent.id                    AS "ID_E"
                          ,ent.nro_linha             AS "NRO_LINHA_E"
                          ,ent.chave                 AS "chave_E"
                          ,ent.cod_empresa           AS "EMPRESA__E"
                          ,ent.local                 AS "LOCAL_E"
                          ,cnpj_cpf                  AS "CNPJ"
                          ,ent.dtlanc                AS "DT_LANC_E"
                          ,ent.dtnf                  AS "TD_NF_E"
                          ,ent.nro                   AS "NRO_NF_E"
                          ,ent.serie				 AS "SERIE_E"
                          ,case  
							 when ent.operacao = 'E' then 'ENTRADA' 
							 else 					  	  'SALDO ANTERIOR' 
                           end as OPERACAO 
                          ,ent.material             AS "MATERIAL_E"
                          ,ent.descricao            AS "DESCRICAO_E" 
                          ,ent.cfop                 AS "CFOP_E"
                          ,ent.qtd 					as "QTD_E"
                          ,case  
                                  when ent.operacao = 'E' then 0 
                                  else ent.qtd-ent.sobra
                           end as QTD_REMANESCENTE 
                          ,ent.vlr_contabil	    AS "VALOR_TOTAL_E"
                          ,ent.bas_icms		    AS "BASE_ICMS_E"
                          ,ent.saldo			AS "SALDO_ENTRADA_E"
                           ,case
                              when (ent.qtd = ent.saldo) then 'N'
                              else                            'S'
                           end as usado
                           from nfe_det_e ent
                           inner join clientes cli on cli.cod_empresa = ent.cod_empresa and cli.local = ent.local 
                           where ( (ENT.operacao = 'E' AND ENT.vlr_cof = 0 ) or (ENT.operacao = 'A' ))
                           order by cli.empresa,to_char(ent.dtnf,'YYYY'),ent.id,ent.nro_linha,ent.operacao,ent.serie,ent.nro
