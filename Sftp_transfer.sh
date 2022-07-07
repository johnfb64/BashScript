#!/usr/bin/bash
########## VARIABLES ##########################################
LOG="poner ruta del log"
DATE=`date '+%d-%m-%Y,%H:%M'`
HOST="poner usuario@servidor"
PWD="password aqui"
ORIGEN="/de donde se halan los archivos"
ARCHIVO="cuales son los archivos"
DESTINO="para donde van"

############ TRAE ARCHIVOS DE BATCH ############################
cd $ORIGEN
scp -pr usuario@servidor:$ORIGEN/*.txt .
if [ $? = 0 ]
   then
   echo "Archivos traidos correctamente" >> $LOG
else
   echo "Archivos no transmitidos" >> $LOG
fi

########### ENVIA ARCHIVOS A SFTP ##############################
sshpass -p $PWD sftp -F /dev/null -o PreferredAuthentications=password $HOST<<EOF
cd $DESTINO
put $ARCHIVO
bye
EOF

######### LIMPIEZA DE CARPETA ###############################
sleep 3
cd /home/donde_qudan_los archivos
rm -f /home/donde_qudan_los archivos/*.edi

####################### REALIZA BACKUP #######################

