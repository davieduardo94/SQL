update P set CUSTO=COMPRA where CUSTO=0 and CODIGO_EMPRESA=;
--------------------------------------------------------
select 'update V_I set COMPRA_VL='||COMPRA||' where COD_VENDA in (select CODIGO from V where CODIGO_EMPRESA=) and COD_PRODUTO='||PROD_COD||';' from P_E where CODIGO_EMPRESA= and PROD_COD in (select CODIGO from P where status=0) and status=0 ORDER BY PROD_COD;
--------------------------------------------------------
update V_I set CUSTO=COMPRA where COD_VENDA in (select CODIGO from V where CODIGO_EMPRESA=);