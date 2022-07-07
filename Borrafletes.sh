#!/bin/bash
ARCHIVOSRUTA="/reportes/CKPR/fletes/recibosfletes/"
LOG='/tmp/Archivos_Fletes/Logs/delete_fletes.txt'
FOLDERS='/tmp/Archivos_Fletes/temporal.txt'
cd /reportes/CKPR/fletes/recibosfletes/


DIRECT=`pwd`
echo "==============================================================" >>$LOG

if [ $DIRECT = "/reportes/CKPR/fletes/recibosfletes/" ]
   then
   #Ponga un .aqui donde quiere el borrado. 
   #touch .aqui
	if [ -f /reportes/CKPR/fletes/recibosfletes/.aqui ]
      then
	  ls -ltr /reportes/CKPR/fletes/recibosfletes/ | awk '{print $9}' >>$FOLDERS
	  NUMFOLDERS=`cat $FOLDERS | wc -l`
	  
	  for i in $(2 $NUMFOLDERS)
	  do
	    CARPETA=`cat $FOLDERS | awk -v num="$i" 'NR==num'`
		find /reportes/CKPR/fletes/recibosfletes/$CARPETA/ -ctime +365 -exec ls -lR >>$LOG  {} \;
		echo "Archivos antes de borrar" >>$LOG
		
		#find /reportes/CKPR/fletes/recibosfletes/59377372/recibosfletes/96187700/ -ctime +365 -exec rm -r >>$LOG  {} \;
	  done	
	  echo "==========="  >>$LOG
	  date >>$LOG
      echo "Archivos despues de borrar" >>$LOG
      echo "==============================================================" >>$LOG
      echo " "
	else
        echo "Por algun  motivo desconocido no se esta ubicado en la ruta /app/psoft854/PSCFG/appserv/prcs/CKPR/log_output, por lo que NO borro nada" >>$LOG
     fi
else
    echo "Por algun  motivo desconocido no se esta ubicado en la ruta /app/psoft854/PSCFG/appserv/prcs/CKPR/log_output, por lo que NO borro nada" >>$LOG
fi
rm /reportes/CKPR/fletes/recibosfletes/.aqui
