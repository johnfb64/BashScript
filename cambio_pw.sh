#!/bin/bash
echo "Indique usuario: "
read USER

while read -ra line; do
    echo $line
    ssh -n $line "echo '$USER:Corbeta22*' | chpasswd"
done < medellin.txt


