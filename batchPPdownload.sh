#!/bin/bash

if [[ $# -lt 2 ]]
then
	echo "################################"
        echo "USAGE: ./batchPPdownload.sh <url file> <save directory>"
        echo "EXAMPLE: ./batchPPdownload.sh ./downloadurls.log /home/t2k/public_html/post/gpsgroup/ptdata/organizedData/csrs-pp/NU1SeptentrioGPS/GPSData_Internal"
        echo "<save directory> can be absolute or relative path"
	echo "################################"
        exit 1
fi


#Get the full path for the save directory
SAVEDIR=`readlink -f $1`

#Get the full path for the save directory
FILELIST=`readlink -f $2`

echo "#######################"
echo "Files to be downloaded"
while read line
do
	echo $line
done < $FILELIST

echo "Continue? (y/n)"
read cont

if [ "$cont" == 'n' ]
then
        echo "exiting"
        exit 1
fi

wget -P $SAVEDIR --limit-rate=500k -w 5 --random-wait -i $FILELIST

ls -gGhtr $SAVEDIR 
mv ${FILELIST} ${FILELIST}.finished 
