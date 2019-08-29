CREATE OR REPLACE VIEW public.vw_relatorio_venda_vendedor AS 
SELECT venda.id,
venda.data_venda,
venda.id_empresa,
empresa.fantasia AS empresa_fantasia,
venda.id_cliente,
pessoa.nome_razao AS NOME_CLIENTE,
pessoa.apelido_fantasia AS conhecido_por,
pessoa.fone1 AS fone1,
pessoa.fone2 AS fone2,
venda.id_vendedor,
pessoa1.nome_razao AS vendedor_nome,
venda.id_fpagto,
forma_pagamento.descricao AS forma_pagamento,
venda.tot_bruto,
venda.tot_desc_prc,
venda.tot_desc_vlr,
venda.tot_liquido,
venda.vlr_acrescimos,
venda.obs,
venda.tipo_comissao,
venda.comissao_prc
FROM venda
JOIN empresa ON venda.id_empresa = empresa.id
JOIN pessoa ON venda.id_cliente = pessoa.id
JOIN pessoa pessoa1 ON venda.id_vendedor = pessoa1.id
JOIN forma_pagamento ON venda.id_fpagto = forma_pagamento.id