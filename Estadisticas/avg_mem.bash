#!/bin/bash
mem_avg () {
  host=`hostname`
  timer=`/bin/date '+%d-%m-%Y-%H:%M'`
  fecha_hoy=`/bin/date '+%d-%m-%Y'`
  touch /root/Documents/estadistica_mem_$fecha_hoy.txt
  echo " " > avg_mem.txt
  #cada 5 minutos
  CONT=5
  MEM_DISP=`free -g | grep Mem | awk '{print $7}'`
  MEM_FREE=`free -g | grep Mem | awk '{print $4}'`
  MEM_USO=`expr $MEM_DISP - $MEM_FREE`
    for i in $(seq 1 $CONT)
    do
      PER_MEM=`expr $MEM_DISP \* $MEM_USO / 100`
      echo $PER_MEM >> avg_mem.txt

      sleep 1
    done
  #CONT=`expr $CONT - 1`
  SUM=`cat /root/Documents/avg_mem.txt | awk '{sum +=$1} END {print sum}'`

  AVG=`expr $SUM / $CONT | bc`
  echo $AVG%,$timer >> /root/Documents/estadistica_mem_$fecha_hoy.txt
}
