select
c.id,
c.id_empresa as EMPRESA,
c.id_cliente as ID_CLIENTE,
c.cliente_nome as NOME_CLIENTE,
c.cliente_fone as FONE_1,
c.cliente_celular as FONE_2,
c.id_profissional,
p1.nome_razao as profissional,
c.data,
c.hora,
c.status,
CASE 
	WHEN c.status=0 THEN
		'AGENDADO'
	WHEN c.status=1 THEN
		'ATENDIDO'
		ELSE
		'CANCELADO'
END AS STATUS_ATENDIMENTO,
c.user_agendou,
u.login AS NOME_USUARIO,
c.atendido_data as DATA_ATENDIMENTO,
c.tot_consulta as VALOR
from clinica_agenda c 
join pessoa p on p.id=c.id_cliente
join pessoa p1 on p1.id=c.id_profissional
join usuario u on u.id=c.user_agendou
where c.id_empresa=  and c.data between ' ' and ' '
order by data
