fun() {  
    local _arr=(`echo $1 | cut -d " "  --output-delimiter=" " -f 1-`)  
    local _n_arr=${#_arr[@]}  
    for((i=0;i<$_n_arr;i++));  
    do    
       elem=${_arr[$i]}  
       echo "$i : $elem"  
    done;   
}  
   
array=(a b c)  
fun "$(echo ${array[@]})"  
