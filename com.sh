#!/bin/bash
<<doc
Name:
Date:
Title:
Sample I/P:
Sample O/P:
doc

arr=(`cat useranswer.txt`)
arr1=(`cat correctanswer.txt`)
echo ${arr[@]}
echo ${arr1[@]}
len=${#arr1[@]}
echo $len
for i in `seq 0 $((len-1))`
do
    if [ ${arr[i]} == ${arr1[i]} ]
    then
	echo correct
    elif [ ${arr[i]} = e ]
    then
	echo time out
    else
	echo wrong
    fi
done
