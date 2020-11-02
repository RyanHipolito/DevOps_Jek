#!/bin/bash
. /home/ec2-user/.bash_profile
SQL_statment=`cat $1`

SPOOL_FILE=/var/lib/jenkins/workspace/Oracle_Pipeline/API_FOLDER/execute.log

SQLPLUS_OUTPUT=`sqlplus "C##Devops/devops12@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=172.31.4.53)(PORT=1521))(CONNECT_DATA=(SID=cdb1)))" << EOF
		SET HEAD OFF
        SET AUTOPRINT OFF
        SET TERMOUT OFF
        SET SERVEROUTPUT ON

        SPOOL  ${SPOOL_FILE}
WHENEVER SQLERROR EXIT SQL.SQLCODE
${SQL_statment}

EOF`

cat $SQLPLUS_OUTPUT > /var/lib/jenkins/workspace/Oracle_Pipeline/API_FOLDER/execute_test.log

RC=$?

if [[ $RC != 0 ]] ; then

    echo " RDBMS exit code : $RC  "     | tee -a ${LOG_FILE}
    cat ${SPOOL_FILE}         
    exit 3

fi
