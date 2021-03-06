#!/bin/bash
. /home/ec2-user/.bash_profile
SQL_statment=`cat $1`

SPOOL_FILE=/tmp/execute.log

SQLPLUS_OUTPUT=`sqlplus "C##Devops/devops12@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=172.31.4.53)(PORT=1521))(CONNECT_DATA=(SID=cdb1)))" << EOF
                SET HEAD OFF
        SET AUTOPRINT OFF
        SET TERMOUT OFF
        SET SERVEROUTPUT ON

        SPOOL  ${SPOOL_FILE}
WHENEVER SQLERROR EXIT SQL.SQLCODE
${SQL_statment}

EOF`

RC=$?

if [[ $RC != 0 ]] ; then
        echo " RDBMS exit code : $RC  "     | tee -a ${LOG_FILE}
else
echo "All Test Scenarios are Completed" > /tmp/execute_test.log
echo "#####################################################" >> /tmp/execute_test.log
echo "## All Queries are Passed and Ready for Deployment ##" >> /tmp/execute_test.log
echo "#####################################################" >> /tmp/execute_test.log
echo ${SQLPLUS_OUTPUT} >> /tmp/execute_test.log
fi
