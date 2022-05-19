#!/bin/bash
echo " ">informe.csv
TEST="7"
while read -ra line; do
    echo $line
    HN=`ssh -n $line hostname`
    echo $HN
    ESTADO=`timeout 5 ssh -n $line geopos status | awk 'NR==1' | wc -w`
    NUM=`timeout 5 ssh -n $line cat /etc/backup.conf | grep CARPETAS | awk 'NR==1' | wc -w`;
    INFO=`timeout 5 ssh -n $line geopos status`
    MARCA=`timeout 5 ssh -n $line dmidecode | grep -i -A4 "^system INFO" | awk 'NR==2 {print $2}'`
    HORA_BACKUP=`timeout 5 ssh -n $line cat /etc/crontab | grep backupNas | awk '{print $2":"$1,$8}'`
    DESTINO=`timeout 5 ssh -n $line cat /etc/backup.conf | grep SERVERNAS | cut -c1-26`
    echo "Codigo $ESTADO"
    if [ $ESTADO -eq $TEST ];then
	for i in $(seq 1 $NUM);do
        CARPETAS=`ssh -n $line cat /etc/backup.conf | grep CARPETAS | awk -v i="$i" 'NR==1 {print $i}'`
        echo $HN,$line,"PRINCIPAL",$MARCA,$CARPETAS,$DESTINO,$HORA_BACKUP>>informe.csv
        done;
    else
        for i in $(seq 1 $NUM);do
        CARPETAS=`ssh -n $line cat /etc/backup.conf | grep CARPETAS | awk -v i="$i" 'NR==1 {print $i}'`
        echo $HN,$line,"SECUNDARIO",$MARCA,$CARPETAS,$DESTINO,$HORA_BACKUP>>informe.csv
        done;
    fi
done < servidores.txt
