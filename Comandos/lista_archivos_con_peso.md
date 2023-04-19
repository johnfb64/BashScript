#EJEMPLO DE COMANDO QUE LISTA ARCHIVOS, MUESTRA FECHA Y PESO DE CADA UNO CON ARRAYS. 

archivos=($(du -sh * | awk '{print $2}')); \
dia=($(du -sh * | awk '{print "date -r " $2, "\"+%d-%m-%Y\""}'|sh)); \
hora=($(du -sh * | awk '{print "date -r " $2, "\"+%H:%M\""}'|sh)); \
peso=($(du -sh * | awk '{print $1}')); \
wordc=($(du -sh * | wc -l)); \
for i in $(seq 0 $wordc); do echo ${archivos[i]}, ${dia[i]},${hora[i]},${peso[i]};done
