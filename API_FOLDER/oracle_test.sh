. /root/.bash_profile
SQL_statment=`cat $1`

sqlplus "C##Devops/devops12@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=172.31.4.53)(PORT=1521))(CONNECT_DATA=(SID=cdb1)))" <<END
WHENEVER SQLERROR EXIT SQL.SQLCODE
${SQL_statment}
commit;
END
