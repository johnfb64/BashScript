#!/bin/bash
read -p "Introduzca primer numero: " n1
read -p "Introduzca primer segundo: " n2
echo "la suma es: $(($n1+$n2))"
echo "la resta es: $(($n1-$n2))"
echo "la multiplicacion es: $(($n1*$n2))"
echo "la division es: $(($n1/$n2))"
echo "el modulo (resto) es: $(($n1%$n2))"
