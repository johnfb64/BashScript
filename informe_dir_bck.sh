#!/bin/bash
echo " ">informe.csv
TEST="7"
while read -ra line; do
   echo $line
   hn=`ssh -n $line hostname`
   echo $hn
   estado=`timeout 5 ssh -n $line geopos status | awk 'NR==1' | wc -w`
   bckups=`timeout 5 ssh -n $line cat /etc/backup.conf | grep CARPETAS | awk 'NR==1'`
   info=`timeout 5 ssh -n $line geopos status`
   marca=`timeout 5 ssh -n $line dmidecode | grep -i -A4 "^system info" | awk 'NR==2 {print $2}'`
   hora_backup=`timeout 5 ssh -n $line cat /etc/crontab | grep backupNas | awk '{print $2":"$1,$8}'`
   echo "Codigo $estado"
   if [ $estado -eq $TEST ];then
      echo $hn,$line,"PRINCIPAL",$marca,$bckups,$hora_backup>>informe.csv
      else
      echo "secundario"
      echo $hn,$line,"RESPALDO",$marca,$bckups,$hora_backup>>informe.csv
   fi
done < servidores.txt
