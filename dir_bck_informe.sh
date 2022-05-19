#!/bin/bash
echo " ">informe.csv
TEST="7"
while read -ra line; do
    echo $line
    HN=`timeout 5 ssh -n $line hostname`
    sleep 1
    echo $HN
    ESTADO=`timeout 5 ssh -n $line geopos status | awk 'NR==1' | wc -w`
    sleep 2
    CARPETAS=0
    NUM=`timeout 5 ssh -n $line cat /etc/backup.conf | grep CARPETAS | awk 'NR==1' | wc -w`;
    sleep 2
    INFO=`timeout 5 ssh -n $line geopos status`
    sleep 2
    MARCA=`timeout 5 ssh -n $line dmidecode | grep -i -A4 "^system INFO" | awk 'NR==2 {print $2}'`
    sleep 2
    HORA_BACKUP=`timeout 5 ssh -n $line cat /etc/crontab | grep backupNas | awk '{print $2":"$1,$8}'`
    sleep 2
    DESTINO=`timeout 5 ssh -n $line cat /etc/backup.conf | grep SERVERNAS | cut -c1-26`
    sleep 2
    echo "Codigo $ESTADO"
    if [ $ESTADO -eq $TEST ];then

	if [ $NUM == 0 ];then
	   echo $HN,$line,"PRINCIPAL",$MARCA,$DESTINO,$HORA_BACKUP>>informe.csv
	else
	   for i in $(seq 1 $NUM);do
              CARPETAS=`timeout 5 ssh -n $line cat /etc/backup.conf | grep CARPETAS | awk -v i="$i" 'NR==1 {print $i}'`
	      sleep 2
              echo $HN,$line,"PRINCIPAL",$MARCA,$CARPETAS,$DESTINO,$HORA_BACKUP>>informe.csv
              done;
	fi
    else
   	for i in $(seq 1 $NUM);do
	   CARPETAS=`timeout 5 ssh -n $line cat /etc/backup.conf | grep CARPETAS | awk -v i="$i" 'NR==1 {print $i}'`
	   sleep 2
           echo $HN,$line,"SECUNDARIO",$MARCA,$CARPETAS,$DESTINO,$HORA_BACKUP>>informe.csv
           done
    fi
done< servidores.txt
