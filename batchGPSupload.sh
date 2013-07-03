#!/bin/bash

if [[ $# -lt 2 ]]
then
	echo "Provide 2 parameters first!"
	echo "USAGE: ./batchGPSupload.sh <search directory> <search string>"
	echo "EXAMPLE: ./batchGPSupload.sh ./ \"pt*_.O\""
	#Note: will upload any files in the search directory or below
	#      including symlinks
	exit 1
fi

#Get the full path for the search directory
STARTDIR=`readlink -f $1`

#Find all files in or below the search directory which match
#the search string and save full paths to FILES
FILES=`find -L ${STARTDIR}  -name "$2"` 

#Display those files
for a in $FILES
do
	echo "$a"
done

echo "The files listed above will be uploaded, continue? (y/n)"
read cont

if [ "$cont" == 'n' ]
then
	echo "exiting"
	exit 1
fi
echo "uploading..."
#change to the directory the script is in
cd `dirname $0`

#login to the website
./login.sh

#For each file call the upload script
#THESE SCRIPTS MUST BE IN THE SAME DIRECTORY 
for b in $FILES
do
	#echo "$a"
	./uploadGPSdata.sh $b

	#Sleep for a random number of seconds to emulate a human
#	r=$(( ( $RANDOM % 40 + 20 ) ))
#	echo "Sleeping for $r seconds..."
#	sleep $r
done

#rm loginOutput.html
#rm confirmationPage.html

