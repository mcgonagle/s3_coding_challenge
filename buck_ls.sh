#!/bin/bash

#help function to print out options for script
helpFunction()
{
   echo ""
   echo "Usage: $0"
   echo -e "\t-b to display bytes"
   echo -e "\t-k to display kilobytes"
   echo -e "\t-m to display megabytes"
   echo -e "\t-g to display gigabytes"
   exit 1 # Exit script after printing help
}

#logic to make sure user enters expected parameters
if [ "$1" == "-b" ] || [ "$1" == "-k" ] || [ "$1" == "-m" ] || [ "$1" == "-g" ]; then	
	echo
else 
 	helpFunction
fi	

#logic to set up paths to aws cli based on operating system 
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        export PATH="$PATH:~/.local/bin" 
elif [[ "$OSTYPE" == "darwin"* ]]; then
        export PATH="$PATH:~/Library/Python/3.7/bin"
else
       echo "Unknown OS type $OSTYPE"
       exit 1
fi

#logic to iterate through all of the buckets, get creation date/time, bucket size
#and print it out bytes, kilobytes, megabytes, or gigabytes based on option passed into the script
#It also determines the number of files in each bucket and the last modification date of the most recent file.

echo -e "\t==============================================================="
for bucket in $(aws s3 ls|awk '{ print $3 }'); do
		echo -e "\tBUCKET name is $bucket"
		echo -e "\tCREATION date is `aws s3 ls |grep $bucket|  awk '{ print $1 " " $2 }'`"

                bucket_size=`aws s3api list-objects --bucket $bucket --output text --query "[sum(Contents[].Size)]"`
		if [ "$1" == "-b" ]
		then
			echo -e "\tbucket size in BYTES is: $bucket_size"
		elif [ "$1" == "-k" ]
		then
			kilobytes_bucket_size=`echo $bucket_size / 1024 |bc`
			echo -e "\tbucket size in KILOBYTES is: $kilobytes_bucket_size"
		elif [ "$1" == "-m" ]
		then
			megabytes_bucket_size=`echo $bucket_size / 1024 / 1024 |bc`
			echo -e "\tbucket size in MEGABYTES is: $megabytes_bucket_size"
		elif [ "$1" == "-g" ]
		then
			gigabytes_bucket_size=`echo $bucket_size / 1024 / 1024 / 1024|bc`
			echo -e "\tbucket size in GIGABYTES is: $gigabytes_bucket_size"
		else 
   		echo "Some or all of the parameters are incorrect"
   		helpFunction
		fi

		num_of_files=`aws s3api list-objects --bucket $bucket --output text --query "[length(Contents[])]"`
		echo -e "\tNUMBER OF FILES in bucket is: $num_of_files"

		mod_date=`aws s3 ls $bucket --recursive | sort | tail -n 1 | awk '{print $1 " "  $2 }'`
		echo -e "\tLAST MODFIFIED DATE/TIME of the most recent file: $mod_date"

		echo -e "\t==============================================================="

done
