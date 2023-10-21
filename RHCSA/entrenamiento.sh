#!/bin/bash
#Proyecto en desarrollo por John Ballen
#============================= FUNCIONES DE TEXTO ========================================
instrucciones_tar(){
cat $(pwd)/texto/tar1.txt
}


#=========================================================================================
#=========================================================================================

#============================== FUNCIONES DE EJECUCION ===================================
file_creation(){
  mkdir $(pwd)/folder_test
  touch -t 1507160000 $(pwd)/folder_test/file_test{1..100}.txt
  touch $(pwd)/folder_test/file_test{101..200}.txt
}

folder_delete(){
  rm -rf $(pwd)/folder_test/
  echo "Archivos eliminados"
}

#========================================================================================
#========================================================================================

#============================ FUNCIONES DE MENU ==========================================

menu(){
clear
echo "===MENU==="
echo "1. Instrucciones y Ejercicios"
echo "2. Creacion carpeta y archivos dummy"
echo "3. Borrar carpeta y archivos"

echo "5. Salir"
echo -n "Ingrese una opcion: "
echo " "
}

menu_instrucciones(){
clear
echo "===MENU==="
echo "a) Compresion y descompresion con tar"
echo "b) Enlaces simbolicos"

echo "s) Salir"
echo -n "Ingrese una opcion: "
echo " "
}

while true; do
  menu
  read opc

  case $opc in
    
    1)
      while true; do
        menu_instrucciones
        read opt
        case $opt in
      
        a)
          instrucciones_tar	
          ;;
        b)
          echo "enlaces simbolicos en construccion"
          ;;
        s)
          echo "Adios!"
          break
          ;;
        esac
        echo -n "Presione una tecla para continuar"
        read enter 
     done
     ;;
    2)
      file_creation
      ;;

    3)
      folder_delete
      ;;

    5)
      echo "Adios!"
      break
      ;;
  esac
  echo -n "Presione una tecla para continuar"
  read enter
done
