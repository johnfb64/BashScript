#!/bin/bash
###################################################################
# Script que escanea el estatus de un servicio determinado por    #
# una determinada cantidad de maquinas                            #
###################################################################
TEST="7"
while read -ra line; do
   echo $line
   hn=`ssh -n $line hostname`
   echo $hn
   estado=`ssh -n $line geopos status | awk 'NR==1' | wc -w`
   echo $estado
   if [ $estado -eq $TEST ];then
      echo "principal"
      echo $line,$hn,"PRINCIPAL">>informe.txt
      else
      echo "secundario"
      echo $line,$hn,"RESPALDO">>informe.txt
   fi
done < servidores.txt
