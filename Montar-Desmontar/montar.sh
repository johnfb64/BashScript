# Author: John Ballen
# Date Created:04-16-2021
# Description: The scrpt run basic admin commands
# Date Modified: 04-16-2021

umount -l /dev/sdb1 /home/john/Share/Disk2
        if [ $? -eq 0 ]
        then
        echo "OK"
        exit 0
        else
        sudo umount -l /dev/sda1 /home/john/Share/Disk2
        fi

umount -l /dev/sdb2 /home/john/Share/Disk3
        if [ $? -eq 0 ]
        then
        echo "OK"
        exit 0
        else
        sudo umount -l /dev/sda2 /home/john/Share/Disk3
        fi
umount -l /dev/sdb3 /home/john/Share/Disk1
        if [ $? -eq 0 ]
        then
        echo "OK"
        exit 0
        else
        sudo umount -l /dev/sda3 /home/john/Share/Disk1
        fi

sleep 5

mount /dev/sdb1 /home/john/Share/Disk2
        if [ $? -eq 0 ]
        then
        echo "OK"
        exit 0
        else
        mount /dev/sda1 /home/john/Share/Disk2
	if [ $? -eq 0 ]
	then
        echo "OK"
	exit 0
	else 
	mount /dev/sdc1 /home/john/Share/Disk2
        fi

mount /dev/sdb2 /home/john/Share/Disk3
        if [ $? -eq 0 ]
        then
        echo "OK"
        exit 0
        else
        mount /dev/sda2 /home/john/Share/Disk3
	if [ $? -eq 0 ]
	then
        echo "OK"
	exit 0
	else 
	mount /dev/sdc2 /home/john/Share/Disk3
        fi
		
mount /dev/sdb3 /home/john/Share/Disk1
        if [ $? -eq 0 ]
        then
        echo "OK"
        exit 0
        else
        mount /dev/sda3 /home/john/Share/Disk1
	if [ $? -eq 0 ]
	then
        echo "OK"
	exit 0
	else 
	mount /dev/sdc3 /home/john/Share/Disk1
        fi
