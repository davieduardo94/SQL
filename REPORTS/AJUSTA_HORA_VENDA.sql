
update estoque set hora=substring(hora from 0 for 9);
--------------------------------------------------------------
select distinct 'update venda set hora_venda='''||hora||''' where id='||id_vendas_itens||' and id_empresa='||loja||';'  
id_vendas_itens from estoque where data BETWEEN ' ' and ' ' and 
loja= and 
id_vendas_itens in 
(select id from venda where data_venda BETWEEN ' ' and ' ') 
ORDER BY id_vendas_itens;
