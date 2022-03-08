#!/bin/bash
###########################SCP##################################
ARCHIVO=`ssh admin@xx.xxx.x.xx ls -lrta /reportes/CKPR/Textiles/Gildan/Informes | tail -n1 | awk {'print $9'}`
#linea test
echo $ARCHIVO
#/home/psoft85/gildan = Esta es lar uta donde debe quedar, aqui se una de prueba
scp psoft85@xx.xx.xx.xx:/reportes/CKPR/Textiles/Gildan/Informes/$ARCHIVO /home/psoft85/gildan
#############################FTP###################################

HOST="ftp.server.com"
USER="user"
PWD="(o!owdnA@password"
DESTINO="laCarpetaDondeVaQuedar"

ftp -inv $HOST <<EOF
user $USER $PWD
cd $DESTINO
#put $ARCHIVO
bye
EOF






--------------------------------------------------------------------------------------------------------------------------------

#!/bin/bash
###########################SCP##################################
FILE=`ssh psoft85@10.181.0.77 ls -lrt /reportes/CKPR/Textiles/Gildan/Informes | tail -n1 | awk {'print $9'}`
#linea test
echo $FILE
scp psoft85@10.181.0.77:/reportes/CKPR/Textiles/Gildan/Informes/$FILE /home/psoft85/
#############################FTP###################################

HOST="ftp.gildan.com"
USER="235899"
PWD="(o!0m81anA@2021pr"
DESTINO="tovan"
ARCHIVO="/home/psoft85/gildan/$FILE"

ftp -inv $HOST <<EOF
user $USER $PWD
cd $DESTINO
put $FILE
bye
EOF

######################GUARDADO DE REGISTRO##########################
mv $FILE /home/psoft85/gildan/
