#!/bin/bash
io=$(iostat -xd | awk 'NR==4 {print $15}')
echo "$io"
if [$io -ge 1 ]
then
echo $io es muy alto
else
echo $io es muy bajo
fi
