yt="YT"
sex="Male"
echo name is $yt,sex is $sex
echo "\$0 is: $0"
if [ ! -z $1 ]
then
    echo "\$1 is: $1"
else
    echo "\$1 is null"
fi

if [ -z $2 ]
then
    echo "\$2 is null"
else
    echo "\$2 is $2"
fi

