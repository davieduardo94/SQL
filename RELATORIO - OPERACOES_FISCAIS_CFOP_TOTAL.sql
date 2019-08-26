select 
NFI.ID_EMPRESA,
nf.id_nf,
nf.emissao_data,
nf.id_cliente,
p.nome_razao,
nf.status,
nf.id_venda,
Nfi.prod_cfop,
SUM(nfi.icms_bc),
SUM(nfi.icms_valor),
SUM(NFI.icms_st_base),
SUM(NFI.icms_st_valor),
SUM(nfi.prod_vprod) AS TOTAL_PRODUTO
from 
nfe_prc as nf
join nfe_itens as nfi on nfi.id_nfe=nf.id_nf
join pessoa as p on p.id=nf.id_cliente
where nfi.id_empresa=3 and nf.emissao_data between '2019-08-01' and '2019-08-26' AND STATUS=100  GROUP BY ID_EMPRESA,ID_NF, ID_CLIENTE, EMISSAO_DATA, NOME_RAZAO, STATUS, NF.ID_VENDA, NFI.PROD_CFOP ORDER BY NF.ID_NF