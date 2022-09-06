#!/bin/bash
cambia_fstab () {
fecha=`/bin/date '+%d-%m-%Y'`

awk '$2~"^/var$"{$4="defaults,nodev,nosuid,noexec"}1 && \
        $2~"^/home$"{$4="defaults,nodev,nosuid,usrquota,grpquota"}1 && \
        $2~"^/tmp$"{$4="defaults,nodev,nosuid,noexec"}1' OFS="\t" /etc/fstab >> /tmp/fstab.temp

mv /etc/fstab /etc/fstab.$fecha
if [ $? -eq 0 ]
   then
   mv /tmp/fstab.temp /etc/fstab
else
   echo "fstab no se actualizo"
fi

echo "======================FSTAB==============================">> /tmp/informe.txt

echo "1.1.6 Asegurar que la opción nodev esté establecida sobre la partición /tmp  (Automático)">>/tmp/informe.txt
echo "1.1.7 Asegurar que la opción nosuid esté estaecida sobre la partición /tmp  (Automático)">>/tmp/informe.txt
echo "1.1.8 Asegurar que la opción noexec esté establecida sobrea partición /tmp (Automático)">>/tmp/informe.txt
echo " " >>/tmp/informe.txt
echo "1.1.14 Asegurar que la partición /var incluya la opción nodevAutomático">>/tmp/informe.txt
echo "1.1.15 Asegurar que la partición /var incluya la opción nosuid (Automático">>/tmp/informe.txt
echo "1.1.16 Asegurar que la partición /var incluya la opción noexec (Automático)">>/tmp/informe.txt
echo " " >>/tmp/informe.txt
echo "1.1.30 Asegurar que la partición /home incluya la opción nodev (Automáti">>/tmp/informe.txt
echo "1.1.31 Asegurar que la partición /home incluya la opción nosuid (Automáti">>/tmp/informe.txt
echo "1.1.35 Asegurar que la opción usrquota esté establecida en la partición /home (Automático)">>/tmp/informe.txt
echo "1.1.36 Asegurar que la opción grpquota esté establecida en la partición /home (Automático)">>/tmp/informe.txt
echo " " >>/tmp/informe.txt
echo " " >>/tmp/informe.txt
echo "IMPORTANTE!. REVISE EL FSTAB Y HAGA REINICIO DE CONFIANZA. TENGA A LA MANO ACCESO POR VIRTUALIZACION O IDRAC Y UN LIVE CD DE LA DISTRO..."
sleep 3
echo " " >>/tmp/informe.txt
cat /etc/fstab

cat /etc/fstab >> /tmp/informe.txt
rm -f /tmp/fstab

}


