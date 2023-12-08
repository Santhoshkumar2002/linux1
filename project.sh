#!/bin/bash
<<doc
Name:
Date:
Title:
Sample I/P:
Sample O/P:
doc
echo "1-Signup"
echo "2-Signin"
echo "3-Exit"
read -p "Enter the number: " num
name=(`cat username.csv`)
temp=1
case $num in 
    1)
	while [ $temp -eq 1 ]
	do
	    count=0
	    read -p "Enter the username: " user
	    for i in ${name[@]}
	    do
		if [ $user == $i ]
		then
		    count=1
		    var=$i
		fi
	    done
	    if [ $count -eq 1 ]
	    then
	    	echo -e "This $var username exit\nSo enter the username again"
    	    else
		temp=0
	    fi
	done
	temp1=0
	while [ $temp1 -eq 0 ]
	do
	    read -p "Enter the password:" pass
	    read -p "Enter the confirm password:" conpass
	    if [ $pass == $conpass ]
	    then
    		echo $user >> username.csv
		echo $pass >> password.csv
		echo "Sign up Successfull :)"
		temp1=1
	    else
		echo -e "Error: Password not matched\nPlease enter valid password"
	    fi
	done
	;;
    2)
	pass=(`cat password.csv`)
	len=${#name[@]}
	while [ $temp -eq 1 ]
	do
	    count1=0
	    read -p "Enter the username: " user1
	    read -p "Enter the passwrd: " pass1
	    for i in `seq 0 $((len-1))`
	    do
		if [ $user1 == ${name[i]} -a $pass1 == ${pass[i]} ]
		then
		    count1=1
		fi
	   done
	   if [ $count1 -eq 0 ]
	   then
	       echo "Error: User name or password is incorrect, Please enter username "
	   else
	       echo "Signin successfully completed"
	       temp=0
	   fi
       done
       echo "1-Take test"
       echo "2-Exit"
       read -p "Enter the choice:" option
       case $option in
	   1)
	       len1=`cat question.txt | wc -l`
	       for i in `seq 5 5 $len1`
	       do
		   head -$i question.txt | tail -5
		   for j in `seq 10 -1 1`
		   do
		       echo -ne "\rEnter the option: $j "
		       read -t 1 opt
		       if [ -n "$opt" ]
		       then
			   break
		       else
			   opt='e'
		       fi
		   done
		   echo
		   echo $opt >> useranswer.txt
	       done
	       echo "RESULT"
	       arr1=(`cat useranswer.txt`)
	       arr2=(`cat correctanswer.txt`)
	       len4=${#arr2[@]}
	       k=0
	       Total=0
	       for m in `seq 5 5 $len1`
	       do
		   head -$m question.txt | tail -5
		   if [ ${arr1[k]} == ${arr2[k]} ]
		   then
		       Total=$((Total+1))
		       echo correct
		   elif [ ${arr1[k]} = e ]
		   then
		       echo Time out
		       echo "Correct option:${arr2[k]}"
		   else
		       echo wrong
		       echo "Correct option:${arr2[k]}"
		   fi
		   echo
		   k=$((k+1))
	       done
	       echo "Total marks $Total out of $len4"
	       sed -i 'd' useranswer.txt
	       ;;
	   2)
	       exit
	       ;;
       esac
       ;;
   3)
       exit
       ;;
esac
