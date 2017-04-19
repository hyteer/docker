#!/bin/bash
#echo "sllaa"
telnet 172.17.0.5 33301
if [ $? = 0 ];then
    echo "success..."
else
    echo "fail..."
fi

