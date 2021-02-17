select min(id) from V where EMPRESA=  and DATA>'2020-12-31';

select 'update V_I set compra='||pcompra||', vpcusto='||pcompra||' where produto='||id_produto||' and ID_VENDA>= ;' from produto_empresa 
where ID_EMPRESA= 
and id_produto in 
(select id_produto from venda_itens where ID_VENDA>= ) 
and status=0 
ORDER BY id_produto;
