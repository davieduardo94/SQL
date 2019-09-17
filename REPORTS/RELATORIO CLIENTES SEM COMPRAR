
select

P.ID,
p.nome_razao,
p.cad_data,
max(v.data_venda) as ULTIMA_COMPRA,
V.ID AS VEMDA,
count(v.id)
from pessoa p
join venda v on v.id_cliente=p.id
where 
p.id not in (select v.id_cliente from venda v where v.data_venda BETWEEN '2019-07-01' and '2019-07-31') 
AND 
v.data_venda BETWEEN '2019-05-01' and '2019-08-31' 
GROUP BY 
P.ID,p.nome_razao, p.cad_data,V.ID, v.data_venda 
ORDER BY v.data_venda
