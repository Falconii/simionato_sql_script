Select                     fec.id                    AS FEC_ID 
                          ,fec.descricao             as FEC_DESCRICAO
                          ,cli.empresa               as EMPRESA_S
                          ,to_char(ven.dtnf, 'YYYY') as ANO 
                          ,ven.id                    as "ID_S" 
                          ,ven.nro_linha             as "NRO_LINHA_S"
                          --,ven.chave                 as CHAVE_S
                          ,ven.cod_empresa           AS COD_EMPRESA_S 
                          ,ven.local                 AS LOCAL_S 
                          --,cli.cnpj_cpf              AS CNPJ_S
                          --,ven.id_planilha 
                          --,ven.dtlanc 				 as DT_LANC_S 
                          --,ven.dtnf 				 AS DTNF_S
                          ,ven.nro					 AS NRO_NF_S  
                          ,ven.serie				 AS SERIE_S 
                          ,ven.material 			 AS MATERIAL_S 
                          ,ven.descricao 			 AS DESCRICAO_S 
                          ,ven.cfop 				 AS CFOP_S 
                          ,ven.qtd 					 AS "QTD_S"
                          --,ven.vlr_contabil 		 AS "VALOR_TOTAL_S"
                          --,ven.bas_icms     		 AS "BASE_ICMS_S"
                          --,ven.bas_pis      		 AS "BASE_PIS_S"
                          --,ven.per_pis      		 AS "PERC_PIS_S"
                          --,ven.vlr_pis               AS "VLR_PIS_S"
                          --,ven.bas_cof               AS "BASE_COF_S"
                          --,ven.per_cof               AS "PERC_COFINS_S"
                          --,ven.vlr_cof               AS "VLR_COF_S"
                          ,ven.saldo                 AS "SALDO_VENDA"
                          ,ent.id                    AS "ID_E"
                          ,ent.nro_linha             AS "NRO_LINHA_E"
                          --,ent.chave                 AS "chave_E"
                          ,ent.cod_empresa           AS "EMPRESA__E"
                          ,ent.local                 AS "LOCAL_E"
                          --,ven.id_planilha			 AS "ID_PLANILHA_E"
                          --,ent.dtlanc                AS "DT_LANC_E"
                          --,ent.dtnf                  AS "TD_NF_E"
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
                          --,ent.vlr_contabil	    AS "VALOR_TOTAL_E"
                          --,ent.bas_icms		    AS "BASE_ICMS_E"
                          ,ent.saldo			AS "SALDO_ENTRADA_E"
                          ,con.qtd_e			AS "QTD_USADA_E"
                          --,case  
						--	 when ent.operacao = 'E' then round((ent.bas_icms / ent.qtd), 4)
							-- else ent.vlr_unit
                           --end as P_Unit 
                          --,case 
						--	 when ent.operacao = 'E' then round((con.qtd_e* (round((ent.bas_icms/ ent.qtd),4))),4)
						--	 else round((con.qtd_e * ent.vlr_unit), 4)
                         --  end as BASE_PIS 
                        --  ,ven.per_pis AS "PER_PIS"
                         -- ,case 
							-- when ent.operacao = 'E' then round((con.qtd_e* (round((ent.bas_icms/ ent.qtd),4)) *(ven.per_pis / 100)),4)
						--	 else round((con.qtd_e * ent.vlr_unit) * (ven.per_pis / 100), 4)
                         --  end as VLR_PIS 
                         -- ,case 
					--		 when ent.operacao = 'E' then round((con.qtd_e* (round((ent.bas_icms/ ent.qtd),4))),4)
				--			 else round((con.qtd_e * ent.vlr_unit), 4)
                  --         end as BASE_COFINS 
                   --       ,ven.per_cof "PER_COFINS"
                    --      ,case 
                    --           when ent.operacao = 'E' then round((con.qtd_e* (round((ent.bas_icms/ ent.qtd),4)) *(ven.per_cof / 100)),4) 
                     --          else round((con.qtd_e * ent.vlr_unit) * (ven.per_cof / 100), 4)
                     --      end as VLR_COFINS 
                           from fechamento fec 
                           inner join controle_e con  on con.id_grupo = fec.id_grupo and con.id_fechamento = fec.id 
                           inner join nfe_det_e ven on ven.id = con.id_s and ven.nro_linha = con.nro_linha_s 
                           inner join nfe_det_e ent on ent.id = con.id_e and ent.nro_linha = con.nro_linha_e 
                           inner join clientes cli on cli.cod_empresa = ven.cod_empresa and cli.local = ven.local 
                           order by cli.empresa,to_char(ven.dtnf,'YYYY'),ven.id,ven.nro_linha,ent.operacao,ent.serie,ent.nro
