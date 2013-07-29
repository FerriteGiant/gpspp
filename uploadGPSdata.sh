#Source conf file to obtain return_email
. uploadGPSdata.conf

#if [ "$USER" == '' ] || [ "$SESSIONID" == '' ]
#then
#        echo "Login failed!"
#        exit 1
#fi


#Submit file passed in from calling script
curl -i -L --cookie "cookies.txt" \
--form "return_email=${RETURN_EMAIL}" \
--form "process_type=Static" \
--form "sysref_system=ITRF" \
--form "rfile_upload=@$1" \
--form "cmd_process_type=std" \
--form "ppp_access=real_browser" \
--form "user_id=31332" \
--form "language=en" \
http://webapp.geod.nrcan.gc.ca/geod/process/ppp_process.php \
> confirmationPage.html

#cat confirmationPage.html | awk -f findOutputURL.awk >> downloadurls.log
 
#cat confirmationPage.html | awk -f confirmUpload.awk filePath=$1 >> upload.log


#Sleep for a random number of seconds to emulate a human
minSeconds=5
maxSeconds=10
r=$(( ( $RANDOM % $(($maxSeconds-$minSeconds))+$minSeconds ) ))
echo "Sleeping for $r seconds..."
sleep $r

