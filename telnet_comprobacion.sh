#!/usr/bin/bash
#Hecho por John Ballen

#Esto es una funcion. 
OrdenesCompra () {

echo "############# MODULO DE ORDENES #################"
########## VARIABLES ##########################################
LOG="/home/ponga ruta de archivo del log"
DATE=`date '+%d-%m-%Y,%H:%M'`
HOST="usuario@servidor.com"
PWD="password"
ORIGEN="/Origen remoto del archivo/"
FOLDERINSUMO="/Ubicacion local del archivo"
ARCHIVO="/ubicacion local del archivo/*.formato"
DESTINO="/ORDERS/IN"
#DESTINO="/"
FORMAT="formato"
#No quitar hasta despues del test
BCK="/ruta backup del archivo/"
SFTP="ponga aqui la IP del servidor sftp"

###################### SECCION DE IMPORTANCIA EN ESTE SCRIPT ##########################
#######################################################################################
#Validación de conectividad con Netcat
#Echo envia una señal 0 si hay respuesta, si es !0, entonces indicara el error. 
echo "quit"  | nc $SFTP
if [ $? -eq 0 ]
then
echo "$DATE - Comunicacion exitosa con el servidor ftp"| tee -a "$LOG"
#------------------------------------
#######################################################################################



########### TRAE ARCHIVOS A SERVIDOR  ############################
rsync -avzh --remove-source-files --progress usuario@servidor.com:$ORIGEN/*.$FORMAT $FOLDERINSUMO
if [ $? -eq 0 ]
then
echo "$DATE - Archivos traidos correctamente" >> $LOG
########### ENVIA ARCHIVOS A SFTP ##############################
sshpass -p $PWD sftp -F /dev/null -o PreferredAuthentications=password $HOST<<EOF
cd $DESTINO
lcd $FOLDERINSUMO
put $ARCHIVO
bye
EOF

######## BACKUP ARCHIVOS Y LIMPIEZA ############################
scp -pr $FOLDERINSUMO/*.$FORMAT usuario@servidor.com:$BCK
if [ $? -eq 0 ]
then
cd $FOLDERINSUMO
rm -f $ARCHIVO
else
echo "$DATE - Archivos no transmitidos hacia backup" >> $LOG
fi
else "$DATE - Archivos no transmitidos hacia servidor" >> $LOG
fi

#Continuacion Validación de conectividad con Netcat
else
echo "$DATE - Error de comunicación con el servidor sftp, validar con proveedor..." | tee -a "$LOG"
fi
#------------------------------------
}