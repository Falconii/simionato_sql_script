CREATE TABLE public.nfe_valores_dema  ( 
    id_demanda                      int4 NOT NULL,
	id                            	int4 NOT NULL,
	nro_linha                     	int4 NOT NULL,
	dtnfe                         	date NOT NULL,
	dtcredito                     	date NULL,
	vlr_economico_pis             	numeric(18,4) NULL,
	vlr_outro_pis                 	numeric(18,4) NULL,
	vlr_economico_cofins          	numeric(18,4) NULL,
	vlr_outro_cofins              	numeric(18,4) NULL,
	dtfcorrecao                   	date NULL,
	vlr_economico_pis_corrigido   	numeric(18,4) NULL,
	vlr_outro_pis_corrigido       	numeric(18,4) NULL,
	vlr_economico_cofins_corrigido	numeric(18,4) NULL,
	vlr_outro_cofins_corrigido    	numeric(18,4) NULL,
	metodo_pis                    	char(5) NULL,
	metodo_cofins                 	char(5) NULL,
	taxa                          	numeric(7,2) NULL,
	usuarioinclusao               	int4 NULL,
	usuarioatualizacao            	int4 NULL,
	PRIMARY KEY(id_demanda,id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

CREATE TABLE public.nfe_valores_ipi_dema  ( 
    id_demanda          int4 NOT NULL,
	id                	int4 NOT NULL,
	nro_linha         	int4 NOT NULL,
	dtnfe             	date NOT NULL,
	dtcredito         	date NULL,
	dtfcorrecao       	date NULL,
	vlr_ipi           	numeric(18,4) NULL,
	vlr_ipi_corrigido 	numeric(18,4) NULL,
	taxa              	numeric(7,2) NULL,
	usuarioinclusao   	int4 NULL,
	usuarioatualizacao	int4 NULL,
	PRIMARY KEY(id_demanda,id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

CREATE TABLE public.nfe_cab_status  ( 
    id_demanda          int4 NOT NULL,
	id                	serial NOT NULL,
	dtbebida          	timestamp NULL,
	dtimposto         	timestamp NULL,
	dtselic           	timestamp NULL,
	dtvenda           	timestamp NULL,
	dtvendames        	timestamp NULL,
	PRIMARY KEY(id_demanda,id)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

DROP TABLE nfe_det_nota_ve_dema;
GO

CREATE TABLE public.nfe_det_nota_ve_dema  (
    id_demanda      int4 NOT NULL, 
	id          	int4 NOT NULL,
	nro_linha   	int4 NOT NULL,
	dtnf        	date NOT NULL,
	nro         	char(9) NOT NULL,
	serie       	char(3) NOT NULL,
	nr_item     	varchar(10) NULL,
	material    	char(15) NULL,
	descricao   	varchar(100) NULL,
	qtd         	numeric(15,4) NULL,
	vlr_contabil	numeric(15,4) NULL,
	bas_ipi     	numeric(15,2) NULL,
	per_ipi     	numeric(6,2) NULL,
	vlr_ipi     	numeric(15,2) NULL,
	sem_venda   	varchar(1) NULL,
	id_v        	int4 NULL,
	nro_linha_v 	int4 NULL,
	PRIMARY KEY(id_demanda,id,nro_linha)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO
CREATE INDEX nfe_det_nota_ve_dema_01
	ON public.nfe_det_nota_ve_dema USING btree (id_demanda int4_ops, id_v int4_ops, nro_linha_v int4_ops)
GO


  SELECT tabela.*
  from  (  SELECT cab.planilha as planilha,cab.id as id,count(det.*) as nfe,coalesce(status.id,0) as status,count(comp.*) as complemento,count(cfop.*) as cfop  
           FROM   demanda_planilha plan  
           LEFT JOIN nfe_det det on det.id = plan.id_planilha  
           LEFT JOIN nfe_det_comp   comp    on comp.id = det.id and comp.nro_linha = det.nro_linha  
           LEFT JOIN nfe_det_cfop   cfop    on cfop.id = det.id and cfop.nro_linha = det.nro_linha  
           LEFT JOIN nfe_cab        cab     on cab.id = det.id  
           LEFT JOIN nfe_cab_status status  on status.id = det.id  
           WHERE  plan.id_demanda = 1  GROUP BY cab.planilha,cab.id  ) as tabela  
  where not (tabela.nfe = tabela.complemento and tabela.nfe = tabela.status and tabela.nfe = tabela.cfop) 

SELECT distinct CASE    WHEN prod.cnpj IS NULL then 'I'   ELSE                        'A' END AS operacao, cli.empresa,cab.local,cab.cnpj,cab.sistema,det.material,det.descricao,det.ncm,comp.bebida FROM   demanda_planilha plan INNER JOIN nfe_det det on det.id = plan.id_planilha INNER JOIN nfe_det_comp comp on comp.id = det.id and comp.nro_linha = det.nro_linha  and comp.bebida = ''  INNER JOIN nfe_cab cab  on cab.id = det.id INNER JOIN clientes cli  on cab.cnpj = cli.cnpj_cpf LEFT JOIN produto_bebida prod on prod.cnpj = cab.cnpj and prod.sistema = cab.sistema and prod.material = det.material and prod.descricao = det.descricao and prod.ncm = det.ncm WHERE plan.id_demanda = 1  LIMIT 1000 OFFSET 0 

SELECT * from  nfe_cab_status
go

truncate nfe_cab_status
go

insert into nfe_cab_status(id_demanda, id, dtbebida, dtimposto, dtselic, dtvenda, dtvendames)  VALUES (   1   , 1    , null , null , null , null , null )


