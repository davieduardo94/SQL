select 
E.id,
e.data,
e.hora,
e.id_produto_empresa as IDPRODUTO,
p.descricao as nome_produto,
e.saldo_anterior,
e.qtde as quantidade,
e.saldo_atual,
e.tipo,
e.id_entrada_itens,
e.id_vendas_itens,
e.id_balanco_itens,
e.tipo_operacao,
CASE 
	WHEN e.tipo_operacao=1 THEN
	'(+)IMPORTAÇAO XML'
	WHEN e.tipo_operacao=2 THEN
	'(+)ENTRADA'
	WHEN e.tipo_operacao=12 THEN
	'(-)VENDA'
	WHEN e.tipo_operacao=11 THEN
	'(=)BALANÇO ESTOQUE'
	WHEN e.tipo_operacao=15 THEN
	'(+)CANCELAMENTO DE VENDA'
	WHEN e.tipo_operacao=37 THEN
	'(-)TRANSFERENCIA'
	WHEN e.tipo_operacao=39 THEN
	'(-)EXTRAVIO/PERDA'
	WHEN e.tipo_operacao=46 THEN
	'(+)CANCELAMENTO DE SAIDA'
	WHEN e.tipo_operacao=52 THEN
	'(+)REABERTURA DE BALANÇO'
END
from estoque e
join produto p on  e.id_produto_empresa = p.id 
where data > '2020-01-01' ORDER BY data
