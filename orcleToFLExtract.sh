#!/usr/bin/bash
ORACLE_HOME=/home/oracle/instantclient_12_1
export LD_LIBRARY_PATH="$ORACLE_HOME"
export PATH="$ORACLE_HOME:$PATH"
#Read User and Pass from running script Usage USER_NM/PSW
#for running the Script use this $nohup sh orcleToFLExtract.sh USER_NM/PSW &
usrPSW=${1}
tblNM='tbl_name'
dYM=`date + "%Y%m%d%H%M%S"`
FILE="/location/${tblNM}_${dYM}.txt"

/home/oracle/instantclient_12_1/sqlplus -s ${usrPSW}@host:1521/SERVICE_ID <<EOF
SET underline off
SET HEADING OFF
SET FEEDBACK OFF
SET ECHO OFF
SET VERIFY OFF
SET SPACE 0
SET PAGESIZE 0
SET PAGES 0
SET TERMOUT OFF
SET TRIMSPOOL ON
SET LINESIZE 4000
SET NLS_LANG=AMERICAN_AMERICA.WE8MSQIN1252
SET SERVEROUTPUT ON
SPOOL $FILE
SELECT 
TRIM(REPLACE(REPLACE(COL_A,CHR(10)),CHR(13)))||'~'||
TRIM(REPLACE(REPLACE(COL_B,CHR(10)),CHR(13)))||'~'||
TRIM(REPLACE(REPLACE(COL_1,CHR(10)),CHR(13)))||'~'||
TRIM(REPLACE(REPLACE(COL_C,CHR(10)),CHR(13)))
FROM SCHEMA.${tblNM};
SPOOL OFF
EXIT
EOF







