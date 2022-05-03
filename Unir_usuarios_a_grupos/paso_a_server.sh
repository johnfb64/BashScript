#!/bin/bash
while read -r line;do
   echo $line
   scp -pr /backup/john/Chk_Servers/une_usuarios_grupos/lista_y_agrega_a_grupo.sh $line:/root/Documents
   sleep 1
   ssh -n $line sh /root/Documents/lista_y_agrega_a_grupo.sh
   sleep 2
   ssh -n $line rm /root/Documents/lista_y_agrega_a_grupo.sh
done <servidores.txt
