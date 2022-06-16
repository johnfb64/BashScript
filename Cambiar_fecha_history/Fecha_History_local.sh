#!/bin/bash

echo "Digite nombre de usuario"
read VALIDA
FORMATO="%d/%m/%y %T "
if [ $VALIDA = "root" ]
then
  echo $line
  echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> /root/.bash_profile
  source /root/.bash_profile

else

  echo "Indique usuario: "
  read USER
  echo $line
  echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> /home/$USER/.bash_profile
  source /home/$USER/.bash_profile

fi
