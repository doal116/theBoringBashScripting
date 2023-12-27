#!/bin/bash
buffer=""
extList=()

#Getting extensions to look for.
while [[ $buffer != 'no' ]]
do
    echo "${extList[@]}"
    echo -e "\nEnter the file's extension One at a time(pdf/jpg/..)\n[type 'no' if you want to stop the input]: "
    read buffer
    if [[ $buffer != 'no' ]]
    then 
        extList+=("$buffer")
    fi
    clear
done

#Creating directories for the extensions
# and moving them into their respective directories.

echo -e "\nDo you want to begin the moving process?\n[Y(yes)/N(no)]: " 
read mvProcess

numExt=${#extList[@]}

if [[ $numExt -ne 0 && $mvProcess != 'N' ]]
then
    for (( i=0 ;  i < $numExt ; i++ ))
    do
        if [[ ! -d "./${extList[$i]}" ]]
        then 
            mkdir "./${extList[$i]}"
        fi
        mv ./*.${extList[$i]} "./${extList[$i]}"
    done
fi