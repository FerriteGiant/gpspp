#!/usr/bin/awk
BEGIN{ FS=" "; }
/id="pppForm"/{ #find line with matching id
    for(x=1;x<=NF;x++)
    {
	#Find the position of the needed field labels
        if($x~"session_id") sidfield=x;
        if($x~"user_name") userfield=x;
    }
    sidfield=sidfield+1;
    userfield=userfield+1;
    ok= match($sidfield,"=\"([[:alnum:]]*)",a);
    ok= match($userfield,"=\"([[:alnum:]]*)",b);
    print b[1],a[1]; #return a space delimted string with both values
}
