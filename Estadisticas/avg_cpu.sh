#!/bin/bash
cpu_avg () {
  host=`hostname`

  timer=`/bin/date '+%d-%m-%Y-%H:%M'`
  fecha_hoy=`/bin/date '+%d-%m-%Y'`
  touch /root/Documents/estadistica_$fecha_hoy.txt
  #touch "estadisticas_$fecha_hoy.txt"
  echo " " > avg_cpu.txt
  #cada 5 minutos
  CONT=5
  CPUSTAT=`mpstat |grep all |awk '{print $12}' | sed 's/\./ /g' | awk '{print $1}'`
    for i in $(seq 1 $CONT)
    do
      echo $CPUSTAT >> avg_cpu.txt
      sleep 1
    done
  #CONT=`expr $CONT - 1`
  SUM=`cat /root/Documents/avg_cpu.txt | awk '{sum +=$1} END {print sum}'`

  #bc=basic calculator
  AVG=`expr $SUM / $CONT | bc`
  AVGP=`expr 100 - $AVG`
  echo $AVGP%,$timer >> /root/Documents/estadistica_$fecha_hoy.txt