#!/bin/bash
#Este script filtra el archivo etc/passwd y obtiene los resultados de un determinado grupo.
#Luego crea una lista con esos usuarios y la lee en un bucle.
#Luego utiliza con awk el comando usermod con el fin de cambiar los grupos
cut -f1,4 -d: /etc/passwd | grep 1001 | rev | cut -c 6-15 | rev >> /root/Documents/usuarios.txt
while read -ra line; do
#-w = pide devolver valor exacto.
   ls -lrt /dev/ | grep -w "ttyS1" | awk -v linea="$line" '{print "usermod -G " $4 " " linea}'|sh
done < usuarios.txt
rm usuarios.txt
