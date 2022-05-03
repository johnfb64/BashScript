#!/bin/bash

lsblk | grep sda1 | awk '{print "umount -f "$7 " /home/john/shared/Disk_1/"}' |sh
lsblk | grep sda2 | awk '{print "umount -f "$7 " /home/john/shared/Disk_2/"}' |sh
lsblk | grep sda3 | awk '{print "umount -f "$7 " /home/john/shared/Disk_3/"}' |sh

lsblk | grep sda1 | awk '{print "mount "$7 " /home/john/shared/Disk_1/"}' |sh
lsblk | grep sda2 | awk '{print "mount "$7 " /home/john/shared/Disk_2/"}' |sh
lsblk | grep sda3 | awk '{print "mount "$7 " /home/john/shared/Disk_3/"}' |sh
