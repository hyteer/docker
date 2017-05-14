#!/bin/bash
if [ ! -n $1 ]
then a=$1
else a=11
fi
if [ ! -n $2 ]
then b=$2
else b=12
fi

if [ $a == $b ]
then echo "a equals b"
elif [ $a -gt $b ]
then echo "a greater than b"
elif [ $a -lt $b ]
then echo "a less than b"
else echo "no valid data..."
fi


