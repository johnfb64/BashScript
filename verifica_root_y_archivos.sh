#!/usr/bin/bash
#####################################################################
# SCRIPT PARA TRANSFERENCIA DE ARCHIVOS DE BATMAN HACIA CARVAJAL    #
# AUTOR: INFRAESTRUCTURA LINUX                                      #
# FECHA: 29-07-2022                                                 #
#####################################################################
LOG="/root/Linea_Base/informe.txt"
fecha=`date '+%d-%m-%Y,%H:%M'`
ARCHIVO="rutas.txt"
#verifica () {

echo "==============VERIFICA ROOT Y ARCHIVOS USUARIO============"|tee -a "$LOG"
GRUPO=`cat /etc/passwd | grep ^root |awk -F: '{print $4}'`
GRREQ=0
if [ "$GRUPO" == 0 ]
then
   echo "Usuario root ya se encontraba en grupo 0"|tee -a "$LOG"
else
   usermod -g 0 root
   if [ $? -eq 0 ]
   then
      echo "Usuario root pasado a grupo 0 exitosamente..."|tee -a "$LOG"
   else
      echo "No se pudo cambiar de grupo al usuario root, validar manualmente..."|tee -a "$LOG"
   fi
fi
#}

# CONSIDERACION 1: CUANDO LA VARIABLE A COMPARAR COMO "$GRUPO" GENERE MAS DE UN VALOR, GENERARA ERROR, 
# POR QUE SOLO SEPODRAN HACER COMPARACIONES 1 A 1. LA SOLUCION ES DECLARAR ENTRE CORCHETES, PERO SE DEBERA
# VERIFICAR COMO HACER PARA GENERE UN SOLO RESULTADO. PARA LOGRAR ESTE RESULTADO, OBSERVE QUE SE DEJO
# EL PARAMETRO DE BUSQUEDA "grep root" a "grep ^root", ESTO FILTRO EL RESULTADO.
