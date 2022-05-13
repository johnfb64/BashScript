#!/bin/bash
while read -r line;
do
	   ip_server=$line
	      hn=`ssh -n $line hostname`
	         so=`ssh -n $line cat /etc/issue | awk '{print $7}'`
		    echo `$ip_server,$so`
	    done<servidores.txt
