#!/bin/bash
> informe.txt
while read -ra line;do
HN=`timeout 5 ssh -n $line hostname`

MARCA=`timeout 5 ssh -n $line dmidecode | grep -i -A4 "^system info" | grep Manufacturer | awk '{print $2}'`
SERIAL=`timeout 5 ssh -n $line dmidecode | grep -i -A4 "^system info" | grep Serial | awk '{print $3}'`
MODELO=`timeout 5 ssh -n $line dmidecode | grep -i -A4 "^system info" | grep Product | awk -F: '{print $2}'`
SEDE=`timeout 5 ssh -n $line hostname | awk -F- '{print $1}'`

#Validación Antivirus
timeout 5 ssh -n $line systemctl status ds_agent >/dev/null
if [ $? -eq 0 ]
then
  VALIDA_AV="AV instalado"
else
  VALIDA_AV="AV NO instalado"
fi

#Validación de EOL
timeout 5 ssh -n $line cat /etc/os-release > /dev/null
if [ $? -eq 0 ]
then

DIST=`timeout 5 ssh -n $line cat /etc/os-release | grep "^PRETTY" |awk -F= '{print $2}'|awk '{print $1}'|sed 's/"//g'`

    if [ $DIST = "SUSE" ]
    then
      DISTVER=`timeout 5 ssh -n $line cat /etc/os-release | grep "^PRETTY" |awk -F= '{print $2}'`
      VER=`timeout 5 ssh -n $line cat /etc/os-release | grep "^PRETTY" |awk -F= '{print $2}'|awk '{print $1,$5}'|sed 's/"//g'|sed 's/ /_/g'`
      if [ $VER = "SUSE_15" ]
      then
        EOL="VIGENTE"
      else
        EOL="OBSOLETO"
      fi

    elif [ $DIST = "Oracle" ]
    then
      DISTVER=`timeout 5 ssh -n $line cat /etc/os-release | grep "^PRETTY" |awk -F= '{print $2}'`
      VER=`timeout 5 ssh -n $line cat /etc/os-release | grep "^PRETTY" |awk -F= '{print $2}'|awk '{print $4}'|awk -F. '{print $1}'`
      if [ $VER -ge 7 ]
      then
        EOL="VIGENTE"
      else
        EOL="OBSOLETO"
      fi
    elif [ $DIST = "CentOS" ]
    then
      DISTVER=`timeout 5 ssh -n $line cat /etc/os-release | grep "^PRETTY" |awk -F= '{print $2}'`
      VER=`timeout 5 ssh -n $line cat /etc/os-release | grep "^PRETTY" |awk -F= '{print $2}'|awk '{print $3}'`
      if [ $VER -eq 7 ]
      then
        EOL="VIGENTE"
      else
        EOL="OBSOLETO"
      fi
    elif [ $DIST = "Red" ]
    then
      DISTVER=`timeout 5 ssh -n $line cat /etc/redhat-release`
      VER=`timeout 5 ssh -n $line cat /etc/redhat-release | awk '{print $6}' |awk -F. '{print $1}'`
      if [ $VER = 8 ]
      then
        EOL="VIGENTE"
      else
        EOL="OBSOLETO"
      fi

    fi
else
  timeout 5 ssh -n $line cat /etc/issue > /dev/null
  if [ $? -eq 0 ]
  then
    DISTVER=`timeout 5 ssh -n $line cat /etc/issue | awk 'NR==2{print $3,$4,$5,$6,$7,$8}'`
    VER=`timeout 5 ssh -n $line cat /etc/issue | awk 'NR==2{print $3"_"$7}'`
    EOL="OBSOLETO"
  else
    echo "$HN,En construccion"
  fi

fi

echo "$HN,$line,$EOL,$MARCA,$SERIAL,$MODELO,$DISTVER,$VER,$VALIDA_AV"|tee -a informe.txt

done<servidores.txt
