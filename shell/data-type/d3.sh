#!/bin/bash
# 必须先声明
declare -A dict
dict=([key1]="value1" [key2]="value2" [key3]="value3")

# 打印指定key的value
echo ${dict["key1"]}
# 打印所有key值
echo ${!dict[*]}
# 打印所有value
echo ${dict[*]}

# 遍历key值
for key in $(echo ${!dict[*]})
do
    echo "$key : ${dict[$key]}"
done
