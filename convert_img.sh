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
uniqueNumLen=8
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
uniqueNumLen=$OPTARG
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
    local numLen=${#uniqueNum} 
    if [ $numLen -gt $uniqueNumLen ];  then
        echo "The unique number becomes bigger then max possible. Set it to default value: $uniqueNumInit"
        $uniqueNum=$uniqueNumInit
    fi
}

printUniqueNum()
{
    local numLen=${#uniqueNum}
    if [ $numLen -le $uniqueNumLen ];  then
        printf -v printedNum "%0${uniqueNumLen}d" $uniqueNum
    fi
    echo "$printedNum"
}

renameFile()
{
    setNewUniqueNum
    dateStump=`date +%S_%M_%H-%d-%m-%Y`
    fileName="$dateStump-$(printUniqueNum).jpg"

    echo "Rename file $1 to $fileName in $directory"

    mv ./$1 ./$fileName
}

testRename()
{
    cd $directory
    for file in $( ls )
    do
    case ${file##*.} in
    
    tiff|gif|bmp|png|ppm|pgm|pbm|pnm|webp|hdr|heif|bat|bpg|cgm|svg|ics|wbmp|jng|jpg|jpeg)
    #
    renameFile $file	
    ;;
        
    esac
	done
}

#testRename


rename()
{
    dateStump=`date +%S_%M_%H-%d-%m-%Y`
    find . -iregex '.*\.\(tiff\|gif\|bmp\|png\|ppm\|pgm\|pbm\|pnm\|webp\|hdr\|heif\|bpg\|cgm\|svg\|ics\|wbmp\|jng\|jpg\|jpeg\)$' -exec convert '{}' $dateStump-%0${uniqueNumLen}d.jpg
}

rename





