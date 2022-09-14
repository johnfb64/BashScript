#!/bin/bash
#####################################################################
# SCRIPT PARA TRANSFERENCIA DE ARCHIVOS DE BATMAN HACIA CARVAJAL    #
# AUTOR: INFRAESTRUCTURA LINUX                                      #
# FECHA: 12-09-2022                                                 #
#####################################################################


echo "############# EXTRAE ARCHIVOS SCP #################"
########## VARIABLES ##########################################
DATE=`date '+%d-%m-%Y,%H:%M'`
LOG="/home/carvajal/logs/Trae_archivos_sftp_.log"
HOST=" "
PWD=" "
FOLDERINSUMO="/home/carvajal/TOT_AVISO/PROC_FILE"
ARCHIVO="/home/carvajal/TOT_AVISO/PROC_FILE/*.TXT"
DESTINO="/DESADV/OUT"
#DESTINO="/"
MAYUS="HSE"
MINUS="hse"
FORMAT=`expr $MAYUS - $MINUS`
#No quitar hasta despues del test
BCK="/reportes/CKPR/files/bckedicen/avides"
NFILE="TEST_AVISO.TXT"
RUTA_REMOTO="/reportes/CKPR/avides/"

#RENAME mueve. Esto facilitara el tratamiento de archivos, en caso que halla un gran volumen se borrara de TEMP y no de out, lo que evitara
#borrados accidentales.
sshpass -p $PWD sftp -F /dev/null -o PreferredAuthentications=password $HOST<<EOF
cd $DESTINO
lcd $FOLDERINSUMO
get *$FORMAT*
bye
EOF

lista=($(ls -ltr $FOLDERINSUMO| awk '{print $9}'))

NUM=`ls -ltr $FOLDERINSUMO | wc -l`
for i in $(seq 0 $NUM);do
   echo ${lista[i]}
sshpass -p $PWD sftp -F /dev/null -o PreferredAuthentications=password $HOST<<EOF
cd $DESTINO
rm ${lista[i]}
bye
EOF
done

#VERIFICACION TOT_AVISO
ssh 10.181.0.77 ls -ltr $RUTA_REMOTO | grep $NFILE
if [ $? -eq 0 ]
then
   echo "aun hay un archivo $NFILE en $RUTA_REMOTO, aun no se envia el archivo - $DATE"|tee -a "$LOG"
else
   #Crea TOT_AVISO.TXT
   cd $FOLDERINSUMO
   #ESPECIFICAR ARCHIVO TOT_TXT.
   ls -ltr | grep $MINUS | awk '{print "cat "$9">>/home/carvajal/TOT_AVISO/PROC_FILE/TEST_AVISO.TXT"}' |sh &&\
   ls -ltr | grep $MAYUS | awk '{print "cat "$9">>/home/carvajal/TOT_AVISO/PROC_FILE/TEST_AVISO.TXT"}' |sh
   if [ $? -eq 0 ]
   then
      #Elimina $FORMAT
       rm -f $FOLDERINSUMO/*.$MAYUS && rm -f $FOLDERINSUMO/*.$MINUS
       scp -pr $FOLDERINSUMO/$NFILE psoft85@10.181.0.77:$RUTA_REMOTO
       if [ $? -eq 0 ]
       then
       echo "Archivo $NFILE enviado exitosamente, se procede a hacer backup - $DATE"|tee -a "$LOG"
       BACKUP_TOTAVISO="TOT_AVISO.TXT-$DATE"
       mv $NFILE $BACKUP_TOTAVISO
       scp -pr $FOLDERINSUMO/$BACKUP_TOTAVISO psoft85@10.181.0.77:$BCK
       if [ $? -eq 0 ]
       then
           echo "Archivo TOT_AVISO.TXT respaldado exitosamente, se procede a borrar - $DATE"|tee -a "$LOG"
           rm $FOLDERINSUMO/$BACKUP_TOTAVISO
       else
           echo "Posibles errores en la comunicación o creacion de archivo... - $DATE"
           echo "Archivo TOT_AVISO.TXT no fue eliminado - $DATE"|tee -a "$LOG"
       fi

       else
       echo "Archivo TOT_AVISO.TXT no enviado - $DATE"|tee -a "$LOG"
       fi
   else
      echo "no hay archivos TXT para enviar - $DATE"|tee -a "$LOG"
   fi

fi


