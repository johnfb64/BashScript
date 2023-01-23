#!/bin/sh
>informe.txt
echo "Host, IP, smb estatus, smb servicio"
while read -ra line;do
   HN=`timeout 5s ssh -n $line hostname`
   timeout 5s ssh -n $line smbstatus >/dev/null
   if [ $? -eq 0 ]
   then
     SMBSTATUS=`timeout 5s ssh -n $line smbstatus | grep version`

     timeout 5s ssh -n $line systemctl status smb >/dev/null
     if [ $? -eq 0 ]
     then
       SMB_SERVICE="Servicio smb activo"
     else
       timeout 5s ssh -n $line /etc/init.d/smb status >/dev/null
       if [ $? -eq 0 ]
       then
         SMB_SERVICE="Servicio smb activo"
       else
         SMB_SERVICE="Servicio SMB No activo"
       fi
      fi

   else
     SMBSTATUS="SMB NO INSTALADO"
     SMB_SERVICE="Servicio SMB No existe"
   fi

echo "$HN,$line,$SMBSTATUS,$SMB_SERVICE" | tee -a informe.txt

done<servidores.txt
