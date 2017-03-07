#!/bin/bash

directory=$PWD
MAX_NUM = 99999999
uniqueNumInit = 0;
uniqueNum = $uniqueNumInit

setNewUniqueNum()
{
    uniqueNum = uniqueNum + 1;
    
    if [uniqueNum > MAX_NUM];  then
        echo "The unique number becomes bigger then max possible. Set it to default value: $ uniqueNumInit"
        uniqueNum = uniqueNumInit
    fi
}

renameFile()
{
    setNewUniqueNum
    dateStump=`%S_%M_%H-%d-%m-%Y`
    fileName="$dateStump-$uniqueNum.jpg"

    echo "Rename file $1 to $fileName in $directory"

    mv $directory/$1 $directory/$fileName
}




testRename()
{
    for file in $( ls ); do
        renameFile $file			
	done
}

    testRename