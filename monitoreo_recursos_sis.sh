#/bin/bash
#Se puede trabajar solo en enteros y no en decimales con int(valor) //linea 5. 
df -h | awk '{print $5"  "$6}' >/app/scripts/fs_fbcredito_db.txt
free -m -h -t | grep T | awk '{usage=($3*100)/$2} END {print int(usage) "%"}' >/app/scripts/mem_fbcredito_db.txt
grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage) "%"}' >/app/scripts/cpu_fbcredito_db.txt
cd /app/scripts
scp -p -r fs_fbcredito_db.txt 10.181.0.111:/home/UIM
scp -p -r mem_fbcredito_db.txt 10.181.0.111:/home/UIM
scp -p -r cpu_fbcredito_db.txt 10.181.0.111:/home/UIM
