#!/bin/bash
###################################################
# script depuración mq     #
# Hecho por John Ballén                           #
# Fecha Creación: 03-01-2023                      #
###################################################

DATE=`date '+%d-%m-%Y,%H:%M'`
cd "Ruta para vaciar archivos"
LOG="/tmp/borra_mq_queue_$HOSTN_$DATE.txt"

NUM=`ls -ltr | grep df | grep smmsp | awk '{print $9}'|wc -l`
lista=($(ls -ltr |grep smmsp | awk '{print $9}'))
for i in $(seq 0 $NUM);do
   echo > ${lista[i]}

#ls -ltr | grep ${lista[i]}|awk '{print "> " $9}'
done
