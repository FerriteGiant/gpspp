#!/bin/bash

if [[ $# -lt 2 ]]
then
	echo "Provide 2 parameters first!"
	echo "USAGE: ./batchGPSupload.sh <search directory> <regex search string>"
	echo "Example: ./batchGPSupload.sh ./ \".*/PT001(5[0-9]|6[0-5])0.13O.gz\""
	echo "This will find NU1 files for days 150-165."
	#echo "EXAMPLE: ./batchGPSupload.sh ./ \"pt*_.O\""
	#Note: will upload any files in the search directory or below
	#      including symlinks
	exit 1
fi

#Get the full path for the search directory
STARTDIR=`readlink -f $1`

#Find all files in or below the search directory which match
#the search string and save full paths to FILES
#FILES=`find -L ${STARTDIR}  -name "$2" | sort` #Use this line instead for simpler searching
FILES=`find -L ${STARTDIR}  -regextype "posix-extended" -regex "$2" | sort` 

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
echo "Beginning Upload."
#change to the directory the script is in
cd `dirname $0`

#login to the website
./login.sh

#For each file call the upload script
#THESE SCRIPTS MUST BE IN THE SAME DIRECTORY 
for b in $FILES
do
	echo "Uploading: $b"
	./uploadGPSdata.sh $b

done

#rm loginOutput.html
#rm confirmationPage.html

