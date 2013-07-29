#login page: http://webapp.geod.nrcan.gc.ca/geod/account-compte/login.php

#Source the conf file to get username, password
. uploadGPSdata.conf

echo "Logging in as: $USERNAME" #XXX

#Login to the CSRS website
curl -i -L \
--cookie-jar cookies.txt \
--user-agent 'Mozilla/5.0 (X11; Ubuntu; Linux armv7l; rv:17.0) Gecko/20100101 Firefox/17.0' \
--data "emaillogin=${USERNAME}" \
--data "passlogin=${PASSWORD}" \
--data "referrer=/geod/index.php" \
--data "ajax=0" \
--data "sublogin=1" \
http://webapp.geod.nrcan.gc.ca/geod/jpWare/process.php > \
loginOutput.html

