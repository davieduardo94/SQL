-----------------------------system_generators ---------------------------
update system_generators set vlr_corrente=(select max(id_venda) from RECEBER) where nome='VENDA';

------------------------------INSERT INTO VENDA --------------------------

select 'insert into venda (id, data_venda, id_operacao, id_empresa, id_cliente, id_vendedor, id_fpagto, id_portador, id_usuario, tot_bruto, tot_desc_prc, tot_desc_vlr, tot_liquido, vlr_acrescimos, vlr_entrada, status, obs,  venda_processada, id_user_processor_venda, data_hora_processada) values (get_id(''VENDA''), '''||data_venda||''', 12, 1, '||id_cliente||', '||id_vendedor||', '||id_fpagto||', 1, '||id_usuario||', '||tot_bruto||', '||tot_desc_prc||', '||tot_desc_vlr||', '||tot_liquido||', '||vlr_acrescimos||', '||vlr_entrada||', '||status||', '''||coalesce(obs,'')||''', '||venda_processada||', '||id_user_processor_venda||', '''||data_hora_processada||''');' from venda order by id

------------------------------- ALTER TABLE VENDA ITENS -------------------
######## **ordernar tabela venda por id e copiar novos ids para id_liberacao nas vendas antigas** #################

select 'update venda_itens set id_venda='||id_liberacao||' where id_venda='||id||';' from venda where id in (select id_venda from venda_itens order by id_venda) order by id
 

=============================== CONTAS A RECEBER ================================
delete from receber;  

alter table receber add id_receber character varying (10);

select 'insert into receber (id, id_cliente, id_empresa, id_venda, id_vendedor, id_portador, status, data_compra, tot_compra, data_vecto, valor_doc, valor_pag, parc_num, parc_qtd, historico, data_lanca, valor_doc_original, id_receber) values (get_id(''RECEBER''), '||id_cliente_lotus||',1, '||DOCUMENTO||', 00001, 1, '||IIF(DATABAIXA IS NULL,0,1)||', '''||DATAHORAALTERACAO||''','||VALOR||','''||VENCIMENTO||''','||VALOR||', 0, 1,1,''VENDA'', '''||DATAHORAALTERACAO||''', '||VALOR||', '''||DOCUMENTO||''');' FROM TRECPARCELA

--------------------------------------------------------------------------
alter table TRECPARCELA add id_lotus int;
select 'update TRECPARCELA A set A.id_lotus='||id||' where A.DOCUMENTO='''||id_receber||''';' from receber order by id
---------------------------------------------------------
select 'update receber set id_venda='||a.DOCUMENTO||' where id='||id_lotus||';' from TRECPARCELA a ORDER BY ID_LOTUS
-------------------------------------------------------
select ' update receber set id_venda='||id_liberacao||' where id_venda='||id||' AND data_compra='''||data_venda||''';' from venda where data_venda between '2019-08-01' and '2019-08-20' order by id

update receber set data_compra=data_vecto where data_vecto<'2018-12-31';


================================== NFE ==========================================
select 'update nfe_prc set id_venda='||id_liberacao||' where id_venda='||id||';' from venda order by id


