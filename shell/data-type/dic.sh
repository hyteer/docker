#!/bin/bash

echo "shell定义字典"
#必须先声明
declare -A dic
dic=([key1]="value1" [key2]="value2" [key3]="value3")

#打印指定key的value
echo ${dic["key1"]}
#打印所有key值
echo ${!dic[*]}
#打印所有value
echo ${dic[*]}

#遍历key值
for key in $(echo ${!dic[*]})
do
        echo "$key : ${dic[$key]}"
done
