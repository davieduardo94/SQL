select 'update TABLE_TO_UPDATE set COLUMN=(select sum(COLUNA) from TABLE_NAME where COLUMN_REFERENCE='||COLUMN_REFERENCE||');' from TABLE_ORIGIN order by COLUMN_ORDER