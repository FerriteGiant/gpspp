#!/usr/bin/awk
BEGIN{ FS=" "; }
/Location: /{

	urlpart1="http://webapp.csrs.nrcan.gc.ca/field/data/"
	ok=match($0,"data%2F([[:alnum:]_]*)",urlpart2);
	print urlpart1 urlpart2[1] "/" urlpart2[1] "_full_output.zip"
}
