#login page: http://csrsjava.geod.nrcan.gc.ca/csrsicp/CsrsLogin?userlang=en

#Source the conf file to get username, password
. uploadGPSdata.conf

echo "Username: $USERNAME" #XXX

#Login to the CSRS website
curl --data "username=${USERNAME}&pw=${PASSWORD}&page=1&userlang=en" \
--location "http://csrsjava.geod.nrcan.gc.ca/csrsicp/LoginHandler" > \
loginOutput.html

