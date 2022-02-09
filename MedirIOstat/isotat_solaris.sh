#!/bin/bash
umbral = 20
c0d0=`/usr/bin/iostat -xpns 2 1 | awk 'NR==3{print $8}'`
c0d1=`/usr/bin/iostat -xpns 2 1 | awk 'NR==4{print $8}'`
c0d2=`/usr/bin/iostat -xpns 2 1 | awk 'NR==5{print $8}'`
reportes_tools=`/usr/bin/iostat -xpns 2 1 | awk 'NR==6{print $8}'`
appsrv02=`/usr/bin/iostat -xpns 2 1 | awk 'NR==7{print $8}'`
backup_pstool=`/usr/bin/iostat -xpns 2 1 | awk 'NR==8{print $8}'`

if [ $c0d0 -ge 10 ]
then
echo c0d0 $c0d0 es un valor alto
else
echo c0d0 $c0d0 es un valor bajo
fi

if [ $c0d1 -ge 10 ]
then
echo c0d1 $c0d1 es un valor alto
else
echo c0d1 $c0d1 es un valor bajo
fi

if [ $c0d2 -ge 10 ]
then
echo c0d2 $c0d2 es un valor alto
else
echo c0d2 $c0d2 es un valor bajo
fi

if [ $reportes_tool -ge 10 ]
then
echo reportes_tool $reportes_tool es un valor alto
else
echo reportes_tool $reportes_tool es un valor bajo
fi

if [ $appsrv02 -ge 10 ]
then
echo appsrv02 $appsrv02 es un valor alto
else
echo appsrv02 $appsrv02 es un valor bajo
fi

if [ $backup_pstool -ge 10 ]
then
echo backup_pstool $backup_pstool es un valor alto
else
echo backup_pstool $backup_pstool es un valor bajo
fi
