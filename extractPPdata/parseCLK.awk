#!/usr/bin/awk
BEGIN{ 
	FS=" +";
	OFS=" ";
	headerRow="";
     }

FNR==1 {outputName=FILENAME".CLK"; print outputName}

/DIR/{ #find line containing /regex/ 
    for(x=1;x<=NF;x++)
    	{
	#Find the position of the needed field labels
        if($x~/DOY/) DOYpos=x;
        if($x~/CLK\(ns\)/) CLKpos=x;
        }
headerRow = NR;
}
#skip the rest of the rules until NR = headerRow+1  
headerRow==""||headerRow==NR{next}


{
print $DOYpos,$CLKpos > outputName;
}

