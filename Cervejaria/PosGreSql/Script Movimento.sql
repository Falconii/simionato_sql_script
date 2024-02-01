CREATE TABLE public.movidet  ( 
	id        	int4 NOT NULL,
	bkpf_belnr	char(20) NOT NULL,
	bkpf_gjahr	int4 NOT NULL,
	bkpf_blart	char(5) NOT NULL,
	bkpf_budat	date NOT NULL,
	bkpf_monat	int4 NOT NULL,
	bkpf_cpudt	date NOT NULL,
	bkpf_cputm	char(20) NOT NULL,
	bkpf_usnam	char(20) NOT NULL,
	bkpf_bktxt	varchar(255) NOT NULL,
	bkpf_bstat	char(5) NOT NULL,
	bseg_buzei	int4 NOT NULL,
	bseg_koart	char(1) NOT NULL,
	bseg_shkzg	char(1) NOT NULL,
	bseg_dmbtr	numeric(15,2) NOT NULL,
	bseg_sgtxt	varchar(255) NOT NULL,
	bseg_hkont	char(10) NOT NULL,
	PRIMARY KEY(bkpf_belnr,bseg_buzei,bkpf_cpudt)
)
WITHOUT OIDS 
TABLESPACE "Producao"
GO

    