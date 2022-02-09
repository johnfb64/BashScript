#!/bin/bash
echo > pgp_list.txt
ls -lrt *.PGP | awk '{print $9}' >> pgp_list.txt
while read line;
do  pgp --decrypt $line --passphrase "R00st3r?.";
done < pgp_list.txt
rm pgp_list.txt