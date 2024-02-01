SELECT he.arquivo,he.dtgravacao,he.hrgravacao,he.seqgravacao,he.resbanco,he.banco,he.contacorrente,he.agencia,he.razaoempresa,sega.* 
from segmentoa sega 
INNER JOIN header he on he.id = sega.id_header
order by sega.id_header,sega.nro_linha
go


SELECT sega.nomefavorecido,sega.datapagamento,sum(sega.valorpagamento) total
from segmentoa sega 
group by sega.nomefavorecido,sega.datapagamento
order by sega.nomefavorecido,sega.datapagamento
go


SELECT he.arquivo,he.banco,he.contacorrente,he.agencia,he.razaoempresa,segb.* 
from segmentob segb 
INNER JOIN header he on he.id = segb.id_header
order by segb.id_header,segb.nro_linha
go

SELECT he.arquivo,he.dtgravacao,he.hrgravacao,he.seqgravacao,he.resbanco
FROM HEADER he
group by he.arquivo,he.dtgravacao,he.hrgravacao,he.seqgravacao,he.resbanco
order by he.arquivo,he.dtgravacao,he.hrgravacao,he.seqgravacao,he.resbanco