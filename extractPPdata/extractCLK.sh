#!/bin/bash
if [[ $# -lt 3 ]]
then
	echo "*********************************************"
        echo "Provide exactly three arguments!"
        echo "USAGE: ./extractCLK.sh <search directory> <regex search string> <destination directory>"
        echo "Example: ./extractCLK.sh ~/DATA/ \".*PT001(5[0-9]|6[0-5])0_full_output.zip\" ~/clkdata/"
        echo "This will find NU1 files for days 150-165."
	echo "*********************************************"
        #Note: will process any files in the search directory or below
        #      including symlinks
        exit 1
fi

#Get the full path for the search directory
STARTDIR=`readlink -f $1`
#Get the full path for the destination directory
DESTDIR=`readlink -f $3`

#Find all files in or below the search directory which match
#the search string and save full paths to FILES
FILES=`find -L ${STARTDIR}  -regextype "posix-extended" -regex "$2"`
SortedFILES=$(echo $FILES | awk -F/ '{print $NF}' RS=" " | sort -t_ -k 3)

#Display those files
for a in $SortedFILES
do
        echo "$a"
done
#echo $SortedFILES | awk '{print}' RS=" "
echo "Destination: $DESTDIR"
echo "The files listed above will be processed, continue? (y/n)"
read cont
#cont='y'
if [ "$cont" != 'y' ]
then
        echo "exiting"
        exit 1
fi
echo "Beginning file processing."
fileNames=""
for a in $FILES
do
	fileNames="$fileNames $3$(zipinfo -1 $a \*.pos)"
	unzip $a \*.pos -d $3 > /dev/null
done
echo $fileNames | awk '{print $0}' RS=" "

for a in $fileNames
do
	awk -f parseCLK.awk $a
	
done
