#/bin/bash
#Se puede trabajar solo en enteros y no en decimales con int(valor) //linea 5. 
df -h | awk '{print $5"  "$6}' >/app/scripts/informe.txt
free -m -h -t | grep T | awk '{usage=($3*100)/$2} END {print int(usage) "%"}' >/app/scripts/informe.txt
grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage) "%"}' >/app/scripts/informe.txt
cd /app/scripts
scp -p -r fs_informe_db.txt xx.xxx.x.xxx:/home/destino
scp -p -r mem_informe_db.txt xx.xxx.0.xxx:/home/destino
scp -p -r cpu_informe_db.txt xx.xxx.x.xxx:/home/destino
