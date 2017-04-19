#!/bin/bash
./wait-for-it.sh -t 5 172.17.0.5:80 -- echo "timeout..."
if [ $? = 0 ];then
    echo "success..., \$? is $?"
else 
    echo "fail... \$? is $?"
fi


