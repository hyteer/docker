#!/bin/bash  
  
arr0=(1 2 3)  
arr1=(2 4 6)  
arr2=(3 6 9)  
#arr0=( "bj" "xh" "jg" "gs" "xs" )
multiArr=($arr0 $arr1 $arr2)
i=2
j=3
srvs=( 
	i=1  
	j=2  
)
#you want arr[i][j]  
#echo `eval echo ${arr$i[$j]} `
echo "Arr$i: $arr0"

for arr in ${multiArr[@]}
do
echo "Arr: ${arr[@]}"
done

echo "multiArr: ${multiArr[@]}"

