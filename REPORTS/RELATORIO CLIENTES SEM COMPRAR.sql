SELECT v.id_cliente,
       p.nome_razao,
       p.apelido_fantasia,
       p.fone1,
       pessoa1.nome_razao AS vendedor_nome,
       max(v.data_venda) AS ULTIMA_COMPRA
FROM venda v
JOIN pessoa pessoa1 ON v.id_vendedor = pessoa1.id
JOIN pessoa p ON v.id_cliente = p.id
WHERE v.status=1
  AND data_venda BETWEEN '2019-06-01' AND '2019-07-30'
  AND v.id_cliente NOT IN
    (SELECT id_cliente
     FROM venda
     WHERE data_venda>'2019-08-01')
GROUP BY v.id_cliente,
         p.nome_razao,
         p.apelido_fantasia,
         pessoa1.nome_razao,
         p.fone1,
         v.data_venda
ORDER BY data_venda
