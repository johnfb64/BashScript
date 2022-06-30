#!/bin/bash
host=`hostname`
fecha=`/bin/date '+%d-%m-%Y,%H:%M'`
fecha_hoy=`/bin/date '+%d-%m-%Y'`
NUMPROC=32
BATCH02_LOG=/root/Estadisticas/batch02/Estadisticas_batch02_$fecha_hoy.txt
BATCH02_IOSTAT_LOG=/root/Estadisticas/batch02/Iostat_batch02_$fecha_hoy.txt

###########################PROCESADOR############################
for i in {2..33}
do
  #La columna 16 es idle
  PROC=`ssh admin@10.181.0.xx mpstat | awk -v stat="$i" 'NR==stat {print $16}'`
  #echo $PROC
  COUNT=$((COUNT + PROC))
done
#echo $COUNT
AVG=$((COUNT /32))
echo "batch02,AVG_CPU,$fecha,$AVG" >> $BATCH02_LOG


###########################MEMORIA############################
MEMORIA=`ssh admin@10.181.0.xx top -b -n 1 | grep Memory | awk '{print $2}' | sed 's/G//g'`
LIBRE=`ssh admin@10.181.0.xx top -b -n 1 | grep Memory | awk '{print $5}' | sed 's/G//g'`
#echo $MEMORIA
#echo $LIBRE
OCUPADO=$((MEMORIA - LIBRE))
echo "batch02,STAT_MEM,$fecha,$MEMORIA,$LIBRE,$OCUPADO" >> $BATCH02_LOG

###########################IOSTAT############################

ZPOOL_CANT=`ssh admin@10.181.0.81 zpool list | wc -l`
for i in $(seq 2 $ZPOOL_CANT)
do
   DISK_ID=`ssh admin@10.181.0.xx zpool list | awk -v fila="$i" 'NR==fila' | awk '{print "zpool status "$1}' | ssh admin@10.181.0.81 | grep c0t | awk '{print "/usr/bin/iostat -xpns 2 1 | grep -w " $1}' | ssh admin@10.181.0.81 | tail -1 | awk '{print "asvc_t "$8","$11}'`
   echo "batch02,IOSTAT,$fecha,$DISK_ID" >> $BATCH02_IOSTAT_LOG
done
