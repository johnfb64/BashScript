#!/bin/bash
################# VARIABLES #########################
LOG="/home/carvajal/logs/traerhse.log"
DATE=`date '+%d-%m-%Y,%H:%M'`
HOST="1356@64.76.52.91"
PWD="Col0#B1aN@deCO.A7k3t0"
ORIGENREM="/DESADV/out"
LOCALDES="/home/carvajal/TOT_AVISO"

############ TRAE ARCHIVOS DE SFTP ############################
sshpass -p $PWD sftp -F /dev/null -o PreferredAuthentications=password $HOST<<EOF
cd $ORIGENREM
lcd $LOCALDES
get *.hse
bye
EOF
