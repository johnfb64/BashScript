# Author: John Ballen
# Date Created:04-16-2021
# Description: The scrpt run basic admin commands
# Date Modified: 04-16-2021

mount /dev/sdb1 /home/john/Share/Disk2
        if [ $? -eq 0 ]
        then
        echo "OK"
        exit 0
        else
        mount /dev/sda1 /home/john/Share/Disk2
        fi
