#!/usr/bin/bash
#############################################################################################
#Peoplesoft genera el archivo en la ruta: /reportes/CKPR/newfiles/EDI_PROVEEDORES/Inventario*.exi
#El archivo Inventario*.exi se debe copiar en la ruta /INVRPT/IN  del SFTP de Carvajal apolo.cen.biz 
#############################################################################################

cartera () {
echo "############## MODULO CARTERA #####################"
######### VARIABLES ##########################################
LOG="ruta/log"
DATE=`date '+%d-%m-%Y,%H:%M'`
HOST="host servidor"
PWD="password servidor"
ORIGEN="/De donde hala"
FOLDERINSUMO="/Insumos"
ARCHIVO="/Tipo_de_archivo"
#DESTINO="/carpeta"
DESTINO="/carpeta"
FORMAT="txt"


############ TRAE ARCHIVOS DE BATCH ############################
scp -pr usuario@ip:$ORIGEN/*.$FORMAT $FOLDERINSUMO
if [ $? = 0 ]
   then
   echo "$DATE - Archivos traidos correctamente" >> $LOG    
else
   echo "$DATE - Archivos no transmitidos" >> $LOG
fi

########### ENVIA ARCHIVOS A SFTP ##############################  
sshpass -p $PWD sftp -F /dev/null -o PreferredAuthentications=password $HOST<<EOF
cd $DESTINO
lcd $FOLDERINSUMO
put $ARCHIVO
bye
EOF

######### LIMPIEZA DE CARPETA ###############################
sleep 3
cd $FOLDERINSUMO
rm -f $ARCHIVO

####################### REALIZA BACKUP #######################


}
