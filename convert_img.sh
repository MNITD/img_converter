#!/bin/bash
#script converts images of all extentions into images with extention .jpg
#script renames converted files with date and time of convertating
#and special id 

#options
#-c change directory with imgs (default current)
#-n set number of digits in id (default 8)
#-i set initial id (default 0)

#default options args
directory=$PWD
idLen=8
MAX_NUM=99999999
uniqueNumInit=0
uniqueNum=$uniqueNumInit

#check option args
#args of option should NOT be another option
checkargs () {
if [[ $OPTARG =~ ^-[c/n/i]$ ]]
then
echo "Option argument check failed!"
echo "Unknow argument $OPTARG for option $opt!"
exit 1
fi
}

#with : after option, because args for option is required
while getopts "c:n:i:" opt
do
case $opt in

c) checkargs 
directory=$OPTARG
echo "The directory was changed to : $OPTARG"
;;

n) checkargs
idLen=$OPTARG
echo "The number of digits in id was changed to : $OPTARG"
;;

i) checkargs
echo "The initial id was changed to : $OPTARG"
uniqueNumInit=$OPTARG
;;

*) 
echo "No reasonable options found!"
;;
esac
done


setNewUniqueNum()
{
    uniqueNum=$[ $uniqueNum+1 ];
    echo $uniqueNum
    if [ $uniqueNum -gt $MAX_NUM ];  then
        echo "The unique number becomes bigger then max possible. Set it to default value: $uniqueNumInit"
        $uniqueNum=$uniqueNumInit
    fi
}

renameFile()
{
    setNewUniqueNum
    dateStump=`date +%S_%M_%H-%d-%m-%Y`
    fileName="$dateStump-$uniqueNum.jpg"

    echo "Rename file $1 to $fileName in $directory"

    mv ./$1 ./$fileName
}




testRename()
{
    cd $directory
    for file in $( ls ); do
        renameFile $file			
	done
}

testRename





