#!/bin/bash
###########################CONSTANTES############################
fecha=`/bin/date '+%d-%m-%Y,%H:%M'`
fecha_hoy=`/bin/date '+%d-%m-%Y'`

###########################VARIABLES############################
#cambiar solo estos parametros -----------------------------------------
SERVIDOR="admin@10.181.0.xx"
host="servidor"
LOG_MEM_CPU=/root/Estadisticas/servidor/Estadisticas_servidor_$fecha_hoy.txt
LOG_IOSTAT_LOG=/root/Estadisticas/servidor/Iostat_servidor_$fecha_hoy.txt
#------------------------------------------------------------------------
###########################PROCESADOR############################
CPU_CANT=`ssh $SERVIDOR mpstat | wc -l`
for i in $(seq 2 $CPU_CANT)
do
  #La columna 16 es idle
  PROC=`ssh $SERVIDOR mpstat | awk -v stat="$i" 'NR==stat {print $16}'`
  #echo $PROC
  COUNT=$((COUNT + PROC))
done
#echo $COUNT
AVG=$((COUNT / CPU_CANT))
echo "$host,AVG_CPU,$fecha,$AVG" >> $LOG_MEM_CPU

###########################MEMORIA############################
MEMORIA=`ssh $SERVIDOR top -b -n 1 | grep Memory | awk '{print $2}' | sed 's/G//g'`
LIBRE=`ssh $SERVIDOR top -b -n 1 | grep Memory | awk '{print $5}' | sed 's/G//g'`
#echo $MEMORIA
#echo $LIBRE
OCUPADO=$((MEMORIA - LIBRE))
echo "$host,STAT_MEM,$fecha,$MEMORIA,$LIBRE,$OCUPADO" >> $LOG_MEM_CPU

###########################IOSTAT############################
ZPOOL_CANT=`ssh $SERVIDOR zpool list | wc -l`
for i in $(seq 2 $ZPOOL_CANT)
do
   DISK_ID=`ssh $SERVIDOR zpool list | awk -v fila="$i" 'NR==fila' | awk '{print "zpool status "$1}' \
   | ssh $SERVIDOR | grep c0t | awk '{print "/usr/bin/iostat -xpns 2 1 | grep -w " $1}' | \
   ssh $SERVIDOR | tail -1 | awk '{print "asvc_t "$8","$11}'`
   echo "$host,IOSTAT,$fecha,$DISK_ID" >> $LOG_IOSTAT_LOG
done


