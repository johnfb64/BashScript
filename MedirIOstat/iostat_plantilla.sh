#!/bin/bash
#Este parametro permite parametrizar el umbral de medida
umbral=10
#Estas variables de ejemplo capturan el dato de avg iostat de disco
c0d0=`/usr/bin/iostat -xpns 2 1 | awk 'NR==3{print $8}'`
c0d1=`/usr/bin/iostat -xpns 2 1 | awk 'NR==4{print $8}'`
c0d2=`/usr/bin/iostat -xpns 2 1 | awk 'NR==5{print $8}'`
reportes_tools=`/usr/bin/iostat -xpns 2 1 | awk 'NR==6{print $8}'`
appsrv02=`/usr/bin/iostat -xpns 2 1 | awk 'NR==7{print $8}'`
backup_pstool=`/usr/bin/iostat -xpns 2 1 | awk 'NR==8{print $8}'`

#Este for escribe en un arvhivo txt las medidas que se van dando en iostat hasta 5
for i in 1 2 3 4 5; do
c0d1=`/usr/bin/iostat -xpns 2 1 | awk 'NR==4{print $8}'`
#este archivo almacena las medidas
echo $c0d1 >> count.txt
#Las medidas tienen un espacio de tiempo de 5 s. 
sleep 1
done
#############################################################################################################################
#NOTA: PARA NO CREAR REDUNDANCIA DE ARCHIVOS COUNT, SE PUEDE USAR EL MISMO ARCHIVO, LIMPIANDOLO DESPUES DE SACAR EL PROMEDIO.
############################################################################################################################# 
#Aqui se almacena en una variable el promedio de medidas guardadas en count.txt
#sum/5 es el promedio de veces por la cantidad indicada en el for
c0d1_avg=`cat /app/scripts/count.txt | awk '{sum +=$1} END {print sum/5}'`
echo $c0d1_avg
#Esta linea limpia el archivo, sin embargo la info quedo almacenada en variable
echo > count.txt

#Este if decida mensaje de acuerdo a valor de promedio
if [ $c0d1_avg -ge $umbral ]
then 
echo c0d1 Tiene Iostat Alto
else
echo c0d1 Tiene Iostat Bajo
fi
