#!/usr/bin/bash

#####################################################################
# FUNCION PARA TRANSFERENCIA DE ARCHIVOS DE BATMAN HACIA CARVAJAL   #
# AUTOR: JOHN BALLEN                                                #
# FECHA: 29-07-2022                                                 #
#####################################################################

OrdenesCompra () {

echo "############# MODULO DE ORDENES #################" >> $LOG
########## VARIABLES ##########################################
LOG="/home/carvajal/logs/traerbatch01_orders.log"
DATE=`date '+%d-%m-%Y,%H:%M'`
HOST="USUARIO@SERVIDOR"
PWD="password_de_servidor"
ORIGEN="/reportes/CKPR/files/EDICEN"
FOLDERINSUMO="/home/carvajal/EDICEN"
ARCHIVO="/home/carvajal/EDICEN/*.test"
#DESTINO="/ORDERS/IN"
DESTINO="/"
FORMAT="test"
BCK="/reportes/CKPR/files/bckedicen/test_new_Script"

############ TRAE ARCHIVOS DE BATCH ############################
rsync -avzh --remove-source-files --progress psoft85@10.181.0.77:$ORIGEN/*.$FORMAT $FOLDERINSUMO

if [ $? = 0 ]
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
scp -pr $FOLDERINSUMO/*.$FORMAT psoft85@10.181.0.77:$BCK
if [ $? = 0 ]
then
sleep 3
cd $FOLDERINSUMO
rm -f $ARCHIVO
else
echo "$DATE - Archivos no transmitidos hacia backup" >> $LOG
fi
else "$DATE - Archivos no transmitidos hacia servidor" >> $LOG
fi
}


