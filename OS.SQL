-------------------- AJUSTAR FORMA DE PAGAMENTO ---------------------------------
select *from tb_ord_servicos where CODFPAGTO not in (select CODFPAGTO from tb_fpagtos)
update tb_ord_servicos set codfpagto=1 where CODFPAGTO not in (select CODFPAGTO from tb_fpagtos)

-------------------------------------UPDATE IDENTIFICADOR MULTI ------------------------------------------------------------
update TB_ORD_SERVICOS set IDENTIFICADOR = replace(IDENTIFICADOR,'-','');
update TB_ORD_SERVICOS set IDENTIFICADOR =  SUBSTRING(identificador,0,4)+ '-' + SUBSTRING(identificador,4,8)+ 'RO';
update TB_ORD_SERVICOS set IDENTIFICADOR = replace(IDENTIFICADOR,'RO','-RO');

-------------------------- OS DO MULTI ------------------------------------------
select 'insert into oservicos
(id,entrada_data,entrada_hora,entrada_id_usuario,id_empresa,id_pessoa, tipo_servico,situacao_os,status,id_formapagto,tot_servicos_bru,tot_servicos_desc_prc,tot_servicos_desc_vlr,tot_servicos_liq,tot_pecas_bru,tot_pecas_desc_prc,tot_pecas_desc_vlr,tot_pecas_liq,tot_geral_bruto,tot_geral_desc_prc,tot_geral_acrescimo,tot_geral_liquido,conclusao_data,conclusao_hora,conclusao_id_usuario,tot_geral_entrada,identificador,oficina_km,processado,id_user_processor,tot_geral_desc_valor,defeito_reclamado,defeito_constatado,padrao_obs,padrao_nuserie,padrao_modelo,padrao_marca)
VALUES ('+CAST(NUOS AS VARCHAR(10))+','''+COALESCE(convert(varchar(20),DATA_AB,111),'2016-08-30 00:00:00.000')+''','''+COALESCE(CAST(HORA_AB AS VARCHAR(100)),'00:00:00')+''','+'(select COALESCE(id,1) from usuario where login ='''+(USER_AB )+''' limit 1 )'+',1,'+'(select COALESCE(id,1) from pessoa where ID ='+COALESCE(CAST(CODCLIENTE AS VARCHAR(100)),'1')+'),0,
'+COALESCE(CAST(TIPO_OS AS VARCHAR(100)),'0')+','+CAST(STATUS AS VARCHAR(100))+','+COALESCE(CAST(CODFPAGTO AS VARCHAR(10)),'1')+','+CAST(TOT_SERVICOS AS VARCHAR(100))+','+COALESCE(CAST(TOT_DESC_SERV_PRC AS VARCHAR(100)),'0')+','+COALESCE(CAST(TOT_DESC_SERV_VLR AS VARCHAR(100)),'0')+','+CAST(TOT_LIQUIDO AS VARCHAR(100))+','+CAST(TOT_LIQUIDO AS VARCHAR(100))+','+COALESCE(CAST(TOT_DESC_PRC AS VARCHAR(100)),'0')+','+COALESCE(CAST(TOT_DESC_VLR AS VARCHAR(100)),'0')+','+COALESCE(CAST(TOT_LIQUIDO AS VARCHAR(100)),'0')+','+COALESCE(CAST(TOT_BRUTO AS VARCHAR(100)),'0')+','+COALESCE(CAST(TOT_DESC_PRC AS VARCHAR(100)),'0')+',0,'+COALESCE(CAST(TOT_LIQUIDO AS VARCHAR(100)),'0')+','''+COALESCE(convert(varchar(20),FECHOU_DATA,111),'2016-08-30 00:00:00.000')+''','''+COALESCE(convert(varchar(20),FECHOU_HORA,111),'00:00:00')+''','+COALESCE(CAST(CODCLIENTE AS VARCHAR(100)),'1')+',0,'''+COALESCE(CAST(IDENTIFICADOR AS VARCHAR(100)),'')+''','+COALESCE(CAST(KM AS VARCHAR(100)),'0')+',0,'+'(select COALESCE(id,1) from usuario where login ='''+(USER_AB )+''' limit 1 )'+',0,'''+coalesce(cast(DEFEITO as varchar(100)),'')+''','''+coalesce(cast(CONSTATADO as varchar(100)),'')+''','''+coalesce(cast(OCORRENCIAS as varchar(100)),'')+''','''+coalesce(cast(NU_SERIE as varchar(100)),'')+''','''+coalesce(cast(MODELO as varchar(100)),'')+''','''+coalesce(cast(MARCA as varchar(100)),'')+''');' from tb_ord_servicos 


select 'update oservicos set padrao_nuserie='''+coalesce(cast(NU_SERIE as varchar(100)),'')+''',  padrao_modelo='''+coalesce(cast(MODELO as varchar(100)),'')+''', padrao_marca='''+coalesce(cast(MARCA as varchar(100)),'')+''' where id=+CAST(NUOS AS VARCHAR(10))+';' from tb_ord_servicos 


-------------------------- ITENS OS -------------------------
select  'INSERT INTO public.oservicos_itens(
id_os,item,complemento,id_produto,vlr_vendido,qtde,vlr_bruto, vlr_desc_prc,vlr_desc_vlr,vlr_liquido,id_tecnico, entregue,grade)
    VALUES ('+coalesce(cast(os_numero as varchar(100)),'1')+','''+coalesce(cast(ITEM as varchar(100)),'')+''','''+coalesce(cast(desc_prod as varchar(100)),'')+''','			 
             +coalesce(cast(codproduto as varchar(100)),'1')+','
             +coalesce(cast(vl_vendido as varchar(100)),'0')+','
             +coalesce(cast(qtde_sai as varchar(100)),'0')+','
             +coalesce(cast(tot_bru as varchar(100)),'0')+','
             +coalesce(cast(tot_des as varchar(100)),'0')+','
             +coalesce(cast(tot_des as varchar(100)),'0')+','
             +coalesce(cast(tot_liq as varchar(100)),'0')+','
             +coalesce(cast(codvendedor as varchar(100)),'1')+','
             +'1'+','
             +'''UN'');' from tb_estoque_sub where os_numero in (select nuos from TB_ORD_SERVICOS) ORDER BY OS_NUMERO


select os_numero from TB_ESTOQUE_SUB where os_numero in (select nuos from TB_ORD_SERVICOS)

------------------------ PRODUTO SERVIÇOS --------------------
update produto set status=0,servico=1 where status=3 

-------------------------COMPLEMENTO OS -----------------------

select 'update public.oservicos_itens set complemento='''+coalesce(cast(desc_prod as varchar(100)),'')+''' where id_produto='+coalesce(cast(codproduto as varchar(100)),'1')+' and item='''+coalesce(cast(item as varchar(100)),'')+''' and id_os='+coalesce(cast(os_numero as varchar(100)),'1')+';' from tb_estoque_sub where os_numero in (select nuos from TB_ORD_SERVICOS)

select 'update public.oservicos_itens set item='''+coalesce(cast(ITEM as varchar(100)),'')+''' where id_produto='+coalesce(cast(codproduto as varchar(100)),'1')+' and id_os='+coalesce(cast(os_numero as varchar(100)),'1')+';' from tb_estoque_sub where os_numero in (select nuos from TB_ORD_SERVICOS)

---------------------------------------------------------------

/*
select 'delete from tb_estoque_sub where os_numero='+cast(os_numero as varchar(100))+';' from tb_estoque_sub where os_numero not in (select nuos from tb_ord_servicos ) and os_numero>0 group by os_numero

delete from tb_estoque_sub where os_numero=

SELECT 'insert into oservicos_veiculos (placa,marca,modelo) values ('''+COALESCE(IDENTIFICADOR,'')+''','''+COALESCE(MARCA,'')+''','''+COALESCE(MODELO,'')+''');' FROM TB_ORD_SERVICOS group by marca,modelo,identificador
*/

------------------------------CORRIGIR VALOR TOTAL PECAS E SERVICOS OS ---------------------------------------------------


select 'update oservicos set tot_servicos_bru='
+coalesce(cast(tot_servicos as varchar(100)),'0')+','+
' tot_servicos_liq='
+coalesce(cast(tot_servicos as varchar(100)),'0')+','
+'tot_pecas_bru='+coalesce(cast(tot_produtos as varchar(100)),'0')+','
+' tot_pecas_liq='+coalesce(cast(tot_produtos as varchar(100)),'0')+
' where id='+cast(nuos as varchar(100))+';'from tb_ord_servicos



-------------------------------VEICULOS ----------------------------
Select 'INSERT INTO public.oservicos_veiculos(placa, marca, modelo, cor, ano_fab, km, chassi)VALUES ('''+coalesce(cast(identificador as varchar(100)),'padrao')+''','''+'SEM MARCA'+''','''+'SEM MODELO'+''','''+'SEM COR'+''',2018,000,000);' from tb_ord_servicos group by identificador

-----------------------UPDATE VEICULOS LOTUS ----------------------------
select 'update public.oservicos_veiculos set marca='''+coalesce(cast(marca as varchar(100)),'NAO INFORMADO')+''', modelo='''+coalesce(cast(modelo as varchar(100)),'NAO NFORMADO')+''',cor='''+coalesce(cast(cor as varchar(100)),'NAO INFORMADO')+''',ano_fab='''+coalesce(cast(ano as varchar(100)),'2000')+''',km='''+coalesce(cast(km as varchar(100)),'0000')+''',chassi='''+coalesce(cast(chassi as varchar(100)),'1000')+'''where placa='''+coalesce(cast(identificador as varchar(100)),'OOO-000-RO')+''';' from  tb_ord_servicos group by identificador,marca,modelo,cor,ano,km,chassi

select 'INSERT INTO public.oservicos_veiculos(placa, marca, modelo, cor, ano_fab, km, chassi)
    VALUES ('''
+coalesce(cast(identificador as varchar(100)),'padraoo')+''','''
+coalesce(cast(marca as varchar(100)),'padrao')+''','''
+coalesce(cast(modelo as varchar(100)),'padrao')+''','''
+coalesce(cast(cor as varchar(100)),'padrao')+''','''
+coalesce(cast(ano as varchar(100)),'199')+''','''
+coalesce(cast(km as varchar(100)),'0')+''','''
+coalesce(cast(chassi as varchar(100)),'1')+''');' from tb_ord_servicos group by identificador,marca,modelo,cor,ano,km,chassi

===========================RECLAMADO E CONSTATADO ======================================

select 'update oservicos set defeito_reclamado='''
+coalesce(cast(defeito as varchar(100)),'')+''', defeito_constatado='''
+coalesce(cast(constatado as varchar(100)),'')+''', padrao_obs='''+coalesce(cast(ocorrencias as varchar(100)),'')+''' where id='
+coalesce(cast(nuos as varchar(100)),'')+';'
 from tb_ord_servicos where nuos>0




