#Source conf file to obtain return_email
. uploadGPSdata.conf

#Parse the loginOutput.html file for the user and session id
USERNAMEANDID=`cat loginOutput.html| awk -f parseline.awk`
USER=`echo $USERNAMEANDID | cut -f 1 -d " "`
SESSIONID=`echo $USERNAMEANDID | cut -f 2 -d " "`

if [ "$USER" == '' ] || [ "$SESSIONID" == '' ]
then
	echo "Login failed!"
	exit 1
fi

echo "Login data: $USER - $SESSIONID"

#Submit file passed in from calling script
curl -i -L --form "rfile_upload=@$1" \
--form "process_type=Static" \
--form "sysref_system=ITRF" \
--form "return_email=${RETURN_EMAIL}" \
--form "cmd_process_type=std" \
--form "user_name=${USER}" \
--form "session_id=${SESSIONID}" \
--form "language=en" \
http://webapp.csrs.nrcan.gc.ca/field/Scripts/CSRS_PPP_cgi.pl \
> confirmationPage.html

#Sleep for a random number of seconds to emulate a human
minSeconds=100
maxSeconds=130
r=$(( ( $RANDOM % $(($maxSeconds-$minSeconds))+$minSeconds ) ))
echo "Sleeping for $r seconds..."
sleep $r

