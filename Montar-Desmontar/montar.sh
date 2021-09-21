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
	sudo mount /dev/sda1 /home/john/Share/Disk2
	fi
	
mount /dev/sdb2 /home/john/Share/Disk3
	if [ $? -eq 0 ]
        then
        echo "OK"
        exit 0
        else
	sudo mount /dev/sda2 /home/john/Share/Disk3
	fi
mount /dev/sdb3 /home/john/Share/Disk1
	if [ $? -eq 0 ]
        then
	echo "OK"
	exit 0
        else
	sudo mount /dev/sda3 /home/john/Share/Disk1
        fi

