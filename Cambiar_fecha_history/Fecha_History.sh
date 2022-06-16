#!/bin/bash

echo "Digite nombre de usuario"
read VALIDA 
if [ $VALIDA = "root" ];
then

  while read -ra line; do
    timeout 5 ssh -n $line "echo -e 'export HISTTIMEFORMAT=\"%d/%m/%y %T \"' >> /root/.bash_profile"
    timeout 5 ssh -n $line source /root/.bash_profile
  done < servidores.txt

else

  while read -ra line; do
      timeout 5 ssh -n $line "echo -e 'export HISTTIMEFORMAT=\"%d/%m/%y %T \"' >> /home/$VALIDA/.bash_profile"
      #ssh -n $line echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> /home/$VALIDA/.bash_profile;
      timeout 5 ssh -n $line source /home/$VALIDA/.bash_profile;
  done < servidores.txt

fi

echo "Asegurse de cerrar sesion y volver a abrir!"
