#!/bin/bash
LISTDEV=($(fdisk -l | grep "Disk /" | grep -v mapper | awk '{print $2}'| sed 's/://g'))
CANT=`expr $(fdisk -l | grep "Disk /" | grep -v mapper | wc -l) - 1`
for i in $(seq 0 $CANT);do
  CHECK=`lsblk ${LISTDEV[i]} | awk 'NR==3'| wc -l`
  if [ $CHECK -eq 0 ]
  then
    echo "${LISTDEV[i]} sin formato"
  else
    echo "${LISTDEV[i]} con formato"
  fi
done
echo "Estas salidas se pueden conectar a otros comandos..."
