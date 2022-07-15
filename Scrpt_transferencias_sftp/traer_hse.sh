#!/bin/bash
################# VARIABLES #########################
LOG="/donde_quedara_el_log"
#DATE=`date '+%d-%m-%Y,%H:%M'`
DATE=`date '+%H%M-%m%d%Y'`
HOST="serividor sftp"
PWD="pwd sftp"
ORIGENREM="/ruta archivos orgien"
LOCALDES="/ruta local donde van a quedar"
BCK="/ruta a donde se les va a hacer backup"
PROCFOLDER="/ruta donde se guardan los archivos procesados"

############ TRAE ARCHIVOS DE SFTP ############################
sshpass -p $PWD sftp -F /dev/null -o PreferredAuthentications=password $HOST<<EOF
cd $ORIGENREM
lcd $LOCALDES
get *.hse
bye
EOF

############ PROCESA ARCHIVOS #################################
CANT_FILES=`ls -ltr $LOCALDES | grep hse | wc -l`
for i in $(seq 1 $CANT_FILES)
do
   FILE=`ls -ltr $LOCALDES | grep hse | gawk -v num="$i" 'NR==num{ print $9 }'`
   cat $LOCALDES/$FILE>>$LOCALDES/TOT_AVISO.TXT
done

############# MUEVE Y LIMPIA ARCHIVOS BCK ################################
find $BCK/*.hse -mtime +60 -exec rm -f {} \;
mv $LOCALDES/*.hse $BCK

############# RENOMBRA, LIMPIA Y MUEVE ARCHIVOS ########################

find $PROCFOLDER/*.txt -mtime +60 -exec rm -f {} \;
mv $LOCALDES/TOT_AVISO.TXT $PROCFOLDER/$DATE.txt
