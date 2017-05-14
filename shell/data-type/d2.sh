#!/bin/bash

echo "shell定义字典"
#必须先声明
declare -A dic
dic=([key1]="value1" [key2]="value2" [key3]="value3")
dict2=(
	[key1]="tony" 
	[key2]="yt" 
	[key3]="silly" 
)

#打印指定key的value
echo ${dict2["key1"]}
echo ${dict2["key2"]}
