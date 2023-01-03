#!/bin/bash
###################################################
# script para validación precheck - postcheck     #
# Hecho por John Ballén                           #
# Fecha Creación: 03-01-2023                      #
###################################################

#Variables
DATE=`date '+%d-%m-%Y,%H:%M'`
HOSTN=`hostname`
LOG="/tmp/precheck_log_$HOSTN_$DATE.txt"

#Toma de parametros
echo "===== INICIA SCRIPT UPTIME - $DATE =====" |tee -a "$LOG"
echo " "|tee -a "$LOG"
echo "tiempo arriba ---------------"|tee -a "$LOG"
uptime |tee -a "$LOG"
echo "Hora de ejecucion script -------------------------------------"|tee -a "$LOG"
echo $DATE |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "================ DISTRIBUCIÓN  ==================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
cat /etc/*release* |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "=============== SERVICIOS =====================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
systemctl list-units --type=service |tee -a "$LOG"
echo " "|tee -a "$LOG"
echo "=============== filesystems  =====================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
df -h |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "================ filesystems inodos  ==================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
df -hiT |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "================ informacion pvs  ==================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
pvs |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "================ informacion vgs  ==================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
vgs |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "================ informacion lvs  ==================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
lvs |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "=============== Servicios con netstat  =====================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
netstat -tulpn |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "=============== informacion de dispositivos por bloque   =====================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
lsblk -f |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "=============== Estructura hardware ========================" |tee -a "$LOG"
echo " " |tee -a "$LOG"
echo "-------------------CPU---------------------" |tee -a "$LOG"
echo " "|tee -a "$LOG"
lscpu |tee -a "$LOG"
echo " "|tee -a "$LOG"
echo "-------------------MEMORIA---------------------" |tee -a "$LOG"
echo " "|tee -a "$LOG"
free -g |tee -a "$LOG"
echo " "|tee -a "$LOG"
echo "-------------------DMIDECODE---------------------" |tee -a "$LOG"
echo " "|tee -a "$LOG"
dmidecode | grep -i -A4 "^system info"|tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "=============== FSTAB  =====================" |tee -a "$LOG"
echo " " |tee -a "$LOG"
cat /etc/fstab |tee -a "$LOG"
echo " " |tee -a "$LOG"

echo "================ TABLAS DE ENRUTAMIENTOS  ==================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
route -n |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "================ INTERFACES DE RED  ==================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
ip a |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "================ VERSION DE KERNEL  ==================" |tee -a "$LOG"
echo " "|tee -a "$LOG"
uname -r |tee -a "$LOG"
echo " "|tee -a "$LOG"

echo "============================================" |tee -a "$LOG"
echo "Se transfiere archivo de log a Thor..."
echo "Ingrese la contraseña del root:"
scp -pr $LOG root@10.181.0.174:/backup/john/log_precheck
echo "Extraiga el archivo /tmp/precheck_log.txt o revise la ruta en thor, /backup/john/log_precheck"|tee -a "$LOG"
echo "================ FIN  ==================" |tee -a "$LOG"
