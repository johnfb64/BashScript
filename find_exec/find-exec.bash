# borra los archivos core
HOSTNAME="batch03"
SERVERBACKUP="10.181.0.111"
SERVERBACKUPPWD="/home/people/logs/$HOSTNAME"
FTPUSER="people"
FTPPASS="People13"
DATE=`date '+%A'`
LOGDIRECTORY="/app/scripts/logs/"
LOGFILE=borra_core-$DATE.log
LOG="$LOGDIRECTORY/$LOGFILE"
echo > $LOG

echo "==============================================================" >>$LOG
date >>$LOG
echo "Archivos antes de borrar" >>$LOG
echo " "
cd  /app/psoft854/PSCFG/appserv
find  /app/psoft854/PSCFG/appserv -name core  -exec ls -lR {} \; >> $LOG;
archivo=find  /app/psoft854/PSCFG/appserv -name core  -exec ls -lR {} \;
find  /app/psoft854/PSCFG/appserv -name core  -exec rm  {} \; >> $LOG;
echo "==========="  >> $LOG
date >> $LOG
echo "Archivos despues de borrar" >> $LOG
echo "==============================================================" >>$LOG
#exit
