#!/usr/bin/awk
BEGIN{ FS=" "; }
#Look for a line containing the following and execute the code
#in curly braces on that line
/CSRS-PPP RINEX File Upload Acknowledgement/{

	#Split off the filename+extension	
	numFields=split(filePath,filePathArray,"/");
	#Split apart the filename and extension
	split(filePathArray[numFields],fileNameArray,".");
	#save just the file name
	fileName1=fileNameArray[1];
	
	#$0 is the default variable the line is saved to
	ok=match($0,"RINEX file ([[:alnum:]_]*)",a);
	fileName2=a[1];
	if(ok>0 && fileName1==fileName2)
		print "The file " fileName1 " has been successfully uploaded.";
	else if(ok==0 || fileName1 != fileName2)
		print "The file " fileName1 " has failed to upload.";
}
