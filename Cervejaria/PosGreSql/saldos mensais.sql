SELECT * FROM  SALDO

-- Listagem de 2023
select
  "CNPJ",
  "UNIDADE",
  coalesce("Jan/2023",0)  as  "Jan/2023" ,
  coalesce("Fev/2023",0)  as  "Fev/2023" ,
  coalesce("Mar/2023",0)  as  "Mar/2023" ,
  coalesce("Abr/2023",0)  as  "Abr/2023" ,
  coalesce("Mai/2023",0)  as  "Mai/2023" ,
  coalesce("Jun/2023",0)  as  "Jun/2023" 
  from crosstab('SELECT acu.cnpj,depara.unid,((cast(acu.ano as integer)-2007-1)*12+cast(acu.mes as integer)) as mes,acu.total_nfe FROM acumulado_data_qtd_nf acu left join depara on depara.cnpj = acu.cnpj order by acu.cnpj ',
                'select m from generate_series(1,120) m') as  ct(
  "CNPJ" text,
  "UNIDADE" text,
  "Jan/2023" numeric(10,2),
  "Fev/2023" numeric(10,2),
  "Mar/2023" numeric(10,2),
  "Abr/2023" numeric(10,2),
  "Mai/2023" numeric(10,2),
  "Jun/2023" numeric(10,2)
);



SELECT sld.cdempresa,sld.cdfilial,sld.ano,sld.mes,sld.conta,sld.saldofinal
FROM saldo sld
ORDER BY sld.cdempresa,sld.cdfilial,sld.ano,sld.mes
